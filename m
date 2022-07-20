Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD457B609
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiGTL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiGTL6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:58:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C272ED0;
        Wed, 20 Jul 2022 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658318311; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPPCh6LnPww+kbqa2Z9TXCT7MqlxqoEk5GKe4eZg+d0=;
        b=PusYh3vGIr5JCPPDBQ8btI6tloV/wi1FD8zh2hjxM8uwjCti0yfNjmhO5GKnJTh5bTfvKa
        HDX7u8KKHaMyJ/O8lI7mNxbJowK6byOGJ9D2+YACKn525LYwz/0ZbIDUWSbhCs9N0pSIiR
        +lS+gbFz6RpgFLuOjtkBMjrLqvP6Ltc=
Date:   Wed, 20 Jul 2022 12:58:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 10/11] ASoC: jz4740-i2s: Move component functions near
 the component driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <7LIBFR.71QJ7EA1306B1@crapouillou.net>
In-Reply-To: <20220708160244.21933-11-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-11-aidanmacdonald.0x0@gmail.com>
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

Le ven., juil. 8 2022 at 17:02:43 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Move the component suspend/resume functions near the definition
> of the component driver to emphasize that they're unrelated to
> the DAI functions.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

I'm not really fond of moving code like that, so I'll leave Mark with=20
the liberty to take or not this patch.

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 72=20
> +++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 70b9d28a40ce..5db73f12efcf 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -303,42 +303,6 @@ static int jz4740_i2s_set_sysclk(struct=20
> snd_soc_dai *dai, int clk_id,
>  	return ret;
>  }
>=20
> -static int jz4740_i2s_suspend(struct snd_soc_component *component)
> -{
> -	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> -
> -	if (snd_soc_component_active(component)) {
> -		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF,=20
> JZ_AIC_CONF_ENABLE);
> -		clk_disable_unprepare(i2s->clk_i2s);
> -	}
> -
> -	clk_disable_unprepare(i2s->clk_aic);
> -
> -	return 0;
> -}
> -
> -static int jz4740_i2s_resume(struct snd_soc_component *component)
> -{
> -	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> -	int ret;
> -
> -	ret =3D clk_prepare_enable(i2s->clk_aic);
> -	if (ret)
> -		return ret;
> -
> -	if (snd_soc_component_active(component)) {
> -		ret =3D clk_prepare_enable(i2s->clk_i2s);
> -		if (ret) {
> -			clk_disable_unprepare(i2s->clk_aic);
> -			return ret;
> -		}
> -
> -		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
> -	}
> -
> -	return 0;
> -}
> -
>  static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> @@ -459,6 +423,42 @@ static const struct i2s_soc_info=20
> jz4780_i2s_soc_info =3D {
>  	.pll_clk_name		=3D "pll half",
>  };
>=20
> +static int jz4740_i2s_suspend(struct snd_soc_component *component)
> +{
> +	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> +
> +	if (snd_soc_component_active(component)) {
> +		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF,=20
> JZ_AIC_CONF_ENABLE);
> +		clk_disable_unprepare(i2s->clk_i2s);
> +	}
> +
> +	clk_disable_unprepare(i2s->clk_aic);
> +
> +	return 0;
> +}
> +
> +static int jz4740_i2s_resume(struct snd_soc_component *component)
> +{
> +	struct jz4740_i2s *i2s =3D snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(i2s->clk_aic);
> +	if (ret)
> +		return ret;
> +
> +	if (snd_soc_component_active(component)) {
> +		ret =3D clk_prepare_enable(i2s->clk_i2s);
> +		if (ret) {
> +			clk_disable_unprepare(i2s->clk_aic);
> +			return ret;
> +		}
> +
> +		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct snd_soc_component_driver jz4740_i2s_component =3D {
>  	.name			=3D "jz4740-i2s",
>  	.suspend		=3D jz4740_i2s_suspend,
> --
> 2.35.1
>=20


