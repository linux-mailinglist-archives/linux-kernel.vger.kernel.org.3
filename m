Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89484934B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351621AbiASF7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiASF7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:59:42 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C897C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 21:59:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p27so4995523lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 21:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tKYVg7wJMJMNFKIyw+d3Kv62PM5IDYj6Uiog3M1guQ=;
        b=O3rjR1xwJ5RJa/8Pr4j+o/xz2ODymM24FgRvDAyyXVz801NpNIj40tnMPXagEzzIdN
         YgApJ9Se2RtCuzQIBr9UoxOYieOUmAITh7Ff2mH+sSXNnt/MyPTQm0hxbsds1OhLg9Lx
         iGrVXc3V0OyRFdbBmsPvPpedratR1otyTGqBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tKYVg7wJMJMNFKIyw+d3Kv62PM5IDYj6Uiog3M1guQ=;
        b=unRdqjrvLgH1YeFCW+bkNRqGTO3KUqQMU1J2E5bHteaa9RxETRwOUihjaOLVhOTfor
         ol/utYV0utbRRBHi2j+Y3DJWH7+DY7x9BHsG+ikQUaO2viYxqBnRinVI2AufqhWf9epB
         l/HlLREplMAxVdZobaui7T7jbzHJKlWQ9Uv7dWDqVo8PMiO2rCXnUG7N9iq8R73QkI1y
         0oH8kqrFpOORU/1OivcgpJ4maN20hcFBFgds0KyMIZtFoYwvARCScR6QFr06l5uX8SfZ
         OTeahhzvYdZC+GPqFH6+PvAxnWpXzmSzTzmuEEfcqV2/u10tgiIY8AWKHlp19Vnj1Hpj
         2OSg==
X-Gm-Message-State: AOAM533j0bcPgm+YcELV2K6WtTQupeiIrjpjqQE/rA/q7vlTliPRSZOt
        DIRIgoi+IK0mTyNN+TEFCFly7a39jv/f/jWISdPbBQ==
X-Google-Smtp-Source: ABdhPJxmDuwkFJziW4xvLsZmdp9HyrtsLl84OWqtBxpyS7OeNwc36CaaRT+rymCOgrfcQNTO0R57Np83PfJ/v382SjQ=
X-Received: by 2002:a05:6512:1320:: with SMTP id x32mr25449431lfu.597.1642571980606;
 Tue, 18 Jan 2022 21:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20220114230209.4091727-1-briannorris@chromium.org>
 <20220114150129.v2.3.I3c79b1466c14b02980071221e5b99283cd26ec77@changeid>
 <CAGXv+5HC00YU6ARtGDahxWLqivvUCowh7wDq5H5OzoGO9htB+g@mail.gmail.com> <YecgcwXrQNzCesMN@google.com>
In-Reply-To: <YecgcwXrQNzCesMN@google.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 19 Jan 2022 13:59:29 +0800
Message-ID: <CAGXv+5HANAorgJhSupH96V_n01VzvO5mY6LXf=bzzMi3ek089w@mail.gmail.com>
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

On Wed, Jan 19, 2022 at 4:18 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Chen-Yu,
>
> On Mon, Jan 17, 2022 at 05:01:52PM +0800, Chen-Yu Tsai wrote:
> > On Sat, Jan 15, 2022 at 7:03 AM Brian Norris <briannorris@chromium.org> wrote:
> > >
> > > Now that the cdn-dp driver supports plug-change callbacks, let's wire it
> > > up.
> > >
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  sound/soc/rockchip/rk3399_gru_sound.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> > > index e2d52d8d0ff9..eeef3ed70037 100644
> > > --- a/sound/soc/rockchip/rk3399_gru_sound.c
> > > +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> > > @@ -164,6 +164,25 @@ static int rockchip_sound_da7219_hw_params(struct snd_pcm_substream *substream,
> > >         return 0;
> > >  }
> > >
> > > +static struct snd_soc_jack cdn_dp_card_jack;
> > > +
> > > +static int rockchip_sound_cdndp_init(struct snd_soc_pcm_runtime *rtd)
> > > +{
> > > +       struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
> >
> > Using snd_soc_card_get_codec_dai() might be a better choice throughout this
> > driver. While it will work for the cdn_dp case, because it is the first DAI
> > in |rockchip_dais[]|, all the invocations for the other codecs are likely
> > returning the wrong DAI.
>
> I'll admit, I'm not very familiar with the ASoC object model, so you may
> well be correct that there's something fishy in here. But I did trace
> through the objects involved here, and we *are* getting the correct DAI
> for both this case and the DA7219 case (preexisting code).

Neither am I, so ...

> It looks like we actually have a new runtime for each of our static
> dai_links:
>
> devm_snd_soc_register_card()
>   ...
>   for_each_card_prelinks()
>     snd_soc_add_pcm_runtime()
>
> So I think this is valid to keep as-is.

I missed this bit. As you say, things are good.

> > For this particular patch it works either way, so
> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Thanks for looking!

And thanks for double checking!
