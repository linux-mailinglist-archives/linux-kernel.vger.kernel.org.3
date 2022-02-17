Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAD04BA4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiBQPko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:40:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiBQPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:40:41 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61D2B2E19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:40:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a42so8907227ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtHuVZsN9dq8Ef87/aHczhTpVzC+pvWaYD+ZfU02gIo=;
        b=DI03Q5WXZVS9ul6CojxIkkW4nz0ZO8uejIIb6VmNzipMI4NSLJuTUuNVVF8WnOFPAk
         ETS6C8BnZIusFEeLd24/3GcTkvUN/KMupJrzeOYeA7tKvdIomQivWL/B3zy0zY/tPlWx
         qZd8OE4OY3XIcUeT56fXQg7Hw3ayHOmVCKvDHuwxw4crgO4MVGVUQrERnwTHeExrETVI
         5SmD7k91ENizvCB6TkQp/RzxY1OH9FxQ24PYKDpYCZa7+veM6B71vzU3wVeuJytFMcjb
         NcYwsjepH5AqvNSOFhYwssoKWSW7LOjr9PgcAHHYaWL9iU46/fTADC/Xvtya3WEZDAsS
         +HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtHuVZsN9dq8Ef87/aHczhTpVzC+pvWaYD+ZfU02gIo=;
        b=1Z+0nWsB/+S0hI65YG8sNn6W0j7R2LHW1xj5JsD367pPkt+hx2XS07eA9jiWvTQ4Oc
         wOUv3t+80iL1EMbyUKmKUD40jXb4y/C8Ct9MpRLx8FrJB59dOlZhKTg4idi8kGUiklwC
         +U3NFntHwyUK6+2pyC99Tu88nLv4CFjs8f5+rQoY5eHLkMIh2gnDeUwsdctkCUKfoKT/
         j7mdgUQ+E+zaTxJ+K/O/PtVJ9vIJ/JMUS6elCr6oTB+q8Swvp1oryOqKT80tih7RJT60
         PY02VqGIPo5yEFFV1Bu+e0B0rfiPcN5yHUeG0M1jBk20Q885ygUBMoBlUL2eTOnbp/Tm
         c5DQ==
X-Gm-Message-State: AOAM533vB6F8UKaaWSQXTBRJePELiGZ15R0uaKu/N174WvG8LTSeLp9U
        FuaVR1SjJjFio/uD6AL6JiUKPODkPX8DQFAAVJ4F8g==
X-Google-Smtp-Source: ABdhPJzS1HsQQFljNPEfdzoowpGZXeJXTbt7Iuq1OuK3MM2rhphn87bPRKA7/KY2OrtWgxD7W1s9ZurapEW2QYPSaeM=
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id
 7-20020a05651c00c700b00244f9d77c48mr2735695ljr.300.1645112424989; Thu, 17 Feb
 2022 07:40:24 -0800 (PST)
MIME-Version: 1.0
References: <1644395927-4138-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644395927-4138-1-git-send-email-wangqing@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:48 +0100
Message-ID: <CAPDyKFqg5N1tCqQ2u2jt5qU0qLuDJRSJRtq_aMVDc7XNDbRvkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: use div64_u64() instead of do_div()
To:     Qing Wang <wangqing@vivo.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 at 09:39, Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
>
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 65037e1..777c9a8
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -766,7 +766,7 @@ static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
>                 clk_ns  = 1000000000ULL;
>                 do_div(clk_ns, mmc->actual_clock);
>                 timeout = ns + clk_ns - 1;
> -               do_div(timeout, clk_ns);
> +               div64_u64(timeout, clk_ns);
>                 timeout += clks;
>                 /* in 1048576 sclk cycle unit */
>                 timeout = DIV_ROUND_UP(timeout, BIT(20));
> --
> 2.7.4
>
