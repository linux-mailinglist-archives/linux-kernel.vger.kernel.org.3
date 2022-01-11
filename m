Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4508C48AEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiAKNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbiAKNlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:41:47 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DBCC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:41:46 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C09EF20143;
        Tue, 11 Jan 2022 14:41:41 +0100 (CET)
Subject: Re: [PATCH 7/7] pinctrl: mediatek: paris: Support generic
 PIN_CONFIG_DRIVE_STRENGTH_UA
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <99ae1a61-7d12-f723-efb7-b26abb3811ef@somainline.org>
Date:   Tue, 11 Jan 2022 14:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-8-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
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
> 
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

Hello Chen-Yu,

this commit is so nice that:
- My heart says that it's fine as it is, but
- My brain says that it makes a lot more sense if you push the cleanup
changes to reverse that logic before pushing this commit, as to reduce the
count of changed lines (hence, to reduce some noise)...

...so please, can you rebase this commit over the cleanups?

Thanks,
- Angelo

> 
> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 84 ++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index 678c8aa33012..5a94903ae372 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -48,6 +48,53 @@ static const char * const mtk_gpio_functions[] = {
>   	"func12", "func13", "func14", "func15",
>   };
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
> +	/* This should never happen. */
> +	if (WARN_ON_ONCE(val < 0 || val > 7))
> +		return -EINVAL;
> +
> +	/* Bit 0 simply enables this hardware part */
> +	if (!(val & BIT(0)))
> +		return -EINVAL;
> +
> +	return mtk_drv_adv_uA[(val >> 1)];
> +}
> +
> +static int mtk_drv_uA_to_adv(int val)
> +{
> +	switch (val) {
> +	case 125:
> +		return 0x1;
> +	case 250:
> +		return 0x3;
> +	case 500:
> +		return 0x5;
> +	case 1000:
> +		return 0x7;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
>   					  struct pinctrl_gpio_range *range,
>   					  unsigned int pin)
> @@ -151,11 +198,38 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>   
>   		break;
>   	case PIN_CONFIG_DRIVE_STRENGTH:
> +		if (hw->soc->adv_drive_get) {
> +			err = hw->soc->adv_drive_get(hw, desc, &ret);
> +			if (!err) {
> +				err = mtk_drv_adv_to_uA(ret);
> +				if (err > 0) {
> +					/* PIN_CONFIG_DRIVE_STRENGTH_UA used */
> +					err = -EINVAL;
> +					break;
> +				}
> +			}
> +		}
> +
>   		if (hw->soc->drive_get)
>   			err = hw->soc->drive_get(hw, desc, &ret);
>   		else
>   			err = -ENOTSUPP;
>   		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH_UA:
> +		if (hw->soc->adv_drive_get) {
> +			err = hw->soc->adv_drive_get(hw, desc, &ret);
> +			if (err)
> +				break;
> +			err = mtk_drv_adv_to_uA(ret);
> +			if (err < 0)
> +				break;
> +
> +			ret = err;
> +			err = 0;
> +		} else {
> +			err = -ENOTSUPP;
> +		}
> +		break;
>   	case MTK_PIN_CONFIG_TDSEL:
>   	case MTK_PIN_CONFIG_RDSEL:
>   		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
> @@ -271,6 +345,16 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>   		else
>   			err = -ENOTSUPP;
>   		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH_UA:
> +		if (hw->soc->adv_drive_set) {
> +			err = mtk_drv_uA_to_adv(arg);
> +			if (err < 0)
> +				break;
> +			err = hw->soc->adv_drive_set(hw, desc, err);
> +		} else {
> +			err = -ENOTSUPP;
> +		}
> +		break;
>   	case MTK_PIN_CONFIG_TDSEL:
>   	case MTK_PIN_CONFIG_RDSEL:
>   		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
> 

