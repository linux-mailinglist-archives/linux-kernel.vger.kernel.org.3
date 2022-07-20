Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070457B616
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiGTMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiGTMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:04:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793456B241;
        Wed, 20 Jul 2022 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658318652; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnfcxwjD5VEqdAApN8ZMGAAkgvJHjWCm9p0n29wZyrM=;
        b=BfHJXcPl0gTqQpDrY09cVTdgChK8nlMPusOWuVwRkxOdgl3gPDJiEk39+/L/vctWhsB/9g
        aCx/QmdduNUuDfR6YmIXqok2/foWS6RpP88WwvPja6pTjk/qeP4blL2pCLloi6H9ucXxpt
        9oBSxvVdZRNcM+pCfFT2pnJbNPrS3/o=
Date:   Wed, 20 Jul 2022 13:04:00 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 11/11] ASoC: jz4740-i2s: Refactor DAI probe/remove ops
 as component ops
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <OUIBFR.VWH85QRTE1NF3@crapouillou.net>
In-Reply-To: <20220708160244.21933-12-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-12-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le ven., juil. 8 2022 at 17:02:44 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Move most of the DAI probe/remove logic into component ops.
> This makes things more consistent because the AIC clock is
> now managed solely from the component side. And it makes it
> easier to add codec switching support later on.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 54=20
> +++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 5db73f12efcf..d99a19bc5166 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -306,32 +306,10 @@ static int jz4740_i2s_set_sysclk(struct=20
> snd_soc_dai *dai, int clk_id,
>  static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -	int ret;
> -
> -	ret =3D clk_prepare_enable(i2s->clk_aic);
> -	if (ret)
> -		return ret;
>=20
>  	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
>  		&i2s->capture_dma_data);
>=20
> -	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
> -
> -	regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
> -		     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
> -		     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
> -
> -	regmap_field_write(i2s->field_rx_fifo_thresh, 7);
> -	regmap_field_write(i2s->field_tx_fifo_thresh, 8);
> -
> -	return 0;
> -}
> -
> -static int jz4740_i2s_dai_remove(struct snd_soc_dai *dai)
> -{
> -	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> -
> -	clk_disable_unprepare(i2s->clk_aic);
>  	return 0;
>  }
>=20
> @@ -351,7 +329,6 @@ static const struct snd_soc_dai_ops=20
> jz4740_i2s_dai_ops =3D {
>=20
>  static struct snd_soc_dai_driver jz4740_i2s_dai =3D {
>  	.probe =3D jz4740_i2s_dai_probe,
> -	.remove =3D jz4740_i2s_dai_remove,
>  	.playback =3D {
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
> @@ -389,7 +366,6 @@ static const struct i2s_soc_info=20
> jz4760_i2s_soc_info =3D {
>=20
>  static struct snd_soc_dai_driver jz4770_i2s_dai =3D {
>  	.probe =3D jz4740_i2s_dai_probe,
> -	.remove =3D jz4740_i2s_dai_remove,
>  	.playback =3D {
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
> @@ -459,8 +435,38 @@ static int jz4740_i2s_resume(struct=20
> snd_soc_component *component)
>  	return 0;
>  }
>=20
> +static int jz4740_i2s_probe(struct snd_soc_component *component)
> +{
> +	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(i2s->clk_aic);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
> +
> +	regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
> +		     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
> +		     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
> +
> +	regmap_field_write(i2s->field_rx_fifo_thresh, 7);
> +	regmap_field_write(i2s->field_tx_fifo_thresh, 8);
> +
> +	return 0;
> +}
> +
> +static void jz4740_i2s_remove(struct snd_soc_component *component)
> +{
> +	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> +
> +	clk_disable_unprepare(i2s->clk_aic);
> +}
> +
>  static const struct snd_soc_component_driver jz4740_i2s_component =3D {
>  	.name			=3D "jz4740-i2s",
> +	.probe			=3D jz4740_i2s_probe,
> +	.remove			=3D jz4740_i2s_remove,
>  	.suspend		=3D jz4740_i2s_suspend,
>  	.resume			=3D jz4740_i2s_resume,
>  	.legacy_dai_naming	=3D 1,
> --
> 2.35.1
>=20


