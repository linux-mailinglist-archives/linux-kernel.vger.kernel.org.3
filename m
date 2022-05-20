Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339A452E94C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347928AbiETJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiETJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:47:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6BC201B7;
        Fri, 20 May 2022 02:47:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 02A571F99B;
        Fri, 20 May 2022 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653040058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0EDYX6/jlsKjCqfkxKgPdol0lZ2Drp928yPwi4paSLQ=;
        b=GsRkmokRG8jMr2vvJlveZSJsxyDD0gdysvsOlHzRO6nawaGMCacKesz3nKhzFGIrXCT7O4
        QkJnIO5CeoLCZr01MrYO4ZxjGX/iAKWb9nnKmyZTxnA3DKcfPWofoLQAult89v3jpyKQSe
        qP8vVQpSn5xrwiweHnkSnl9hnN8jHSE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 746C02C141;
        Fri, 20 May 2022 09:47:37 +0000 (UTC)
Date:   Fri, 20 May 2022 11:47:37 +0200
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
Subject: Re: [PATCH v4 6/6] arm64: Enable perf events based hard lockup
 detector
Message-ID: <YodjucHQ3Nab5J/f@alley>
References: <20220427161340.8518-1-lecopzer.chen@mediatek.com>
 <20220427161340.8518-7-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161340.8518-7-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-28 00:13:40, Lecopzer Chen wrote:
> With the recent feature added to enable perf events to use pseudo NMIs
> as interrupts on platforms which support GICv3 or later, its now been
> possible to enable hard lockup detector (or NMI watchdog) on arm64
> platforms. So enable corresponding support.
> 
> One thing to note here is that normally lockup detector is initialized
> just after the early initcalls but PMU on arm64 comes up much later as
> device_initcall(). To cope with that, overriding watchdog_nmi_probe() to
> let the watchdog framework know PMU not ready, and inform the framework
> to re-initialize lockup detection once PMU has been initialized.
> 
> [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> 
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1390,10 +1391,15 @@ static struct platform_driver armv8_pmu_driver = {
>  
>  static int __init armv8_pmu_driver_init(void)
>  {
> +	int ret;
> +
>  	if (acpi_disabled)
> -		return platform_driver_register(&armv8_pmu_driver);
> +		ret = platform_driver_register(&armv8_pmu_driver);
>  	else
> -		return arm_pmu_acpi_probe(armv8_pmuv3_pmu_init);
> +		ret = arm_pmu_acpi_probe(armv8_pmuv3_pmu_init);
> +
> +	retry_lockup_detector_init();

Does it makes sense to call retry_lockup_detector_init() when
the above returned an error? Should it be?

	if (!ret)
		retry_lockup_detector_init();

> +	return ret;
>  }
>  device_initcall(armv8_pmu_driver_init)


I am not qualified to ack the arm-specific code. But otherwise
the change looks reasonable.

Best Regards,
Petr
