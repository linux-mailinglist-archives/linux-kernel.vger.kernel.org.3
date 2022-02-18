Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F14BBB26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiBROzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:55:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiBROzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:55:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657A5AEFA;
        Fri, 18 Feb 2022 06:54:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BFA811F46B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645196083;
        bh=4dV1hV1+YnNgGJXnt+4LirNOcxSvJ3Z0S2uL4BexeZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ET1ltjqvLph6pmZpUK++4dzAZBt+ZHSGWGfsCkZh7KTHOVUEuBJR0sOw9G3K1nx0b
         efYAuul5m2xlrIa3+JdQ8cTB2QZCsf7/upQ+NdxWzn+AlJXxirf1YObr9DmsLyl1xL
         LR7SZutJxYUFkf0MRqSjamRFZ1YnmdvJDdTIyDpLZtQOW6e7T4/TQSj+cg/c5nO8V/
         1vm47qXfOaGEjtYe/nyvlfDhcu0J0im0ThOU749Vf8fvfiCmqyXaX5Y8IwccqTda1T
         TC2ZUJUmGfMjvXFN95NU6tysDP+tK+PoAZ/5eYL8iFZ7M8ZSJSqNXxKpUmhV/uFSgr
         jea9S9L2DH+Hg==
Message-ID: <308642b6-3615-bb55-2667-e2e3150be015@collabora.com>
Date:   Fri, 18 Feb 2022 15:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v2 11/17] ASoC: mediatek: mt8186: support gpio control in
 platform driver
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, aaronyu@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
 <20220217134205.15400-12-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217134205.15400-12-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> This patch add gpio control for all audio interface separately.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 210 ++++++++++++++++++++
