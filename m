Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5FF58E930
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiHJI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiHJI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:59:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15663AE218
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:58:45 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j63so22174749ybb.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2PmnQy9U1/lt+p+l2hFrCjWUU3aQ4y+M/PEcXE/12/M=;
        b=hVE1t++rCxMZhMYt1GawIULran/IylUDFqwBk5nwsKqUWql6L/107UrX2s/XV8Pc2C
         vw1FUcNtVohHQvJCzGpzIv+buAz/wncXboJPMlqZU4tVdYhtpjNl0SCDNkxPB8FMSxAy
         HNYbwUDS682oyFo6612DPRKU3JaUm1s+pmxjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2PmnQy9U1/lt+p+l2hFrCjWUU3aQ4y+M/PEcXE/12/M=;
        b=iJKMSD9xf1YxQaJI949vk/TDCrnJPCjeYXMiBp7WeIesLLdXgZta+zcXIOY2jkU28I
         C8bdp5YVxhHlAQtqt+NkLnDWKX0/fnHIOEcS+ugXwjC21DanF2AVZKqxEGaf3piaMvaT
         1kNYhLvznG4UFAN3biWmW5H/jSNj67Dx4PYZc3nUgSjUM7SQjJ2LcqKtoNO885Ee7dwS
         miw7KOUxcj2E0Bkp6Yhk2H6qlKmIgAdBWpwyiS6T19dqf3g3UBZ8NeDwhkKYWhpWoCq2
         LQnu5IzYLgPK/eUprkg2XqgZJwT/2Tm1pkkDTBN0dkk7jEk2nM53SZgkgJ/m2iOjZCeX
         bvww==
X-Gm-Message-State: ACgBeo1ZTXOeqcseTXi0SYsS5Y60U81hiyXASw4nHWa8zT8gXM4lIoUu
        TZGRYH8nglLnuadggLp6GNmmgvtmgBFm/p2hgiv8Aw==
X-Google-Smtp-Source: AA6agR4MsGGUtyoBj/+yfnuqG/nZkrPYAXn5jSRB3Z0SE44kHwOP2tZOVpF2oR9/x9/29h2lTYjFz3mqg67VAFwVp4Y=
X-Received: by 2002:a25:cec6:0:b0:671:72cf:f585 with SMTP id
 x189-20020a25cec6000000b0067172cff585mr24617848ybe.201.1660121924228; Wed, 10
 Aug 2022 01:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220726033058.403715-1-xji@analogixsemi.com> <9385f8642e6ad5491a036360c644dc21b9a3f009.camel@mediatek.com>
In-Reply-To: <9385f8642e6ad5491a036360c644dc21b9a3f009.camel@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 10 Aug 2022 16:58:18 +0800
Message-ID: <CAJMQK-injwWcNVC-niYTgbFQ3R6yOMGkSX+vAuwWAEiMhhft3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Support HDMI_I2S audio format
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 5:16 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> On Tue, 2022-07-26 at 11:30 +0800, Xin Ji wrote:
> > 1. Support HDMI_I2S audio format.
> > 2. Return 0 if there is no sink connection in .hw_param callback.
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 23 +++++++++++++++++--
> > ----
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> Acked-by: Jiaxin Yu<jiaxin.yu@mediatek.com>
Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>

> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 79fc7a50b497..c74b5df4cade 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1797,8 +1797,13 @@ static int anx7625_audio_hw_params(struct
> > device *dev, void *data,
> >       int wl, ch, rate;
> >       int ret = 0;
> >
> > -     if (fmt->fmt != HDMI_DSP_A) {
> > -             DRM_DEV_ERROR(dev, "only supports DSP_A\n");
> > +     if (anx7625_sink_detect(ctx) == connector_status_disconnected)
> > {
> > +             DRM_DEV_DEBUG_DRIVER(dev, "DP not connected\n");
> > +             return 0;
> > +     }
> > +
> > +     if (fmt->fmt != HDMI_DSP_A && fmt->fmt != HDMI_I2S) {
> > +             DRM_DEV_ERROR(dev, "only supports DSP_A & I2S\n");
> >               return -EINVAL;
> >       }
> >
> > @@ -1806,10 +1811,16 @@ static int anx7625_audio_hw_params(struct
> > device *dev, void *data,
> >                            params->sample_rate, params->sample_width,
> >                            params->cea.channels);
> >
> > -     ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > -                                 AUDIO_CHANNEL_STATUS_6,
> > -                                 ~I2S_SLAVE_MODE,
> > -                                 TDM_SLAVE_MODE);
> > +     if (fmt->fmt == HDMI_DSP_A)
> > +             ret = anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > +                                        AUDIO_CHANNEL_STATUS_6,
> > +                                        ~I2S_SLAVE_MODE,
> > +                                        TDM_SLAVE_MODE);
> > +     else
> > +             ret = anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> > +                                        AUDIO_CHANNEL_STATUS_6,
> > +                                        ~TDM_SLAVE_MODE,
> > +                                        I2S_SLAVE_MODE);
> >
> >       /* Word length */
> >       switch (params->sample_width) {
>
