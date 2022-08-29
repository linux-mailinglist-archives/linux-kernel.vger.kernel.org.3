Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112035A433C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiH2G2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2G2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:28:53 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73A74B0FA;
        Sun, 28 Aug 2022 23:28:52 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11f0fa892aeso1024415fac.7;
        Sun, 28 Aug 2022 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dHQJKSyHKH/RlxhxZ4Q/EKqTBZjMDarnF1XaHz0S2gU=;
        b=XCdQxL63SAkWPhdSckr1KRYpMwuInjqA5hL6NqW7+L3ZU8SIYVCPCWIexWqvjsVnvt
         Iw1hAANity4bXp7k2QT87/LpO5kWHKdqU4KLWmIt+f06LpNg2IW3BW2vlS7mAFYQv7XZ
         oH8gSg6WccFk+ohOGZP5VXV9W7QBvGKkLu3SW88JpVcqOgcdOh1acG2M+9AN+ElLgnxd
         4JC8o/Km51u5OeJWbEUeZEj65ca58ZuB7buySpzk9l+biB7HOimLrxOubfm20bMV5WQc
         Go0cS7YfjPPH70E5EsVrZmaAHXPJjTQ6kfxiwvZoPWxGc+5zX/ffwpBLkBZJ5LeC0bLa
         ccqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dHQJKSyHKH/RlxhxZ4Q/EKqTBZjMDarnF1XaHz0S2gU=;
        b=jd4woTRFtvXxjeBBFUCLO+kcZE+d1TaIkglz+zPxUYeHMAQk54VFohITVVfIQpbvPQ
         yDg8PhAM4Qh703LVyIWFvDlw7vF1WctBHPKnhRdwHGZr7zc6ObX7Wk7h07nA3KLqrfOf
         J6qIUMxXSEbyl5FsyeXaXmqhfOQH2KlWm9jNVQxLVXeJNctkdQq0rLTdiNpnYqRxlIuQ
         Dm3DK6FxOz0+bMwCFZsm7+iVf5WEQAK6TPRevUfAySNePz/oNa12zaZBpdah6dox146X
         haUC5ANbQqQLiNodRLytSWJOXGWaXTBOTwQi3HklE0HVjO5zbBWS0llyfuqSQ276LV9m
         Ry/w==
X-Gm-Message-State: ACgBeo3tzHo7w42/4p43viqjwnWP/mZjGvr9u8Lh7/ee0MVuxM4wBYfd
        +lgqsQb5g1/jiZYYnxKIogto/du20O/LfxrLyh4=
X-Google-Smtp-Source: AA6agR6QWzfrwtXmIwOND+BLUkGH9SQkq7gxiFCylMZ1UEuJJq+j0L10LQlJsHA29k0GcUzIkiAGwcJYBvz7BtMTv94=
X-Received: by 2002:a05:6870:64a1:b0:11c:5ca9:e519 with SMTP id
 cz33-20020a05687064a100b0011c5ca9e519mr7385632oab.4.1661754532245; Sun, 28
 Aug 2022 23:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220825114018.1715-1-xuewen.yan@unisoc.com>
In-Reply-To: <20220825114018.1715-1-xuewen.yan@unisoc.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 29 Aug 2022 14:28:41 +0800
Message-ID: <CAB8ipk-su6DRo0DsgaY38Vf2AuxBuvG0GQ0xA22se7Wx5eH0Pg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Check the policy first in cpufreq_cooling_register
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     viresh.kumar@linaro.org, lukasz.luba@arm.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Any comments?

On Thu, Aug 25, 2022 at 7:42 PM Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> Since the policy needs to be accessed first when obtaining cpu devices,
> first check whether the policy is legal before this.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index b76293cc989c..7838b6e2dba5 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -501,17 +501,17 @@ __cpufreq_cooling_register(struct device_node *np,
>         struct thermal_cooling_device_ops *cooling_ops;
>         char *name;
>
> +       if (IS_ERR_OR_NULL(policy)) {
> +               pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
>         dev = get_cpu_device(policy->cpu);
>         if (unlikely(!dev)) {
>                 pr_warn("No cpu device for cpu %d\n", policy->cpu);
>                 return ERR_PTR(-ENODEV);
>         }
>
> -       if (IS_ERR_OR_NULL(policy)) {
> -               pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
> -               return ERR_PTR(-EINVAL);
> -       }
> -
>         i = cpufreq_table_count_valid_entries(policy);
>         if (!i) {
>                 pr_debug("%s: CPUFreq table not found or has no valid entries\n",
> --
> 2.25.1
>

THanks!
