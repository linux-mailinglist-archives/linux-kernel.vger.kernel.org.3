Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB19569E93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiGGJbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:31:05 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1AE33E04;
        Thu,  7 Jul 2022 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657186262; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3432oYUbB0NCbGzcaiDe7Zz5ohhG6Uoy9WG/btVsu7A=;
        b=JtBdqbQGB661DJdFRqmt6kAQ1SROsa6wGDALoANOgBdiRAomxlU2IucnqCUihPqEtfIJmC
        JMFLR0QwG9OjtAxsdBjEzmmZfgI1AdPXq3yS6K2bYCDsqeDtHGKebsQvudbQwBuYlL4GHT
        kdoqEDR72JweoTDsQMMhimpdx1obwaU=
Date:   Thu, 07 Jul 2022 10:30:51 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/11] ASoC: jz4740-i2s: Refactor DMA channel setup
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <F39NER.PND5B77O5GFP@crapouillou.net>
In-Reply-To: <20220706211330.120198-3-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-3-aidanmacdonald.0x0@gmail.com>
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



Le mer., juil. 6 2022 at 22:13:21 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> It's simpler to set up the playback and capture DMA settings
> at driver probe time instead of during DAI probing.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 298ff0a83931..ecd8df70d39c 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -95,7 +95,6 @@ struct i2s_soc_info {
>  struct jz4740_i2s {
>  	struct resource *mem;
>  	void __iomem *base;
> -	dma_addr_t phys_base;

Acked-by: Paul Cercueil <paul@crapouillou.net>

Note that you can remove "mem" too, it's not used anywhere.

Cheers,
-Paul

>=20
>  	struct clk *clk_aic;
>  	struct clk *clk_i2s;
> @@ -370,21 +369,6 @@ static int jz4740_i2s_resume(struct=20
> snd_soc_component *component)
>  	return 0;
>  }
>=20
> -static void jz4740_i2s_init_pcm_config(struct jz4740_i2s *i2s)
> -{
> -	struct snd_dmaengine_dai_dma_data *dma_data;
> -
> -	/* Playback */
> -	dma_data =3D &i2s->playback_dma_data;
> -	dma_data->maxburst =3D 16;
> -	dma_data->addr =3D i2s->phys_base + JZ_REG_AIC_FIFO;
> -
> -	/* Capture */
> -	dma_data =3D &i2s->capture_dma_data;
> -	dma_data->maxburst =3D 16;
> -	dma_data->addr =3D i2s->phys_base + JZ_REG_AIC_FIFO;
> -}
> -
>  static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
>  {
>  	struct jz4740_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
> @@ -395,7 +379,6 @@ static int jz4740_i2s_dai_probe(struct=20
> snd_soc_dai *dai)
>  	if (ret)
>  		return ret;
>=20
> -	jz4740_i2s_init_pcm_config(i2s);
>  	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
>  		&i2s->capture_dma_data);
>=20
> @@ -529,7 +512,11 @@ static int jz4740_i2s_dev_probe(struct=20
> platform_device *pdev)
>  	if (IS_ERR(i2s->base))
>  		return PTR_ERR(i2s->base);
>=20
> -	i2s->phys_base =3D mem->start;
> +	i2s->playback_dma_data.maxburst =3D 16;
> +	i2s->playback_dma_data.addr =3D mem->start + JZ_REG_AIC_FIFO;
> +
> +	i2s->capture_dma_data.maxburst =3D 16;
> +	i2s->capture_dma_data.addr =3D mem->start + JZ_REG_AIC_FIFO;
>=20
>  	i2s->clk_aic =3D devm_clk_get(dev, "aic");
>  	if (IS_ERR(i2s->clk_aic))
> --
> 2.35.1
>=20


