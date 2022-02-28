Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC94C66F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiB1KPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiB1KPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:15:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA2B40909;
        Mon, 28 Feb 2022 02:14:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9B906210F4;
        Mon, 28 Feb 2022 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646043282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KukxMvO4tyrrizISG36Vcc7/8BtcgAz+EL/84ZHG//k=;
        b=FizPj/xAl+yD5oE2xueO9kol54H8qOAHIZyzKlPhMrxZWfpRfioicmAAD/KVObvozj7ysM
        mtcBbeDgTt+P5n+VPxeE3WgSUKfOTLsDlmvBH0Vv3cew6DU6ccY9cbQh2t++kK/eBiMs/d
        pSwCFv6mFQt9CDZx4kK5SCVsIxzT55Y=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3913EA3B84;
        Mon, 28 Feb 2022 10:14:42 +0000 (UTC)
Date:   Mon, 28 Feb 2022 11:14:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        davem@davemloft.net, jolsa@redhat.com, jthierry@redhat.com,
        keescook@chromium.org, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com, maz@kernel.org,
        mcgrof@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        sparclinux@vger.kernel.org, sumit.garg@linaro.org,
        wangqing@vivo.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH 4/5] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <YhygkafOHc6eeP9f@alley>
References: <Yhjzr8geK7dTXXd2@alley>
 <20220226105229.16378-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226105229.16378-1-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-02-26 18:52:29, Lecopzer Chen wrote:
> > On Sat 2022-02-12 18:43:48, Lecopzer Chen wrote:
> > > From: Pingfan Liu <kernelfans@gmail.com>
> > > 
> > > from: Pingfan Liu <kernelfans@gmail.com>
> > > 
> > > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > > yet. E.g. on arm64, PMU is not ready until
> > > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > > with the driver model and cpuhp. Hence it is hard to push this
> > > initialization before smp_init().
> > > 
> > > But it is easy to take an opposite approach by enabling watchdog_hld to
> > > get the capability of PMU async.
> > > 
> > > The async model is achieved by expanding watchdog_nmi_probe() with
> > > -EBUSY, and a re-initializing work_struct which waits on a wait_queue_head.
> > > 
> > > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > > index b71d434cf648..fa8490cfeef8 100644
> > > --- a/kernel/watchdog.c
> > > +++ b/kernel/watchdog.c
> > > @@ -839,16 +843,64 @@ static void __init watchdog_sysctl_init(void)
> > >  #define watchdog_sysctl_init() do { } while (0)
> > >  #endif /* CONFIG_SYSCTL */
> > >  
> > > +static void lockup_detector_delay_init(struct work_struct *work);
> > > +enum hld_detector_state detector_delay_init_state __initdata;
> > 
> > I would call this "lockup_detector_init_state" to use the same
> > naming scheme everywhere.
> > 
> > > +
> > > +struct wait_queue_head hld_detector_wait __initdata =
> > > +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> > > +
> > > +static struct work_struct detector_work __initdata =
> > 
> > I would call this "lockup_detector_work" to use the same naming scheme
> > everywhere.
> 
> For the naming part, I'll revise both of them in next patch.
> 
> > 
> > > +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> > > +
> > > +static void __init lockup_detector_delay_init(struct work_struct *work)
> > > +{
> > > +	int ret;
> > > +
> > > +	wait_event(hld_detector_wait,
> > > +			detector_delay_init_state == DELAY_INIT_READY);
> > 
> > DELAY_INIT_READY is defined in the 5th patch.
> > 
> > There are many other build errors because this patch uses something
> > that is defined in the 5th patch.
> 
> Thanks for pointing this out, the I'll fix 4th and 5th patches to correct the order.
> 
> > 
> > > +	ret = watchdog_nmi_probe();
> > > +	if (!ret) {
> > > +		nmi_watchdog_available = true;
> > > +		lockup_detector_setup();
> > > +	} else {
> > > +		WARN_ON(ret == -EBUSY);
> > 
> > Why WARN_ON(), please?
> > 
> > Note that it might cause panic() when "panic_on_warn" command line
> > parameter is used.
> > 
> > Also the backtrace will not help much. The context is well known.
> > This code is called from a workqueue worker.
>  
> The motivation to WARN should be:
> 
> lockup_detector_init
> -> watchdog_nmi_probe return -EBUSY
> -> lockup_detector_delay_init checks (detector_delay_init_state == DELAY_INIT_READY)
> -> watchdog_nmi_probe checks
> +	if (detector_delay_init_state != DELAY_INIT_READY)
> +		return -EBUSY;
> 
> Since we first check detector_delay_init_state equals to DELAY_INIT_READY
> and goes into watchdog_nmi_probe() and checks detector_delay_init_state again
> becasue now we move from common part to arch part code.
> In this condition, there shouldn't have any racing to detector_delay_init_state.
> If it does happend an unknown racing, then shows a warning to it.

There should not be any race.

     wait_event(hld_detector_wait,
		detector_delay_init_state == DELAY_INIT_READY);

waits until it is waken by lockup_detector_check(). Well, it could
wait forewer when lockup_detector_check() is caller earlier, see below.


> I think it make sense to remove WARN now becasue it looks verbosely...
> However, I would rather change the following printk to
> "Delayed init for lockup detector failed."

I would print both messages. The above message says what failed.


> > > +		pr_info("Perf NMI watchdog permanently disabled\n");

And this message explains what is the result of the above failure.
It is not obvious.

> > > +	}
> > > +}
> > > +
> > > +/* Ensure the check is called after the initialization of PMU driver */
> > > +static int __init lockup_detector_check(void)
> > > +{
> > > +	if (detector_delay_init_state < DELAY_INIT_WAIT)
> > > +		return 0;
> > > +
> > > +	if (WARN_ON(detector_delay_init_state == DELAY_INIT_WAIT)) {
> > 
> > Again. Is WARN_ON() needed?
> > 
> > Also the condition looks wrong. IMHO, this is the expected state.
> > 
> 
> This does expected DELAY_INIT_READY here, which means,
> every one who comes here to be checked should be READY and WARN if you're
> still in WAIT state, and which means the previous lockup_detector_delay_init()
> failed.

No, DELAY_INIT_READY is set below. DELAY_INIT_WAIT is valid value here.
It means that lockup_detector_delay_init() work is queued.


> IMO, either keeping or removing WARN is fine with me.
> 
> I think I'll remove WARN and add
> pr_info("Delayed init checking for lockup detector failed, retry for once.");
> inside the `if (detector_delay_init_state == DELAY_INIT_WAIT)`
> 
> Or would you have any other suggestion? thanks.
> 
> > > +		detector_delay_init_state = DELAY_INIT_READY;
> > > +		wake_up(&hld_detector_wait);

I see another problem now. We should always call the wake up here
when the work was queued. Otherwise, the worker will stay blocked
forewer.

The worker will also get blocked when the late_initcall is called
before the work is proceed by a worker.

> > > +	}
> > > +	flush_work(&detector_work);
> > > +	return 0;
> > > +}
> > > +late_initcall_sync(lockup_detector_check);


