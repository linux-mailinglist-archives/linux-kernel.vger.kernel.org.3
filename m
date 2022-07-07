Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06F3569EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiGGJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiGGJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:53:17 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7D4F185;
        Thu,  7 Jul 2022 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657187594; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M2iuLPi3znYre9jdhTqzIq1pKMAjj+Qt7rBhbS9PMKc=;
        b=TOmpTwpkYfoyrZfXgxN9P80ZdASQ8xAFueCXRyevhw88XDpsFtV4IV7mDsi6K5yFPNze8l
        dqjj9z/hQSnOThUzJif9/1cTlTT2SQMQnbV1KdyJmlCP+P6Y0ONS+RMosmXgVFSLXzw4rr
        s5a4qsRk8qXubcC8Ieb1GeXaMrlFpuw=
Date:   Thu, 07 Jul 2022 10:53:05 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 10/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample
 formats
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <H4ANER.XJSSJIHNXTEA1@crapouillou.net>
In-Reply-To: <20220706211330.120198-11-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-11-aidanmacdonald.0x0@gmail.com>
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



Le mer., juil. 6 2022 at 22:13:29 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The audio controller on JZ47xx SoCs supports 20- and 24-bit
> samples coming from memory. Allow those formats to be used
> with the I2S driver.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 80b355d715ce..ee99c5e781ec 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -222,9 +222,15 @@ static int jz4740_i2s_hw_params(struct=20
> snd_pcm_substream *substream,
>  	case SNDRV_PCM_FORMAT_S8:
>  		sample_size =3D 0;
>  		break;
> -	case SNDRV_PCM_FORMAT_S16:
> +	case SNDRV_PCM_FORMAT_S16_LE:
>  		sample_size =3D 1;
>  		break;
> +	case SNDRV_PCM_FORMAT_S20_LE:
> +		sample_size =3D 3;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		sample_size =3D 4;
> +		break;

Did you test these? It is unclear to me, looking at the JZ4740 PM, if=20
the 18-bit, 20-bit and 24-bit samples are in 4 bytes or 3 bytes.

Cheers,
-Paul

>  	default:
>  		return -EINVAL;
>  	}
> @@ -362,7 +368,9 @@ static const struct snd_soc_dai_ops=20
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


