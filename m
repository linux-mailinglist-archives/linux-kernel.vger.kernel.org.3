Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09B5694BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiGFVxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiGFVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:53:43 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E126AF1;
        Wed,  6 Jul 2022 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657144419; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MYEVjZzoNtTCJiZr8vDMG0/wpLNhJ5jPks4vAbJZdFc=;
        b=oUJBhL+KMj6Oa0IFZo5sY9BCxn0vgCsmhLQqf+PTtO7pV8BX5B0Su8ewwMh7YusXEBzgL+
        tZ0t1TIba7JXNsIdbvUt4TNUARs9Dyo5XUROQXbwU76OB7kE+2snkjzOzOSn9kZgc2uW46
        +Vs+6/AAw2cE/Ysf/zbdk4chd9W2dpQ=
Date:   Wed, 06 Jul 2022 22:53:29 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 03/11] ASoC: jz4740-i2s: Convert to regmap API
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <5TCMER.XTCEJKYW8UD9@crapouillou.net>
In-Reply-To: <20220706211330.120198-4-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-4-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le mer., juil. 6 2022 at 22:13:22 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Using regmap for accessing the AIC registers makes the driver a
> little easier to read, and later refactors can take advantage of
> regmap APIs to further simplify the driver.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/Kconfig      |  1 +
>  sound/soc/jz4740/jz4740-i2s.c | 99=20
> +++++++++++++++--------------------
>  2 files changed, 42 insertions(+), 58 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
> index e72f826062e9..dd3b4507fbe6 100644
> --- a/sound/soc/jz4740/Kconfig
> +++ b/sound/soc/jz4740/Kconfig
> @@ -3,6 +3,7 @@ config SND_JZ4740_SOC_I2S
>  	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
>  	depends on MIPS || COMPILE_TEST
>  	depends on HAS_IOMEM
> +	select REGMAP_MMIO
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	help
>  	  Say Y if you want to use I2S protocol and I2S codec on Ingenic=20
> JZ4740
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index ecd8df70d39c..66a901f56392 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>=20
>  #include <linux/clk.h>
> @@ -94,7 +95,7 @@ struct i2s_soc_info {
>=20
>  struct jz4740_i2s {
>  	struct resource *mem;
> -	void __iomem *base;
> +	struct regmap *regmap;
>=20
>  	struct clk *clk_aic;
>  	struct clk *clk_i2s;
> @@ -105,39 +106,24 @@ struct jz4740_i2s {
>  	const struct i2s_soc_info *soc_info;
>  };
>=20
> -static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
> -	unsigned int reg)
> -{
> -	return readl(i2s->base + reg);
> -}
> -
> -static inline void jz4740_i2s_write(const struct jz4740_i2s *i2s,
> -	unsigned int reg, uint32_t value)
> -{
> -	writel(value, i2s->base + reg);
> -}
> -
>  static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -	uint32_t conf, ctrl;
>  	int ret;
>=20
>  	if (snd_soc_dai_active(dai))
>  		return 0;
>=20
> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
> -	ctrl |=3D JZ_AIC_CTRL_FLUSH;
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
> +	regmap_write_bits(i2s->regmap, JZ_REG_AIC_CTRL,
> +			  JZ_AIC_CTRL_FLUSH, JZ_AIC_CTRL_FLUSH);

I don't think you need regmap_write_bits() here, since there is no=20
cache to bypass. You could use regmap_update_bits(), or even better,=20
regmap_set_bits().

>=20
>  	ret =3D clk_prepare_enable(i2s->clk_i2s);
>  	if (ret)
>  		return ret;
>=20
> -	conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> -	conf |=3D JZ_AIC_CONF_ENABLE;
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> +	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
> +			   JZ_AIC_CONF_ENABLE, JZ_AIC_CONF_ENABLE);

Use regmap_set_bits() when you want to set all the bits of the mask.

>=20
>  	return 0;
>  }
> @@ -146,14 +132,12 @@ static void jz4740_i2s_shutdown(struct=20
> snd_pcm_substream *substream,
>  	struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -	uint32_t conf;
>=20
>  	if (snd_soc_dai_active(dai))
>  		return;
>=20
> -	conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> -	conf &=3D ~JZ_AIC_CONF_ENABLE;
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> +	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
> +			   JZ_AIC_CONF_ENABLE, 0);

Use regmap_clear_bits() when you want to clear all bits of the mask.

Otherwise, looks fairly good!

Cheers,
-Paul

