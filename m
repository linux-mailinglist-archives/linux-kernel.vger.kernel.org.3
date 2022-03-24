Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3362E4E63B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350324AbiCXM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350295AbiCXM5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:57:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A9694AF;
        Thu, 24 Mar 2022 05:55:57 -0700 (PDT)
X-UUID: e6262b6374fa496f96f18f61742c6541-20220324
X-UUID: e6262b6374fa496f96f18f61742c6541-20220324
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1204572558; Thu, 24 Mar 2022 20:55:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Mar 2022 20:55:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 20:55:51 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <pmladek@suse.com>
CC:     <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
        <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2 4/5] kernel/watchdog: Adapt the watchdog_hld interface for async model
Date:   Thu, 24 Mar 2022 20:55:51 +0800
Message-ID: <20220324125551.9044-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Yji30cmiPzoINrd6@alley>
References: <Yji30cmiPzoINrd6@alley>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat 2022-03-19 16:18:22, Lecopzer Chen wrote:
> > > On Mon 2022-03-07 23:47:28, Lecopzer Chen wrote:
> > > > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > > > yet. E.g. on arm64, PMU is not ready until
> > > > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > > > with the driver model and cpuhp. Hence it is hard to push this
> > > > initialization before smp_init().
> > > 
> > > > --- a/kernel/watchdog.c
> > > > +++ b/kernel/watchdog.c
> > > > @@ -839,16 +843,70 @@ static void __init watchdog_sysctl_init(void)
> > > >  #define watchdog_sysctl_init() do { } while (0)
> > > >  #endif /* CONFIG_SYSCTL */
> > > >  
> > > > +static void lockup_detector_delay_init(struct work_struct *work);
> > > > +bool lockup_detector_pending_init __initdata;
> > > > +
> > > > +struct wait_queue_head hld_detector_wait __initdata =
> > > > +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> > > > +
> > > > +static struct work_struct detector_work __initdata =
> > > > +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> > > > +
> > > > +static void __init lockup_detector_delay_init(struct work_struct *work)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	wait_event(hld_detector_wait,
> > > > +			lockup_detector_pending_init == false);
> > > > +
> > > > +	/*
> > > > +	 * Here, we know the PMU should be ready, so set pending to true to
> > > > +	 * inform watchdog_nmi_probe() that it shouldn't return -EBUSY again.
> > > > +	 */
> > > > +	lockup_detector_pending_init = true;
> > > 
> > > This does not make sense to me. We are here only when:
> > > 
> > >    1. lockup_detector_init() queued this work.
> > > 
> > >    2. Someone cleared @lockup_detector_pending_init and woke the
> > >       worker via wait_queue. IT might be either PMU init code
> > >       or the late lockup_detector_check().
> > > 
> > > watchdog_nmi_probe() might still return -EBUSY when PMU init failed.
> > > 
> > > If you wanted to try the delayed probe once again (3rd attempt) from
> > > lockup_detector_check(), you would need to queue the work once again.
> > > But you need to be sure that lockup_detector_check() was not called
> > > yet. Otherwise, the 2nd work might wait forewer.
> > > 
> > > IMHO, it is not worth the complexity.
> > 
> > The original assumption is: nobody should use delayed probe after
> > lockup_detector_check() (which has __init attribute).
> 
> Good point. It makes perfect sense.
> 
> But it was not mentioned anywhere. And the code did not work this way.
> 
> > 
> > That is, everything including PMU and delayed probe of lock detector must
> > finsh before do_initcalls() which means delayed probe can't support with
> > external PMU module init.
> > 
> > Also,
> >   1. lockup_detector_check is registered with late_initcall_sync(), so it'd
> >      be called in the last order of do_initcalls()).
> > 
> >   2. watchdog_nmi_probe() and all the delayed relative functions and variables
> >      have __init attribute, no one should ever use it after __init section
> >      is released.
> > 
> > The only case is PMU probe function is also late_initcall_sync().
> 
> This is the case for PMU. The API for delayed init is generic a should
> be safe even for other users.
> 

I think this can be fixed after the suggestion provied by you below.
Set lockup_detector_pending_init=false at the end of lockup_detector_check().
So nobody after lockup_detector_check() can ever queue another work.

> 
> > How about this one:
> >   1. Wrap the wake_up code to reduce the complexity for user side.
> > 
> >   2. Remove wait queue.
> >      Instead queue work when lockup_detector_init(), queue the delayed
> >      probe work when arch PMU code finish probe.
> > 
> > and the flow turns to
> > 
> >   1. lockup_detector_init() get -EBUSY, set lockup_detector_pending_init=true
> > 
> >   2. PMU arch code init done, call lockup_detector_queue_work().
> > 
> >   3. lockup_detector_queue_work() queue the work only when
> >      lockup_detector_pending_init=true which means nobody should call
> >      this before lockup_detector_init().
> > 
> >   4. the work lockup_detector_delay_init() is doing without wait event.
> >      if probe success, set lockup_detector_pending_init=false.
> > 
> >   5. at late_initcall_sync(), lockup_detector_check() call flush_work() first
> >      to avoid previous lockup_detector_queue_work() is not scheduled.
> >      And then test whether lockup_detector_pending_init is false, if it's
> >      true, means we have pending init un-finished, than forcely queue work
> >      again and flush_work to make sure the __init section won't be freed
> >      before the work done.
> 
> Nice, I like it.
> 
> > This remove the complexity of wait event which we were disscussed.
> > The draft of the diff code(diff with this series) shows below.
> > 
> > 
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 77eaefee13ea..c776618fbfa8 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -1388,9 +1388,7 @@ static int __init armv8_pmu_driver_init(void)
> >  	else
> >  		ret = arm_pmu_acpi_probe(armv8_pmuv3_pmu_init);
> >  
> > -	/* Inform watchdog core we are ready to probe hld by delayed init. */
> > -	lockup_detector_pending_init = false;
> > -	wake_up(&hld_detector_wait);
> > +	lockup_detector_queue_work();
> 
> The name is strange. The fact that it uses workqueues is an
> implementation detail. I would call it
> retry_lockup_detector_init() so that it is more obvious what it does.

Okay, I don't have a good taste in naming.
I'll provide next version patches including this.


> 
> >  	return ret;
> >  }
> >  device_initcall(armv8_pmu_driver_init)
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -876,15 +865,27 @@ static void __init lockup_detector_delay_init(struct work_struct *work)
> >  	lockup_detector_pending_init = false;
> >  }
> >  
> > +/* Must call after lockup_detector_init() that we do need delayed probe */
> > +void __init lockup_detector_queue_work(void)
> > +{
> > +	if (!lockup_detector_pending_init)
> > +		return;
> > +
> > +	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> > +}
> > +
> >  /* Ensure the check is called after the initialization of PMU driver */
> >  static int __init lockup_detector_check(void)
> >  {
> > +	/* Make sure no work is pending. */
> > +	flush_work(&detector_work);
> > +
> >  	if (!lockup_detector_pending_init)
> >  		return 0;
> >  
> >  	pr_info("Delayed init checking failed, retry for once.\n");
> > -	lockup_detector_pending_init = false;
> > -	wake_up(&hld_detector_wait);
> > +	lockup_detector_queue_work();
> 
> I would do here
> 
> 	lockup_detector_pending_init = false;
> 
> to make sure that lockup_detector_queue_work() will not longer
> queue the work after the final flush.
> 
> Maybe, we could rename the variable to allow_lockup_detector_init_retry.

Okay, I'm prepareing the next version patches, I'll include in it

thanks a lot for all of the suggestion


BRs,
Lecopzer
