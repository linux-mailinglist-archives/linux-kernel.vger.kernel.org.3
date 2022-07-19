Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8D57A2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbiGSP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiGSP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:26:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A5564E0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:26:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id os14so27882399ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pY2CMxbe7mYFu8lMmKdq8QyweRoqymfe+8LQesF8uYE=;
        b=fECi+8lG3d2QZQyelZpEsteMq5/Ly7PqyvAXApZORRN6U6VHI/Xd+RT65kVSQlhDfs
         RIifDvE6urMrudmyO/TXET1KzXJlRNUevdgDbV4Gy8PkxHRcCI9979O3Pwkm1ooW1IZl
         9k/2wyz4Y8r9wO9qqWZu5nBeC6mOWJ7ljwgzEKOPo3COpIzVJCP0oPj3c9atpX7OPNZW
         B14tRFln6rYqvb17WBktV6HEXlgQX97UT3VJNDoFJE2QmKONgjh22rmFbr9Ou2oQNlUf
         Q4trtaDSh5fGHLmUMI5/YAHF+CaUk6pM8Ghcb3JO/WsEeYAI131CpfPk9hn8m/fwMvfL
         lesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pY2CMxbe7mYFu8lMmKdq8QyweRoqymfe+8LQesF8uYE=;
        b=iRf3c8lQCfME/vfUoemtvGPb5J8frLq0CTA7Y2flAB67CUc4YhPoZHgy4iM2pXTvB7
         LfUaB2UAc3+GYsb0S53kDAJLPT6axaIhUpj1cF1Wnrr9L6gA3M0I13lOoODvHNE05YUF
         NS/ML0RowGmKrxhh/8+iNZ8t35w7T/gHXCKpZQVJjAVrT9tKLxmuy/GdYoE8VayBIIIy
         g2QODjKpPJ7GbZijw3drDHsVsnB21K6HIxSfhE0DVA/ZgDq/5qqtGUIDyduRBJejzA/0
         d5r4RRArFTpVsSSvsetp7djYrlu2EVhwCd6dG4rsrZcGPQ8RYYswtnXgozAT2nxeQnda
         Uhyg==
X-Gm-Message-State: AJIora8OSLVaTJl8EIRNENSz/dRROEhnpV/GTa8G37+9uvgO7przOLzs
        yv9huwoA1wdxnu8JNvb0cGypinGb26hGMyetwnBH/A==
X-Google-Smtp-Source: AGRyM1s6y2msksPTZYolBnXWbfyuEFWIjNOwAkx3R6nBSLm9wzLQ6VqBIZlWJeeQ4oXvE+CAxIYjBR203JAhhI/UfDE=
X-Received: by 2002:a17:907:7f9e:b0:72e:d375:431 with SMTP id
 qk30-20020a1709077f9e00b0072ed3750431mr27276672ejc.580.1658244401767; Tue, 19
 Jul 2022 08:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220713031547.11641-1-allen.chen@ite.com.tw>
In-Reply-To: <20220713031547.11641-1-allen.chen@ite.com.tw>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Jul 2022 17:26:30 +0200
Message-ID: <CAG3jFyvDWXZsSKaztKgbAUOY8DNFb81KvSpG5fQC=t1dUZp8oA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: it6505: Add i2c api power on check
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-yen Lin <treapking@google.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 05:16, allen <allen.chen@ite.com.tw> wrote:
>
> From: allen chen <allen.chen@ite.com.tw>
>
> Use i2c bus to read/write when it6505 power off will occur i2c error.
> Add this check will prevent i2c error when it6505 power off.
>
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
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

This patch no longer applies to the drm-misc-next tree, could you
rebase it and send out a v3?
