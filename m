Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585D52ADCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiEQWEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiEQWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:04:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B474B851
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652825068; x=1684361068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DYnEdSppO39yh6uNPMT5k/kcPnrUIqJqd4/BSKdNERc=;
  b=BjbfxZHZEwBynJi1lPzs0SlSzNyrQU2V4xj0J7nIMcWyNqawa51U7IU8
   verdxVoczLZ8EqdJwFMJO32uIVeagW4loCzeBW9OrRatJi/8WLnXNycH6
   Vu3b4EUXAZmRBnbzmaZOLrRlrlrlSvvNNxtcR0+1Bocp2dF4zofMGsfzb
   c0Fzs+/aymVFmN3k33xJt5E9nr6ZTysRxBmVll7sLySeBtQ1+x6wkU4Ka
   G60ugC0gsvCZ9xtECH7RNu5LO6Wa7qiXaSPUC9/0vDxUEgdUh73CphNIL
   pK+5xz2NIxc7qcdlHqYiBV9J+XfEt3VvOEUbFElaJfMmFXJb4wWGSShFX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253399768"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="253399768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="673075036"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2022 15:04:27 -0700
Date:   Tue, 17 May 2022 15:08:10 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining
 tsc_khz
Message-ID: <20220517220810.GB6711@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
 <1652180070.1r874kr0tg.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652180070.1r874kr0tg.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:16:21PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> > The HPET hardlockup detector relies on tsc_khz to estimate the value of
> > that the TSC will have when its HPET channel fires. A refined tsc_khz
> > helps to estimate better the expected TSC value.
> > 
> > Using the early value of tsc_khz may lead to a large error in the expected
> > TSC value. Restarting the NMI watchdog detector has the effect of kicking
> > its HPET channel and make use of the refined tsc_khz.
> > 
> > When the HPET hardlockup is not in use, restarting the NMI watchdog is
> > a noop.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: x86@kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v5:
> >  * Introduced this patch
> > 
> > Changes since v4
> >  * N/A
> > 
> > Changes since v3
> >  * N/A
> > 
> > Changes since v2:
> >  * N/A
> > 
> > Changes since v1:
> >  * N/A
> > ---
> >  arch/x86/kernel/tsc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cafacb2e58cc..cc1843044d88 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1386,6 +1386,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
> >  	/* Inform the TSC deadline clockevent devices about the recalibration */
> >  	lapic_update_tsc_freq();
> >  
> > +	/*
> > +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
> > +	 * Reconfigure it to make use of the refined tsc_khz.
> > +	 */
> > +	lockup_detector_reconfigure();
> 
> I don't know if the API is conceptually good.
> 
> You change something that the lockup detector is currently using, 
> *while* the detector is running asynchronously, and then reconfigure
> it. 

Yes, this is what happens.

> What happens in the window? If this code is only used for small
> adjustments maybe it does not really matter

Please see my comment

> but in principle it's a bad API to export.
> 
> lockup_detector_reconfigure as an internal API is okay because it
> reconfigures things while the watchdog is stopped

I see.

> [actually that  looks untrue for soft dog which uses watchdog_thresh in
> is_softlockup(), but that should be fixed].

Perhaps there should be a watchdog_thresh_user. When the user updates it,
the detector is stopped, watchdog_thresh is updated, and then the detector
is resumed.

> 
> You're the arch so you're allowed to stop the watchdog and configure
> it, e.g., hardlockup_detector_perf_stop() is called in arch/.

I had it like this but it did not look right to me. You are right, however,
I can stop/restart the watchdog when needed.

Thanks and BR,
Ricardo
