Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB157B5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGTL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGTL4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:56:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABC5A2D4;
        Wed, 20 Jul 2022 04:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658318190; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Otu7SpCpuiaT1NLh/DRIgkeeMxIACISVLGxUE2EKWbk=;
        b=ouJniZi1hlAwdQ6wpoWIC/pc0AEoqH+m7LymtYUHg7UFEvQH/nAEtdwWtj9myQp2I7BNOL
        PE8hIAbItCNKIzmwhmr2C8oser6RREY46gSWp1MVyxGbwHRqvwFnQrBjR2EBPwTjAHxSGe
        PSX9FxsEHtT8nU9gpMFOCBrUesPA0FE=
Date:   Wed, 20 Jul 2022 12:56:19 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 08/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE
 sample formats
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <VHIBFR.8XGKG1NT4PHX1@crapouillou.net>
In-Reply-To: <20220708160244.21933-9-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-9-aidanmacdonald.0x0@gmail.com>
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

Le ven., juil. 8 2022 at 17:02:41 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The audio controller on JZ47xx SoCs can transfer 20- and 24-bit
> samples in the FIFO, so allow those formats to be used with the
> I2S driver. Although the FIFO doesn't care about the in-memory
> sample format, we only support 4-byte format variants because the
> DMA controller on these SoCs cannot transfer in 3-byte multiples.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index a41398c24d0e..9be2f3f1b376 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -238,9 +238,15 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	case SNDRV_PCM_FORMAT_S8:
>  		sample_size =3D 0;
>  		break;
> -	case SNDRV_PCM_FORMAT_S16:
> +	case SNDRV_PCM_FORMAT_S16_LE:


I had to lookup the macro to verify, but this is correct.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

>  		sample_size =3D 1;
>  		break;
> +	case SNDRV_PCM_FORMAT_S20_LE:
> +		sample_size =3D 3;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		sample_size =3D 4;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -375,7 +381,9 @@ static const struct snd_soc_dai_ops=20
> jz4740_i2s_dai_ops =3D {
>  };
>=20
>  #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
> -		SNDRV_PCM_FMTBIT_S16_LE)
> +			 SNDRV_PCM_FMTBIT_S16_LE | \
> +			 SNDRV_PCM_FMTBIT_S20_LE | \
> +			 SNDRV_PCM_FMTBIT_S24_LE)
>=20
>  static struct snd_soc_dai_driver jz4740_i2s_dai =3D {
>  	.probe =3D jz4740_i2s_dai_probe,
> --
> 2.35.1
>=20


