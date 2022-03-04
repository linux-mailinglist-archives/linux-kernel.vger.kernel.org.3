Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C324CD201
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiCDKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbiCDKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:05:01 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CBF1AA487
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:04:06 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d23so13228617lfv.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHtDwpQlgQxQz5J0sBkaBc/+7e3RgDBHSazI8GPXM1Y=;
        b=GT7fl/gRaMvLugm2rOKYUe88d7QtN+V88elk3nozvTiV+Co80FPQWl7fNWHsfmzrm3
         uCcO2Lgdxyv+ScS20zbf7r0b0W7XfUn9rbdMUq2kGQvqdjIX3+p5eIpMiSsbMUlK9f7v
         aP7j96xmoUrrKdrzvxEGwhVSbqPDa2RLvBgAcZjM5PmSe8UsDngFOB2p0cr5N/O8Ycgw
         Yz49n4d72vE46c318VRhcjvFT+sj86DDfFK0NnbCN+tlGLW/kIITDi8lCDKRCi46KHnK
         mAmHewQsu4VKEdxAOPo72KJ5fxug5rfFkgHdkXzYwbCHEsg6Dgv8dan1oD2GUvrJW//e
         TEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHtDwpQlgQxQz5J0sBkaBc/+7e3RgDBHSazI8GPXM1Y=;
        b=dyHFlr0/A2vRpZnfg7uDhtH5xAa6HGXD6nUT1tguH3belbWa9BvebSBG5bLlwLzeCA
         PS9wMVtVVpSqevCueiqSOJ4Y8rFCK6JqwZgJdehrfF6IF5n8nK2DWqPkljOKTlTp+Wn2
         VBUH4NB948babTuBNZYNUzhnxiAuzthlMQznoMZUZpSDImAhLK+u7rreKA9jLl8zBUzs
         TBDNKkt1XNSJf+EiKBCk1rXebetvuq3Kd/bwV0xzPkz9cR7FevyItcTRnouHkV+oz840
         fw2aBN+z21gBAhabaMFBmjgOxmFozPoP11sKMHjz+qGgij67YM9EcLkTmk3l1TpZHbX2
         YaJA==
X-Gm-Message-State: AOAM530II26mEJ0YAlVA4nkHL9Pkyo0J8BXM2o7BRSvr2shm3HzYmkFl
        dVFwATc1rBB4a8T3PofWZqCqBfMxpDr6Sgu72So17A==
X-Google-Smtp-Source: ABdhPJzPx2mFiA7lNqjmZmBlJ1nNW8aD9TWzey9L5XjJHYwFuLOxSfnAN4ovrSo85FcjsWm7EUb9Ies8fuVH4Rf5Jgg=
X-Received: by 2002:a19:6f08:0:b0:448:1d19:e69a with SMTP id
 k8-20020a196f08000000b004481d19e69amr480689lfc.373.1646388245194; Fri, 04 Mar
 2022 02:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
In-Reply-To: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Mar 2022 11:03:28 +0100
Message-ID: <CAPDyKFrMu+zfsTzqEA-EtBdU4Wo5m=LwAEoYXPs5PFkxOERnfg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 at 17:35, Douglas Anderson <dianders@chromium.org> wrote:
>
> The PM Runtime docs say:
>   Drivers in ->remove() callback should undo the runtime PM changes done
>   in ->probe(). Usually this means calling pm_runtime_disable(),
>   pm_runtime_dont_use_autosuspend() etc.
>
> From grepping code, it's clear that many people aren't aware of the
> need to call pm_runtime_dont_use_autosuspend().
>
> When brainstorming solutions, one idea that came up was to leverage
> the new-ish devm_pm_runtime_enable() function. The idea here is that:
> * When the devm action is called we know that the driver is being
>   removed. It's the perfect time to undo the use_autosuspend.
> * The code of pm_runtime_dont_use_autosuspend() already handles the
>   case of being called when autosuspend wasn't enabled.
>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Okay, this provides an improvement from the short term perspective.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

When I get some time, I will try to explore the ->remove() and
->probe() error-path case a bit more, to try to suggest a new
interface that might be able to replace the devm_pm_runtime_enable().
Let's see...

Kind regards
Uffe

> ---
>
>  drivers/base/power/runtime.c | 5 +++++
>  include/linux/pm_runtime.h   | 4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2f3cce17219b..d4059e6ffeae 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1476,11 +1476,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
>  static void pm_runtime_disable_action(void *data)
>  {
> +       pm_runtime_dont_use_autosuspend(data);
>         pm_runtime_disable(data);
>  }
>
>  /**
>   * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
> + *
> + * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
> + * you at driver exit time if needed.
> + *
>   * @dev: Device to handle.
>   */
>  int devm_pm_runtime_enable(struct device *dev)
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 9f09601c465a..2bff6a10095d 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -567,6 +567,10 @@ static inline void pm_runtime_disable(struct device *dev)
>   * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
>   * requested (or "autosuspend" will be handled as direct runtime-suspend for
>   * it).
> + *
> + * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
> + * at driver exit time unless your driver initially enabled pm_runtime
> + * with devm_pm_runtime_enable() (which handles it for you).
>   */
>  static inline void pm_runtime_use_autosuspend(struct device *dev)
>  {
> --
> 2.35.1.473.g83b2b277ed-goog
>
