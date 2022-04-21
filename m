Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ACB509F93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiDUM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384038AbiDUM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:28:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E0313F1C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:25:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t12so4685599pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKhg142Wlk6AFjo5SyNKNuZ+EL/BpZej/wWvDH5mY50=;
        b=KQYDKUEOG7XGEF9CzfRneviC28oNECGV9wp4aaL6EO+HgbCyRazvNKSFAbOT3P3Byi
         hlSbIYZ3jvc+HU0wFz+UMeUTJrvJ9CsmhF+gAWZU9Zrj7C82UCPP1ug/4U2oFVyDkpJr
         EnuQMngI1SmLb7LmceYO+/yMj6t5yugx1ealPoYKNV9Zf8cnxf/zRCS3qkYKYcYKHjsi
         W5tynycj2yVt1Ga8MfNUhR53+S+i1hXYVncuX6A/c6P3azWo3kC5jMi6tjBa0C63HrNd
         IlTQdDg01AaKjBz79yKG18xannJDGgPdxk5A30kKhVlS+cmk1xPdjRNB3kXAwQZwWfhI
         Pm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKhg142Wlk6AFjo5SyNKNuZ+EL/BpZej/wWvDH5mY50=;
        b=3FT+0vbL4JiqRT++HLGZlmamO2BXfI/9L5dyAryKx9UEqI/QZBePgw8XXOcOWkHBud
         DUWxCuc4YtXdYNm+ufCMX0IuqG696diacLxOEfWUSdRkf5tnObftrBhs/IGGZSg1UfXO
         fhMKV+zf0q9dBlsNAgc9K7r85U1QpIx647LUJP2fZB8lkoELL2iceNxGNjslF7tJ3Tx1
         qX+porZcQmf+LEhA6F7ffp/ftKW4pwisYLJDjPZNcNwQaZUGHTvKjz0jreDZWF/IBr8t
         ulWj/Zd68WukktfxIylkBVv9y0n/pbo13IEqbxgSmaASro7+qkf/Xj6AtMS36OTRXM1t
         Q7Cg==
X-Gm-Message-State: AOAM5305z3/wp/spaUqX50ZJSG4cu8QgbxEkj6K6aPrW5c72qDe0MvwB
        OXPFUf5dGOCWWdGr8+MQzAo8cfJTIdHtzjfBIG7rvg==
X-Google-Smtp-Source: ABdhPJzzylUC2KC2I6WRbmhpdKZNMmOHuFcuihTnLQb/yX1aMnKuJbhRKQxowIfN7z1NZ/z1KaCl7oplC8mRCrBTnRY=
X-Received: by 2002:a17:90b:124c:b0:1bc:369b:7db5 with SMTP id
 gx12-20020a17090b124c00b001bc369b7db5mr10066726pjb.179.1650543910393; Thu, 21
 Apr 2022 05:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <202204031935.5SkYsM2M-lkp@intel.com> <20220420011644.25730-1-linmq006@gmail.com>
In-Reply-To: <20220420011644.25730-1-linmq006@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 21 Apr 2022 14:24:59 +0200
Message-ID: <CAG3jFyt5EG=OBk+pVwwHeeh_XgsCV82p-KiLcnL_yv8L1wUZ8Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Fix error handling in analogix_dp_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>, Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 at 03:16, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> In the error handling path, the clk_prepare_enable() function
> call should be balanced by a corresponding 'clk_disable_unprepare()'
> call , as already done in the remove function.
>
> Fixes: 3424e3a4f844 ("drm: bridge: analogix/dp: split exynos dp driver to bridge directory")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - remove the wrong return statement.
> ---
>  .../gpu/drm/bridge/analogix/analogix_dp_core.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index eb590fb8e8d0..474ef88015ae 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1698,8 +1698,10 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
>         dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(dp->reg_base))
> -               return ERR_CAST(dp->reg_base);
> +       if (IS_ERR(dp->reg_base)) {
> +               ret = PTR_ERR(dp->reg_base);
> +               goto err_disable_clk;
> +       }
>
>         dp->force_hpd = of_property_read_bool(dev->of_node, "force-hpd");
>
> @@ -1711,7 +1713,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>         if (IS_ERR(dp->hpd_gpiod)) {
>                 dev_err(dev, "error getting HDP GPIO: %ld\n",
>                         PTR_ERR(dp->hpd_gpiod));
> -               return ERR_CAST(dp->hpd_gpiod);
> +               ret = PTR_ERR(dp->hpd_gpiod);
> +               goto err_disable_clk;
>         }
>
>         if (dp->hpd_gpiod) {
> @@ -1731,7 +1734,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>
>         if (dp->irq == -ENXIO) {
>                 dev_err(&pdev->dev, "failed to get irq\n");
> -               return ERR_PTR(-ENODEV);
> +               ret = -ENODEV;
> +               goto err_disable_clk;
>         }
>
>         ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
> @@ -1740,11 +1744,15 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>                                         irq_flags, "analogix-dp", dp);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to request irq\n");
> -               return ERR_PTR(ret);
> +               goto err_disable_clk;
>         }
>         disable_irq(dp->irq);
>
>         return dp;
> +
> +err_disable_clk:
> +       clk_disable_unprepare(dp->clock);
> +       return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(analogix_dp_probe);
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
