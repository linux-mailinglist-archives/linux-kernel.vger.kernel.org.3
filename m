Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD94A57B8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiGTOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiGTOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:42:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D54D805;
        Wed, 20 Jul 2022 07:41:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z13so6867956wro.13;
        Wed, 20 Jul 2022 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pmQh8wJ3rGOyskLRKw3GBidQJ3GYaUH4Sf2DdWGq4sA=;
        b=IwQ7xMGJH9hbQNGwL26KWu6TnEsH/DFR2NYp+KoJqhsfbXwh25rvNG2C3eBFsY90Gj
         x67YC2EVFMpdPktx7wptxhRMj3AbKXR6t64vD/f8PRQ7VZFp2btgHKu23QDXGgPX8i7K
         YOuqbpkpM34IT2FR5xL04/LtbBlfnlGBynGP0PZP19h6s11gAGaj98V9uzvfTfI7Ghxd
         W0yy6WPhS93h+NVdxkE51ezx+S/WjvLDGFHX5x/DSNCtpyibgBhMwDN3PX1kRbqBq7tf
         fpGX+WkqY1ngjLiDWcEFM9t2/VpBCQmK0sZKg1INu76InRBenbC4zt4w7OezAcqXRf0t
         jgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pmQh8wJ3rGOyskLRKw3GBidQJ3GYaUH4Sf2DdWGq4sA=;
        b=oA5h0h3QSaYVL+h6P1Y78AkujIzMyoyFyGEiyZZ64XHLfQ5Sq+XXlA/5iM6M+5Y9Bd
         2BaOV0Ng7KGKnOvAiEHFN8MhYxWOuQs4t//XhbVOFn+8u05Qd342U5X7x+XNO6XjZKfy
         eeHFngov2G5g+ioAuDduYQdP9Dzg+9kBqfE1XW452uIJR8IwgAQ84JoF2zD6ggBWres0
         xwJfwyHO21dyMja6T8oXBnR3nbIzRR796L/KHu5CQCfspSavzsqQK8ZFKewGyAM6PkeK
         uBddZDCM7rFjs4uKsCgSeufpPb4DmBG40wAZP19bUQ9nWjh9ypeof7yKCfAQadTA7W9r
         DvyQ==
X-Gm-Message-State: AJIora+VtOF/na46BTeSjQtC3mf3SHGtjhz3m3bMXZY+WnYINEadtfY2
        0xPD3tY2l8imAtFSCINFJ04=
X-Google-Smtp-Source: AGRyM1u8peSbDCPQD4pilAW2W4aTHPMOVo5SYnm6jIVyGgpq+8SaeL+2JrcT50gIumK0HO8Dg7b0Cw==
X-Received: by 2002:a05:6000:702:b0:21d:7f65:f1b5 with SMTP id bs2-20020a056000070200b0021d7f65f1b5mr30722788wrb.555.1658328117483;
        Wed, 20 Jul 2022 07:41:57 -0700 (PDT)
Received: from localhost (92.40.203.135.threembb.co.uk. [92.40.203.135])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b003a32167b8d4sm2714699wmm.13.2022.07.20.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:41:56 -0700 (PDT)
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-2-aidanmacdonald.0x0@gmail.com>
 <UXHBFR.6W2XPUNX040K1@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] ASoC: jz4740-i2s: Handle independent FIFO
 flush bits
In-reply-to: <UXHBFR.6W2XPUNX040K1@crapouillou.net>
Date:   Wed, 20 Jul 2022 15:43:06 +0100
Message-ID: <KM3aQuHkqtNZOgfaFAVA54klqcIZBA4X@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le ven., juil. 8 2022 at 17:02:34 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> On the JZ4740, there is a single bit that flushes (empties) both
>> the transmit and receive FIFO. Later SoCs have independent flush
>> bits for each FIFO, which allows us to flush the right FIFO when
>> starting up a stream.
>> This also fixes a bug: since we were only setting the JZ4740's
>> flush bit, which corresponds to the TX FIFO flush bit on other
>> SoCs, other SoCs were not having their RX FIFO flushed at all.
>> Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  sound/soc/jz4740/jz4740-i2s.c | 33 ++++++++++++++++++++++++++++++---
>>  1 file changed, 30 insertions(+), 3 deletions(-)
>> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s=
.c
>> index ecd8df70d39c..576f31f9d734 100644
>> --- a/sound/soc/jz4740/jz4740-i2s.c
>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>> @@ -64,6 +64,9 @@
>>  #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
>>  #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
>> +#define JZ4760_AIC_CTRL_TFLUSH BIT(8)
>> +#define JZ4760_AIC_CTRL_RFLUSH BIT(7)
>
> Just rename JZ_AIC_CTRL_FLUSH to JZ_AIC_CTRL_TFLUSH and introduce
> JZ_AIC_CTRL_RLUSH.
>

