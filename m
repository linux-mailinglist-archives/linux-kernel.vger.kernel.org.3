Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B579152AE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiEQWvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiEQWvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:51:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F7A4F455
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652827862; x=1684363862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zzsg2WuJh6uzhJovq8XCrnmcAqakpF47E+0Mjk8izlQ=;
  b=Mh/zA90wHaa8IFQn2f2jnLCbmi/O2VIOSYlevYAzw6yV0zzCMYjK62Yi
   fZbpItEcukbDLIbv4aKGJ95B7vfdxZUt49cEfO/Iqq2+rmXpX75Z0W16j
   nQk+ODyMeYdjfNKT1tpKuEi3J3NJ+Gfyicag2u4BtVJkFk0+s5lZzABLW
   7aWrjpJXuCal+QHM8lfFxnKlcQZ4p2JG8mXNIDcJyornvWLTQdWflz2f5
   DsFnZ8wf5SdAGvVp0dQvKoJvWOG5tx5VdriJ/qnhGo+DZzCyUjuVdY4vM
   dfSQU5yMIT/lrhwxQnYyLtFmRe9dtZgFcvtRce3DAT7nxEzWTMtoORy+B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251879809"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251879809"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="660835593"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 15:51:00 -0700
Date:   Tue, 17 May 2022 15:54:43 -0700
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
Message-ID: <20220517225443.GA8069@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx>
 <20220513211944.GE22683@ranerica-svr.sc.intel.com>
 <87pmkgsf31.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmkgsf31.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 10:17:38AM +0200, Thomas Gleixner wrote:
> On Fri, May 13 2022 at 14:19, Ricardo Neri wrote:
> > On Fri, May 06, 2022 at 11:41:13PM +0200, Thomas Gleixner wrote:
> >> The argument about not bloating the code
> >> with an "obvious???" function which is quite small is slightly beyond my
> >> comprehension level.
> >
> > That obvious function would look like this:
> >
> > void hpet_set_comparator_one_shot(int channel, u32 delta)
> > {
> > 	u32 count;
> >
> > 	count = hpet_readl(HPET_COUNTER);
> > 	count += delta;
> > 	hpet_writel(count, HPET_Tn_CMP(channel));
> > }
> 
> This function only works reliably when the delta is large. See
> hpet_clkevt_set_next_event().

That is a good point. One more reason to not have a
hpet_set_comparator_one_shot(), IMO.

Thanks and BR,
Ricardo
