Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D40C57B5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiGTLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGTLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:44:42 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA51459B1;
        Wed, 20 Jul 2022 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658317473; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfVrDHEaoRWXZN/HPQzTExDiPVvqkM20tNaJY4XTG7k=;
        b=pmPNW73SsabPhfkXe2GuaO61RJcyuQJkm6+2r6XRpoftHet7iBhMA/kK6MoZm71fxlgAqU
        GtJSNQlvwU5zitRxPk770YVdDWy26wAit7edFN6EJ6fQhXOtoXPD/pxCN9T9+D+VzSatGd
        rMYf2pWJsnKmQbjXbACt4m9i6azetrM=
Date:   Wed, 20 Jul 2022 12:44:18 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 01/11] ASoC: jz4740-i2s: Handle independent FIFO flush
 bits
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <UXHBFR.6W2XPUNX040K1@crapouillou.net>
In-Reply-To: <20220708160244.21933-2-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
        <20220708160244.21933-2-aidanmacdonald.0x0@gmail.com>
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

Le ven., juil. 8 2022 at 17:02:34 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> On the JZ4740, there is a single bit that flushes (empties) both
> the transmit and receive FIFO. Later SoCs have independent flush
> bits for each FIFO, which allows us to flush the right FIFO when
> starting up a stream.
>=20
> This also fixes a bug: since we were only setting the JZ4740's
> flush bit, which corresponds to the TX FIFO flush bit on other
> SoCs, other SoCs were not having their RX FIFO flushed at all.
>=20
> Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index ecd8df70d39c..576f31f9d734 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -64,6 +64,9 @@
>  #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
>  #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
>=20
> +#define JZ4760_AIC_CTRL_TFLUSH BIT(8)
> +#define JZ4760_AIC_CTRL_RFLUSH BIT(7)

Just rename JZ_AIC_CTRL_FLUSH to JZ_AIC_CTRL_TFLUSH and introduce=20
JZ_AIC_CTRL_RLUSH.

> +
>  #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
>  #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
>=20
> @@ -90,6 +93,8 @@ enum jz47xx_i2s_version {
>  struct i2s_soc_info {
>  	enum jz47xx_i2s_version version;
>  	struct snd_soc_dai_driver *dai;
> +
> +	bool shared_fifo_flush;
>  };
>=20
>  struct jz4740_i2s {
> @@ -124,12 +129,33 @@ static int jz4740_i2s_startup(struct=20
> snd_pcm_substream *substream,
>  	uint32_t conf, ctrl;
>  	int ret;
>=20
> +	/*
> +	 * When we can flush FIFOs independently, only flush the
> +	 * FIFO that is starting up.
> +	 */
> +	if (!i2s->soc_info->shared_fifo_flush) {
> +		ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
> +
> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +			ctrl |=3D JZ4760_AIC_CTRL_TFLUSH;
> +		else
> +			ctrl |=3D JZ4760_AIC_CTRL_RFLUSH;
> +
> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
> +	}

Wouldn't it be simpler to do one single if/else? And hy is one checked=20
before the (snd_soc_dai_active(dai)) check, and the other is checked=20
after?

You could do something like this:

ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);

if (i2s->soc_info->shared_fifo_flush ||
    substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
    ctrl |=3D JZ_AIC_CTRL_TFLUSH;
} else {
    ctrl |=3D JZ_AIC_CTRL_RFLUSH;
}

jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);

Cheers,
-Paul

> +
>  	if (snd_soc_dai_active(dai))
>  		return 0;
>=20
> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
> -	ctrl |=3D JZ_AIC_CTRL_FLUSH;
> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
> +	/*
> +	 * When there is a shared flush bit for both FIFOs we can
> +	 * only flush the FIFOs if no other stream has started.
> +	 */
> +	if (i2s->soc_info->shared_fifo_flush) {
> +		ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
> +		ctrl |=3D JZ_AIC_CTRL_FLUSH;
> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
> +	}
>=20
>  	ret =3D clk_prepare_enable(i2s->clk_i2s);
>  	if (ret)
> @@ -444,6 +470,7 @@ static struct snd_soc_dai_driver jz4740_i2s_dai =3D=20
> {
>  static const struct i2s_soc_info jz4740_i2s_soc_info =3D {
>  	.version =3D JZ_I2S_JZ4740,
>  	.dai =3D &jz4740_i2s_dai,
> +	.shared_fifo_flush =3D true,
>  };
>=20
>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
> --
> 2.35.1
>=20


