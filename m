Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05256A520
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiGGOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiGGOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:11:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360102CDFB;
        Thu,  7 Jul 2022 07:11:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l68so10712416wml.3;
        Thu, 07 Jul 2022 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0FuWotIpEAG+1OspfsddrYU25zogAWYfMl06AMUfx5Q=;
        b=CyDdK47JTYUX7TzbebFbhCc9/NXhPr+7Ik/noNLgoluzoop/bdBiEpA+A31e4HMb5U
         DB5rufEvZeuR++dDasva4UUaCBx0H9n4wTkX73JWq4eyQ9Yhvf234y1NFwYKeyBpx5NO
         hicZ9QMWyYT+NM29HzxnT0p5cy3Pz2dWwPQuVDuD77mZinxFvjdsj20g9zRhn1hqoStX
         gj4OwWTLALoRJ2xth2HybCznzCBM/9/ouXtATcmQ0QJIa3hfbwbRv1BmlVHIGqxcxSRH
         wbN/CypQ/G2NsKvB9fVR317+ZHQl+zcnhd6hITQWnMHexmX3uZaCdWsQbwP9wUpYcyLt
         tRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0FuWotIpEAG+1OspfsddrYU25zogAWYfMl06AMUfx5Q=;
        b=Dqf5K038yPHNHY5BsWTkqaFai81WC/ffXKM0GlPdmcngNnVfNa52n1agZLSe5rQMb+
         ksrm0TWZ12EMSLYwBU1fBmCuLku3/wBbQIqV2tHmeu65dyvLilCwKpCB6EjO0aG4744U
         VTVGV11Z3VbGiW0aGMhcRnatVC5NS3Jxq1m7TT+TQpzpM5VVC6m1Ul5GaMJbhzBIHT8I
         y4F5d2ojgESRz7ciLjVmkFkPvYpqv/+4suuz+UUbgrwi4R70+Y8H/HjNvdV7Wl2ml0KA
         nHWEpQupReRay5Prj59g/99Jn/SXN//iGigfPazqIwPM2sG1elPZk9dx0xOT1hHO0K4N
         F2Jg==
X-Gm-Message-State: AJIora+3DvDAdUweHIr1Ux7YJSHlLM+5U5LRF3/XACg2okfSwp+alzEO
        Zze17PN2xsnnmJ83SA+tLhE=
X-Google-Smtp-Source: AGRyM1uksjaOXTPtcxfAxHYdRCa5yx1hL6aRj0edWh9tfQta/eARGClVpvXqebJMhCHvB97tDeUysA==
X-Received: by 2002:a05:600c:6024:b0:3a0:4ea4:cfa4 with SMTP id az36-20020a05600c602400b003a04ea4cfa4mr4786024wmb.119.1657203098524;
        Thu, 07 Jul 2022 07:11:38 -0700 (PDT)
Received: from localhost (92.40.203.183.threembb.co.uk. [92.40.203.183])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a02c21b7easm29849438wms.11.2022.07.07.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:11:38 -0700 (PDT)
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
 <20220706211330.120198-4-aidanmacdonald.0x0@gmail.com>
 <5TCMER.XTCEJKYW8UD9@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] ASoC: jz4740-i2s: Convert to regmap API
