Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32757B5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiGTLwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:52:46 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5257E20;
        Wed, 20 Jul 2022 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658317963; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RquTbtLtwFfQ9inCLk4Ulpomsb9JpjXW2cXEGm/uxE4=;
        b=wsNEIB169o1MRcAZxhjwv8ptH4fid4sU4el1kqmI0/g3slTw2idUGaNG7VYj6nhO+hqvvy
        Nd6FWw3fGS4z+2+MiZBhQ+A6I/etNY2Kkc614HPoIi/zxiurGsQmnVJrYvXpkrr/9oyUWy
        uPU7gx+RvNRaThAkPx9Pj3h4asQa+jE=
Date:   Wed, 20 Jul 2022 12:52:34 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 05/11] ASoC: jz4740-i2s: Use FIELD_PREP() macros in
 hw_params callback
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <MBIBFR.N54ZBFKURY0T2@crapouillou.net>
In-Reply-To: <20220708160244.21933-6-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-6-aidanmacdonald.0x0@gmail.com>
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

Le ven., juil. 8 2022 at 17:02:38 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Get rid of a couple of macros and improve readability by using
> FIELD_PREP() and GENMASK() for the sample size setting.
>=20
> Acked-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 043f100a9cfa..d0791dfa9c7b 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -3,6 +3,7 @@
>   *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
>   */
>=20
> +#include <linux/bitfield.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -42,8 +43,8 @@
>  #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
>  #define JZ_AIC_CONF_ENABLE BIT(0)
>=20
> -#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
> -#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
> +#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
> +#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
>  #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
>  #define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
>  #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
> @@ -61,9 +62,6 @@
>  #define JZ4760_AIC_CTRL_TFLUSH BIT(8)
>  #define JZ4760_AIC_CTRL_RFLUSH BIT(7)
>=20
> -#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
> -#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
> -
>  #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
>  #define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
>  #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
> @@ -248,8 +246,9 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	}
>=20
>  	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> -		ctrl &=3D ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK;
> -		ctrl |=3D sample_size << JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET;
> +		ctrl &=3D ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE;
> +		ctrl |=3D FIELD_PREP(JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE, sample_size);
> +
>  		if (params_channels(params) =3D=3D 1)
>  			ctrl |=3D JZ_AIC_CTRL_MONO_TO_STEREO;
>  		else
> @@ -257,8 +256,8 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>=20
>  		div_field =3D i2s->field_i2sdiv_playback;
>  	} else {
> -		ctrl &=3D ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
> -		ctrl |=3D sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
> +		ctrl &=3D ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE;
> +		ctrl |=3D FIELD_PREP(JZ_AIC_CTRL_INPUT_SAMPLE_SIZE, sample_size);
>=20
>  		div_field =3D i2s->field_i2sdiv_capture;
>  	}
> --
> 2.35.1
>=20


