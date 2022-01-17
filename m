Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF5490486
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiAQJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiAQJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:02:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC216C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:02:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d3so54854176lfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eWNHkxEDcvDnOVa58vimxj0RFzSnZVX78Y15KWp4XE=;
        b=F04iKpf55HWHZUfNd0MND3kcC57yHpdTxP2HADRAYHB8O1xd4GhvxL5ge//KS4A7TS
         gpejjKDT3cDnZAclFrysE8oNstHYfFzAc9Xxt1Z6B96UtuI7T3RYhU56mMNBQZGcPJ1S
         9NeSRFgzrZiCJ3BaQjQFBzJfWoY4POEB95y48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eWNHkxEDcvDnOVa58vimxj0RFzSnZVX78Y15KWp4XE=;
        b=r3np+3zH/jaz50F//Syja0/bDjKfEZpY+n6e7Ma0Q8X+ialAGF0Q3rYcMdUS88Vl7v
         VHq9UbOZO8z7QrcSfiOGwa+mPI1FxiDDkUVA2zM2EgB/Dsylv0SMrouR/CqF/LtfG7vA
         8ndb4/FUCncmJPtczDB0RYw3KkMtM94mRT6thRh7iOgsuBKRynP1ZTgbZ5H32zFEOEDO
         /QdMsAYKEfhmD1O9obhvp69lSt9DxraiW9mawheQSL6wTgoa2V1Kx8ZRwudlUCns6IhT
         Mg5zEdvW4+nWzAoBsGcPftxniXHjVa5NTdEHaEiMmlGEReo4uF9++SQpBjEa7zXv6vfq
         AWdA==
X-Gm-Message-State: AOAM533VeYYCv1ndpJ/34FrkvjkfBaC418gCeX1/eghLFgQDzsKZkLxa
        LCEDEEktLggxve/kw2PhnAE9zF4/sh9U09wE3tC2xg==
X-Google-Smtp-Source: ABdhPJwK4naYaBZ+8GM/Ab9/Ixhagfb6WfeIhngfxmIkwTvUXsUhPQGr5I/x32U0ZdswDbRkgjWjQoAnUK/H9/TpoSc=
X-Received: by 2002:a2e:b602:: with SMTP id r2mr3683300ljn.392.1642410123234;
 Mon, 17 Jan 2022 01:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20220114230209.4091727-1-briannorris@chromium.org> <20220114150129.v2.3.I3c79b1466c14b02980071221e5b99283cd26ec77@changeid>
In-Reply-To: <20220114150129.v2.3.I3c79b1466c14b02980071221e5b99283cd26ec77@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 17 Jan 2022 17:01:52 +0800
Message-ID: <CAGXv+5HC00YU6ARtGDahxWLqivvUCowh7wDq5H5OzoGO9htB+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: rk3399_gru_sound: Wire up DP jack detection
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 15, 2022 at 7:03 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Now that the cdn-dp driver supports plug-change callbacks, let's wire it
> up.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> (no changes since v1)
>
>  sound/soc/rockchip/rk3399_gru_sound.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index e2d52d8d0ff9..eeef3ed70037 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -164,6 +164,25 @@ static int rockchip_sound_da7219_hw_params(struct snd_pcm_substream *substream,
>         return 0;
>  }
>
> +static struct snd_soc_jack cdn_dp_card_jack;
> +
> +static int rockchip_sound_cdndp_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +       struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;

Using snd_soc_card_get_codec_dai() might be a better choice throughout this
driver. While it will work for the cdn_dp case, because it is the first DAI
in |rockchip_dais[]|, all the invocations for the other codecs are likely
returning the wrong DAI.

For this particular patch it works either way, so

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>


> +       struct snd_soc_card *card = rtd->card;
> +       int ret;
> +
> +       /* Enable jack detection. */
> +       ret = snd_soc_card_jack_new(card, "DP Jack", SND_JACK_LINEOUT,
> +                                   &cdn_dp_card_jack, NULL, 0);
> +       if (ret) {
> +               dev_err(card->dev, "Can't create DP Jack %d\n", ret);
> +               return ret;
> +       }
> +
> +       return snd_soc_component_set_jack(component, &cdn_dp_card_jack, NULL);
> +}
> +
>  static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
>  {
>         struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
> @@ -315,6 +334,7 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
>         [DAILINK_CDNDP] = {
>                 .name = "DP",
>                 .stream_name = "DP PCM",
> +               .init = rockchip_sound_cdndp_init,
>                 .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>                         SND_SOC_DAIFMT_CBS_CFS,
>                 SND_SOC_DAILINK_REG(cdndp),
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
