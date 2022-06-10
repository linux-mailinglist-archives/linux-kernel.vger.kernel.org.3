Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032EB545EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347520AbiFJITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347304AbiFJISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB9222A6C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:18:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 187so23223317pfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uigtUS1xIOK2eGjV8S/JA4dIQjxGCEEjBa8iZpFRUZ8=;
        b=jcTu9+80+nCglm5pyAvgjAKE5LzR50EJFbv+JYa1B9q25eDB5bk0CSketGhE35Fen9
         ksicx1kd+d4kBZIrPusTVNBQYXCnVqvBmWj+qiZEz2oez+3Is9S8xhIAkw+Y3DjMInS4
         x/lB1Rkorsd/7Qsih8Bq8YMuP5QJ4TSIw+iKGT58tfyzOEBRYjpV2aXcEU5yX44JYw23
         AHyrma18BteO8IEC8uKIon1Q930VeyHyEh7w3ycumGsy+ekt9a03/NX/IZApSGdM0kzr
         YUQFpnDnmEslro2DVFlO9KNQCkzFXxpjzpgMsLCRluHPn60fWIosQjkJx84GTfWHPWMP
         dKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uigtUS1xIOK2eGjV8S/JA4dIQjxGCEEjBa8iZpFRUZ8=;
        b=c/Tj5NKLG2SQklyWxBs3wB7PfGMqNpf6haVIAWwbOuEtTrV3dQzWgLZ58LfBZL8WwS
         mG7ReUarGfTbZmgsW+uHUH9ASTkM0IMik628zXrNQPCg2KPHQD2LTTQ1YmCjUUNF256Y
         UHmt855HatRI1JRHh1z5ayHmY3+J1Q0K1z/JgfVo5U+u4b2f6AHiejnlD2WFRoIKz3QK
         lJmpEx1/V4qGqFocdSbrwfq3eI0S7oWYWoMsaIXJ4G0OD3S+AV/V17iWYgmvKsy2MDZc
         mTWJee972kRUKuQ8izvwd25D0lnNeFMkeZHnRIC/eEtO9f1T9C9JNLTiSyVupmY6XEre
         FuJw==
X-Gm-Message-State: AOAM532WyQBG+DOEp4OHsO7jfotyfUwxR7g5DTP/dKWfUtz4tqbseF7t
        6E1mFdVQ0dOB73Ta+9NIbuClNNyXyMHT0/T7ABA9LQ==
X-Google-Smtp-Source: ABdhPJx5RVqbDB4bxEL1kVn3ZdTR+qKYAp/7L1lm1uQ+DxI0/H0SJ3MghFQhCMEJKNsJSZwoNGUsaIguSVPleHNXWlo=
X-Received: by 2002:a63:91ca:0:b0:3fc:9077:c7c7 with SMTP id
 l193-20020a6391ca000000b003fc9077c7c7mr39163270pge.201.1654849081218; Fri, 10
 Jun 2022 01:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211218182804.208906-1-antonio.borneo@foss.st.com> <20220607213144.427177-1-antonio.borneo@foss.st.com>
In-Reply-To: <20220607213144.427177-1-antonio.borneo@foss.st.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 10 Jun 2022 10:17:49 +0200
Message-ID: <CAG3jFyvt8+Tbbx6rT8R72aNgEk40O+V7GE0ZTc4RdWDcQmhwYg@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm: adv7511: override i2c address of cec before
 accessing it
To:     Antonio Borneo <antonio.borneo@foss.st.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 23:32, Antonio Borneo <antonio.borneo@foss.st.com> wrote:
>
> Commit 680532c50bca ("drm: adv7511: Add support for
> i2c_new_secondary_device") allows a device tree node to override
> the default addresses of the secondary i2c devices. This is useful
> for solving address conflicts on the i2c bus.
>
> In adv7511_init_cec_regmap() the new i2c address of cec device is
> read from device tree and immediately accessed, well before it is
> written in the proper register to override the default address.
> This can cause an i2c error during probe and a consequent probe
> failure.
>
> Once the new i2c address is read from the device tree, override
> the default address before any attempt to access the cec.
>
> Tested with adv7533 and stm32mp157f.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Fixes: 680532c50bca ("drm: adv7511: Add support for i2c_new_secondary_device")
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> ---
>
> This patch got somehow lost, I'm resending it.
> Added reviewed by Kieran Bingham.
> Rebased on drm-misc-next.
>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 5bb9300040dd..074c2e650cae 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1065,6 +1065,10 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
>                                                 ADV7511_CEC_I2C_ADDR_DEFAULT);
>         if (IS_ERR(adv->i2c_cec))
>                 return PTR_ERR(adv->i2c_cec);
> +
> +       regmap_write(adv->regmap, ADV7511_REG_CEC_I2C_ADDR,
> +                    adv->i2c_cec->addr << 1);
> +
>         i2c_set_clientdata(adv->i2c_cec, adv);
>
>         adv->regmap_cec = devm_regmap_init_i2c(adv->i2c_cec,
> @@ -1271,9 +1275,6 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>         if (ret)
>                 goto err_i2c_unregister_packet;
>
> -       regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR,
> -                    adv7511->i2c_cec->addr << 1);
> -
>         INIT_WORK(&adv7511->hpd_work, adv7511_hpd_work);
>
>         if (i2c->irq) {
>
> base-commit: dfa687bffc8a4a21ed929c7dececf01b8f1f52ee
> --
> 2.36.1
>

Applied to drm-misc-next.
