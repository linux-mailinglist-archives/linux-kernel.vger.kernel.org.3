Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE30569EB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbiGGJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiGGJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:40:41 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFC313D30;
        Thu,  7 Jul 2022 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657186839; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tyen7txTUb5pq9zQQGZmuWYUpttgvf+WfkbcsWB8ZG4=;
        b=MaSHGdQBI+VAXUZX/C8tnXzbfL4brntQ/nxoaJhWbkMP80u3mi4YyKlBfABfFtTD1DgVaq
        RRtbfxPfeOdL3JfrQM+gxQ2nJORDBvRcPovkKaZH5TDuUsRzxDGKwbfsFSXkurOOk4Z/m7
        6PWG8VIiSZuXOYD/L4CSukqEkAo+8BA=
Date:   Thu, 07 Jul 2022 10:40:29 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 06/11] ASoC: jz4740-i2s: Use FIELD_PREP() macros in
 hw_params callback
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <HJ9NER.R0SNUFB7SCZ52@crapouillou.net>
In-Reply-To: <20220706211330.120198-7-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-7-aidanmacdonald.0x0@gmail.com>
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



Le mer., juil. 6 2022 at 22:13:25 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Get rid of a couple of macros and improve readability by using
> FIELD_PREP() and GENMASK() for the sample size setting.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 8bb9449d13d3..3c3cf78bf848 100644
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
> @@ -49,8 +50,8 @@
>  #define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
>  #define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
>=20
> -#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
> -#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
> +#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
> +#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
>  #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
>  #define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
>  #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
> @@ -65,9 +66,6 @@
>  #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
>  #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
>=20
> -#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
> -#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
> -
>  #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
>  #define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
>  #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
> @@ -245,8 +243,9 @@ static int jz4740_i2s_hw_params(struct=20
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
> @@ -254,8 +253,8 @@ static int jz4740_i2s_hw_params(struct=20
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


