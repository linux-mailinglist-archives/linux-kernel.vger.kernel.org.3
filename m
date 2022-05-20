Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372B952E8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347739AbiETJiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiETJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:38:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B1E5D1B7;
        Fri, 20 May 2022 02:38:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C26CB1F9EE;
        Fri, 20 May 2022 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653039524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vwa8jgE6ubsEKfUz+gYRve0wuQBCRznCtklt59zTV6Q=;
        b=n4FUsnYY/xBnyS3SXETnotHd5Ec72kh2zh+Dai5f7buZTjDHEcxmvFl76tcNcSiGnbmu5U
        COCabwTrl3uU15SJXqrrKAF+acixaXA+4I53JuXXoiexiw5MqutnBzZx+zmDOKwi0qKMRt
        enjPGTMixqFSFTH0zMOo/VadTvKZals=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 27E2F2C142;
        Fri, 20 May 2022 09:38:44 +0000 (UTC)
Date:   Fri, 20 May 2022 11:38:43 +0200
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
Subject: Re: [PATCH v4 4/6] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <YodhoxG0xmfrNYoN@alley>
References: <20220427161340.8518-1-lecopzer.chen@mediatek.com>
 <20220427161340.8518-5-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161340.8518-5-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-28 00:13:38, Lecopzer Chen wrote:
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
> The delayed probe is able to use if watchdog_nmi_probe() returns
> non-zero which means the return code returned when PMU is not ready yet.
> 
> Provide an API - retry_lockup_detector_init() for anyone who needs
> to delayed init lockup detector if they had ever failed at
> lockup_detector_init().
> 
> The original assumption is: nobody should use delayed probe after
> lockup_detector_check() which has __init attribute.
> That is, anyone uses this API must call between lockup_detector_init()
> and lockup_detector_check(), and the caller must have __init attribute
> 
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> +/*
> + * retry_lockup_detector_init - retry init lockup detector if possible.
> + *
> + * Retry hardlockup detector init. It is useful when it requires some
> + * functionality that has to be initialized later on a particular
> + * platform.
> + */
> +void __init retry_lockup_detector_init(void)
> +{
> +	/* Must be called before late init calls */
> +	if (!allow_lockup_detector_init_retry)
> +		return;
> +
> +	queue_work_on(__smp_processor_id(), system_wq, &detector_work);

Just a small nit. This can be simplified by calling:

	schedule_work(&detector_work);

It uses "system_wq" that uses CPU-bound workers. It prefers
the current CPU. But the exact CPU is not important. Any CPU-bound
worker is enough.

> +}
> +

With the above change, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am sorry for the late review. I had busy weeks.
