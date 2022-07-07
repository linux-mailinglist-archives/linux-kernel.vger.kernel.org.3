Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B7569ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiGGJr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiGGJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:47:22 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9419645077;
        Thu,  7 Jul 2022 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657187235; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA2f0yBa6U6ftJuYv1lYb8ecq1Rzy1PWTbc6pDrTiGY=;
        b=Q+Qb29ekKl3YvJV7p2iui3OpCBEqgzBvNsy2BaKIolTqg3PRMyMIWRSCBA6iE0S+6oYZHj
        JRZvSKp5uEarGHt/HYdqtlWJwJg9ROhjKU1VgBv6tGnYVdl6vgh2/g1SEBv36Sd04ZXok1
        ZFx/Ih4TbzaYEAZqelshawgmkUKBoA8=
Date:   Thu, 07 Jul 2022 10:47:05 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 09/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <HU9NER.25VYXWS2PRRL2@crapouillou.net>
In-Reply-To: <20220706211330.120198-10-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-10-aidanmacdonald.0x0@gmail.com>
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



Le mer., juil. 6 2022 at 22:13:28 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> On some Ingenic SoCs, such as the X1000, there is a programmable
> divider used to generate the I2S system clock from a PLL, rather
> than a fixed PLL/2 clock. It doesn't make much sense to call the
> clock "pll half" on those SoCs, so the clock name should really be
> a SoC-dependent value.

Do you really need the .set_sysclk() callback? I've never seen it used=20
on any of the Ingenic boards I have, so to me it's pretty much dead=20
code. Unless you do use this callback, I'd suggest to drop this patch=20
until you do need it.

Cheers,
-Paul

> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 3a21ee9d34d1..80b355d715ce 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -71,6 +71,8 @@ struct i2s_soc_info {
>  	struct reg_field field_tx_fifo_thresh;
>  	struct reg_field field_i2sdiv_capture;
>  	struct reg_field field_i2sdiv_playback;
> +
> +	const char *pll_clk_name;
>  };
>=20
>  struct jz4740_i2s {
> @@ -265,7 +267,7 @@ static int jz4740_i2s_set_sysclk(struct=20
> snd_soc_dai *dai, int clk_id,
>  		clk_set_parent(i2s->clk_i2s, parent);
>  		break;
>  	case JZ4740_I2S_CLKSRC_PLL:
> -		parent =3D clk_get(NULL, "pll half");
> +		parent =3D clk_get(NULL, i2s->soc_info->pll_clk_name);
>  		if (IS_ERR(parent))
>  			return PTR_ERR(parent);
>  		clk_set_parent(i2s->clk_i2s, parent);
> @@ -387,6 +389,7 @@ static const struct i2s_soc_info=20
> jz4740_i2s_soc_info =3D {
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		=3D "pll half",
>  };
>=20
>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
> @@ -395,6 +398,7 @@ static const struct i2s_soc_info=20
> jz4760_i2s_soc_info =3D {
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		=3D "pll half",
>  };
>=20
>  static struct snd_soc_dai_driver jz4770_i2s_dai =3D {
> @@ -421,6 +425,7 @@ static const struct i2s_soc_info=20
> jz4770_i2s_soc_info =3D {
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		=3D "pll half",
>  };
>=20
>  static const struct i2s_soc_info jz4780_i2s_soc_info =3D {
> @@ -429,6 +434,7 @@ static const struct i2s_soc_info=20
> jz4780_i2s_soc_info =3D {
>  	.field_tx_fifo_thresh	=3D REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
>  	.field_i2sdiv_capture	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
>  	.field_i2sdiv_playback	=3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
> +	.pll_clk_name		=3D "pll half",
>  };
>=20
>  static const struct snd_soc_component_driver jz4740_i2s_component =3D {
> --
> 2.35.1
>=20


