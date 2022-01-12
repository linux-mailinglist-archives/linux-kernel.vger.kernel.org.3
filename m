Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9548C05F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351762AbiALIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiALIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:53:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C84FC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:53:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g11so5700092lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QX44NtMzpgo+l2Ho0SHw53qmGi3kaH4gIg9bfUEaJf8=;
        b=GwrhxtFMs32fVtJhHB7d1TFxrETcq3mcE7NxamZu/6SOWSIdtZ4+Srz4LvEcSQmDB9
         LGFQ2vBPVGkMp3fk+4mJMplM1VhKxsHdEqD7JU4j3PciOrX6Zd64Jq9V2eEXn6NbELug
         K4bzHQ4527hYt4Ei4Xt8net4BaK/oZ4fiVvYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX44NtMzpgo+l2Ho0SHw53qmGi3kaH4gIg9bfUEaJf8=;
        b=s6DOzKUW++FdTxw1mSoHDs2cvhxe81DxCEMfzHX93L09n+iesXn7CIZYxBzU9pZeZ3
         s0CuG01gniVYFhCwhxNFOB8LK2g7gJNfzS7dVo1BFPwuYMKVsGcQBno6sJgTBBGDirET
         4u2ofQUnsknARV2y22YIYAwMFQlaI9b+KfSzbTDHDTjZK82ZK4A1OL8Hnsbh8wZ7B1TQ
         Xm8btrfwizjz3675QkvdPCtz48W8nKrSA5Ggqj+aaM98GI5Q9bsP4nti3ITR0v6AdtTV
         haN73R2oRBKfwvJ0G8C9W3nkkSk/20OzcjWuFXkQrXJ1x17R4ePzvLN8s8beI3dgP7y1
         xyew==
X-Gm-Message-State: AOAM533B75b3fbDjyuU7YEIbdV+sFJ/6HHF+iqbD57ai/6vKRzhokjTs
        eyUvzLtLijFBLnYQDBP5O3rcGskg4Ag2vlKPYyRsFQ==
X-Google-Smtp-Source: ABdhPJxEbYrAx/hnpV9Nn6yck1TYbHCWYGr7VZUmUHpP5vookcO09X5JJ9gm0O/ez/CfSZpUBOe1UT3KZO6sItHHMFc=
X-Received: by 2002:a2e:7f1a:: with SMTP id a26mr5747639ljd.414.1641977622599;
 Wed, 12 Jan 2022 00:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20220111112244.1483783-1-wenst@chromium.org> <20220111112244.1483783-8-wenst@chromium.org>
In-Reply-To: <20220111112244.1483783-8-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 12 Jan 2022 16:53:31 +0800
Message-ID: <CAGXv+5Gq0uH-eA799f1MRgzeUU9fsfi-Xz0XyW7ZJW==i_mcYg@mail.gmail.com>
Subject: Re: [PATCH 7/7] pinctrl: mediatek: paris: Support generic PIN_CONFIG_DRIVE_STRENGTH_UA
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 7:23 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Some of the MediaTek chips that utilize the Paris pinctrl driver library
> support a lower drive strength (<= 1mA) than the standard drive strength
> settings (2~16 mA) on certain pins. This was previously supported by the
> custom MTK_PIN_CONFIG_DRV_ADV parameter along with the
> "mediatek,drive-strength-adv" device tree property.
>
> The drive strength values for this hardware are 125, 250, 500, and 1000 mA,
> and can be readily described by the existing "drive-strength-microamp",
> which then gets parsed by the generic pinconf library into the parameter
> PIN_CONFIG_DRIVE_STRENGTH_UA.

So I am actually unsure how to implement support for this properly.
My intention was to map "mediatek,drive-strength-adv" to
"drive-strength-microamp". This implies using the advanced mode if
the property is present, and vice versa.

(Also unsure if such a binding would be acceptable.)

However the pin configs are passed in one-by-one within the driver, so
it doesn't seem viable to check for the absence of a certain parameter.
This might involve a bit more rewriting.

ChenYu

