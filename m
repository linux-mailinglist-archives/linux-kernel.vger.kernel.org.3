Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59FE526C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384638AbiEMVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiEMVQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:16:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6FD27FE3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652476576; x=1684012576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Gskyxl5a38unKZlQosOqjGR7Ihzv9T1bkSU8Qq82ZE=;
  b=iuqSWemR6QTtifoX0Bmz+wmhZFx5045APKimXuGW5I85UtOzgGmSPW3f
   OV8vAqZbCYIetn/kN8hd0s4NF09FEctds3LzknOxrjxvm4QdqmA4t5+xp
   /nVTv2NVOrMn+2Jk2oVH+Xmfg65h3q4M6rP0awtxjNG6u28VL7jEJMMmc
   hV2d+2zUa/OzmGD5YwCVCOVlXfpmuRKgZjulN6NvBxtgpN9Owmn3DT3v7
   /40fhOAlLWdByhCHmmRMkuTY59L9N2s5tNTiMue/zg9yJLKZYpMvVa4n9
   GHnF2mhgWUwgNBk8f+6Yr7rdW3aTbVaHp0kd/ke3XqR0Lew5LMfdPrLrg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250940431"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250940431"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 14:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="595421000"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2022 14:16:09 -0700
Date:   Fri, 13 May 2022 14:19:44 -0700
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
Message-ID: <20220513211944.GE22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtfufifa.ffs@tglx>
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

On Fri, May 06, 2022 at 11:41:13PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > Programming an HPET channel as periodic requires setting the
> > HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
> > register must be written twice (once for the comparator value and once for
> > the periodic value). Since this programming might be needed in several
> > places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
> > add a helper function for this purpose.
> >
> > A helper function hpet_set_comparator_oneshot() could also be implemented.
> > However, such function would only program the comparator register and the
> > function would be quite small. Hence, it is better to not bloat the code
> > with such an obvious function.
> 
> This word salad above does not provide a single reason why the periodic
> programming function is required and better suited for the NMI watchdog
> case

The goal of hpet_set_comparator_periodic() is to avoid code duplication. The
functions hpet_clkevt_set_state_periodic() and kick_timer() in the HPET NMI
watchdog need to program a periodic HPET channel when supported.


> and then goes on and blurbs about why a function which is not
> required is not implemented.

I can remove this.

> The argument about not bloating the code
> with an "obvious???" function which is quite small is slightly beyond my
> comprehension level.

That obvious function would look like this:

void hpet_set_comparator_one_shot(int channel, u32 delta)
{
	u32 count;

	count = hpet_readl(HPET_COUNTER);
	count += delta;
	hpet_writel(count, HPET_Tn_CMP(channel));
}

It involves one register read, one addition and one register write. IMO, this
code is sufficiently simple and small to allow duplication.

Programming a periodic HPET channel is not as straightforward, IMO. It involves
handling two different values (period and comparator) written in a specific
sequence, one configuration bit, and one delay. It also involves three register
writes and one register read.

Thanks and BR,
Ricardo
