Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C574CC14B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiCCPbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiCCPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:31:44 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43A13FAED;
        Thu,  3 Mar 2022 07:30:56 -0800 (PST)
X-UUID: ef07d239f4c74e5e89cabe3788ad0145-20220303
X-UUID: ef07d239f4c74e5e89cabe3788ad0145-20220303
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1650477533; Thu, 03 Mar 2022 23:30:49 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 3 Mar 2022 23:30:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Mar
 2022 23:30:47 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 23:30:46 +0800
Message-ID: <a6a2c2e4acdd52bd3aa8b8551e0a9180255aecd2.camel@mediatek.com>
Subject: Re: [v2 11/17] ASoC: mediatek: mt8186: support gpio control in
 platform driver
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <aaronyu@google.com>, <zhangqilong3@huawei.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 3 Mar 2022 23:30:46 +0800
In-Reply-To: <308642b6-3615-bb55-2667-e2e3150be015@collabora.com>
References: <20220217134205.15400-1-jiaxin.yu@mediatek.com>
         <20220217134205.15400-12-jiaxin.yu@mediatek.com>
         <308642b6-3615-bb55-2667-e2e3150be015@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-18 at 15:54 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/02/22 14:41, Jiaxin Yu ha scritto:
> > This patch add gpio control for all audio interface separately.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >   sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 210
> > ++++++++++++++++++++
> >   sound/soc/mediatek/mt8186/mt8186-afe-gpio.h |  19 ++
> >   2 files changed, 229 insertions(+)
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
> >   create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
> > 
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
> > b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
> > new file mode 100644
> > index 000000000000..6faec5c95bf3
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
> > @@ -0,0 +1,210 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// mt8186-afe-gpio.c  --  Mediatek 8186 afe gpio ctrl
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +#include <linux/gpio.h>
> > +#include <linux/pinctrl/consumer.h>
> > +
> > +#include "mt8186-afe-common.h"
> > +#include "mt8186-afe-gpio.h"
> > +
> > +struct pinctrl *aud_pinctrl;
> > +
> > +enum mt8186_afe_gpio {
> > +	MT8186_AFE_GPIO_CLK_MOSI_OFF,
> > +	MT8186_AFE_GPIO_CLK_MOSI_ON,
> > +	MT8186_AFE_GPIO_CLK_MISO_OFF,
> > +	MT8186_AFE_GPIO_CLK_MISO_ON,
> > +	MT8186_AFE_GPIO_DAT_MISO_OFF,
> > +	MT8186_AFE_GPIO_DAT_MISO_ON,
> > +	MT8186_AFE_GPIO_DAT_MOSI_OFF,
> > +	MT8186_AFE_GPIO_DAT_MOSI_ON,
> > +	MT8186_AFE_GPIO_I2S0_OFF,
> > +	MT8186_AFE_GPIO_I2S0_ON,
> > +	MT8186_AFE_GPIO_I2S1_OFF,
> > +	MT8186_AFE_GPIO_I2S1_ON,
> > +	MT8186_AFE_GPIO_I2S2_OFF,
> > +	MT8186_AFE_GPIO_I2S2_ON,
> > +	MT8186_AFE_GPIO_I2S3_OFF,
> > +	MT8186_AFE_GPIO_I2S3_ON,
> > +	MT8186_AFE_GPIO_TDM_OFF,
> > +	MT8186_AFE_GPIO_TDM_ON,
> > +	MT8186_AFE_GPIO_PCM_OFF,
> > +	MT8186_AFE_GPIO_PCM_ON,
> > +	MT8186_AFE_GPIO_GPIO_NUM
> > +};
> > +
> > +struct audio_gpio_attr {
> > +	const char *name;
> > +	bool gpio_prepare;
> > +	struct pinctrl_state *gpioctrl;
> > +};
> > +
> > +static struct audio_gpio_attr aud_gpios[MT8186_AFE_GPIO_GPIO_NUM]
> > = {
> > +	[MT8186_AFE_GPIO_CLK_MOSI_OFF] = {"aud_clk_mosi_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_CLK_MOSI_ON] = {"aud_clk_mosi_on", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_CLK_MISO_OFF] = {"aud_clk_miso_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_CLK_MISO_ON] = {"aud_clk_miso_on", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_DAT_MISO_OFF] = {"aud_dat_miso_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_DAT_MISO_ON] = {"aud_dat_miso_on", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_DAT_MOSI_OFF] = {"aud_dat_mosi_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_DAT_MOSI_ON] = {"aud_dat_mosi_on", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_I2S0_OFF] = {"aud_gpio_i2s0_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_I2S0_ON] = {"aud_gpio_i2s0_on", false, NULL},
> > +	[MT8186_AFE_GPIO_I2S1_OFF] = {"aud_gpio_i2s1_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_I2S1_ON] = {"aud_gpio_i2s1_on", false, NULL},
> > +	[MT8186_AFE_GPIO_I2S2_OFF] = {"aud_gpio_i2s2_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_I2S2_ON] = {"aud_gpio_i2s2_on", false, NULL},
> > +	[MT8186_AFE_GPIO_I2S3_OFF] = {"aud_gpio_i2s3_off", false,
> > NULL},
> > +	[MT8186_AFE_GPIO_I2S3_ON] = {"aud_gpio_i2s3_on", false, NULL},
> > +	[MT8186_AFE_GPIO_TDM_OFF] = {"aud_gpio_tdm_off", false, NULL},
> > +	[MT8186_AFE_GPIO_TDM_ON] = {"aud_gpio_tdm_on", false, NULL},
> > +	[MT8186_AFE_GPIO_PCM_OFF] = {"aud_gpio_pcm_off", false, NULL},
> > +	[MT8186_AFE_GPIO_PCM_ON] = {"aud_gpio_pcm_on", false, NULL},
> > +};
> > +
> > +static DEFINE_MUTEX(gpio_request_mutex);
> > +
> > +int mt8186_afe_gpio_init(struct device *dev)
> > +{
> > +	int ret;
> > +	int i = 0;
> > +
> > +	aud_pinctrl = devm_pinctrl_get(dev);
> > +	if (IS_ERR(aud_pinctrl)) {
> > +		ret = PTR_ERR(aud_pinctrl);
> > +		dev_info(dev, "%s(), ret %d, cannot get
> > aud_pinctrl!\n",
> > +			 __func__, ret);
> 
> dev_err()
> ... and return ret.
> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(aud_gpios); i++) {
> > +		aud_gpios[i].gpioctrl =
> > pinctrl_lookup_state(aud_pinctrl,
> > +							     aud_gpios[
> > i].name);
> > +		if (IS_ERR(aud_gpios[i].gpioctrl)) {
> > +			ret = PTR_ERR(aud_gpios[i].gpioctrl);
> > +			dev_info(dev, "%s(), pinctrl_lookup_state %s
> > fail, ret %d\n",
> > +				 __func__, aud_gpios[i].name, ret);
> 
> dev_err()
> 
> P.S.: I think that this function should return ret, at this point, to
> avoid
>        unexpected behavior.

Because we maybe don't need to config all of audio interface gpio in
dtsi. for example, we may only use I2S0/I2S1 instead of I2S3/I2S4, so
there only config I2S0/I2S1's pinctrl in dtsi. So I think there only
need dev_info() as a reminder. How do you suggest for it?

> 
> 
> > +		} else {
> > +			aud_gpios[i].gpio_prepare = true;
> > +		}
> > +	}
> > +
> > +	/* gpio status init */
> > +	mt8186_afe_gpio_request(dev, false, MT8186_DAI_ADDA, 0);
> > +	mt8186_afe_gpio_request(dev, false, MT8186_DAI_ADDA, 1);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mt8186_afe_gpio_init);
> > +
> > +static int mt8186_afe_gpio_select(struct device *dev,
> > +				  enum mt8186_afe_gpio type)
> > +{
> > +	int ret = 0;
> > +
> > +	if (type < 0 || type >= MT8186_AFE_GPIO_GPIO_NUM) {
> > +		dev_info(dev, "%s(), error, invalid gpio type %d\n",
> > +			 __func__, type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!aud_gpios[type].gpio_prepare) {
> > +		dev_info(dev, "%s(), error, gpio type %d not
> > prepared\n",
> > +			 __func__, type);
> > +		return -EIO;
> > +	}
> > +
> > +	ret = pinctrl_select_state(aud_pinctrl,
> > +				   aud_gpios[type].gpioctrl);
> > +	if (ret)
> > +		dev_info(dev, "%s(), error, can not set gpio type
> > %d\n",
> > +			 __func__, type);
> > +
> > +	return ret;
> 
> Please change it like so:
> 
> 	if (ret) {
> 		dev_err(dev, "Failed to select picntrl state for type
> %d\n", type);
> 		return ret;
> 	}
> 
> 	return 0;
> 
> > +}
> > +
> > +static int mt8186_afe_gpio_adda_dl(struct device *dev, bool
> > enable)
> > +{
> > +	if (enable) {
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_CLK_MOSI_ON);
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_DAT_MOSI_ON);
> > +	} else {
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_DAT_MOSI_OFF);
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_CLK_MOSI_OFF);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8186_afe_gpio_adda_ul(struct device *dev, bool
> > enable)
> > +{
> > +	if (enable) {
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_CLK_MISO_ON);
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_DAT_MISO_ON);
> > +	} else {
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_DAT_MISO_OFF);
> > +		mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_CLK_MISO_OFF);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int mt8186_afe_gpio_request(struct device *dev, bool enable,
> > +			    int dai, int uplink)
> > +{
> 
> I think that it's more readable and even shorter if you do:
> 
> 	enum mt8186_afe_gpio sel;
> 
> 	int ret = -EINVAL;
> 
> 
> 
> 	mutex_lock(&gpio_request_mutex);
> 
> 
> 
> 	switch (dai) {
> 
> 	case MT8186_DAI_ADDA:
> 		if (uplink)
> 			ret = mt8186_afe_gpio_adda_ul(dev, enable);
> 		else
> 			ret = mt8186_afe_gpio_adda_dl(dev, enable);
> 		goto unlock;
> 	case MT8186_DAI_I2S_0:
> 
> 		sel = enable ? MT8186_AFE_GPIO_I2S0_ON :
> MT8186_AFE_GPIO_I2S0_OFF;
> 
> 		break;
> 
> 	case MT8186_DAI_I2S_1:
> 
> 		sel = enable ? MT8186_AFE_GPIO_I2S1_ON :
> MT8186_AFE_GPIO_I2S1_OFF;
> 
> 		break;
> 
> 
> 
> 	.................... all other cases ................
> 
> 	default:
> 
> 		dev_err(dev, "invalid dai %d\n", dai);
> 
> 		goto unlock;
> 
> 	}
> 
> 
> 	ret = mt8186_afe_gpio_select(dev, sel);
> 
> 
> unlock:
> 
> 	mutex_unlock(&gpio_request_mutex);
> 
> 	return ret;
> }
> 
> > +	mutex_lock(&gpio_request_mutex);
> > +	switch (dai) {
> > +	case MT8186_DAI_ADDA:
> > +		if (uplink)
> > +			mt8186_afe_gpio_adda_ul(dev, enable);
> > +		else
> > +			mt8186_afe_gpio_adda_dl(dev, enable);
> > +		break;
> > +	case MT8186_DAI_I2S_0:
> > +		if (enable)
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S0_ON);
> > +		else
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S0_OFF);
> > +		break;
> > +	case MT8186_DAI_I2S_1:
> > +		if (enable)
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S1_ON);
> > +		else
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S1_OFF);
> > +		break;
> > +	case MT8186_DAI_I2S_2:
> > +		if (enable)
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S2_ON);
> > +		else
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S2_OFF);
> > +		break;
> > +	case MT8186_DAI_I2S_3:
> > +		if (enable)
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S3_ON);
> > +		else
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_I2S3_OFF);
> > +		break;
> > +	case MT8186_DAI_TDM_IN:
> > +		if (enable)
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_TDM_ON);
> > +		else
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_TDM_OFF);
> > +		break;
> > +	case MT8186_DAI_PCM:
> > +		if (enable)
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_PCM_ON);
> > +		else
> > +			mt8186_afe_gpio_select(dev,
> > MT8186_AFE_GPIO_PCM_OFF);
> > +		break;
> > +	default:
> > +		mutex_unlock(&gpio_request_mutex);
> > +		dev_info(dev, "%s(), invalid dai %d\n", __func__, dai);
> > +		return -EINVAL;
> > +	}
> > +	mutex_unlock(&gpio_request_mutex);
> > +	return 0;
> > +}
> > diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
> > b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
> > new file mode 100644
> > index 000000000000..1ddc27838eb1
> > --- /dev/null
> > +++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * mt6833-afe-gpio.h  --  Mediatek 6833 afe gpio ctrl definition
> > + *
> > + * Copyright (c) 2022 MediaTek Inc.
> > + * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > + */
> > +
> > +#ifndef _MT8186_AFE_GPIO_H_
> > +#define _MT8186_AFE_GPIO_H_
> > +
> > +struct mtk_base_afe;
> > +
> > +int mt8186_afe_gpio_init(struct device *dev);
> > +
> > +int mt8186_afe_gpio_request(struct device *dev, bool enable,
> > +			    int dai, int uplink);
> > +
> > +#endif
> 
> 

