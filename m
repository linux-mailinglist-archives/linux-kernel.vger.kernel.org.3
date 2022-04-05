Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5C4F49AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443916AbiDEWUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455710AbiDEQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB771D310;
        Tue,  5 Apr 2022 08:19:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EDAF6210DE;
        Tue,  5 Apr 2022 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649171971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AUaCL0W4jHwKamsmD5VqBN+3A3UfQ6aVKoMK0LhECXY=;
        b=a4sG92MVGf37CQeLB+XZVjYv2GHIwuzBOfLNOrkSLltR8rVJAMiL70GClf7Ilj5pI58Ug+
        r5J4lVPcvWThTyiJH0rb9jdVD1/cT6W4UlE+3rv+qg8vTg7+udhg1Jf+hxs6Q0tU3+5bx+
        kfxmTkkuL0P3NjRxrXZ57wrS9n8o60k=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE2A6A3B82;
        Tue,  5 Apr 2022 15:19:30 +0000 (UTC)
Date:   Tue, 5 Apr 2022 17:19:28 +0200
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
Subject: Re: [PATCH v3 4/5] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <YkxeAM+SwYHAnJE1@alley>
References: <20220404144113.GB26840@pathway.suse.cz>
 <20220405133503.4487-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405133503.4487-1-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 21:35:03, Lecopzer Chen wrote:
> > On Thu 2022-03-24 22:14:04, Lecopzer Chen wrote:
> > > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > > yet. E.g. on arm64, PMU is not ready until
> > > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > > with the driver model and cpuhp. Hence it is hard to push this
> > > initialization before smp_init().
> > > 
> > > But it is easy to take an opposite approach and try to initialize
> > > the watchdog once again later.
> > > The delayed probe is called using workqueues. It need to allocate
> > > memory and must be proceed in a normal context.
> > > The delayed probe is queued only when the early one returns -EBUSY.
> > > It is the return code returned when PMU is not ready yet.
> > > 
> > > Provide an API - retry_lockup_detector_init() for anyone who needs
> > > to delayed init lockup detector.
> > > 
> > > The original assumption is: nobody should use delayed probe after
> > > lockup_detector_check() which has __init attribute.
> > > That is, anyone uses this API must call between lockup_detector_init()
> > > and lockup_detector_check(), and the caller must have __init attribute
> > > 
> > > --- a/kernel/watchdog.c
> > > +++ b/kernel/watchdog.c
> > > +}
> > > +
> > > +/*
> > > + * retry_lockup_detector_init - retry init lockup detector if possible.
> > > + *
> > > + * Only take effect when allow_lockup_detector_init_retry is true, which
> > > + * means it must call between lockup_detector_init() and lockup_detector_check().
> > > + * Be aware that caller must have __init attribute, relative functions
> > > + * will be freed after kernel initialization.
> > > + */
> > > +void __init retry_lockup_detector_init(void)
> > > +{
> > > +	if (!allow_lockup_detector_init_retry)
> > > +		return;
> > > +
> > > +	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> > > +}
> > > +
> > > +/* Ensure the check is called after the initialization of driver */
> > > +static int __init lockup_detector_check(void)
> > > +{
> > > +	/* Make sure no work is pending. */
> > > +	flush_work(&detector_work);
> > 
> > This is racy. We should first disable
> > "allow_lockup_detector_init_retry" to make sure
> > that retry_lockup_detector_init() will not queue
> > the work any longer.
> 
> But disable before flush_work will make the 
>     lockup_detector_delay_init() ->
>     watchdog_nmi_probe ->
>     +	if (!allow_lockup_detector_init_retry)
>     +		return -EBUSY;

I see. It is exactly the reason why I suggest to remove the
optimization and keep the code simple.

> how about:
> ...
> static bool __init delayed_init_allowed = true;
> ...
> /*
>  * retry_lockup_detector_init - retry init lockup detector if possible.
>  *
>  * Only take effect when allow_lockup_detector_init_retry is true, which
>  * means it must call between lockup_detector_init() and lockup_detector_check().
>  * Be aware that caller must have __init attribute, relative functions
>  * will be freed after kernel initialization.
>  */
> void __init retry_lockup_detector_init(void)
> {
> 	if (!allow_lockup_detector_init_retry || !delayed_init_allowed)
> 		return;
> 
> 	/* 
> 	 * we shouldn't queue any delayed init work twice to avoid
> 	 * any unwanted racy.
> 	 */
> 	delayed_init_allowed = false;

Grrr, this is so complicated and confusing. It might be because of
badly selected variable names or comments. But I think that it is
simply a bad approach.

OK, you suggest two variables. If I get it correctly:

    + The variable "delayed_init_allowed"
     tries to prevent the race in lockup_detector_check().

     It will make sure that the work could not be queued after
     flush_work() finishes.

     Is this obvious from the comment?
     Is this obvious from the variable name?

     I am sorry. But it is not obvious to me. I understand it only
     because I see it together in this mail. It will be pretty
     hard to get it from the code when I see it one year later.


   + The variable "allow_lockup_detector_init_retry" has an unclear
     meaning. It might mean:

	+ watchdog_nmi_probe() ended with -EBUSY in
	  lockup_detector_init() and we can try the delayed init.

	+ but it also means that watchdog_nmi_probe() succeeded in
	  lockup_detector_delay_init() and there is no need to
	  try the delayed init any longer.

       Is this obvious from the variable name?
       Is it explained anywhere?
       Is it easy to understand?

       No, from my POV. It is really bad idea to have a single
       variable with so many meanings.


And this is my problem with this approach. There was one variable with
unclear meanting. And you are trying to fix it by two variables
with unclear meaning.

> 	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> }
> 
> 
> /*
>  * Ensure the check is called after the initialization of driver
>  * and before removing init code.
>  */
> static int __init lockup_detector_check(void)
> {
> 	delayed_init_allowed = false;
> 	flush_work(&detector_work);
> 	allow_lockup_detector_init_retry = false;
> 
> 	return 0;
> }

No, please keep it simple. Just have one variable that will say
whether we are allowed to queue the work:

  + It will be allowed when watchdog_nmi_probe() ended
    with -EBUSY in lockup_detector_init()

  + It will not longer be allowed when watchdog_nmi_probe()
    succeeded or when lockup_detector_check() flushes
    the pending works.


Best Regards,
Petr