>=20
>  	clk_disable_unprepare(i2s->clk_i2s);
>  }
> @@ -162,8 +146,6 @@ static int jz4740_i2s_trigger(struct=20
> snd_pcm_substream *substream, int cmd,
>  	struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -
> -	uint32_t ctrl;
>  	uint32_t mask;
>=20
>  	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> @@ -171,38 +153,30 @@ static int jz4740_i2s_trigger(struct=20
> snd_pcm_substream *substream, int cmd,
>  	else
>  		mask =3D JZ_AIC_CTRL_ENABLE_CAPTURE | JZ_AIC_CTRL_ENABLE_RX_DMA;
>=20
> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
> -
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		ctrl |=3D mask;
> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask, mask);
>  		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		ctrl &=3D ~mask;
> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask, 0);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>=20
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
> -
>  	return 0;
>  }
>=20
>  static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int=20
> fmt)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -
> -	uint32_t format =3D 0;
> -	uint32_t conf;
> -
> -	conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> -
> -	conf &=3D ~(JZ_AIC_CONF_BIT_CLK_MASTER | JZ_AIC_CONF_SYNC_CLK_MASTER);
> +	const unsigned int conf_mask =3D JZ_AIC_CONF_BIT_CLK_MASTER |
> +				       JZ_AIC_CONF_SYNC_CLK_MASTER;
> +	unsigned int conf =3D 0, format =3D 0;
>=20
>  	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>  	case SND_SOC_DAIFMT_BP_FP:
> @@ -238,8 +212,8 @@ static int jz4740_i2s_set_fmt(struct snd_soc_dai=20
> *dai, unsigned int fmt)
>  		return -EINVAL;
>  	}
>=20
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_I2S_FMT, format);
> +	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF, conf_mask, conf);
> +	regmap_write(i2s->regmap, JZ_REG_AIC_I2S_FMT, format);
>=20
>  	return 0;
>  }
> @@ -252,9 +226,9 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	uint32_t ctrl, div_reg;
>  	int div;
>=20
> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
> +	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
> +	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
>=20
> -	div_reg =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CLK_DIV);
>  	div =3D clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
>=20
>  	switch (params_format(params)) {
> @@ -291,8 +265,8 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  		}
>  	}
>=20
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
> +	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
> +	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
>=20
>  	return 0;
>  }
> @@ -329,12 +303,10 @@ static int jz4740_i2s_set_sysclk(struct=20
> snd_soc_dai *dai, int clk_id,
>  static int jz4740_i2s_suspend(struct snd_soc_component *component)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> -	uint32_t conf;
>=20
>  	if (snd_soc_component_active(component)) {
> -		conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> -		conf &=3D ~JZ_AIC_CONF_ENABLE;
> -		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
> +				   JZ_AIC_CONF_ENABLE, 0);
>=20
>  		clk_disable_unprepare(i2s->clk_i2s);
>  	}
> @@ -347,7 +319,6 @@ static int jz4740_i2s_suspend(struct=20
> snd_soc_component *component)
>  static int jz4740_i2s_resume(struct snd_soc_component *component)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> -	uint32_t conf;
>  	int ret;
>=20
>  	ret =3D clk_prepare_enable(i2s->clk_aic);
> @@ -361,9 +332,8 @@ static int jz4740_i2s_resume(struct=20
> snd_soc_component *component)
>  			return ret;
>  		}
>=20
> -		conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
> -		conf |=3D JZ_AIC_CONF_ENABLE;
> -		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
> +				   JZ_AIC_CONF_ENABLE, JZ_AIC_CONF_ENABLE);
>  	}
>=20
>  	return 0;
> @@ -396,8 +366,8 @@ static int jz4740_i2s_dai_probe(struct=20
> snd_soc_dai *dai)
>  			JZ_AIC_CONF_INTERNAL_CODEC;
>  	}
>=20
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
> +	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
> +	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
>=20
>  	return 0;
>  }
> @@ -495,11 +465,19 @@ static const struct of_device_id=20
> jz4740_of_matches[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, jz4740_of_matches);
>=20
> +static const struct regmap_config jz4740_i2s_regmap_config =3D {
> +	.reg_bits	=3D 32,
> +	.reg_stride	=3D 4,
> +	.val_bits	=3D 32,
> +	.max_register	=3D JZ_REG_AIC_FIFO,
> +};
> +
>  static int jz4740_i2s_dev_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct jz4740_i2s *i2s;
>  	struct resource *mem;
> +	void __iomem *regs;
>  	int ret;
>=20
>  	i2s =3D devm_kzalloc(dev, sizeof(*i2s), GFP_KERNEL);
> @@ -508,9 +486,9 @@ static int jz4740_i2s_dev_probe(struct=20
> platform_device *pdev)
>=20
>  	i2s->soc_info =3D device_get_match_data(dev);
>=20
> -	i2s->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> -	if (IS_ERR(i2s->base))
> -		return PTR_ERR(i2s->base);
> +	regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
>=20
>  	i2s->playback_dma_data.maxburst =3D 16;
>  	i2s->playback_dma_data.addr =3D mem->start + JZ_REG_AIC_FIFO;
> @@ -526,6 +504,11 @@ static int jz4740_i2s_dev_probe(struct=20
> platform_device *pdev)
>  	if (IS_ERR(i2s->clk_i2s))
>  		return PTR_ERR(i2s->clk_i2s);
>=20
> +	i2s->regmap =3D devm_regmap_init_mmio(&pdev->dev, regs,
> +					    &jz4740_i2s_regmap_config);
> +	if (IS_ERR(i2s->regmap))
> +		return PTR_ERR(i2s->regmap);
> +
>  	platform_set_drvdata(pdev, i2s);
>=20
>  	ret =3D devm_snd_soc_register_component(dev, &jz4740_i2s_component,
> --
> 2.35.1
>=20