> Add support for PIN_CONFIG_DRIVE_STRENGTH_UA while keeping the old
> custom parameter around for backward compatibility.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>
> The indentation in the switch/case blocks is getting somewhat out of
> control. I also have some cleanup changes to reverse the logic of the
> if/break statements. Not sure if it should be done before or after this
> patch though.
>
> ---
>  drivers/pinctrl/mediatek/pinctrl-paris.c | 84 ++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index 678c8aa33012..5a94903ae372 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -48,6 +48,53 @@ static const char * const mtk_gpio_functions[] = {
>         "func12", "func13", "func14", "func15",
>  };
>
> +/*
> + * This section supports converting to/from custom MTK_PIN_CONFIG_DRV_ADV
> + * and standard PIN_CONFIG_DRIVE_STRENGTH_UA pin configs.
> + *
> + * The custom value encodes three hardware bits as follows:
> + *
> + *   |           Bits           |
> + *   | 2 (E1) | 1 (E0) | 0 (EN) | drive strength (uA)
> + *   ------------------------------------------------
> + *   |    x   |    x   |    0   | disabled, use standard drive strength
> + *   -------------------------------------
> + *   |    0   |    0   |    1   |  125 uA
> + *   |    0   |    1   |    1   |  250 uA
> + *   |    1   |    0   |    1   |  500 uA
> + *   |    1   |    1   |    1   | 1000 uA
> + */
> +static const int mtk_drv_adv_uA[] = { 125, 250, 500, 1000 };
> +
> +static int mtk_drv_adv_to_uA(int val)
> +{
> +       /* This should never happen. */
> +       if (WARN_ON_ONCE(val < 0 || val > 7))
> +               return -EINVAL;
> +
> +       /* Bit 0 simply enables this hardware part */
> +       if (!(val & BIT(0)))
> +               return -EINVAL;
> +
> +       return mtk_drv_adv_uA[(val >> 1)];
> +}
> +
> +static int mtk_drv_uA_to_adv(int val)
> +{
> +       switch (val) {
> +       case 125:
> +               return 0x1;
> +       case 250:
> +               return 0x3;
> +       case 500:
> +               return 0x5;
> +       case 1000:
> +               return 0x7;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
>                                           struct pinctrl_gpio_range *range,
>                                           unsigned int pin)
> @@ -151,11 +198,38 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>
>                 break;
>         case PIN_CONFIG_DRIVE_STRENGTH:
> +               if (hw->soc->adv_drive_get) {
> +                       err = hw->soc->adv_drive_get(hw, desc, &ret);
> +                       if (!err) {
> +                               err = mtk_drv_adv_to_uA(ret);
> +                               if (err > 0) {
> +                                       /* PIN_CONFIG_DRIVE_STRENGTH_UA used */
> +                                       err = -EINVAL;
> +                                       break;
> +                               }
> +                       }
> +               }
> +
>                 if (hw->soc->drive_get)
>                         err = hw->soc->drive_get(hw, desc, &ret);
>                 else
>                         err = -ENOTSUPP;
>                 break;
> +       case PIN_CONFIG_DRIVE_STRENGTH_UA:
> +               if (hw->soc->adv_drive_get) {
> +                       err = hw->soc->adv_drive_get(hw, desc, &ret);
> +                       if (err)
> +                               break;
> +                       err = mtk_drv_adv_to_uA(ret);
> +                       if (err < 0)
> +                               break;
> +
> +                       ret = err;
> +                       err = 0;
> +               } else {
> +                       err = -ENOTSUPP;
> +               }
> +               break;
>         case MTK_PIN_CONFIG_TDSEL:
>         case MTK_PIN_CONFIG_RDSEL:
>                 reg = (param == MTK_PIN_CONFIG_TDSEL) ?
> @@ -271,6 +345,16 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                 else
>                         err = -ENOTSUPP;
>                 break;
> +       case PIN_CONFIG_DRIVE_STRENGTH_UA:
> +               if (hw->soc->adv_drive_set) {
> +                       err = mtk_drv_uA_to_adv(arg);
> +                       if (err < 0)
> +                               break;
> +                       err = hw->soc->adv_drive_set(hw, desc, err);
> +               } else {
> +                       err = -ENOTSUPP;
> +               }
> +               break;
>         case MTK_PIN_CONFIG_TDSEL:
>         case MTK_PIN_CONFIG_RDSEL:
>                 reg = (param == MTK_PIN_CONFIG_TDSEL) ?
> --
> 2.34.1.575.g55b058a8bb-goog
>
