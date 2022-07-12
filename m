Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E3571411
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiGLILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiGLILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:11:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4984733E2C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:11:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so12899919eju.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAblE0VfQqsX2FhEhlmNF0MI2SNQOD6qrUOnSLVyV4g=;
        b=ivBDfg89ttyBXF2y7cPm4jaQbb5003PCxWgf/aXnVIOQ9lzVlgUx8hxJcF0Y2lofFb
         IoYC1WixKj5jb1Qtb5pnd5zf5XWP8aX8nB0+EeB8+a3Em//uQzGCekpcVs1xfW6bIspz
         LbuOl2j+9jaUiWi/OLV1vPeyr7bpMr7ddoEiXMjOQi93z872tZSI+oqqd4xW+Ni/9aMj
         wDM3OZJel9JhH32s2ZyzmLkBH/hq0oCXYiGi0ZvfOXsMUOy7TNssIHWM0E6oPYr4BOmP
         v6q49mCdkkhPd22DO+bkd6S5JHJ2hVqf2rT7ALMj4Qsn6V3ATUhsTs05bwWkW2peG7s6
         +CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAblE0VfQqsX2FhEhlmNF0MI2SNQOD6qrUOnSLVyV4g=;
        b=B/rc0v8B0fP9GJUk5wDuTfTxF8NaaPY0mOYO+kevAotZjAgqFf/KBJ7S2ji4tWsRT7
         PUQqk6ZC5JkRgnbY2I4yTj3T+y5h/iTu+Ww/GqmLTQgkJTI7f0GF1YO+ONiyAjHC8OzX
         sH8L+rRTyDg6+65O3BocDAuej4lOwtZQ83j9SAlek8VE+TXIoMc1vdFT/b5Eu1JznGqq
         vpqwaUo4Hgy0JmuA1O/xVwUyWssER9dyRHTtnEWGpyUMn9PoqwEeJCt4mPYfaJcD7tPr
         UO2hkRjmeCErtt/EbUGFqQ+3y+Ya0zBdGH4NaJMikJC4wfymQG2jSeVYPSbnQ0FyQKww
         V44w==
X-Gm-Message-State: AJIora+THI5YjEppfIcqBg7gZ3lScYl+1qHjjqJcx3dAHf80w7h+0l9M
        7dfrw4WgrrcITTBfKf2TSwA/d5lbiwoekhPkBekrqg==
X-Google-Smtp-Source: AGRyM1st+UXUXVEvgt9xRYT2K1rCAEH/fZJxbA0Cs3nrka+3T4iORaEJGfNcv/HymDNnr2RLU0RJCvmYznMipIPgX5s=
X-Received: by 2002:a17:907:7b87:b0:726:c868:cf38 with SMTP id
 ne7-20020a1709077b8700b00726c868cf38mr22365650ejc.580.1657613487777; Tue, 12
 Jul 2022 01:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220707080600.49041-1-allen.chen@ite.com.tw> <20220707080600.49041-3-allen.chen@ite.com.tw>
In-Reply-To: <20220707080600.49041-3-allen.chen@ite.com.tw>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 12 Jul 2022 10:11:16 +0200
Message-ID: <CAG3jFyuz-9fDXXziRzZBhGQ2NC3R2nFW=aeimghTZXGCraPbuw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/bridge: it6505: Add i2c api power on check
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-yen Lin <treapking@google.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-Yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, 7 Jul 2022 at 10:06, allen <allen.chen@ite.com.tw> wrote:
>
> From: allen chen <allen.chen@ite.com.tw>
>
> Use i2c bus to read/write when it6505 power off will occure i2c error.

^^^ typ-o
Change occure to occur.

This is an issue that would have been caught by running checkpatch
--strict, please try to run it on all patches before submission.

> Add this check will prevent i2c error when it6505 power off.
>
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index aa5e0aa1af85..cfd2c3275dc5 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -518,6 +518,9 @@ static int it6505_read(struct it6505 *it6505, unsigned int reg_addr)
>         int err;
>         struct device *dev = &it6505->client->dev;
>
> +       if (!it6505->powered)
> +               return -ENODEV;
> +
>         err = regmap_read(it6505->regmap, reg_addr, &value);
>         if (err < 0) {
>                 dev_err(dev, "read failed reg[0x%x] err: %d", reg_addr, err);
> @@ -533,6 +536,9 @@ static int it6505_write(struct it6505 *it6505, unsigned int reg_addr,
>         int err;
>         struct device *dev = &it6505->client->dev;
>
> +       if (!it6505->powered)
> +               return -ENODEV;
> +
>         err = regmap_write(it6505->regmap, reg_addr, reg_val);
>
>         if (err < 0) {
> @@ -550,6 +556,9 @@ static int it6505_set_bits(struct it6505 *it6505, unsigned int reg,
>         int err;
>         struct device *dev = &it6505->client->dev;
>
> +       if (!it6505->powered)
> +               return -ENODEV;
> +
>         err = regmap_update_bits(it6505->regmap, reg, mask, value);
>         if (err < 0) {
>                 dev_err(dev, "write reg[0x%x] = 0x%x mask = 0x%x failed err %d",
> @@ -2553,13 +2562,12 @@ static int it6505_poweron(struct it6505 *it6505)
>                 usleep_range(10000, 20000);
>         }
>
> +       it6505->powered = true;
>         it6505_reset_logic(it6505);
>         it6505_int_mask_enable(it6505);
>         it6505_init(it6505);
>         it6505_lane_off(it6505);
>
> -       it6505->powered = true;
> -
>         return 0;
>  }
>
> --
> 2.25.1
>

With that fixed:
Reviewed-by: Robert Foss <robert.foss@linaro.org>