OK, I think that the three states are too complicated. I suggest to
use only a single bool. Something like:

static bool lockup_detector_pending_init __initdata;

struct wait_queue_head lockup_detector_wait __initdata =
		__WAIT_QUEUE_HEAD_INITIALIZER(lockup_detector_wait);

static struct work_struct detector_work __initdata =
		__WORK_INITIALIZER(lockup_detector_work,
				   lockup_detector_delay_init);

static void __init lockup_detector_delay_init(struct work_struct *work)
{
	int ret;

	wait_event(lockup_detector_wait, lockup_detector_pending_init == false);

	ret = watchdog_nmi_probe();
	if (ret) {
		pr_info("Delayed init of the lockup detector failed: %\n);
		pr_info("Perf NMI watchdog permanently disabled\n");
		return;
	}

	nmi_watchdog_available = true;
	lockup_detector_setup();
}

/* Trigger delayedEnsure the check is called after the initialization of PMU driver */
static int __init lockup_detector_check(void)
{
	if (!lockup_detector_pending_init)
		return;

	lockup_detector_pending_init = false;
	wake_up(&lockup_detector_wait);
	return 0;
}
late_initcall_sync(lockup_detector_check);

void __init lockup_detector_init(void)
{
	int ret;

	if (tick_nohz_full_enabled())
		pr_info("Disabling watchdog on nohz_full cores by default\n");

	cpumask_copy(&watchdog_cpumask,
		     housekeeping_cpumask(HK_FLAG_TIMER));

	ret = watchdog_nmi_probe();
	if (!ret)
		nmi_watchdog_available = true;
	else if (ret == -EBUSY) {
		detector_delay_pending_init = true;
		/* Init must be done in a process context on a bound CPU. */
		queue_work_on(smp_processor_id(), system_wq, 
				  &lockup_detector_work);
	}

	lockup_detector_setup();
	watchdog_sysctl_init();
}

The result is that lockup_detector_work() will never stay blocked
forever. There are two possibilities:

1.  lockup_detector_work() called before lockup_detector_check().
    In this case, wait_event() will wait until lockup_detector_check()
    clears detector_delay_pending_init and calls wake_up().

2. lockup_detector_check() called before lockup_detector_work().
   In this case, wait_even() will immediately continue because
   it will see cleared detector_delay_pending_init.


Best Regards,
Petr
