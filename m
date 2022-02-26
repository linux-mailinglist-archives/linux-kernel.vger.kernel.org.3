Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53944C554B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiBZKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBZKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:53:15 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B542A1A;
        Sat, 26 Feb 2022 02:52:35 -0800 (PST)
X-UUID: 430014f3bf804ade8d02b08d99d484e2-20220226
X-UUID: 430014f3bf804ade8d02b08d99d484e2-20220226
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 429990658; Sat, 26 Feb 2022 18:52:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 26 Feb 2022 18:52:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Feb 2022 18:52:29 +0800
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
Date:   Sat, 26 Feb 2022 18:52:29 +0800
Message-ID: <20220226105229.16378-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Yhjzr8geK7dTXXd2@alley>
References: <Yhjzr8geK7dTXXd2@alley>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat 2022-02-12 18:43:48, Lecopzer Chen wrote:
> > From: Pingfan Liu <kernelfans@gmail.com>
> > 
> > from: Pingfan Liu <kernelfans@gmail.com>
> > 
> > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > yet. E.g. on arm64, PMU is not ready until
> > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > with the driver model and cpuhp. Hence it is hard to push this
> > initialization before smp_init().
> > 
> > But it is easy to take an opposite approach by enabling watchdog_hld to
> > get the capability of PMU async.
> > 
> > The async model is achieved by expanding watchdog_nmi_probe() with
> > -EBUSY, and a re-initializing work_struct which waits on a wait_queue_head.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Co-developed-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  kernel/watchdog.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 54 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index b71d434cf648..fa8490cfeef8 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -839,16 +843,64 @@ static void __init watchdog_sysctl_init(void)
> >  #define watchdog_sysctl_init() do { } while (0)
> >  #endif /* CONFIG_SYSCTL */
> >  
> > +static void lockup_detector_delay_init(struct work_struct *work);
> > +enum hld_detector_state detector_delay_init_state __initdata;
> 
> I would call this "lockup_detector_init_state" to use the same
> naming scheme everywhere.
> 
> > +
> > +struct wait_queue_head hld_detector_wait __initdata =
> > +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> > +
> > +static struct work_struct detector_work __initdata =
> 
> I would call this "lockup_detector_work" to use the same naming scheme
> everywhere.

For the naming part, I'll revise both of them in next patch.

> 
> > +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> > +
> > +static void __init lockup_detector_delay_init(struct work_struct *work)
> > +{
> > +	int ret;
> > +
> > +	wait_event(hld_detector_wait,
> > +			detector_delay_init_state == DELAY_INIT_READY);
> 
> DELAY_INIT_READY is defined in the 5th patch.
> 
> There are many other build errors because this patch uses something
> that is defined in the 5th patch.

Thanks for pointing this out, the I'll fix 4th and 5th patches to correct the order.

> 
> > +	ret = watchdog_nmi_probe();
> > +	if (!ret) {
> > +		nmi_watchdog_available = true;
> > +		lockup_detector_setup();
> > +	} else {
> > +		WARN_ON(ret == -EBUSY);
> 
> Why WARN_ON(), please?
> 
> Note that it might cause panic() when "panic_on_warn" command line
> parameter is used.
> 
> Also the backtrace will not help much. The context is well known.
> This code is called from a workqueue worker.
 
The motivation to WARN should be:

lockup_detector_init
-> watchdog_nmi_probe return -EBUSY
-> lockup_detector_delay_init checks (detector_delay_init_state == DELAY_INIT_READY)
-> watchdog_nmi_probe checks
+	if (detector_delay_init_state != DELAY_INIT_READY)
+		return -EBUSY;

Since we first check detector_delay_init_state equals to DELAY_INIT_READY
and goes into watchdog_nmi_probe() and checks detector_delay_init_state again
becasue now we move from common part to arch part code.
In this condition, there shouldn't have any racing to detector_delay_init_state.
If it does happend an unknown racing, then shows a warning to it.

I think it make sense to remove WARN now becasue it looks verbosely...
However, I would rather change the following printk to
"Delayed init for lockup detector failed."

Is this fine with you?



> 
> > +		pr_info("Perf NMI watchdog permanently disabled\n");
> > +	}
> > +}
> > +
> > +/* Ensure the check is called after the initialization of PMU driver */
> > +static int __init lockup_detector_check(void)
> > +{
> > +	if (detector_delay_init_state < DELAY_INIT_WAIT)
> > +		return 0;
> > +
> > +	if (WARN_ON(detector_delay_init_state == DELAY_INIT_WAIT)) {
> 
> Again. Is WARN_ON() needed?
> 
> Also the condition looks wrong. IMHO, this is the expected state.
> 

This does expected DELAY_INIT_READY here, which means,
every one who comes here to be checked should be READY and WARN if you're
still in WAIT state, and which means the previous lockup_detector_delay_init()
failed.

IMO, either keeping or removing WARN is fine with me.

I think I'll remove WARN and add
pr_info("Delayed init checking for lockup detector failed, retry for once.");
inside the `if (detector_delay_init_state == DELAY_INIT_WAIT)`

Or would you have any other suggestion? thanks.

> > +		detector_delay_init_state = DELAY_INIT_READY;
> > +		wake_up(&hld_detector_wait);
> > +	}
> > +	flush_work(&detector_work);
> > +	return 0;
> > +}
> > +late_initcall_sync(lockup_detector_check);
> 
> Otherwise, it make sense.
> 
> Best Regards,
> Petr
> 
> PS: I am not going to review the last patch because I am no familiar
>     with arm. I reviewed just the changes in the generic watchdog
>     code.

Thanks again for your review.


BRs,
Lecopzer
