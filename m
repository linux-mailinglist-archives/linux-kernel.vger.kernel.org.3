Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE1492F23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbiARUSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349112AbiARUSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:18:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9899C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:18:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso377715pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 12:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fTJy6r2petxIyCqlCeqcI3j0J1mr0+L2iTxm9kuz7Xs=;
        b=inhbbrVy+Fl/lXwKK3g5gU174TWO3UbXPm6+kPhfHgNNQVApLzBtbDcGk4Xgom17AB
         i3YZWJdLTgR31k1+RKgfidYdZUqNPiFDDZAGoFHkdyc4Ob67KE7sURHRukbTSubzASSf
         maDQWVxRz4iuaY3PO0xLJR+1EQcEZT+I8Q6AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fTJy6r2petxIyCqlCeqcI3j0J1mr0+L2iTxm9kuz7Xs=;
        b=C405xfIacK2Fesp1/SE4deeKRuMFHpPcpPekzAtduOKoPtyR1CylyB8DYoTKTVIX6e
         QY7X6n7X3EYwC3058dA3iZ8LrxQFwyX6p9ySOIrKm2XpJFKhZS0koof6zIahllQ9B1uT
         ytqP2djFXv44GiLXO2Kbx//A15RpA0at0T6fveTitM+2RIl5I5OoUsSd6lhZg+hqC+Te
         z4TZsSJrOVwMqtQ1g5q6qnfJt1cMqEUAft0u8yxSrvaBfdZ2rDDjdCMz0KK8hgEvuCWr
         Z4A9CIfqFarh1Ae4f8zz4CSE+2JZFVhJIooLtONS/9Y54XDOFechYiWRqT6t9WIFROtf
         Mfig==
X-Gm-Message-State: AOAM532/jQY/subbsZWqfJH81zERFcak/E//AN+M8wNkzuPjQ0EdMl3F
        x5SXv+dECLh1g0LxZ5cKPrLu1w==
X-Google-Smtp-Source: ABdhPJxiIurI5FHOTYvsCLYSQboCxGuQP/VrNeICLl1afrsd2ymXtXw5svEXZBZPdy/+GQJ6NoXhPA==
X-Received: by 2002:a17:90b:4b8a:: with SMTP id lr10mr278353pjb.58.1642537079558;
        Tue, 18 Jan 2022 12:17:59 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e4bb:67e6:f0b5:1b92])
        by smtp.gmail.com with ESMTPSA id ha11sm1170099pjb.3.2022.01.18.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 12:17:58 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:17:55 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
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
Subject: Re: [PATCH v2 3/3] ASoC: rk3399_gru_sound: Wire up DP jack detection
Message-ID: <YecgcwXrQNzCesMN@google.com>
References: <20220114230209.4091727-1-briannorris@chromium.org>
 <20220114150129.v2.3.I3c79b1466c14b02980071221e5b99283cd26ec77@changeid>
 <CAGXv+5HC00YU6ARtGDahxWLqivvUCowh7wDq5H5OzoGO9htB+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXv+5HC00YU6ARtGDahxWLqivvUCowh7wDq5H5OzoGO9htB+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Mon, Jan 17, 2022 at 05:01:52PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jan 15, 2022 at 7:03 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Now that the cdn-dp driver supports plug-change callbacks, let's wire it
> > up.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  sound/soc/rockchip/rk3399_gru_sound.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> > index e2d52d8d0ff9..eeef3ed70037 100644
> > --- a/sound/soc/rockchip/rk3399_gru_sound.c
> > +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> > @@ -164,6 +164,25 @@ static int rockchip_sound_da7219_hw_params(struct snd_pcm_substream *substream,
> >         return 0;
> >  }
> >
> > +static struct snd_soc_jack cdn_dp_card_jack;
> > +
> > +static int rockchip_sound_cdndp_init(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +       struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
> 
> Using snd_soc_card_get_codec_dai() might be a better choice throughout this
> driver. While it will work for the cdn_dp case, because it is the first DAI
> in |rockchip_dais[]|, all the invocations for the other codecs are likely
> returning the wrong DAI.

I'll admit, I'm not very familiar with the ASoC object model, so you may
well be correct that there's something fishy in here. But I did trace
through the objects involved here, and we *are* getting the correct DAI
for both this case and the DA7219 case (preexisting code).

It looks like we actually have a new runtime for each of our static
dai_links:

devm_snd_soc_register_card()
  ...
  for_each_card_prelinks()
    snd_soc_add_pcm_runtime()

So I think this is valid to keep as-is.

> For this particular patch it works either way, so
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks for looking!

Brian
