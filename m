Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8944DD85D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiCRKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiCRKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:42:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D7E2E5189;
        Fri, 18 Mar 2022 03:40:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE2A11F390;
        Fri, 18 Mar 2022 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647600034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eAuiFb+OsFON4yFjKLQAFK1dNFxRsTZb0OnrTTRn9u0=;
        b=C32sGETYRNnx5Wr8LQxLIcbYrT0DnLCxlclsrJfisEggI2MYD0T8o8/CrHNpZcBjoK1VdT
        IuD1+udT+EDwEVmHcfnZNIpGNuSCmV63GQW/SnEpa40zWyu7spaviICSz3zugBpPoOCc2r
        PPqFl/cthhqlzZ1HPJOrpBbQGOKDa8k=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 46B10A3B8A;
        Fri, 18 Mar 2022 10:40:34 +0000 (UTC)
Date:   Fri, 18 Mar 2022 11:40:31 +0100
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
Subject: Re: [PATCH v2 4/5] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <YjRhnxg3L3cHUU/l@alley>
References: <20220307154729.13477-1-lecopzer.chen@mediatek.com>
 <20220307154729.13477-5-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307154729.13477-5-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-03-07 23:47:28, Lecopzer Chen wrote:
> When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> yet. E.g. on arm64, PMU is not ready until
> device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> with the driver model and cpuhp. Hence it is hard to push this
> initialization before smp_init().

The above is clear.

> But it is easy to take an opposite approach by enabling watchdog_hld to
> get the capability of PMU async.
> 
> The async model is achieved by expanding watchdog_nmi_probe() with
> -EBUSY, and a re-initializing work_struct which waits on a wait_queue_head.

These two paragraphs are a bit confusing to me. It might be just a
problem with translation. I am not a native speaker. Anyway, I wonder
if the following is more clear:

<proposal>
But it is easy to take an opposite approach and try to initialize
the watchdog once again later.

The delayed probe is called using workqueues. It need to allocate
memory and must be proceed in a normal context.

The delayed probe is queued only when the early one returns -EBUSY.
It is the return code returned when PMU is not ready yet.
</proposal>

> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -103,7 +103,11 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
>  	hardlockup_detector_perf_disable();
>  }
>  
> -/* Return 0, if a NMI watchdog is available. Error code otherwise */
> +/*
> + * Arch specific API. Return 0, if a NMI watchdog is available. -EBUSY if not
> + * ready, and arch code should wake up hld_detector_wait when ready. Other
> + * negative value if not support.
> + */

I wonder if the following is slightly more clear:

 /*
 * Arch specific API.
 *
 * Return 0 when NMI watchdog is available, negative value otherwise.
 * The error code -EBUSY is special. It means that a deferred probe
 * might succeed later.
 */

>  int __weak __init watchdog_nmi_probe(void)
>  {
>  	return hardlockup_detector_perf_init();
> @@ -839,16 +843,70 @@ static void __init watchdog_sysctl_init(void)
>  #define watchdog_sysctl_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
> +static void lockup_detector_delay_init(struct work_struct *work);
> +bool lockup_detector_pending_init __initdata;
> +
> +struct wait_queue_head hld_detector_wait __initdata =
> +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> +
> +static struct work_struct detector_work __initdata =
> +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> +
> +static void __init lockup_detector_delay_init(struct work_struct *work)
> +{
> +	int ret;
> +
> +	wait_event(hld_detector_wait,
> +			lockup_detector_pending_init == false);
> +
> +	/*
> +	 * Here, we know the PMU should be ready, so set pending to true to
> +	 * inform watchdog_nmi_probe() that it shouldn't return -EBUSY again.
> +	 */
> +	lockup_detector_pending_init = true;

This does not make sense to me. We are here only when:

   1. lockup_detector_init() queued this work.

   2. Someone cleared @lockup_detector_pending_init and woke the
      worker via wait_queue. IT might be either PMU init code
      or the late lockup_detector_check().

watchdog_nmi_probe() might still return -EBUSY when PMU init failed.

If you wanted to try the delayed probe once again (3rd attempt) from
lockup_detector_check(), you would need to queue the work once again.
But you need to be sure that lockup_detector_check() was not called
yet. Otherwise, the 2nd work might wait forewer.

IMHO, it is not worth the complexity.

> +	ret = watchdog_nmi_probe();
> +	if (ret) {
> +		pr_info("Delayed init of the lockup detector failed: %d\n", ret);
> +		pr_info("Perf NMI watchdog permanently disabled\n");
> +		return;
> +	}
> +
> +	nmi_watchdog_available = true;
> +	lockup_detector_setup();
> +	lockup_detector_pending_init = false;
> +}

Otherwise, it looks good to me.

Best Regards,
Petr