In-reply-to: <5TCMER.XTCEJKYW8UD9@crapouillou.net>
Date:   Thu, 07 Jul 2022 15:12:46 +0100
Message-ID: <Gxxqlw6y9IqFtK5yae8JZEBRwuGaYApg@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le mer., juil. 6 2022 at 22:13:22 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> Using regmap for accessing the AIC registers makes the driver a
>> little easier to read, and later refactors can take advantage of
>> regmap APIs to further simplify the driver.
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  sound/soc/jz4740/Kconfig      |  1 +
>>  sound/soc/jz4740/jz4740-i2s.c | 99 +++++++++++++++--------------------
>>  2 files changed, 42 insertions(+), 58 deletions(-)
>> diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
>> index e72f826062e9..dd3b4507fbe6 100644
>> --- a/sound/soc/jz4740/Kconfig
>> +++ b/sound/soc/jz4740/Kconfig
>> @@ -3,6 +3,7 @@ config SND_JZ4740_SOC_I2S
>>  	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
>>  	depends on MIPS || COMPILE_TEST
>>  	depends on HAS_IOMEM
>> +	select REGMAP_MMIO
>>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>>  	help
>>  	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
>> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s=
.c
>> index ecd8df70d39c..66a901f56392 100644
>> --- a/sound/soc/jz4740/jz4740-i2s.c
>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/module.h>
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>>  #include <linux/slab.h>
>>  #include <linux/clk.h>
>> @@ -94,7 +95,7 @@ struct i2s_soc_info {
>>  struct jz4740_i2s {
>>  	struct resource *mem;
>> -	void __iomem *base;
>> +	struct regmap *regmap;
>>  	struct clk *clk_aic;
>>  	struct clk *clk_i2s;
>> @@ -105,39 +106,24 @@ struct jz4740_i2s {
>>  	const struct i2s_soc_info *soc_info;
>>  };
>> -static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
>> -	unsigned int reg)
>> -{
>> -	return readl(i2s->base + reg);
>> -}
>> -
>> -static inline void jz4740_i2s_write(const struct jz4740_i2s *i2s,
>> -	unsigned int reg, uint32_t value)
>> -{
>> -	writel(value, i2s->base + reg);
>> -}
>> -
>>  static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
>>  	struct snd_soc_dai *dai)
>>  {
>>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
>> -	uint32_t conf, ctrl;
>>  	int ret;
>>  	if (snd_soc_dai_active(dai))
>>  		return 0;
>> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>> -	ctrl |=3D JZ_AIC_CTRL_FLUSH;
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>> +	regmap_write_bits(i2s->regmap, JZ_REG_AIC_CTRL,
>> +			  JZ_AIC_CTRL_FLUSH, JZ_AIC_CTRL_FLUSH);
>
> I don't think you need regmap_write_bits() here, since there is no cache =
to
> bypass. You could use regmap_update_bits(), or even better, regmap_set_bi=
ts().
>

write_bits isn't _exactly_ just a cache bypass operation -- it means
"write the register even if the value is the same as what was read."
An update_bits doesn't necessarily perform a register write, even if
there is no cache and the register is volatile.

The distinction shouldn't matter here, since the flush bit is supposed
to be self-clearing. So I might as well use regmap_set_bits().

Also: I just noticed this will need to be a regmap field. It seems that
all SoCs newer than jz4740 have separate transmit/receive flush bits.
At least the JZ4760, JZ4780, and X1000 manuals say as much. Not sure
about the JZ4770 since I don't have any documentation for that SoC.

>>  	ret =3D clk_prepare_enable(i2s->clk_i2s);
>>  	if (ret)
>>  		return ret;
>> -	conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
>> -	conf |=3D JZ_AIC_CONF_ENABLE;
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>> +	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
>> +			   JZ_AIC_CONF_ENABLE, JZ_AIC_CONF_ENABLE);
>
> Use regmap_set_bits() when you want to set all the bits of the mask.
>
>>  	return 0;
>>  }
>> @@ -146,14 +132,12 @@ static void jz4740_i2s_shutdown(struct
>> snd_pcm_substream *substream,
>>  	struct snd_soc_dai *dai)
>>  {
>>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
>> -	uint32_t conf;
>>  	if (snd_soc_dai_active(dai))
>>  		return;
>> -	conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
>> -	conf &=3D ~JZ_AIC_CONF_ENABLE;
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>> +	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
>> +			   JZ_AIC_CONF_ENABLE, 0);
>
> Use regmap_clear_bits() when you want to clear all bits of the mask.
>
> Otherwise, looks fairly good!
>
> Cheers,
> -Paul
>

Thanks, I didn't know about set/clear bits but that'll make it even
simpler.

