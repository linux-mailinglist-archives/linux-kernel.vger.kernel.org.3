Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0034C71C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiB1Qdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiB1Qdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:33:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A743EFE;
        Mon, 28 Feb 2022 08:33:08 -0800 (PST)
X-UUID: 844e9321f9514547804018f8b76c476d-20220301
X-UUID: 844e9321f9514547804018f8b76c476d-20220301
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 920374331; Tue, 01 Mar 2022 00:32:59 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Mar 2022 00:32:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Mar
 2022 00:32:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 00:32:56 +0800
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
Subject: Re: [PATCH 4/5] kernel/watchdog: Adapt the watchdog_hld interface for async model
Date:   Tue, 1 Mar 2022 00:32:57 +0800
Message-ID: <20220228163257.2411-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YhygkafOHc6eeP9f@alley>
References: <YhygkafOHc6eeP9f@alley>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, there is no race now, the condition is much like a verbose checking for
the state. I'll remove it.


> > I think it make sense to remove WARN now becasue it looks verbosely...
> > However, I would rather change the following printk to
> > "Delayed init for lockup detector failed."
> 
> I would print both messages. The above message says what failed.
> 
> 
> > > > +		pr_info("Perf NMI watchdog permanently disabled\n");
> 
> And this message explains what is the result of the above failure.
> It is not obvious.

Yes, make sense, let's print both.


> 
> > > > +	}
> > > > +}
> > > > +
> > > > +/* Ensure the check is called after the initialization of PMU driver */
> > > > +static int __init lockup_detector_check(void)
> > > > +{
> > > > +	if (detector_delay_init_state < DELAY_INIT_WAIT)
> > > > +		return 0;
> > > > +
> > > > +	if (WARN_ON(detector_delay_init_state == DELAY_INIT_WAIT)) {
> > > 
> > > Again. Is WARN_ON() needed?
> > > 
> > > Also the condition looks wrong. IMHO, this is the expected state.
> > > 
> > 
> > This does expected DELAY_INIT_READY here, which means,
> > every one who comes here to be checked should be READY and WARN if you're
> > still in WAIT state, and which means the previous lockup_detector_delay_init()
> > failed.
> 
> No, DELAY_INIT_READY is set below. DELAY_INIT_WAIT is valid value here.
> It means that lockup_detector_delay_init() work is queued.
> 

Sorry, I didn't describe clearly,

For the call flow:

kernel_init_freeable()
-> lockup_detector_init()
--> queue work(lockup_detector_delay_init) with state registering
    to DELAY_INIT_WAIT.
---> lockup_detector_delay_init wait DELAY_INIT_READY that set
     by armv8_pmu_driver_init().
----> device_initcall(armv8_pmu_driver_init),
      set state to READY and wake_up the work. (in 5th patch)
-----> lockup_detector_delay_init recieves READY and calls
       watchdog_nmi_probe() again.
------> late_initcall_sync(lockup_detector_check);
        check if the state is READY? In other words, did the arch driver
        finish probing watchdog between "queue work" and "late_initcall_sync()"?
        If not, we forcely set state to READY and wake_up again.


> 
> > IMO, either keeping or removing WARN is fine with me.
> > 
> > I think I'll remove WARN and add
> > pr_info("Delayed init checking for lockup detector failed, retry for once.");
> > inside the `if (detector_delay_init_state == DELAY_INIT_WAIT)`
> > 
> > Or would you have any other suggestion? thanks.
> > 
> > > > +		detector_delay_init_state = DELAY_INIT_READY;
> > > > +		wake_up(&hld_detector_wait);
> 
> I see another problem now. We should always call the wake up here
> when the work was queued. Otherwise, the worker will stay blocked
> forewer.
> 
> The worker will also get blocked when the late_initcall is called
> before the work is proceed by a worker.

lockup_detector_check() is used to solve the blocking state.
As the description above, if state is WAIT when lockup_detector_check(),
we would forcely set state to READY can wake up the work for once.
After lockup_detector_check(), nobody cares about the state and the worker
also finishes its work.

> 
> > > > +	}
> > > > +	flush_work(&detector_work);
> > > > +	return 0;
> > > > +}
> > > > +late_initcall_sync(lockup_detector_check);
> 
> 
> OK, I think that the three states are too complicated. I suggest to
> use only a single bool. Something like:
> 
> static bool lockup_detector_pending_init __initdata;
> 
> struct wait_queue_head lockup_detector_wait __initdata =
> 		__WAIT_QUEUE_HEAD_INITIALIZER(lockup_detector_wait);
> 
> static struct work_struct detector_work __initdata =
> 		__WORK_INITIALIZER(lockup_detector_work,
> 				   lockup_detector_delay_init);
> 
> static void __init lockup_detector_delay_init(struct work_struct *work)
> {
> 	int ret;
> 
> 	wait_event(lockup_detector_wait, lockup_detector_pending_init == false);
> 
> 	ret = watchdog_nmi_probe();
> 	if (ret) {
> 		pr_info("Delayed init of the lockup detector failed: %\n);
> 		pr_info("Perf NMI watchdog permanently disabled\n");
> 		return;
> 	}
> 
> 	nmi_watchdog_available = true;
> 	lockup_detector_setup();
> }
> 
> /* Trigger delayedEnsure the check is called after the initialization of PMU driver */
> static int __init lockup_detector_check(void)
> {
> 	if (!lockup_detector_pending_init)
> 		return;
> 
> 	lockup_detector_pending_init = false;
> 	wake_up(&lockup_detector_wait);
> 	return 0;
> }
> late_initcall_sync(lockup_detector_check);
> 
> void __init lockup_detector_init(void)
> {
> 	int ret;
> 
> 	if (tick_nohz_full_enabled())
> 		pr_info("Disabling watchdog on nohz_full cores by default\n");
> 
> 	cpumask_copy(&watchdog_cpumask,
> 		     housekeeping_cpumask(HK_FLAG_TIMER));
> 
> 	ret = watchdog_nmi_probe();
> 	if (!ret)
> 		nmi_watchdog_available = true;
> 	else if (ret == -EBUSY) {
> 		detector_delay_pending_init = true;
> 		/* Init must be done in a process context on a bound CPU. */
> 		queue_work_on(smp_processor_id(), system_wq, 
> 				  &lockup_detector_work);
> 	}
> 
> 	lockup_detector_setup();
> 	watchdog_sysctl_init();
> }
> 
> The result is that lockup_detector_work() will never stay blocked
> forever. There are two possibilities:
> 
> 1.  lockup_detector_work() called before lockup_detector_check().
>     In this case, wait_event() will wait until lockup_detector_check()
>     clears detector_delay_pending_init and calls wake_up().
> 
> 2. lockup_detector_check() called before lockup_detector_work().
>    In this case, wait_even() will immediately continue because
>    it will see cleared detector_delay_pending_init.
> 

Thanks, I think this logic is much simpler than three states for our use case now,
It also fits the call flow described above, I will revise it base on this
code.


Thanks a lot for your code and review!

BRs,
Lecopzer
