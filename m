Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7C526C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384662AbiEMVZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358795AbiEMVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:25:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD8663FD
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652477128; x=1684013128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6Vls9wnN+x00vvDZEEHtOYdZPzsd8ahPI1ukzsIW6A=;
  b=nO/Q31FD+tqSRLnr5rJ+KbWanPdla8H2wpg9JU9hCwj0Rp2NQNDknYqO
   5khjTFzgOqJh5MychSdM+XAPGLj4cBpNqlr9XQdHqjmB+5uBYRL+zdPhq
   QMMev1r2nU5Fb6ltC9H16pDLkMWTHvZFk/Otn9kRNLMmA18B69dMkulBt
   gOVnMlNe8WyL5yoAO1yjnVFT9iNQIzPQk+ciUKp4dqFJStkblWbNDigtp
   teR7oVJIh9AzI66F7ja0Nx/pkoUuH6DkYMjjJ2z8wmYoSqU/1XeFN5L6L
   bqgAbl33qPdU6eSH7dxZNeheDeM3RhH1YNZNrdwA+i/NyOH15pFFRnIF3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270350414"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270350414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 14:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712562541"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 14:25:28 -0700
Date:   Fri, 13 May 2022 14:29:03 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
Message-ID: <20220513212903.GF22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx>
 <87ilqifhxj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilqifhxj.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:51:52PM +0200, Thomas Gleixner wrote:
> On Fri, May 06 2022 at 23:41, Thomas Gleixner wrote:
> > On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> >> Programming an HPET channel as periodic requires setting the
> >> HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
> >> register must be written twice (once for the comparator value and once for
> >> the periodic value). Since this programming might be needed in several
> >> places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
> >> add a helper function for this purpose.
> >>
> >> A helper function hpet_set_comparator_oneshot() could also be implemented.
> >> However, such function would only program the comparator register and the
> >> function would be quite small. Hence, it is better to not bloat the code
> >> with such an obvious function.
> >
> > This word salad above does not provide a single reason why the periodic
> > programming function is required and better suited for the NMI watchdog
> > case and then goes on and blurbs about why a function which is not
> > required is not implemented. The argument about not bloating the code
> > with an "obvious???" function which is quite small is slightly beyond my
> > comprehension level.
> 
> What's even more uncomprehensible is that the patch which actually sets
> up that NMI watchdog cruft has:
> 
> > +       if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
> > +               hld_data->has_periodic = true;
> 
> So how the heck does that work with a HPET which does not support
> periodic mode?

If the HPET channel does not support periodic mode (as indicated by the flag
above), it will read the HPET counter into a local variable, increment that
local variable, and write comparator of the HPET channel.

If the HPET channel does support periodic mode, it will not kick it again.
It will only kick a periodic HPET channel if needed (e.g., if the NMI watchdog
was idle of watchdog_thresh changed its value).

> 
> That watchdog muck will still happily invoke that set periodic function
> in the hope that it works by chance?

It will not. It will check hld_data->has_periodic and act accordingly.

FWIW, I have tested this NMI watchdog with periodic and non-periodic HPET
channels.

Thanks and BR,
Ricardo