>>  	clk_disable_unprepare(i2s->clk_i2s);
>>  }
>> @@ -162,8 +146,6 @@ static int jz4740_i2s_trigger(struct snd_pcm_substre=
am
>> *substream, int cmd,
>>  	struct snd_soc_dai *dai)
>>  {
>>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
>> -
>> -	uint32_t ctrl;
>>  	uint32_t mask;
>>  	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>> @@ -171,38 +153,30 @@ static int jz4740_i2s_trigger(struct snd_pcm_subst=
ream
>> *substream, int cmd,
>>  	else
>>  		mask =3D JZ_AIC_CTRL_ENABLE_CAPTURE | JZ_AIC_CTRL_ENABLE_RX_DMA;
>> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>> -
>>  	switch (cmd) {
>>  	case SNDRV_PCM_TRIGGER_START:
>>  	case SNDRV_PCM_TRIGGER_RESUME:
>>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> -		ctrl |=3D mask;
>> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask, mask);
>>  		break;
>>  	case SNDRV_PCM_TRIGGER_STOP:
>>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> -		ctrl &=3D ~mask;
>> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask, 0);
>>  		break;
>>  	default:
>>  		return -EINVAL;
>>  	}
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>> -
>>  	return 0;
>>  }
>>  static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>  {
>>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
>> -
>> -	uint32_t format =3D 0;
>> -	uint32_t conf;
>> -
>> -	conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
>> -
>> -	conf &=3D ~(JZ_AIC_CONF_BIT_CLK_MASTER | JZ_AIC_CONF_SYNC_CLK_MASTER);
>> +	const unsigned int conf_mask =3D JZ_AIC_CONF_BIT_CLK_MASTER |
>> +				       JZ_AIC_CONF_SYNC_CLK_MASTER;
>> +	unsigned int conf =3D 0, format =3D 0;
>>  	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>>  	case SND_SOC_DAIFMT_BP_FP:
>> @@ -238,8 +212,8 @@ static int jz4740_i2s_set_fmt(struct snd_soc_dai *da=
i,
>> unsigned int fmt)
>>  		return -EINVAL;
>>  	}
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_I2S_FMT, format);
>> +	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF, conf_mask, conf);
>> +	regmap_write(i2s->regmap, JZ_REG_AIC_I2S_FMT, format);
>>  	return 0;
>>  }
>> @@ -252,9 +226,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_subst=
ream
>> *substream,
>>  	uint32_t ctrl, div_reg;
>>  	int div;
>> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>> +	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
>> +	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
>> -	div_reg =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CLK_DIV);
>>  	div =3D clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
>>  	switch (params_format(params)) {
>> @@ -291,8 +265,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_subst=
ream
>> *substream,
>>  		}
>>  	}
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
>> +	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
>> +	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
>>  	return 0;
>>  }
>> @@ -329,12 +303,10 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai
>> *dai, int clk_id,
>>  static int jz4740_i2s_suspend(struct snd_soc_component *component)
>>  {
>>  	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
>> -	uint32_t conf;
>>  	if (snd_soc_component_active(component)) {
>> -		conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
>> -		conf &=3D ~JZ_AIC_CONF_ENABLE;
>> -		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
>> +				   JZ_AIC_CONF_ENABLE, 0);
>>  		clk_disable_unprepare(i2s->clk_i2s);
>>  	}
>> @@ -347,7 +319,6 @@ static int jz4740_i2s_suspend(struct snd_soc_compone=
nt
>> *component)
>>  static int jz4740_i2s_resume(struct snd_soc_component *component)
>>  {
>>  	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
>> -	uint32_t conf;
>>  	int ret;
>>  	ret =3D clk_prepare_enable(i2s->clk_aic);
>> @@ -361,9 +332,8 @@ static int jz4740_i2s_resume(struct snd_soc_component
>> *component)
>>  			return ret;
>>  		}
>> -		conf =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
>> -		conf |=3D JZ_AIC_CONF_ENABLE;
>> -		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>> +		regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF,
>> +				   JZ_AIC_CONF_ENABLE, JZ_AIC_CONF_ENABLE);
>>  	}
>>  	return 0;
>> @@ -396,8 +366,8 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *=
dai)
>>  			JZ_AIC_CONF_INTERNAL_CODEC;
>>  	}
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>> +	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
>> +	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
>>  	return 0;
>>  }
>> @@ -495,11 +465,19 @@ static const struct of_device_id jz4740_of_matches=
[] =3D
>> {
>>  };
>>  MODULE_DEVICE_TABLE(of, jz4740_of_matches);
>> +static const struct regmap_config jz4740_i2s_regmap_config =3D {
>> +	.reg_bits	=3D 32,
>> +	.reg_stride	=3D 4,
>> +	.val_bits	=3D 32,
>> +	.max_register	=3D JZ_REG_AIC_FIFO,
>> +};
>> +
>>  static int jz4740_i2s_dev_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev =3D &pdev->dev;
>>  	struct jz4740_i2s *i2s;
>>  	struct resource *mem;
>> +	void __iomem *regs;
>>  	int ret;
>>  	i2s =3D devm_kzalloc(dev, sizeof(*i2s), GFP_KERNEL);
>> @@ -508,9 +486,9 @@ static int jz4740_i2s_dev_probe(struct platform_devi=
ce
>> *pdev)
>>  	i2s->soc_info =3D device_get_match_data(dev);
>> -	i2s->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
>> -	if (IS_ERR(i2s->base))
>> -		return PTR_ERR(i2s->base);
>> +	regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>>  	i2s->playback_dma_data.maxburst =3D 16;
>>  	i2s->playback_dma_data.addr =3D mem->start + JZ_REG_AIC_FIFO;
>> @@ -526,6 +504,11 @@ static int jz4740_i2s_dev_probe(struct platform_dev=
ice
>> *pdev)
>>  	if (IS_ERR(i2s->clk_i2s))
>>  		return PTR_ERR(i2s->clk_i2s);
>> +	i2s->regmap =3D devm_regmap_init_mmio(&pdev->dev, regs,
>> +					    &jz4740_i2s_regmap_config);
>> +	if (IS_ERR(i2s->regmap))
>> +		return PTR_ERR(i2s->regmap);
>> +
>>  	platform_set_drvdata(pdev, i2s);
>>  	ret =3D devm_snd_soc_register_component(dev, &jz4740_i2s_component,
>> --
>> 2.35.1
>>=20

