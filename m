Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE3468D24
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 21:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbhLEUMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 15:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 15:12:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D9C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 12:08:42 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v1so34575638edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 12:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QXxYuNajLT9aeXvv58z0yRW9+GgVj2dLdd+ovoaDnas=;
        b=YC0Fl3IoGL6bJY0MdDNYujg1N1pyxHwbaVrKbeC2uf4/9SItfIIj9ml9NzdxC1ifNL
         kYep4b3nnHfJUwdGuj27RiT/Sk0V6ZpWEsXpGLK+imcbkJtHLRVaTGo09/Seq0Ny9aKU
         fd/cyF16cKvg1ofsYTM/Ze+XmrNs91JRBQPtxvonCav9eWEFybQ6FINZ7e93eQvjjQnN
         pLLx41UuFPKUA9GhmG07SxfYGhTPfaFoURqYkzVsd4k4bb9qXzzZzGKAB54SvXQMWDuJ
         vXrdmvn5tsb5h0gNBh8s+S3NZL8bbj3sF9J/T1hNYar836j8hgtukiEvNMWOSulk6yg0
         A8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QXxYuNajLT9aeXvv58z0yRW9+GgVj2dLdd+ovoaDnas=;
        b=eoM9a3I0eDkBdaZM3b1B4epJF161EAvYjZLIskxT9vxREnPGPXPKAhB+GXQH/6VVsB
         1CS57/ggp2jy+YGXLDy/tioNKx0n9zRjQGJsc1/CoWOcm4dtjH2AqUlYlpqLT3J5sQZr
         RVEAa5EnHVUYpieEwrugGYe/HGeC4lXFvzi+IB+09WtEUlLMgqRiTEM0LJRmh/PbAJVv
         49Eq4MYn5QnpFwW+H6ier/0FeD0by+vPtz3ePOHnkhj2IU6pVtrsV7wu8Upx0UlkvM9J
         ec2K++tE5DeSONg4jYj0VWpifWcI2VaYAw6NDxGtQv1XRjwZ7LySgzZE5pv2EC54Dar2
         THRw==
X-Gm-Message-State: AOAM5322rIAeQv+r5jty2iPYwMCnwPijw8AZd6EmkHQUNwFg9TNKW/8q
        NmHzi8DzY8OXVv3JaCWszQY=
X-Google-Smtp-Source: ABdhPJz3bwHwNBdYx92DNL0Z5Z9bo2d0P3FgX25KmcONs/GoqwZLM0U/wVurfpthMF8cqBvF7Xufsg==
X-Received: by 2002:a17:906:b2d0:: with SMTP id cf16mr40484482ejb.52.1638734920482;
        Sun, 05 Dec 2021 12:08:40 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id sh30sm5759120ejc.117.2021.12.05.12.08.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Dec 2021 12:08:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH RFC v1 2/2] ASoC: meson: aiu: Move AIU_I2S_MISC hold
 setting to aiu-fifo-i2s
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20211205180816.2083864-3-martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 00:08:37 +0400
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Geraldo Nascimento <geraldogabriel@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEA4CE24-9982-4155-B621-FF43C92417A7@gmail.com>
References: <20211205180816.2083864-1-martin.blumenstingl@googlemail.com>
 <20211205180816.2083864-3-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 5 Dec 2021, at 10:08 pm, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> The out-of-tree vendor driver uses the following approach to set the
