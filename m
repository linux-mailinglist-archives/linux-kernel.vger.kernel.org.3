Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B104F84E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbiDGQYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiDGQX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:23:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF21EF9C6;
        Thu,  7 Apr 2022 09:21:48 -0700 (PDT)
X-UUID: 0c4fcde325ee40d1ac7a75fc58780397-20220408
X-UUID: 0c4fcde325ee40d1ac7a75fc58780397-20220408
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2021688543; Fri, 08 Apr 2022 00:21:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Apr 2022 00:21:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 00:21:43 +0800
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
Date:   Fri, 8 Apr 2022 00:21:43 +0800
Message-ID: <20220407162143.1127-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YkxeAM+SwYHAnJE1@alley>
References: <YkxeAM+SwYHAnJE1@alley>
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

> On Tue 2022-04-05 21:35:03, Lecopzer Chen wrote:
> > > On Thu 2022-03-24 22:14:04, Lecopzer Chen wrote:
> > > > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > > > yet. E.g. on arm64, PMU is not ready until
> > > > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > > > with the driver model and cpuhp. Hence it is hard to push this
> > > > initialization before smp_init().
> > > > 
> > > > But it is easy to take an opposite approach and try to initialize
> > > > the watchdog once again later.
> > > > The delayed probe is called using workqueues. It need to allocate
> > > > memory and must be proceed in a normal context.
> > > > The delayed probe is queued only when the early one returns -EBUSY.
> > > > It is the return code returned when PMU is not ready yet.
> > > > 
> > > > Provide an API - retry_lockup_detector_init() for anyone who needs
> > > > to delayed init lockup detector.
> > > > 
> > > > The original assumption is: nobody should use delayed probe after
> > > > lockup_detector_check() which has __init attribute.
> > > > That is, anyone uses this API must call between lockup_detector_init()
> > > > and lockup_detector_check(), and the caller must have __init attribute
> > > > 
> > > > --- a/kernel/watchdog.c
> > > > +++ b/kernel/watchdog.c
> > > > +}
> > > > +
> > > > +/*
> > > > + * retry_lockup_detector_init - retry init lockup detector if possible.
> > > > + *
> > > > + * Only take effect when allow_lockup_detector_init_retry is true, which
> > > > + * means it must call between lockup_detector_init() and lockup_detector_check().
> > > > + * Be aware that caller must have __init attribute, relative functions
> > > > + * will be freed after kernel initialization.
> > > > + */
> > > > +void __init retry_lockup_detector_init(void)
> > > > +{
> > > > +	if (!allow_lockup_detector_init_retry)
> > > > +		return;
> > > > +
> > > > +	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> > > > +}
> > > > +
> > > > +/* Ensure the check is called after the initialization of driver */
> > > > +static int __init lockup_detector_check(void)
> > > > +{
> > > > +	/* Make sure no work is pending. */
> > > > +	flush_work(&detector_work);
> > > 
> > > This is racy. We should first disable
> > > "allow_lockup_detector_init_retry" to make sure
> > > that retry_lockup_detector_init() will not queue
> > > the work any longer.
> > 
> > But disable before flush_work will make the 
> >     lockup_detector_delay_init() ->
> >     watchdog_nmi_probe ->
> >     +	if (!allow_lockup_detector_init_retry)
> >     +		return -EBUSY;
> 
> I see. It is exactly the reason why I suggest to remove the
> optimization and keep the code simple.
> 
> > how about:
> > ...
> > static bool __init delayed_init_allowed = true;
> > ...
> > /*
> >  * retry_lockup_detector_init - retry init lockup detector if possible.
> >  *
> >  * Only take effect when allow_lockup_detector_init_retry is true, which
> >  * means it must call between lockup_detector_init() and lockup_detector_check().
> >  * Be aware that caller must have __init attribute, relative functions
> >  * will be freed after kernel initialization.
> >  */
> > void __init retry_lockup_detector_init(void)
> > {
> > 	if (!allow_lockup_detector_init_retry || !delayed_init_allowed)
> > 		return;
> > 
> > 	/* 
> > 	 * we shouldn't queue any delayed init work twice to avoid
> > 	 * any unwanted racy.
> > 	 */
> > 	delayed_init_allowed = false;
> 
> Grrr, this is so complicated and confusing. It might be because of
> badly selected variable names or comments. But I think that it is
> simply a bad approach.
> 
> OK, you suggest two variables. If I get it correctly:
> 
>     + The variable "delayed_init_allowed"
>      tries to prevent the race in lockup_detector_check().
> 
>      It will make sure that the work could not be queued after
>      flush_work() finishes.
> 
>      Is this obvious from the comment?
>      Is this obvious from the variable name?
> 
>      I am sorry. But it is not obvious to me. I understand it only
>      because I see it together in this mail. It will be pretty
>      hard to get it from the code when I see it one year later.
> 
> 
>    + The variable "allow_lockup_detector_init_retry" has an unclear
>      meaning. It might mean:
> 
> 	+ watchdog_nmi_probe() ended with -EBUSY in
> 	  lockup_detector_init() and we can try the delayed init.
> 
> 	+ but it also means that watchdog_nmi_probe() succeeded in
> 	  lockup_detector_delay_init() and there is no need to
> 	  try the delayed init any longer.
> 
>        Is this obvious from the variable name?
>        Is it explained anywhere?
>        Is it easy to understand?
> 
>        No, from my POV. It is really bad idea to have a single
>        variable with so many meanings.
> 
> 
> And this is my problem with this approach. There was one variable with
> unclear meanting. And you are trying to fix it by two variables
> with unclear meaning.
> 

I really apreciate for your reply, many thanks for it.

For my point of view, the naming for "delayed_init_allowed" is the
whole system state now is able to(allowed) do delayed init.
The "allow_lockup_detector_init_retry" is that delayed init is ready
to retry register NMI watchdog.

Thus the meaning of delayed_init_"allowed" is, we are allowed to
do delayed init including
    1. initialization of delayed init
    2. the retry of delayed init

I'm sorry for that I didn't express the meaning clearly.
I'll have definition in detail in the later version patch not only
a brief comment and I hope you can review much easier.
This only explain the thought how I made decision for the naming.

So let me back to the discussion below.



> > 	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> > }
> > 
> > 
> > /*
> >  * Ensure the check is called after the initialization of driver
> >  * and before removing init code.
> >  */
> > static int __init lockup_detector_check(void)
> > {
> > 	delayed_init_allowed = false;
> > 	flush_work(&detector_work);
> > 	allow_lockup_detector_init_retry = false;
> > 
> > 	return 0;
> > }
> 
> No, please keep it simple. Just have one variable that will say
> whether we are allowed to queue the work:
> 
>   + It will be allowed when watchdog_nmi_probe() ended
>     with -EBUSY in lockup_detector_init()
> 
>   + It will not longer be allowed when watchdog_nmi_probe()
>     succeeded or when lockup_detector_check() flushes
>     the pending works.
> 

Okay, let me think about it. I'll try to find a better solution that
only uses one variable.
And it's strongly about how users use it in 5th patch, I'll give further
reply in 5th patch


thanks
BRs,
Lecopzer




