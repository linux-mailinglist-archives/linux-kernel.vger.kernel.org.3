Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC55297A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiEQDGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEQDF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:05:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743D64D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652756754; x=1684292754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1eXK/Lt9/M/kHEgyQGFmbYTuXrCc0mJ/GpdZrACprGU=;
  b=OewGFiYvnJ5lEzGuQrc7/98QlybO/5lHPQxblhnE8Ypjqxym/2CuDGoM
   5Kuq7WX3OZRHMXXLjcgBC/Ld/RlI7NUsp4ADC+rkQjQjun9H8BVJgo9To
   zzNWWYKQ7h7/stK6uXQzZUIjsrDpH5wnFHC3pQdg9A9du7Gx38zqOxVZB
   g1q7M15Asdk0J3KUO4Yc3W+w57H6ohvAvksUfB/yd7xSSCXKdvwElOqBh
   gq0wDUZ0dVr5QYFaxO8NXtoeMkIlTaAG9uE3LF9Pw9u5VdWLKA9BPcuQP
   3Q8T2Mr8M4jaJqF4OjJc/tvwp1ZrDqSxQrs1I6QnbC2Oi5psuR7CG29/Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271161209"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="271161209"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 20:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="660399844"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 16 May 2022 20:05:54 -0700
Date:   Mon, 16 May 2022 20:09:35 -0700
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
Subject: Re: [PATCH v6 29/29] x86/tsc: Switch to perf-based hardlockup
 detector if TSC become unstable
Message-ID: <20220517030935.GA2678@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-30-ricardo.neri-calderon@linux.intel.com>
 <1652184158.yhzceh3nwk.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652184158.yhzceh3nwk.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:14:00PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> > The HPET-based hardlockup detector relies on the TSC to determine if an
> > observed NMI interrupt was originated by HPET timer. Hence, this detector
> > can no longer be used with an unstable TSC.
> > 
> > In such case, permanently stop the HPET-based hardlockup detector and
> > start the perf-based detector.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: x86@kernel.org
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v5:
> >  * Relocated the delcaration of hardlockup_detector_switch_to_perf() to
> >    x86/nmi.h It does not depend on HPET.
> >  * Removed function stub. The shim hardlockup detector is always for x86.
> > 
> > Changes since v4:
> >  * Added a stub version of hardlockup_detector_switch_to_perf() for
> >    !CONFIG_HPET_TIMER. (lkp)
> >  * Reconfigure the whole lockup detector instead of unconditionally
> >    starting the perf-based hardlockup detector.
> > 
> > Changes since v3:
> >  * None
> > 
> > Changes since v2:
> >  * Introduced this patch.
> > 
> > Changes since v1:
> >  * N/A
> > ---
> >  arch/x86/include/asm/nmi.h     | 6 ++++++
> >  arch/x86/kernel/tsc.c          | 2 ++
> >  arch/x86/kernel/watchdog_hld.c | 6 ++++++
> >  3 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
> > index 4a0d5b562c91..47752ff67d8b 100644
> > --- a/arch/x86/include/asm/nmi.h
> > +++ b/arch/x86/include/asm/nmi.h
> > @@ -63,4 +63,10 @@ void stop_nmi(void);
> >  void restart_nmi(void);
> >  void local_touch_nmi(void);
> >  
> > +#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR
> > +void hardlockup_detector_switch_to_perf(void);
> > +#else
> > +static inline void hardlockup_detector_switch_to_perf(void) { }
> > +#endif
> > +
> >  #endif /* _ASM_X86_NMI_H */
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cc1843044d88..74772ffc79d1 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1176,6 +1176,8 @@ void mark_tsc_unstable(char *reason)
> >  
> >  	clocksource_mark_unstable(&clocksource_tsc_early);
> >  	clocksource_mark_unstable(&clocksource_tsc);
> > +
> > +	hardlockup_detector_switch_to_perf();
> >  }
> >  
> >  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> > diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
> > index ef11f0af4ef5..7940977c6312 100644
> > --- a/arch/x86/kernel/watchdog_hld.c
> > +++ b/arch/x86/kernel/watchdog_hld.c
> > @@ -83,3 +83,9 @@ void watchdog_nmi_start(void)
> >  	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
> >  		hardlockup_detector_hpet_start();
> >  }
> > +
> > +void hardlockup_detector_switch_to_perf(void)
> > +{
> > +	detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
> 
> Another possible problem along the same lines here,
> isn't your watchdog still running at this point? And
> it uses detector_type in the switch.
> 
> > +	lockup_detector_reconfigure();
> 
> Actually the detector_type switch is used in some
> functions called by lockup_detector_reconfigure()
> e.g., watchdog_nmi_stop, so this seems buggy even
> without concurrent watchdog.

Yes, this true. I missed this race.

> 
> Is this switching a good idea in general? The admin
> has asked for non-standard option because they want
> more PMU counterss available and now it eats a
> counter potentially causing a problem rather than
> detecting one.

Agreed. A very valid point.
> 
> I would rather just disable with a warning if it were
> up to me. If you *really* wanted to be fancy then
> allow admin to re-enable via proc maybe.

I think that in either case, /proc/sys/kernel/nmi_watchdog
need to be updated to reflect that the NMI watchdog has
been disabled. That would require to expose other interfaces
of the watchdog.

Thanks and BR,
Ricardo