> AIU_I2S_MISC register:
> 1) write AIU_MEM_I2S_START_PTR and AIU_MEM_I2S_RD_PTR
> 2) configure AIU_I2S_MUTE_SWAP[15:0]
> 3) write AIU_MEM_I2S_END_PTR
> 4) set AIU_I2S_MISC[2] to 1 (documented as: "put I2S interface in hold
>   mode")
> 5) set AIU_I2S_MISC[4] to 1 (depending on the driver revision it =
always
>   stays at 1 while for older drivers this bit is unset in step 4)
> 6) set AIU_I2S_MISC[2] to 0
> 7) write AIU_MEM_I2S_MASKS
> 8) toggle AIU_MEM_I2S_CONTROL[0]
> 9) toggle AIU_MEM_I2S_BUF_CNTL[0]
>=20
> Additional testing shows that when AIU_I2S_MISC[2] is set to 1 then no
> interrupts are generated anymore. The way this bit is managed by the
> vendor driver as well as not getting any interrupts can mean that it's
> related to the FIFO and not the encoder.
>=20
> Move setting the AIU_I2S_MISC[2] bit to aiu_fifo_i2s_hw_params() so it
> closer resembles the flow in the vendor kernel. While here also
> configure AIU_I2S_MISC[4] (documented as: "force each audio data to
> left or right according to the bit attached with the audio data")
> similar to how the vendor driver does this. This fixes the infamous =
and
> long-standing "machine gun noise" issue (a buffer underrun issue).
>=20
> Fixes: 6ae9ca9ce986bf ("ASoC: meson: aiu: add i2s and spdif support")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Reported-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> Signed-off-by: Martin Blumenstingl =
<martin.blumenstingl@googlemail.com>

Thanks Martin.

Checked with WeTek Play 2 (GXBB), LePotato (GXL), and Khadas VIM2 (GXM)
so I=E2=80=99m delighted to say:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

> ---
> sound/soc/meson/aiu-encoder-i2s.c | 33 -------------------------------
> sound/soc/meson/aiu-fifo-i2s.c    | 12 +++++++++++
> 2 files changed, 12 insertions(+), 33 deletions(-)
>=20
> diff --git a/sound/soc/meson/aiu-encoder-i2s.c =
b/sound/soc/meson/aiu-encoder-i2s.c
> index 932224552146..67729de41a73 100644
> --- a/sound/soc/meson/aiu-encoder-i2s.c
> +++ b/sound/soc/meson/aiu-encoder-i2s.c
> @@ -18,7 +18,6 @@
> #define AIU_RST_SOFT_I2S_FAST		BIT(0)
>=20
> #define AIU_I2S_DAC_CFG_MSB_FIRST	BIT(2)
> -#define AIU_I2S_MISC_HOLD_EN		BIT(2)
> #define AIU_CLK_CTRL_I2S_DIV_EN		BIT(0)
> #define AIU_CLK_CTRL_I2S_DIV		GENMASK(3, 2)
> #define AIU_CLK_CTRL_AOCLK_INVERT	BIT(6)
> @@ -36,37 +35,6 @@ static void aiu_encoder_i2s_divider_enable(struct =
snd_soc_component *component,
> 				      enable ? AIU_CLK_CTRL_I2S_DIV_EN : =
0);
> }
>=20
> -static void aiu_encoder_i2s_hold(struct snd_soc_component *component,
> -				 bool enable)
> -{
> -	snd_soc_component_update_bits(component, AIU_I2S_MISC,
> -				      AIU_I2S_MISC_HOLD_EN,
> -				      enable ? AIU_I2S_MISC_HOLD_EN : =
0);
> -}
> -
> -static int aiu_encoder_i2s_trigger(struct snd_pcm_substream =
*substream, int cmd,
> -				   struct snd_soc_dai *dai)
> -{
> -	struct snd_soc_component *component =3D dai->component;
> -
> -	switch (cmd) {
> -	case SNDRV_PCM_TRIGGER_START:
> -	case SNDRV_PCM_TRIGGER_RESUME:
> -	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		aiu_encoder_i2s_hold(component, false);
> -		return 0;
> -
> -	case SNDRV_PCM_TRIGGER_STOP:
> -	case SNDRV_PCM_TRIGGER_SUSPEND:
> -	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		aiu_encoder_i2s_hold(component, true);
> -		return 0;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -
> static int aiu_encoder_i2s_setup_desc(struct snd_soc_component =
*component,
> 				      struct snd_pcm_hw_params *params)
> {
> @@ -353,7 +321,6 @@ static void aiu_encoder_i2s_shutdown(struct =
snd_pcm_substream *substream,
> }
>=20
> const struct snd_soc_dai_ops aiu_encoder_i2s_dai_ops =3D {
> -	.trigger	=3D aiu_encoder_i2s_trigger,
> 	.hw_params	=3D aiu_encoder_i2s_hw_params,
> 	.hw_free	=3D aiu_encoder_i2s_hw_free,
> 	.set_fmt	=3D aiu_encoder_i2s_set_fmt,
> diff --git a/sound/soc/meson/aiu-fifo-i2s.c =
b/sound/soc/meson/aiu-fifo-i2s.c
> index 2388a2d0b3a6..d0a1090d6465 100644
> --- a/sound/soc/meson/aiu-fifo-i2s.c
> +++ b/sound/soc/meson/aiu-fifo-i2s.c
> @@ -20,6 +20,8 @@
> #define AIU_MEM_I2S_CONTROL_MODE_16BIT	BIT(6)
> #define AIU_MEM_I2S_BUF_CNTL_INIT	BIT(0)
> #define AIU_RST_SOFT_I2S_FAST		BIT(0)
> +#define AIU_I2S_MISC_HOLD_EN		BIT(2)
> +#define AIU_I2S_MISC_FORCE_LEFT_RIGHT	BIT(4)
>=20
> #define AIU_FIFO_I2S_BLOCK		256
>=20
> @@ -90,6 +92,10 @@ static int aiu_fifo_i2s_hw_params(struct =
snd_pcm_substream *substream,
> 	unsigned int val;
> 	int ret;
>=20
> +	snd_soc_component_update_bits(component, AIU_I2S_MISC,
> +				      AIU_I2S_MISC_HOLD_EN,
> +				      AIU_I2S_MISC_HOLD_EN);
> +
> 	ret =3D aiu_fifo_hw_params(substream, params, dai);
> 	if (ret)
> 		return ret;
> @@ -117,6 +123,12 @@ static int aiu_fifo_i2s_hw_params(struct =
snd_pcm_substream *substream,
> 	snd_soc_component_update_bits(component, AIU_MEM_I2S_MASKS,
> 				      AIU_MEM_I2S_MASKS_IRQ_BLOCK, val);
>=20
> +	snd_soc_component_update_bits(component, AIU_I2S_MISC,
> +				      AIU_I2S_MISC_FORCE_LEFT_RIGHT,
> +				      AIU_I2S_MISC_FORCE_LEFT_RIGHT);
> +	snd_soc_component_update_bits(component, AIU_I2S_MISC,
> +				      AIU_I2S_MISC_HOLD_EN, 0);
> +
> 	return 0;
> }
>=20
> --=20
> 2.34.1
>=20

