Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BA4F177B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378261AbiDDOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379674AbiDDOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:45:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA71A40A08;
        Mon,  4 Apr 2022 07:41:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8A4D11F381;
        Mon,  4 Apr 2022 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649083274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1hUy9Z7t/TX9ZMrDfSqRcc30TzPK6DZa4A2U57uryQ=;
        b=lb4vB1fhyBQGU3jebbX7RlDvjfDoGQEjomdeljJ0NfL0i9i42/cLNXiwdAyoDd+PKSUho8
        gVfhBn9AMJMX6oAspaWNbNARQ59DJUbV+2pv/Nm2+Wd6yshafJFamigARCIieUqQvdx6BA
        YKoS6VZzAyPqvvErJKMiyy/LRfVzeNg=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07258A3B82;
        Mon,  4 Apr 2022 14:41:14 +0000 (UTC)
Date:   Mon, 4 Apr 2022 16:41:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        catalin.marinas@arm.com, davem@davemloft.net, jolsa@redhat.com,
        jthierry@redhat.com, keescook@chromium.org, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com, maz@kernel.org,
        mcgrof@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        sparclinux@vger.kernel.org, sumit.garg@linaro.org,
        wangqing@vivo.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v3 4/5] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <20220404144113.GB26840@pathway.suse.cz>
References: <20220324141405.10835-1-lecopzer.chen@mediatek.com>
 <20220324141405.10835-5-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324141405.10835-5-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-03-24 22:14:04, Lecopzer Chen wrote:
> When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> yet. E.g. on arm64, PMU is not ready until
> device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> with the driver model and cpuhp. Hence it is hard to push this
> initialization before smp_init().
> 
> But it is easy to take an opposite approach and try to initialize
> the watchdog once again later.
> The delayed probe is called using workqueues. It need to allocate
> memory and must be proceed in a normal context.
> The delayed probe is queued only when the early one returns -EBUSY.
> It is the return code returned when PMU is not ready yet.
> 
> Provide an API - retry_lockup_detector_init() for anyone who needs
> to delayed init lockup detector.
> 
> The original assumption is: nobody should use delayed probe after
> lockup_detector_check() which has __init attribute.
> That is, anyone uses this API must call between lockup_detector_init()
> and lockup_detector_check(), and the caller must have __init attribute
> 
> Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/nmi.h |  3 ++
>  kernel/watchdog.c   | 69 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index b7bcd63c36b4..1d84c9a8b460 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -118,6 +118,9 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
>  
>  void watchdog_nmi_stop(void);
>  void watchdog_nmi_start(void);
> +
> +extern bool allow_lockup_detector_init_retry;
> +void retry_lockup_detector_init(void);
>  int watchdog_nmi_probe(void);
>  void watchdog_nmi_enable(unsigned int cpu);
>  void watchdog_nmi_disable(unsigned int cpu);
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index b71d434cf648..308ba29f8f0f 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -103,7 +103,13 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
>  	hardlockup_detector_perf_disable();
>  }
>  
> -/* Return 0, if a NMI watchdog is available. Error code otherwise */
> +/*
> + * Arch specific API.
> + *
> + * Return 0 when NMI watchdog is available, negative value otherwise.
> + * The error code -EBUSY is special. It means that a deferred probe
> + * might succeed later.
> + */
>  int __weak __init watchdog_nmi_probe(void)
>  {
>  	return hardlockup_detector_perf_init();
> @@ -839,16 +845,75 @@ static void __init watchdog_sysctl_init(void)
>  #define watchdog_sysctl_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
> +static void lockup_detector_delay_init(struct work_struct *work);
> +bool allow_lockup_detector_init_retry __initdata;
> +
> +static struct work_struct detector_work __initdata =
> +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> +
> +static void __init lockup_detector_delay_init(struct work_struct *work)
> +{
> +	int ret;
> +
> +	ret = watchdog_nmi_probe();
> +	if (ret) {
> +		pr_info("Delayed init of the lockup detector failed: %d\n", ret);
> +		pr_info("Perf NMI watchdog permanently disabled\n");
> +		return;
> +	}
> +
> +	nmi_watchdog_available = true;
> +	lockup_detector_setup();

The name of the variable "allow_lockup_detector_init_retry" is
slightly confusing in this context. I suggest to add a comment:

	/* Retry is not needed any longer. */
> +	allow_lockup_detector_init_retry = false;


> +}
> +
> +/*
> + * retry_lockup_detector_init - retry init lockup detector if possible.
> + *
> + * Only take effect when allow_lockup_detector_init_retry is true, which
> + * means it must call between lockup_detector_init() and lockup_detector_check().
> + * Be aware that caller must have __init attribute, relative functions
> + * will be freed after kernel initialization.
> + */
> +void __init retry_lockup_detector_init(void)
> +{
> +	if (!allow_lockup_detector_init_retry)
> +		return;
> +
> +	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> +}
> +
> +/* Ensure the check is called after the initialization of driver */
> +static int __init lockup_detector_check(void)
> +{
> +	/* Make sure no work is pending. */
> +	flush_work(&detector_work);

This is racy. We should first disable
"allow_lockup_detector_init_retry" to make sure
that retry_lockup_detector_init() will not queue
the work any longer.

> +	if (!allow_lockup_detector_init_retry)
> +		return 0;
> +
> +	allow_lockup_detector_init_retry = false;
> +	pr_info("Delayed init checking failed, please check your driver.\n");

This prints that the init failed without checking the state
of the watchdog. I guess that it works but it is far from
obvious and any further change might break it.

Is the message really needed?
Does it help?
What exact driver needs checking?

IMHO, it just makes the code more complicated and
it is not worth it.

I suggest to keep it simple:

/*
 * Ensure the check is called after the initialization of driver
 * and before removing init code.
 */
static int __init lockup_detector_check(void)
{
	allow_lockup_detector_init_retry = false;
	flush_work(&detector_work);

	return 0;
}

or if you really want that message then I would do:

/*
 * Ensure the check is called after the initialization of driver
 * and before removing init code.
 */
static int __init lockup_detector_check(void)
{
	bool delayed_init_allowed = allow_lockup_detector_init_retry;

	allow_lockup_detector_init_retry = false;
	flush_work(&detector_work);

	if (delayed_init_allowed && !nmi_watchdog_available)
		pr_info("Delayed init failed. Please, check your driver.\n");

	return 0;
}

Best Regards,
Petr
