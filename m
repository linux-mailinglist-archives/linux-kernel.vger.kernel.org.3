Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FC8569E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiGGJgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:36:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FFB33E3D;
        Thu,  7 Jul 2022 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657186572; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqrfEj7cxAuXaCMhT9TxqrOJJX+8uDkMAnKnSFGyUXM=;
        b=AqSa77YOSz9MeagWtB3RGK5nKLWX4IiwadXr4n5vnUudJv9N9s5Wo2zc0TU5xD2rc7h3ok
        ii0LgKLhr0Tj5XoicFnWr/Q8v+C7JCYnI9O9jCy6wfBmEgLt0CeuXhbZDBFzV7uku6UV1q
        2xlUhLVnALumzxGTW/ssD04YvGvGQEg=
Date:   Thu, 07 Jul 2022 10:36:02 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 04/11] ASoC: jz4740-i2s: Simplify using regmap fields
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <2C9NER.G722ABTZOI2P1@crapouillou.net>
In-Reply-To: <20220706211330.120198-5-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-5-aidanmacdonald.0x0@gmail.com>
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



Le mer., juil. 6 2022 at 22:13:23 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The differences between register fields on different SoC versions
> can be abstracted away using the regmap field API. This is easier
> to understand and extend than comparisons based on the version ID.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 100=20
> ++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 28 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 66a901f56392..cbb89f724f64 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -91,12 +91,22 @@ enum jz47xx_i2s_version {
>  struct i2s_soc_info {
>  	enum jz47xx_i2s_version version;
>  	struct snd_soc_dai_driver *dai;
> +
> +	struct reg_field field_rx_fifo_thresh;
> +	struct reg_field field_tx_fifo_thresh;
> +	struct reg_field field_i2sdiv_capture;
> +	struct reg_field field_i2sdiv_playback;
>  };
>=20
>  struct jz4740_i2s {
>  	struct resource *mem;
>  	struct regmap *regmap;
>=20
> +	struct regmap_field *field_rx_fifo_thresh;
> +	struct regmap_field *field_tx_fifo_thresh;
> +	struct regmap_field *field_i2sdiv_capture;
> +	struct regmap_field *field_i2sdiv_playback;
> +
>  	struct clk *clk_aic;
>  	struct clk *clk_i2s;
>=20
> @@ -222,12 +232,12 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> +	struct regmap_field *div_field;
>  	unsigned int sample_size;
> -	uint32_t ctrl, div_reg;
> +	uint32_t ctrl;
>  	int div;
>=20
>  	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
> -	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
>=20
>  	div =3D clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
>=20
> @@ -250,23 +260,16 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  		else
>  			ctrl &=3D ~JZ_AIC_CTRL_MONO_TO_STEREO;
>=20
> -		div_reg &=3D ~I2SDIV_DV_MASK;
> -		div_reg |=3D (div - 1) << I2SDIV_DV_SHIFT;
> +		div_field =3D i2s->field_i2sdiv_playback;
>  	} else {
>  		ctrl &=3D ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
>  		ctrl |=3D sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
>=20
> -		if (i2s->soc_info->version >=3D JZ_I2S_JZ4770) {
> -			div_reg &=3D ~I2SDIV_IDV_MASK;
> -			div_reg |=3D (div - 1) << I2SDIV_IDV_SHIFT;
> -		} else {
> -			div_reg &=3D ~I2SDIV_DV_MASK;
> -			div_reg |=3D (div - 1) << I2SDIV_DV_SHIFT;
> -		}
> +		div_field =3D i2s->field_i2sdiv_capture;
>  	}
>=20
>  	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
> -	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
> +	regmap_field_write(div_field, div - 1);
>=20
>  	return 0;
>  }
> @@ -342,7 +345,6 @@ static int jz4740_i2s_resume(struct=20
> snd_soc_component *component)
>  static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -	uint32_t conf;
>  	int ret;
>=20
>  	ret =3D clk_prepare_enable(i2s->clk_aic);
> @@ -352,22 +354,14 @@ static int jz4740_i2s_dai_probe(struct=20
> snd_soc_dai *dai)
>  	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
>  		&i2s->capture_dma_data);
>=20
> -	if (i2s->soc_info->version >=3D JZ_I2S_JZ4760) {
> -		conf =3D (7 << JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
> -			(8 << JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
> -			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
> -			JZ_AIC_CONF_I2S |
> -			JZ_AIC_CONF_INTERNAL_CODEC;
> -	} else {
> -		conf =3D (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
> -			(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |

I believe you can remove these macros completely now that they are=20
unused. Same goes for I2S_IDV_MASK, etc.

Cheers,
-Paul

> -			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
> -			JZ_AIC_CONF_I2S |
> -			JZ_AIC_CONF_INTERNAL_CODEC;
> -	}
> -
>  	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
> -	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
> +
> +	regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
> +		     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
> +		     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
> +
> +	regmap_field_write(i2s->field_rx_fifo_thresh, 7);
> +	regmap_field_write(i2s->field_tx_fifo_thresh, 8);
>=20
>  	return 0;
>  }
> @@ -414,11 +408,19 @@ static struct snd_soc_dai_driver jz4740_i2s_dai=20
> =3D {
>  static const struct i2s_soc_info jz4740_i2s_soc_info =3D {
>  	.version =3D JZ_I2S_JZ4740,
>  	.dai =3D &jz4740_i2s_dai,
> +	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 12, 15),
> +	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
> +	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>  };
>=20
>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
>  	.version =3D JZ_I2S_JZ4760,
>  	.dai =3D &jz4740_i2s_dai,
> +	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
> +	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
> +	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>  };
>=20
>  static struct snd_soc_dai_driver jz4770_i2s_dai =3D {
> @@ -442,11 +444,19 @@ static struct snd_soc_dai_driver jz4770_i2s_dai=20
> =3D {
>  static const struct i2s_soc_info jz4770_i2s_soc_info =3D {
>  	.version =3D JZ_I2S_JZ4770,
>  	.dai =3D &jz4770_i2s_dai,
> +	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
> +	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
> +	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
> +	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>  };
>=20
>  static const struct i2s_soc_info jz4780_i2s_soc_info =3D {
>  	.version =3D JZ_I2S_JZ4780,
>  	.dai =3D &jz4770_i2s_dai,
> +	.field_rx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
> +	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
> +	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
> +	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>  };
>=20
>  static const struct snd_soc_component_driver jz4740_i2s_component =3D {
> @@ -465,6 +475,36 @@ static const struct of_device_id=20
> jz4740_of_matches[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, jz4740_of_matches);
>=20
> +static int jz4740_i2s_init_regmap_fields(struct device *dev,
> +					 struct jz4740_i2s *i2s)
> +{
> +	i2s->field_rx_fifo_thresh =3D
> +		devm_regmap_field_alloc(dev, i2s->regmap,
> +					i2s->soc_info->field_rx_fifo_thresh);
> +	if (IS_ERR(i2s->field_rx_fifo_thresh))
> +		return PTR_ERR(i2s->field_rx_fifo_thresh);
> +
> +	i2s->field_tx_fifo_thresh =3D
> +		devm_regmap_field_alloc(dev, i2s->regmap,
> +					i2s->soc_info->field_tx_fifo_thresh);
> +	if (IS_ERR(i2s->field_tx_fifo_thresh))
> +		return PTR_ERR(i2s->field_tx_fifo_thresh);
> +
> +	i2s->field_i2sdiv_capture =3D
> +		devm_regmap_field_alloc(dev, i2s->regmap,
> +					i2s->soc_info->field_i2sdiv_capture);
> +	if (IS_ERR(i2s->field_i2sdiv_capture))
> +		return PTR_ERR(i2s->field_i2sdiv_capture);
> +
> +	i2s->field_i2sdiv_playback =3D
> +		devm_regmap_field_alloc(dev, i2s->regmap,
> +					i2s->soc_info->field_i2sdiv_playback);
> +	if (IS_ERR(i2s->field_i2sdiv_playback))
> +		return PTR_ERR(i2s->field_i2sdiv_playback);
> +
> +	return 0;
> +}
> +
>  static const struct regmap_config jz4740_i2s_regmap_config =3D {
>  	.reg_bits	=3D 32,
>  	.reg_stride	=3D 4,
> @@ -509,6 +549,10 @@ static int jz4740_i2s_dev_probe(struct=20
> platform_device *pdev)
>  	if (IS_ERR(i2s->regmap))
>  		return PTR_ERR(i2s->regmap);
>=20
> +	ret =3D jz4740_i2s_init_regmap_fields(dev, i2s);
> +	if (ret)
> +		return ret;
> +
>  	platform_set_drvdata(pdev, i2s);
>=20
>  	ret =3D devm_snd_soc_register_component(dev, &jz4740_i2s_component,
> --
> 2.35.1
>=20


