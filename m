Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1575A4EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiH2N4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2N4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:56:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96499786F9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:56:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id se27so8133832ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UUksF+3n6Z6Vv7as77dwd1d0dIdOzku40fVIFRcpS7c=;
        b=JLJrEW14rZu3r0yKDTDdvyLTSmBNqOHlW7ZywpZIP1o0qAEyH5F9NQr7NFwTlgc22t
         VmWmnFwSyaLF3H53dnP824wq4kmM0miMR1kIVGcPeoCWh0e+X2leRLa+w3rqY7vbd+Sq
         49t0I7NOUMoHJusEbcoVvIa7Z34nTIutqNEPB3GGFmdT/RKmBKXJPHjpbuAd14fseYLf
         yH00hqz0aoIJkKVG6fmEDWvrg158TwSG3dFofmIN7b1jS44kdASevUngYMhtx+qrudU1
         l4YpLgE5HLrVjLcBy9JXvz9ZimkdehoWkkW5QGR+OS86gcqn16vIkFW+a8gJLhorMbet
         qU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UUksF+3n6Z6Vv7as77dwd1d0dIdOzku40fVIFRcpS7c=;
        b=0FW2UytsRJ4f11oHOYOj95JYr0JLkCIqHD2V73ke0AodRNlvYfI8tIyO6b24l6muhs
         n0Y6ffptFH/yQ4QI6eY08c1LZFpi4UZZSP+f2a7WiYnZIGtZnQYsFRglaH17wGwzr8Lw
         uWXkL9ss7k3sg4jHTBr4wYjvEqydDSpYyo9DKspDm84Ncf8HlFhDJiq94uCZ8ZfdqgVt
         /MsdifwYbdFJ5OvYC2/6c2N6nlg0FxI4pUTmHgL8pyRS/+4XCX7DxHn+T3awlCjFgI7a
         zRbQYTMCvpqa7QbwKffB7tfA3S6KJbbgWkRVFjun4G/uLK+QyEkyp/PgGp2678UPeIMb
         2JKg==
X-Gm-Message-State: ACgBeo1BP5zCsnuUl6hnsJNFJcza2z3994VwbwflbDuuhzXK9dxrPPhf
        e1syVao2VIsgxv+z2CXraNIdl67Fr6XesKkVm1fE9CNH028=
X-Google-Smtp-Source: AA6agR4R1TOlwHtkdeW/5iqUgtHZjFsmMRQANoBtf5XmwzZYZOxbOMJMZJtWqslHrHmGX2eE1rwBmGuWncmdK1uZE3M=
X-Received: by 2002:a17:907:7d91:b0:731:7ecb:1e5b with SMTP id
 oz17-20020a1709077d9100b007317ecb1e5bmr13718953ejc.78.1661781402126; Mon, 29
 Aug 2022 06:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220726033058.403715-1-xji@analogixsemi.com> <9385f8642e6ad5491a036360c644dc21b9a3f009.camel@mediatek.com>
 <CAJMQK-injwWcNVC-niYTgbFQ3R6yOMGkSX+vAuwWAEiMhhft3Q@mail.gmail.com>
In-Reply-To: <CAJMQK-injwWcNVC-niYTgbFQ3R6yOMGkSX+vAuwWAEiMhhft3Q@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 29 Aug 2022 15:56:31 +0200
Message-ID: <CAG3jFysrLDQjc8d=LX4hon029to2xJOqwEyXzNOE9J3z+TJk8w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Support HDMI_I2S audio format
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>, Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 at 10:58, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Tue, Jul 26, 2022 at 5:16 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> >
> > On Tue, 2022-07-26 at 11:30 +0800, Xin Ji wrote:
> > > 1. Support HDMI_I2S audio format.
> > > 2. Return 0 if there is no sink connection in .hw_param callback.
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 23 +++++++++++++++++--
> > > ----
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > >
> > Acked-by: Jiaxin Yu<jiaxin.yu@mediatek.com>
> Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index 79fc7a50b497..c74b5df4cade 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -1797,8 +1797,13 @@ static int anx7625_audio_hw_params(struct
> > > device *dev, void *data,
> > >       int wl, ch, rate;
> > >       int ret = 0;
> > >
> > > -     if (fmt->fmt != HDMI_DSP_A) {
> > > -             DRM_DEV_ERROR(dev, "only supports DSP_A\n");
> > > +     if (anx7625_sink_detect(ctx) == connector_status_disconnected)
> > > {
> > > +             DRM_DEV_DEBUG_DRIVER(dev, "DP not connected\n");
> > > +             return 0;
> > > +     }
> > > +
> > > +     if (fmt->fmt != HDMI_DSP_A && fmt->fmt != HDMI_I2S) {
> > > +             DRM_DEV_ERROR(dev, "only supports DSP_A & I2S\n");
> > >               return -EINVAL;
> > >       }
> > >
> > > @@ -1806,10 +1811,16 @@ static int anx7625_audio_hw_params(struct
> > > device *dev, void *data,
> > >                            params->sample_rate, params->sample_width,
> > >                            params->cea.channels);
> > >
> > > -     ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > > -                                 AUDIO_CHANNEL_STATUS_6,
> > > -                                 ~I2S_SLAVE_MODE,
> > > -                                 TDM_SLAVE_MODE);
> > > +     if (fmt->fmt == HDMI_DSP_A)
> > > +             ret = anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > > +                                        AUDIO_CHANNEL_STATUS_6,
> > > +                                        ~I2S_SLAVE_MODE,
> > > +                                        TDM_SLAVE_MODE);
> > > +     else
> > > +             ret = anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > > +                                        AUDIO_CHANNEL_STATUS_6,
> > > +                                        ~TDM_SLAVE_MODE,
> > > +                                        I2S_SLAVE_MODE);
> > >
> > >       /* Word length */
> > >       switch (params->sample_width) {
> >

Applied to drm-misc-next.
