Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6534C48A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiBYPUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiBYPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:20:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EEC8C7DF;
        Fri, 25 Feb 2022 07:20:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 20E541F380;
        Fri, 25 Feb 2022 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645802416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76D+b8ZUFKHayJqezaXTrIOKH/+w6Mr9BDaG1qJPaqM=;
        b=uiwU9753hHXtDfEByGOp/4k3/mpSpC2iPS5R74LN2olK1KIV4kIuD6y8ARyLKPI+57XebW
        laXnAzMwXNXHJgSFsi5gA5ifwF1cCKT2ypgNk9DHv/UzKegXnyQUGwO9FQLe7NALffYOqs
        LFAeojvzfBLhLsnUVHoCuDy01kc+AaU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 81174A3B83;
        Fri, 25 Feb 2022 15:20:15 +0000 (UTC)
Date:   Fri, 25 Feb 2022 16:20:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, davem@davemloft.net,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sumit.garg@linaro.org,
        kernelfans@gmail.com, yj.chiang@mediatek.com
Subject: Re: [PATCH 4/5] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <Yhjzr8geK7dTXXd2@alley>
References: <20220212104349.14266-1-lecopzer.chen@mediatek.com>
 <20220212104349.14266-5-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212104349.14266-5-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-02-12 18:43:48, Lecopzer Chen wrote:
> From: Pingfan Liu <kernelfans@gmail.com>
> 
> from: Pingfan Liu <kernelfans@gmail.com>
> 
> When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> yet. E.g. on arm64, PMU is not ready until
> device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> with the driver model and cpuhp. Hence it is hard to push this
> initialization before smp_init().
> 
> But it is easy to take an opposite approach by enabling watchdog_hld to
> get the capability of PMU async.
> 
> The async model is achieved by expanding watchdog_nmi_probe() with
> -EBUSY, and a re-initializing work_struct which waits on a wait_queue_head.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Co-developed-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  kernel/watchdog.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index b71d434cf648..fa8490cfeef8 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -839,16 +843,64 @@ static void __init watchdog_sysctl_init(void)
>  #define watchdog_sysctl_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
> +static void lockup_detector_delay_init(struct work_struct *work);
> +enum hld_detector_state detector_delay_init_state __initdata;

I would call this "lockup_detector_init_state" to use the same
naming scheme everywhere.

> +
> +struct wait_queue_head hld_detector_wait __initdata =
> +		__WAIT_QUEUE_HEAD_INITIALIZER(hld_detector_wait);
> +
> +static struct work_struct detector_work __initdata =

I would call this "lockup_detector_work" to use the same naming scheme
everywhere.

> +		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
> +
> +static void __init lockup_detector_delay_init(struct work_struct *work)
> +{
> +	int ret;
> +
> +	wait_event(hld_detector_wait,
> +			detector_delay_init_state == DELAY_INIT_READY);

DELAY_INIT_READY is defined in the 5th patch.

There are many other build errors because this patch uses something
that is defined in the 5th patch.

> +	ret = watchdog_nmi_probe();
> +	if (!ret) {
> +		nmi_watchdog_available = true;
> +		lockup_detector_setup();
> +	} else {
> +		WARN_ON(ret == -EBUSY);

Why WARN_ON(), please?

Note that it might cause panic() when "panic_on_warn" command line
parameter is used.

Also the backtrace will not help much. The context is well known.
This code is called from a workqueue worker.


> +		pr_info("Perf NMI watchdog permanently disabled\n");
> +	}
> +}
> +
> +/* Ensure the check is called after the initialization of PMU driver */
> +static int __init lockup_detector_check(void)
> +{
> +	if (detector_delay_init_state < DELAY_INIT_WAIT)
> +		return 0;
> +
> +	if (WARN_ON(detector_delay_init_state == DELAY_INIT_WAIT)) {

Again. Is WARN_ON() needed?

Also the condition looks wrong. IMHO, this is the expected state.

> +		detector_delay_init_state = DELAY_INIT_READY;
> +		wake_up(&hld_detector_wait);
> +	}
> +	flush_work(&detector_work);
> +	return 0;
> +}
> +late_initcall_sync(lockup_detector_check);

Otherwise, it make sense.

Best Regards,
Petr

PS: I am not going to review the last patch because I am no familiar
    with arm. I reviewed just the changes in the generic watchdog
    code.