>   sound/soc/mediatek/mt8186/mt8186-afe-gpio.h |  19 ++
>   2 files changed, 229 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
> 
> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
> new file mode 100644
> index 000000000000..6faec5c95bf3
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// mt8186-afe-gpio.c  --  Mediatek 8186 afe gpio ctrl
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +#include <linux/gpio.h>
> +#include <linux/pinctrl/consumer.h>
> +
> +#include "mt8186-afe-common.h"
> +#include "mt8186-afe-gpio.h"
> +
> +struct pinctrl *aud_pinctrl;
> +
> +enum mt8186_afe_gpio {
> +	MT8186_AFE_GPIO_CLK_MOSI_OFF,
> +	MT8186_AFE_GPIO_CLK_MOSI_ON,
> +	MT8186_AFE_GPIO_CLK_MISO_OFF,
> +	MT8186_AFE_GPIO_CLK_MISO_ON,
> +	MT8186_AFE_GPIO_DAT_MISO_OFF,
> +	MT8186_AFE_GPIO_DAT_MISO_ON,
> +	MT8186_AFE_GPIO_DAT_MOSI_OFF,
> +	MT8186_AFE_GPIO_DAT_MOSI_ON,
> +	MT8186_AFE_GPIO_I2S0_OFF,
> +	MT8186_AFE_GPIO_I2S0_ON,
> +	MT8186_AFE_GPIO_I2S1_OFF,
> +	MT8186_AFE_GPIO_I2S1_ON,
> +	MT8186_AFE_GPIO_I2S2_OFF,
> +	MT8186_AFE_GPIO_I2S2_ON,
> +	MT8186_AFE_GPIO_I2S3_OFF,
> +	MT8186_AFE_GPIO_I2S3_ON,
> +	MT8186_AFE_GPIO_TDM_OFF,
> +	MT8186_AFE_GPIO_TDM_ON,
> +	MT8186_AFE_GPIO_PCM_OFF,
> +	MT8186_AFE_GPIO_PCM_ON,
> +	MT8186_AFE_GPIO_GPIO_NUM
> +};
> +
> +struct audio_gpio_attr {
> +	const char *name;
> +	bool gpio_prepare;
> +	struct pinctrl_state *gpioctrl;
> +};
> +
> +static struct audio_gpio_attr aud_gpios[MT8186_AFE_GPIO_GPIO_NUM] = {
> +	[MT8186_AFE_GPIO_CLK_MOSI_OFF] = {"aud_clk_mosi_off", false, NULL},
> +	[MT8186_AFE_GPIO_CLK_MOSI_ON] = {"aud_clk_mosi_on", false, NULL},
> +	[MT8186_AFE_GPIO_CLK_MISO_OFF] = {"aud_clk_miso_off", false, NULL},
> +	[MT8186_AFE_GPIO_CLK_MISO_ON] = {"aud_clk_miso_on", false, NULL},
> +	[MT8186_AFE_GPIO_DAT_MISO_OFF] = {"aud_dat_miso_off", false, NULL},
> +	[MT8186_AFE_GPIO_DAT_MISO_ON] = {"aud_dat_miso_on", false, NULL},
> +	[MT8186_AFE_GPIO_DAT_MOSI_OFF] = {"aud_dat_mosi_off", false, NULL},
> +	[MT8186_AFE_GPIO_DAT_MOSI_ON] = {"aud_dat_mosi_on", false, NULL},
> +	[MT8186_AFE_GPIO_I2S0_OFF] = {"aud_gpio_i2s0_off", false, NULL},
> +	[MT8186_AFE_GPIO_I2S0_ON] = {"aud_gpio_i2s0_on", false, NULL},
> +	[MT8186_AFE_GPIO_I2S1_OFF] = {"aud_gpio_i2s1_off", false, NULL},
> +	[MT8186_AFE_GPIO_I2S1_ON] = {"aud_gpio_i2s1_on", false, NULL},
> +	[MT8186_AFE_GPIO_I2S2_OFF] = {"aud_gpio_i2s2_off", false, NULL},
> +	[MT8186_AFE_GPIO_I2S2_ON] = {"aud_gpio_i2s2_on", false, NULL},
> +	[MT8186_AFE_GPIO_I2S3_OFF] = {"aud_gpio_i2s3_off", false, NULL},
> +	[MT8186_AFE_GPIO_I2S3_ON] = {"aud_gpio_i2s3_on", false, NULL},
> +	[MT8186_AFE_GPIO_TDM_OFF] = {"aud_gpio_tdm_off", false, NULL},
> +	[MT8186_AFE_GPIO_TDM_ON] = {"aud_gpio_tdm_on", false, NULL},
> +	[MT8186_AFE_GPIO_PCM_OFF] = {"aud_gpio_pcm_off", false, NULL},
> +	[MT8186_AFE_GPIO_PCM_ON] = {"aud_gpio_pcm_on", false, NULL},
> +};
> +
> +static DEFINE_MUTEX(gpio_request_mutex);
> +
> +int mt8186_afe_gpio_init(struct device *dev)
> +{
> +	int ret;
> +	int i = 0;
> +
> +	aud_pinctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(aud_pinctrl)) {
> +		ret = PTR_ERR(aud_pinctrl);
> +		dev_info(dev, "%s(), ret %d, cannot get aud_pinctrl!\n",
> +			 __func__, ret);

dev_err()
... and return ret.

> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(aud_gpios); i++) {
> +		aud_gpios[i].gpioctrl = pinctrl_lookup_state(aud_pinctrl,
> +							     aud_gpios[i].name);
> +		if (IS_ERR(aud_gpios[i].gpioctrl)) {
> +			ret = PTR_ERR(aud_gpios[i].gpioctrl);
> +			dev_info(dev, "%s(), pinctrl_lookup_state %s fail, ret %d\n",
> +				 __func__, aud_gpios[i].name, ret);

dev_err()

P.S.: I think that this function should return ret, at this point, to avoid
       unexpected behavior.


> +		} else {
> +			aud_gpios[i].gpio_prepare = true;
> +		}
> +	}
> +
> +	/* gpio status init */
> +	mt8186_afe_gpio_request(dev, false, MT8186_DAI_ADDA, 0);
> +	mt8186_afe_gpio_request(dev, false, MT8186_DAI_ADDA, 1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt8186_afe_gpio_init);
> +
> +static int mt8186_afe_gpio_select(struct device *dev,
> +				  enum mt8186_afe_gpio type)
> +{
> +	int ret = 0;
> +
> +	if (type < 0 || type >= MT8186_AFE_GPIO_GPIO_NUM) {
> +		dev_info(dev, "%s(), error, invalid gpio type %d\n",
> +			 __func__, type);
> +		return -EINVAL;
> +	}
> +
> +	if (!aud_gpios[type].gpio_prepare) {
> +		dev_info(dev, "%s(), error, gpio type %d not prepared\n",
> +			 __func__, type);
> +		return -EIO;
> +	}
> +
> +	ret = pinctrl_select_state(aud_pinctrl,
> +				   aud_gpios[type].gpioctrl);
> +	if (ret)
> +		dev_info(dev, "%s(), error, can not set gpio type %d\n",
> +			 __func__, type);
> +
> +	return ret;

Please change it like so:

	if (ret) {
		dev_err(dev, "Failed to select picntrl state for type %d\n", type);
		return ret;
	}

	return 0;

> +}
> +
> +static int mt8186_afe_gpio_adda_dl(struct device *dev, bool enable)
> +{
> +	if (enable) {
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_ON);
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_ON);
> +	} else {
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MOSI_OFF);
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MOSI_OFF);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt8186_afe_gpio_adda_ul(struct device *dev, bool enable)
> +{
> +	if (enable) {
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_ON);
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_ON);
> +	} else {
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_DAT_MISO_OFF);
> +		mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_CLK_MISO_OFF);
> +	}
> +
> +	return 0;
> +}
> +
> +int mt8186_afe_gpio_request(struct device *dev, bool enable,
> +			    int dai, int uplink)
> +{

I think that it's more readable and even shorter if you do:

	enum mt8186_afe_gpio sel;

	int ret = -EINVAL;



	mutex_lock(&gpio_request_mutex);



	switch (dai) {

	case MT8186_DAI_ADDA:
		if (uplink)
			ret = mt8186_afe_gpio_adda_ul(dev, enable);
		else
			ret = mt8186_afe_gpio_adda_dl(dev, enable);
		goto unlock;
	case MT8186_DAI_I2S_0:

		sel = enable ? MT8186_AFE_GPIO_I2S0_ON : MT8186_AFE_GPIO_I2S0_OFF;

		break;

	case MT8186_DAI_I2S_1:

		sel = enable ? MT8186_AFE_GPIO_I2S1_ON : MT8186_AFE_GPIO_I2S1_OFF;

		break;



	.................... all other cases ................

	default:

		dev_err(dev, "invalid dai %d\n", dai);

		goto unlock;

	}


	ret = mt8186_afe_gpio_select(dev, sel);


unlock:

	mutex_unlock(&gpio_request_mutex);

	return ret;
}

