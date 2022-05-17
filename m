Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9099452AE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiEQWtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiEQWt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:49:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA552E6E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652827766; x=1684363766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eW9eeCQ/ZnkVlQzYhrGw1tL7ydi/5swHvLwwK3+msYw=;
  b=KW0YKMPMHh9jm84ggUkMVPwKKOogXdXo6lACmg6OLYJajbhpC5oExT8u
   TCjQUzBLtEQe1LbQ8Imhpxv/vK7HUBRQA8aqj3m+v0sp8cZbv5u0uz5G0
   BUDQIKfBaQ81TCPHJVaqlnNIyH9qjsmwEnGOt5Wm4lmWal2Cp/8/2ylS0
   cflszpzJ8APD/LE4QUQhXtuJnLJiAIw0BlvxBOQhYCz3OW7CTzM+Zj81c
   jKgWu0giJU+BhDT9A6xpdHfuMvouxCFQbAobiMB37WPTXctjwJ2i4dyBw
   8OUYyLKLozM6eLRrcDYTRLayD58i+krSeEQSQ7NLsZRkRMeEk6l5GmKbB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="331980533"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="331980533"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="626709312"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 17 May 2022 15:49:25 -0700
Date:   Tue, 17 May 2022 15:53:08 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
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
Message-ID: <20220517225308.GC6711@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
 <1652180070.1r874kr0tg.astroid@bobo.none>
 <87ilqdpq7u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilqdpq7u.ffs@tglx>
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

On Tue, May 10, 2022 at 01:44:05PM +0200, Thomas Gleixner wrote:
> On Tue, May 10 2022 at 21:16, Nicholas Piggin wrote:
> > Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> >> +	/*
> >> +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
> >> +	 * Reconfigure it to make use of the refined tsc_khz.
> >> +	 */
> >> +	lockup_detector_reconfigure();
> >
> > I don't know if the API is conceptually good.
> >
> > You change something that the lockup detector is currently using, 
> > *while* the detector is running asynchronously, and then reconfigure
> > it. What happens in the window? If this code is only used for small
> > adjustments maybe it does not really matter but in principle it's
> > a bad API to export.
> >
> > lockup_detector_reconfigure as an internal API is okay because it
> > reconfigures things while the watchdog is stopped [actually that
> > looks untrue for soft dog which uses watchdog_thresh in
> > is_softlockup(), but that should be fixed].
> >
> > You're the arch so you're allowed to stop the watchdog and configure
> > it, e.g., hardlockup_detector_perf_stop() is called in arch/.
> >
> > So you want to disable HPET watchdog if it was enabled, then update
> > wherever you're using tsc_khz, then re-enable.
> 
> The real question is whether making this refined tsc_khz value
> immediately effective matters at all. IMO, it does not because up to
> that point the watchdog was happily using the coarse calibrated value
> and the whole use TSC to assess whether the HPET fired mechanism is just
> a guestimate anyway. So what's the point of trying to guess 'more
> correct'.

In some of my test systems I observed that, the TSC value does not fall
within the expected error window the first time the HPET channel expires.

I inferred that the error computed using the coarser tsc_khz was wrong.
Recalculating the error window with refined tsc_khz would correct it.

However, restarting the timer has the side-effect of kicking the timer and,
therefore pushing the first HPET NMI further in the future.

Perhaps kicking HPET channel, not recomputing the error window, corrected
(masked?) the problem.

I will investigate further and rework or drop this patch as needed.

Thanks and BR,
Ricardo
