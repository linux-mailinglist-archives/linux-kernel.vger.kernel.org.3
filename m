Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2EB4F4A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456280AbiDEWpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388908AbiDEPUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:20:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1033C625B;
        Tue,  5 Apr 2022 06:35:13 -0700 (PDT)
X-UUID: cc3c544588a74722b01236958dfe2cf2-20220405
X-UUID: cc3c544588a74722b01236958dfe2cf2-20220405
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1758654438; Tue, 05 Apr 2022 21:35:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 5 Apr 2022 21:35:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Apr 2022 21:35:03 +0800
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
Subject: Re: [PATCH v3 4/5] kernel/watchdog: Adapt the watchdog_hld interface for async model 
Date:   Tue, 5 Apr 2022 21:35:03 +0800
Message-ID: <20220405133503.4487-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220404144113.GB26840@pathway.suse.cz>
References: <20220404144113.GB26840@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu 2022-03-24 22:14:04, Lecopzer Chen wrote:
> > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > yet. E.g. on arm64, PMU is not ready until
> > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > with the driver model and cpuhp. Hence it is hard to push this
> > initialization before smp_init().
> > 
> > But it is easy to take an opposite approach and try to initialize
> > the watchdog once again later.
> > The delayed probe is called using workqueues. It need to allocate
> > memory and must be proceed in a normal context.
> > The delayed probe is queued only when the early one returns -EBUSY.
> > It is the return code returned when PMU is not ready yet.
> > 
> > Provide an API - retry_lockup_detector_init() for anyone who needs
> > to delayed init lockup detector.
> > 
> > The original assumption is: nobody should use delayed probe after
> > lockup_detector_check() which has __init attribute.
> > That is, anyone uses this API must call between lockup_detector_init()
> > and lockup_detector_check(), and the caller must have __init attribute
> > 
> > Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/linux/nmi.h |  3 ++
> >  kernel/watchdog.c   | 69 +++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 70 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > index b7bcd63c36b4..1d84c9a8b460 100644
> > --- a/include/linux/nmi.h
> > +++ b/include/linux/nmi.h
> > @@ -118,6 +118,9 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
> >  
> >  void watchdog_nmi_stop(void);
> >  void watchdog_nmi_start(void);
> > +
> > +extern bool allow_lockup_detector_init_retry;
> > +void retry_lockup_detector_init(void);
> >  int watchdog_nmi_probe(void);
> >  void watchdog_nmi_enable(unsigned int cpu);
> >  void watchdog_nmi_disable(unsigned int cpu);
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index b71d434cf648..308ba29f8f0f 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -103,7 +103,13 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
> >  	hardlockup_detector_perf_disable();
> >  }
> >  
> > -/* Return 0, if a NMI watchdog is available. Error code otherwise */
> > +/*
> > + * Arch specific API.
> > + *
> > + * Return 0 when NMI watchdog is available, negative value otherwise.
> > + * The error code -EBUSY is special. It means that a deferred probe
> > + * might succeed later.
> > + */
> >  int __weak __init watchdog_nmi_probe(void)
> >  {
> >  	return hardlockup_detector_perf_init();
> > @@ -839,16 +845,75 @@ static void __init watchdog_sysctl_init(void)
> >  #define watchdog_sysctl_init() do { } while (0)
> >  #endif /* CONFIG_SYSCTL */
> >  
> > +static void lockup_detector_delay_init(struct work_struct *work);
> > +bool allow_lockup_detector_init_retry __initdata;
> > +
> > +static struct work_struct detector_work __initdata =
> > +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> > +
> > +static void __init lockup_detector_delay_init(struct work_struct *work)
> > +{
> > +	int ret;
> > +
> > +	ret = watchdog_nmi_probe();
> > +	if (ret) {
> > +		pr_info("Delayed init of the lockup detector failed: %d\n", ret);
> > +		pr_info("Perf NMI watchdog permanently disabled\n");
> > +		return;
> > +	}
> > +
> > +	nmi_watchdog_available = true;
> > +	lockup_detector_setup();
> 
> The name of the variable "allow_lockup_detector_init_retry" is
> slightly confusing in this context. I suggest to add a comment:
> 
> 	/* Retry is not needed any longer. */
> > +	allow_lockup_detector_init_retry = false;
> 

Got it, I'll add it, thanks.


> 
> > +}
> > +
> > +/*
> > + * retry_lockup_detector_init - retry init lockup detector if possible.
> > + *
> > + * Only take effect when allow_lockup_detector_init_retry is true, which
> > + * means it must call between lockup_detector_init() and lockup_detector_check().
> > + * Be aware that caller must have __init attribute, relative functions
> > + * will be freed after kernel initialization.
> > + */
> > +void __init retry_lockup_detector_init(void)
> > +{
> > +	if (!allow_lockup_detector_init_retry)
> > +		return;
> > +
> > +	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> > +}
> > +
> > +/* Ensure the check is called after the initialization of driver */
> > +static int __init lockup_detector_check(void)
> > +{
> > +	/* Make sure no work is pending. */
> > +	flush_work(&detector_work);
> 
> This is racy. We should first disable
> "allow_lockup_detector_init_retry" to make sure
> that retry_lockup_detector_init() will not queue
> the work any longer.

But disable before flush_work will make the 
    lockup_detector_delay_init() ->
    watchdog_nmi_probe ->
    +	if (!allow_lockup_detector_init_retry)
    +		return -EBUSY;

Plese check the code I provide below.


> 
> > +	if (!allow_lockup_detector_init_retry)
> > +		return 0;
> > +
> > +	allow_lockup_detector_init_retry = false;
> > +	pr_info("Delayed init checking failed, please check your driver.\n");
> 
> This prints that the init failed without checking the state
> of the watchdog. I guess that it works but it is far from
> obvious and any further change might break it.
> 
> Is the message really needed?
> Does it help?
> What exact driver needs checking?
> 
> IMHO, it just makes the code more complicated and
> it is not worth it.
> 

I think you're right, the message was needed in the patch v2 because we
did another retry in lockup_detector_check().
But now we only do "checking" and the failed message in
lockup_detector_delay_init should be enough.


> I suggest to keep it simple:
> 
> /*
>  * Ensure the check is called after the initialization of driver
>  * and before removing init code.
>  */
> static int __init lockup_detector_check(void)
> {
> 	allow_lockup_detector_init_retry = false;
> 	flush_work(&detector_work);
> 
> 	return 0;
> }
> 


Combine with the first racy problem, let me limit retry_lockup_detector_init
can be called only once.

how about:
...
static bool __init delayed_init_allowed = true;
...
/*
 * retry_lockup_detector_init - retry init lockup detector if possible.
 *
 * Only take effect when allow_lockup_detector_init_retry is true, which
 * means it must call between lockup_detector_init() and lockup_detector_check().
 * Be aware that caller must have __init attribute, relative functions
 * will be freed after kernel initialization.
 */
void __init retry_lockup_detector_init(void)
{
	if (!allow_lockup_detector_init_retry || !delayed_init_allowed)
		return;

	/* 
	 * we shouldn't queue any delayed init work twice to avoid
	 * any unwanted racy.
	 */
	delayed_init_allowed = false;
	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
}


/*
 * Ensure the check is called after the initialization of driver
 * and before removing init code.
 */
static int __init lockup_detector_check(void)
{
	delayed_init_allowed = false;
	flush_work(&detector_work);
	allow_lockup_detector_init_retry = false;

	return 0;
}



> or if you really want that message then I would do:
> 
> /*
>  * Ensure the check is called after the initialization of driver
>  * and before removing init code.
>  */
> static int __init lockup_detector_check(void)
> {
> 	bool delayed_init_allowed = allow_lockup_detector_init_retry;
> 
> 	allow_lockup_detector_init_retry = false;
> 	flush_work(&detector_work);
> 
> 	if (delayed_init_allowed && !nmi_watchdog_available)
> 		pr_info("Delayed init failed. Please, check your driver.\n");
> 
> 	return 0;
> }
> 


thanks
BRs,
Lecopzer
