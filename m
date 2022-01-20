Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9844349547B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358258AbiATS4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:56:10 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:42691 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiATS4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:56:09 -0500
Received: by mail-qk1-f176.google.com with SMTP id c190so7099070qkg.9;
        Thu, 20 Jan 2022 10:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRWBDbesgHdt5Xb1VUf1OEE5dZ9gpONo3xSzy6Jbfyo=;
        b=GJYgAWncVD8cbLwHxq9wcaTYyj3LvZShvgy3Gc5UBw5myRTmSlKbeDb/Kv+1ACgZHV
         fjx6XK3CbxwrpxOkrgqCsri7S3036mzMy3MeTb5X60guACm8Tz2lSyFrY/KXseKFvFya
         DRnOSF81T5Ku2yy6UdwLI3ohWlF+ySIgy2hOx70EZhlUv585IasLn8WSfBi5GngwghcF
         tNfGnX5pRN/AgrWWCmc2EXJ70QyMnBdzBSXMaSddQcBVCTR+HuwKKeOGtErCx9varerr
         UtDZNtthE5+fI/unDrUzag7nmeOV0L406AW+3TYOL/AXgPMvh0vONPZOpRSGnZKcdaBI
         dIFw==
X-Gm-Message-State: AOAM531Hjab1CeMRNGCpqFO4rbqKHP+4Q2XQp6Z1icJRLc8Ut4LRBF65
        jJlkQIRI5uC+wHBGvRy4gN3lp6T2knoesTg+Bh8=
X-Google-Smtp-Source: ABdhPJwQWvstaLQAUXELt6rsGZJHy2Qw5ozIJjOpuU8tyRo8LzlaGVcYVU6AOIodMVKLqKupbn97Wb3lefSo54YHXcc=
X-Received: by 2002:a37:b702:: with SMTP id h2mr151557qkf.135.1642704968644;
 Thu, 20 Jan 2022 10:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20220117081615.45449-1-zhangshaokun@hisilicon.com>
In-Reply-To: <20220117081615.45449-1-zhangshaokun@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jan 2022 19:55:57 +0100
Message-ID: <CAJZ5v0jBVX9H8d8g4v3W7x9MEKQpudr3NP+LGP57FioFvpq7Jg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: Fix long delay issue when tick stopped
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Yang <guoyang2@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 9:16 AM Shaokun Zhang
<zhangshaokun@hisilicon.com> wrote:
>
> From: Guo Yang <guoyang2@huawei.com>
>
> The network delay was always big on arm server tested by qperf,
> the reason was that the cpu entered deep power down idle state(like intel
> C6) and can't goto a shallow one.
>
> The intervals in @get_typical_interval() was much smaller than predicted_ns
> in @menu_select(), so the predict state is always deepest and cause long
> time network delay.
>
> Every time when the cpu got an interrupt from the network, the cpu was
> waken up and did the IRQ, after that the cpu enter @menu_select()
> but the @tick_nohz_tick_stopped() was true and get a big data->next_timer_ns,
> the cpu can never goto a shallow state util the data->next_timer_ns timeout.
> Below was the print when the issue occurrence.
>
> [   37.082861] intervals = 36us
> [   37.082875] intervals = 15us
> [   37.082888] intervals = 22us
> [   37.082902] intervals = 35us
> [   37.082915] intervals = 34us
> [   37.082929] intervals = 39us
> [   37.082942] intervals = 39us
> [   37.082956] intervals = 35us
> [   37.082970] target_residency_ns = 10000, predicted_ns = 35832710
> [   37.082998] target_residency_ns = 600000, predicted_ns = 35832710
> [   37.083037] intervals = 36us
> [   37.083050] intervals = 15us
> [   37.083064] intervals = 22us
> [   37.083077] intervals = 35us
> [   37.083091] intervals = 34us
> [   37.083104] intervals = 39us
> [   37.083118] intervals = 39us
> [   37.083131] intervals = 35us
> [   37.083145] target_residency_ns = 10000, predicted_ns = 35657420
> [   37.083174] target_residency_ns = 600000, predicted_ns = 35657420
> [   37.083212] intervals = 36us
> [   37.083225] intervals = 15us
> [   37.083239] intervals = 22us
> [   37.083253] intervals = 35us
> [   37.083266] intervals = 34us
> [   37.083279] intervals = 39us
> [   37.083293] intervals = 39us
> [   37.083307] intervals = 35us
> [   37.083320] target_residency_ns = 10000, predicted_ns = 35482140
> [   37.083349] target_residency_ns = 600000, predicted_ns = 35482140
>
> Add idle tick wakeup judge before change predicted_ns.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Guo Yang <guoyang2@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/cpuidle/governors/menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index c492268..3f03843 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -313,7 +313,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                                 get_typical_interval(data, predicted_us)) *
>                                 NSEC_PER_USEC;
>
> -       if (tick_nohz_tick_stopped()) {
> +       if (tick_nohz_tick_stopped() && data->tick_wakeup) {

data->tick_wakeup is only true if tick_nohz_idle_got_tick() has
returned true, but I'm not sure how this can happen after stopping the
tick.

IOW, it looks like the change simply makes the condition be always false.

>                 /*
>                  * If the tick is already stopped, the cost of possible short
>                  * idle duration misprediction is much higher, because the CPU
> --
> 1.8.3.1
>
