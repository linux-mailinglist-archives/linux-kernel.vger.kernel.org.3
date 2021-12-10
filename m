Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494A74704F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhLJP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:57:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:19297 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240406AbhLJP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:57:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="299155762"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="299155762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 07:53:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="612965087"
Received: from lclopezf-mobl.amr.corp.intel.com (HELO [10.209.164.172]) ([10.209.164.172])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 07:53:41 -0800
Subject: Re: [PATCH 1/2] ASoC: add ES8156 codec driver
To:     Shumin Chen <chenshumin86@sina.com>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20211210151041.108751-1-chenshumin86@sina.com>
 <20211210151041.108751-2-chenshumin86@sina.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <42b70959-3bfb-7370-4ea4-39833b6e42d9@linux.intel.com>
Date:   Fri, 10 Dec 2021 09:53:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210151041.108751-2-chenshumin86@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/21 9:10 AM, Shumin Chen wrote:
> Add a codec driver for the Everest ES8156, based on code provided by
> Will from Everest Sem>
> Signed-off-by: Shumin Chen <chenshumin86@sina.com>

There's an additional reference below:

+ * Author: Will <pengxiaoxin@everset-semi.com>

This should probably come with a Signed-off-by tag from
'Will'

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin


> @@ -0,0 +1,614 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * es8156.c -- es8156 ALSA SoC audio driver
> + * Copyright Everest Semiconductor Co.,Ltd
> + *
> + * Author: Will <pengxiaoxin@everset-semi.com>
> + *         Shumin Chen <chenshumin86@sina.com>
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/i2c.h>
> +#include <linux/spi/spi.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/of_gpio.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/tlv.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +#include <linux/proc_fs.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/regmap.h>

usually the headers are added by alphabetical order.

> +#include "es8156.h"
> +
> +#define INVALID_GPIO -1
> +#define GPIO_LOW  0
> +#define GPIO_HIGH 1
> +#define es8156_DEF_VOL			0xBF
> +#define MCLK 1

edit: these defines are used below to enable/disable parts of the code.
I don't think it's quite right to do so, you would want to use means to
read properties from platform firmware or use 'optional' versions of
functions to get clocks and gpios.