> +	mutex_lock(&gpio_request_mutex);
> +	switch (dai) {
> +	case MT8186_DAI_ADDA:
> +		if (uplink)
> +			mt8186_afe_gpio_adda_ul(dev, enable);
> +		else
> +			mt8186_afe_gpio_adda_dl(dev, enable);
> +		break;
> +	case MT8186_DAI_I2S_0:
> +		if (enable)
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S0_ON);
> +		else
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S0_OFF);
> +		break;
> +	case MT8186_DAI_I2S_1:
> +		if (enable)
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S1_ON);
> +		else
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S1_OFF);
> +		break;
> +	case MT8186_DAI_I2S_2:
> +		if (enable)
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S2_ON);
> +		else
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S2_OFF);
> +		break;
> +	case MT8186_DAI_I2S_3:
> +		if (enable)
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S3_ON);
> +		else
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_I2S3_OFF);
> +		break;
> +	case MT8186_DAI_TDM_IN:
> +		if (enable)
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_TDM_ON);
> +		else
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_TDM_OFF);
> +		break;
> +	case MT8186_DAI_PCM:
> +		if (enable)
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_PCM_ON);
> +		else
> +			mt8186_afe_gpio_select(dev, MT8186_AFE_GPIO_PCM_OFF);
> +		break;
> +	default:
> +		mutex_unlock(&gpio_request_mutex);
> +		dev_info(dev, "%s(), invalid dai %d\n", __func__, dai);
> +		return -EINVAL;
> +	}
> +	mutex_unlock(&gpio_request_mutex);
> +	return 0;
> +}
> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
> new file mode 100644
> index 000000000000..1ddc27838eb1
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * mt6833-afe-gpio.h  --  Mediatek 6833 afe gpio ctrl definition
> + *
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> + */
> +
> +#ifndef _MT8186_AFE_GPIO_H_
> +#define _MT8186_AFE_GPIO_H_
> +
> +struct mtk_base_afe;
> +
> +int mt8186_afe_gpio_init(struct device *dev);
> +
> +int mt8186_afe_gpio_request(struct device *dev, bool enable,
> +			    int dai, int uplink);
> +
> +#endif

