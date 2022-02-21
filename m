Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61FE4BD4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbiBUEeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbiBUEd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:33:56 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8B31DD8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:33:33 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id w63so10522138ybe.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdVq/Bdju/XC3p7Tx9JRaqrYCFKoB7DXdAQOIXXijT4=;
        b=naEhAVvrNt77acZbiRcdvLw9DUHG1yd9cyyOYNcTREEtbyqkSwJishzXaT+hboEl0f
         pRAGC110oUcocsibxGhLWW22/wL6NFl0CN/DOPolL3EvpDgA5OlsH+Ibtjpdgc/92VwQ
         yutTelFbAq4+BBhwkSH2b9dLMUqZtuzN+NwZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdVq/Bdju/XC3p7Tx9JRaqrYCFKoB7DXdAQOIXXijT4=;
        b=FA6fdBtXQAQXFWrJjGBrCeGzt2ju+/OdeziIUI0tfR7qd8rUKv38T2Zi8M60v+AdPs
         8kMHjdewhS+fvmmNzMlbSZRaDkkUTAuN7YmNwu/Tiy1Up4oCOvYyRRUCnSVumDeJTBib
         +5YgDJymHuzPvrRfONnBsM/yfq0uzFRtr4Upt+5U4vNH4cJLwcefupMzjuDa3TfQgS7H
         jnbChtxSUgiEWfQOZ6sHXrOind5YjRALAHMRkJr5cyojg3QFRpKrie93YlU6Lyu9CNKN
         WhfaGyn0aQhhnrhDfI3OwCslvky1QDgWK2yp7IOSw/uapYnXtTEzJMa2d9V41fFQaeu/
         3agg==
X-Gm-Message-State: AOAM532iQPPZ/hwJlGVvznH/OgBHAVkMzQO76qMKC8CoMcxxKp+BEda4
        E5De0S2bncBwm74pA78eNq6UMsqz/EepFrRXc7kniw==
X-Google-Smtp-Source: ABdhPJwYJZ5wFox2PhJi/05KzYq+SwjE0uRDqCM8m4JmRQqsV2jvXhBNYy4J1vCdqamz5hOFvoAJtCr6mI5+C8RlNaw=
X-Received: by 2002:a25:a486:0:b0:61d:a523:acd0 with SMTP id
 g6-20020a25a486000000b0061da523acd0mr16404502ybi.203.1645418013253; Sun, 20
 Feb 2022 20:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com> <20220210141931.291712-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220210141931.291712-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 21 Feb 2022 12:33:22 +0800
Message-ID: <CAGXv+5Gmzu-w0Oi8dUv-a6v1=S8L5otgCfppbAXm1g+jMZFj8Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] pinctrl: mediatek: common-v1: Add common probe function
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:20 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> As a preparation to cleanup the probe mechanism of mediatek pinctrl
> drivers that are using the v1 controller, add a common probe function
> to this driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

but

> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 11 +++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  2 ++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 6f8dfa6ae5a0..007da39b68c9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -1115,3 +1115,14 @@ int mtk_pctrl_init(struct platform_device *pdev,
>         gpiochip_remove(pctl->chip);
>         return ret;
>  }
> +
> +int mtk_pctrl_common_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct mtk_pinctrl_devdata *data = device_get_match_data(dev);
> +
> +       if (!data)
> +               return -ENOENT;

This is probably bikeshedding, but it seems most other drivers use -ENODEV
or -EINVAL. -ENOENT is seldomly used in this context.

ChenYu