> +
> +static struct snd_soc_component *es8156_codec;
> +
> +static const struct reg_default es8156_reg_defaults[] = {
> +	{0x00, 0x1c}, {0x01, 0x20}, {0x02, 0x00}, {0x03, 0x01},
> +	{0x04, 0x00}, {0x05, 0x04}, {0x06, 0x11}, {0x07, 0x00},
> +	{0x08, 0x06}, {0x09, 0x00}, {0x0a, 0x50}, {0x0b, 0x50},
> +	{0x0c, 0x00}, {0x0d, 0x10}, {0x10, 0x40}, {0x10, 0x40},
> +	{0x11, 0x00}, {0x12, 0x04}, {0x13, 0x11}, {0x14, 0xbf},
> +	{0x15, 0x00}, {0x16, 0x00}, {0x17, 0xf7}, {0x18, 0x00},
> +	{0x19, 0x20}, {0x1a, 0x00}, {0x20, 0x16}, {0x21, 0x7f},
> +	{0x22, 0x00}, {0x23, 0x86}, {0x24, 0x00}, {0x25, 0x07},
> +	{0xfc, 0x00}, {0xfd, 0x81}, {0xfe, 0x55}, {0xff, 0x10},
> +};
> +
> +/* codec private data */
> +struct es8156_priv {
> +	struct regmap *regmap;
> +	unsigned int dmic_amic;
> +	unsigned int sysclk;
> +	struct snd_pcm_hw_constraint_list *sysclk_constraints;
> +	struct clk *mclk;
> +	int debounce_time;
> +	int hp_det_invert;
> +	struct delayed_work work;
> +
> +	int spk_ctl_gpio;
> +	int hp_det_gpio;
> +	bool muted;
> +	bool hp_inserted;
> +	bool spk_active_level;
> +
> +	int pwr_count;
> +};
> +
> +/*
> + * es8156_reset
> + */
> +static int es8156_reset(struct snd_soc_component *codec)
> +{
> +	snd_soc_component_write(codec, ES8156_RESET_REG00, 0x1c);
> +	usleep_range(5000, 5500);
> +	return snd_soc_component_write(codec, ES8156_RESET_REG00, 0x03);

it's a bit odd that you care about the return of the function only in
the second call, is this intentional? Or is this a shortcut for

snd_soc_component_write(codec, ES8156_RESET_REG00, 0x1c);
usleep_range(5000, 5500);
snd_soc_component_write(codec, ES8156_RESET_REG00, 0x03);
return 0;

?


> +static int es8156_set_dai_fmt(struct snd_soc_dai *codec_dai,
> +			      unsigned int fmt)
> +{
> +	struct snd_soc_component *codec = codec_dai->component;
> +
> +	/* set master/slave audio interface */

we use clock provider and consumer terms now.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {

SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK

> +	case SND_SOC_DAIFMT_CBM_CFM:/* es8156 master */

CBP_CFP

> +		snd_soc_component_update_bits(codec, ES8156_SCLK_MODE_REG02, 0x01, 0x01);
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:/* es8156 slave */

CBC_CFC


> +static int es8156_mute(struct snd_soc_dai *dai, int mute, int stream)
> +{
> +	struct snd_soc_component *codec = dai->component;
> +	struct es8156_priv *es8156 = snd_soc_component_get_drvdata(codec);
> +
> +	es8156->muted = mute;
> +	if (mute) {

if (!es8156->hp_inserted)
for symmetry with the case below?

> +		es8156_enable_spk(es8156, false);
> +		msleep(100);
> +		snd_soc_component_update_bits(codec, ES8156_DAC_MUTE_REG13, 0x08, 0x08);
> +	} else if (dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK]) {
> +		snd_soc_component_update_bits(codec, ES8156_DAC_MUTE_REG13, 0x08, 0x00);
> +
> +		if (!es8156->hp_inserted)
> +			es8156_enable_spk(es8156, true);
> +	}
> +	return 0;
> +}

> +static const struct snd_soc_dai_ops es8156_ops = {
> +	.startup = NULL,
> +	.hw_params = es8156_pcm_hw_params,
> +	.set_fmt = es8156_set_dai_fmt,
> +	.set_sysclk = NULL,
> +	.mute_stream = es8156_mute,
> +	.shutdown = NULL,
> +};

don't add callbacks that are NULL.

> +
> +static struct snd_soc_dai_driver es8156_dai = {
> +	.name = "ES8156 HiFi",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = es8156_RATES,
> +		.formats = es8156_FORMATS,
> +	},
> +	.ops = &es8156_ops,
> +	.symmetric_rate = 1,

not sure what the symmetry might mean if there is only playback support.

Likewise the tests above for the playback only direction can only be
always true then?

> +static int es8156_init_regs(struct snd_soc_component *codec)
> +{
> +	/* set clock and analog power */
> +	snd_soc_component_write(codec, ES8156_SCLK_MODE_REG02, 0x04);
> +	snd_soc_component_write(codec, ES8156_ANALOG_SYS1_REG20, 0x2A);
> +	snd_soc_component_write(codec, ES8156_ANALOG_SYS2_REG21, 0x3C);
> +	snd_soc_component_write(codec, ES8156_ANALOG_SYS3_REG22, 0x08);
> +	snd_soc_component_write(codec, ES8156_ANALOG_LP_REG24, 0x07);
> +	snd_soc_component_write(codec, ES8156_ANALOG_SYS4_REG23, 0x00);
> +
> +	/* set powerup time */
> +	snd_soc_component_write(codec, ES8156_TIME_CONTROL1_REG0A, 0x01);
> +	snd_soc_component_write(codec, ES8156_TIME_CONTROL2_REG0B, 0x01);
> +
> +	/* set digtal volume */

typo: digital

> +	snd_soc_component_write(codec, ES8156_VOLUME_CONTROL_REG14, 0xBF);
> +
> +	/* set MCLK */
> +	snd_soc_component_write(codec, ES8156_MAINCLOCK_CTL_REG01, 0x21);
> +	snd_soc_component_write(codec, ES8156_P2S_CONTROL_REG0D, 0x14);
> +	snd_soc_component_write(codec, ES8156_MISC_CONTROL3_REG18, 0x00);
> +	snd_soc_component_write(codec, ES8156_CLOCK_ON_OFF_REG08, 0x3F);
> +	snd_soc_component_write(codec, ES8156_RESET_REG00, 0x02);
> +	snd_soc_component_write(codec, ES8156_RESET_REG00, 0x03);
> +	snd_soc_component_write(codec, ES8156_ANALOG_SYS5_REG25, 0x20);
> +
> +	return 0;
> +}
> +
> +static int es8156_suspend(struct snd_soc_component *codec)
> +{
> +	es8156_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}
> +
> +static int es8156_resume(struct snd_soc_component *codec)
> +{
> +	return 0;

es8156_set_bias_level(codec, SND_SOC_BIAS_ON);

for symmetry with suspend?


> +static int es8156_probe(struct snd_soc_component *codec)
> +{
> +	struct es8156_priv *es8156 = snd_soc_component_get_drvdata(codec);
> +	int ret = 0;
> +
> +	es8156_codec = codec;
> +
> +#if MCLK
> +	es8156->mclk = devm_clk_get(codec->dev, "mclk");
> +	if (PTR_ERR(es8156->mclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	ret = clk_prepare_enable(es8156->mclk);
> +#endif

Unclear how MCLK will be enabled in a build, did you mean

es8156->mclk = devm_clk_get_optional(codec->dev, "mclk");

> +	es8156_reset(codec);
> +	es8156_init_regs(codec);
> +
> +	return ret;
> +}

> +/* es8156 7bit i2c address:CE pin:0 0x08 / CE pin:1 0x09 */
> +static int es8156_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	struct es8156_priv *es8156;
> +	int ret = -1;
> +
> +	es8156 = devm_kzalloc(&i2c->dev, sizeof(*es8156), GFP_KERNEL);
> +	if (!es8156)
> +		return -ENOMEM;
> +
> +	es8156->debounce_time = 200;
> +	es8156->hp_det_invert = 0;
> +	es8156->pwr_count = 0;
> +	es8156->hp_inserted = false;
> +	es8156->muted = true;
> +
> +	es8156->regmap = devm_regmap_init_i2c(i2c, &es8156_regmap_config);
> +	if (IS_ERR(es8156->regmap)) {
> +		ret = PTR_ERR(es8156->regmap);
> +		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(i2c, es8156);
> +#ifdef HP_DET_FUNTION
> +	es8156->spk_ctl_gpio = of_get_named_gpio_flags(np,
> +						       "spk-con-gpio",
> +						       0,
> +						       &flags);
> +	if (es8156->spk_ctl_gpio < 0) {
> +		dev_info(&i2c->dev, "Can not read property spk_ctl_gpio\n");
> +		es8156->spk_ctl_gpio = INVALID_GPIO;
> +	} else {
> +		es8156->spk_active_level = !(flags & OF_GPIO_ACTIVE_LOW);
> +		ret = devm_gpio_request_one(&i2c->dev, es8156->spk_ctl_gpio,
> +					    GPIOF_DIR_OUT, NULL);
> +		if (ret) {
> +			dev_err(&i2c->dev, "Failed to request spk_ctl_gpio\n");
> +			return ret;
> +		}
> +		es8156_enable_spk(es8156, false);
> +	}
> +
> +	es8156->hp_det_gpio = of_get_named_gpio_flags(np,
> +						      "hp-det-gpio",
> +						      0,
> +						      &flags);
> +	if (es8156->hp_det_gpio < 0) {
> +		dev_info(&i2c->dev, "Can not read property hp_det_gpio\n");
> +		es8156->hp_det_gpio = INVALID_GPIO;
> +	} else {
> +		INIT_DELAYED_WORK(&es8156->work, hp_work);
> +		es8156->hp_det_invert = !!(flags & OF_GPIO_ACTIVE_LOW);
> +		ret = devm_gpio_request_one(&i2c->dev, es8156->hp_det_gpio,
> +					    GPIOF_IN, "hp det");
> +		if (ret < 0)
> +			return ret;
> +		hp_irq = gpio_to_irq(es8156->hp_det_gpio);
> +		ret = devm_request_threaded_irq(&i2c->dev, hp_irq, NULL,
> +						es8156_irq_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_TRIGGER_RISING |
> +						IRQF_ONESHOT,
> +						"es8156_interrupt", es8156);
> +		if (ret < 0) {
> +			dev_err(&i2c->dev, "request_irq failed: %d\n", ret);
> +			return ret;
> +		}
> +
> +		schedule_delayed_work(&es8156->work,
> +				      msecs_to_jiffies(es8156->debounce_time));
> +	}
> +#endif

same, this will be dead code. You have to use a property or a
get_optional helper.

> +	ret = snd_soc_register_component(&i2c->dev,
> +				     &soc_codec_dev_es8156,
> +				     &es8156_dai, 1);

use devm_?

> +
> +	return ret;
> +}
> +
> +static  int es8156_i2c_remove(struct i2c_client *client)
> +{
> +	snd_soc_unregister_component(&client->dev);
> +
> +	return 0;
> +}

can be removed if devm is used above.

> +
> +static void es8156_i2c_shutdown(struct i2c_client *client)
> +{
> +	struct es8156_priv *es8156 = i2c_get_clientdata(client);
> +
> +	if (es8156_codec != NULL) {
> +		es8156_enable_spk(es8156, false);
> +		msleep(20);
> +		es8156_set_bias_level(es8156_codec, SND_SOC_BIAS_OFF);
> +	}

unclear shutdown and remove use difference sequences? Isn't this not
needed when removing the driver?

> +MODULE_DESCRIPTION("ASoC es8156 driver");
> +MODULE_AUTHOR("Will <pengxiaoxin@everset-semi.com>");

you would definitively need a Signed-off-by from this author.

> +MODULE_AUTHOR("Shumin Chen <chenshumin86@sina.com>");
> +MODULE_LICENSE("GPL");