According to the JZ4740 programming manual JZ_AIC_CTRL_FLUSH flushes
both FIFOs, so it's not equivalent JZ4760_AIC_CTRL_TFLUSH. I don't
think it's a good idea to confuse the two, or we'd need comments to
explain why JZ4740 uses TFLUSH but not RFLUSH.

>> +
>>  #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
>>  #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
>> @@ -90,6 +93,8 @@ enum jz47xx_i2s_version {
>>  struct i2s_soc_info {
>>  	enum jz47xx_i2s_version version;
>>  	struct snd_soc_dai_driver *dai;
>> +
>> +	bool shared_fifo_flush;
>>  };
>>  struct jz4740_i2s {
>> @@ -124,12 +129,33 @@ static int jz4740_i2s_startup(struct snd_pcm_subst=
ream
>> *substream,
>>  	uint32_t conf, ctrl;
>>  	int ret;
>> +	/*
>> +	 * When we can flush FIFOs independently, only flush the
>> +	 * FIFO that is starting up.
>> +	 */
>> +	if (!i2s->soc_info->shared_fifo_flush) {
>> +		ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>> +
>> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>> +			ctrl |=3D JZ4760_AIC_CTRL_TFLUSH;
>> +		else
>> +			ctrl |=3D JZ4760_AIC_CTRL_RFLUSH;
>> +
>> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>> +	}
>
> Wouldn't it be simpler to do one single if/else? And hy is one checked be=
fore
> the (snd_soc_dai_active(dai)) check, and the other is checked after?

snd_soc_dai_active() is essentially checking if there's an active
substream. Eg. if no streams are open and you start playback, then
the DAI will be inactive. If you then start capture while playback is
running, the DAI is already active.

With a shared flush bit we can only flush if there are no other active
substreams (because we don't want to disturb the active stream by
flushing the FIFO) so it goes after the snd_soc_dai_active() check.

When the FIFOs can be separately flushed, flushing can be done before
the check because it won't disturb any active substream.

> You could do something like this:
>
> ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>
> if (i2s->soc_info->shared_fifo_flush ||
>    substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
>    ctrl |=3D JZ_AIC_CTRL_TFLUSH;
> } else {
>    ctrl |=3D JZ_AIC_CTRL_RFLUSH;
> }
>
> jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>
> Cheers,
> -Paul
>

>> +
>>  	if (snd_soc_dai_active(dai))
>>  		return 0;
>> -	ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>> -	ctrl |=3D JZ_AIC_CTRL_FLUSH;
>> -	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>> +	/*
>> +	 * When there is a shared flush bit for both FIFOs we can
>> +	 * only flush the FIFOs if no other stream has started.
>> +	 */
>> +	if (i2s->soc_info->shared_fifo_flush) {
>> +		ctrl =3D jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
>> +		ctrl |=3D JZ_AIC_CTRL_FLUSH;
>> +		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
>> +	}
>>  	ret =3D clk_prepare_enable(i2s->clk_i2s);
>>  	if (ret)
>> @@ -444,6 +470,7 @@ static struct snd_soc_dai_driver jz4740_i2s_dai =3D {
>>  static const struct i2s_soc_info jz4740_i2s_soc_info =3D {
>>  	.version =3D JZ_I2S_JZ4740,
>>  	.dai =3D &jz4740_i2s_dai,
>> +	.shared_fifo_flush =3D true,
>>  };
>>  static const struct i2s_soc_info jz4760_i2s_soc_info =3D {
>> --
>> 2.35.1
>>=20

