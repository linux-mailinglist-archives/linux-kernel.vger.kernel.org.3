Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3056885F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiGFMbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiGFMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:31:34 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308826AC9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:31:33 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n66so10624265oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcutWXTnA/WDhwPlx9qo4wsri5JOk1i2qD2fd6gm+Uo=;
        b=TQtAz7IJdH/RcgD2JhDeWupI3HpDRhSsuMv93XWEktBxg2cUnb7N6Z5TXgViCOwSNQ
         qduuM1jEM8RgHppmsUYSiMqSyP1mdaql/xEpkAdml3SJJyTp0WZ6AhON3jlOG+8xCuVz
         HRXyVUW5G9o4GUjIgLLCf5Z0OocWhVV5A8UISGzlBn6/c0dXz9MqBUYr4zr4x765O1uY
         p0eWt808Z0CAzZCyAC+XxZyLqBfXOc909/5dF55CsM4lAqsGqh9LjLt2gkXxH40JTMpA
         PfnVGOzaUEqrWd9S5oGXoMtMd99Z23/0XHDjD3JmKlPlwUptGqlnzJeExz374yecRz8o
         eyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcutWXTnA/WDhwPlx9qo4wsri5JOk1i2qD2fd6gm+Uo=;
        b=M+tVNO9i/SZ0UP9BfSVp5G8wemTKsPFNzOlMFt/UKddUpgt3nlEeZ6E7+uhXFRtb9G
         CLOyhODA8dpX3t/X0Ehb54IVRposiFTsPdAxcLyZBDoihSI/+eGWbUrc/uauowwAcLuN
         ikqv/AMFgkr7ZGRBwuSSLDFnV9AVmnU3Pjea2NUE3j1H7oP/bcX6AX83lGo6IFyQECtA
         mYTWANDAIvWagrn31k79Z5Fed6hazs6UZZOms50wB6BMCj7R/zhQ7Tsi/403CjsVeE3X
         jn3bhDAmNRtlU3+rG4xMuQ2WpvwS0TNhW2BMWW/fsz/5BKOtlTwENkWP3lpYtCC0uZPD
         ZWcg==
X-Gm-Message-State: AJIora9AVa8hGm8d7WUBY432RdUmPTJombglM47IhHATmNMFP+Gg9nSt
        L7IDONeQ9HL0CM1DTdlBoAPFB5qA5WF2s/OTycU53w==
X-Google-Smtp-Source: AGRyM1tAz1H7e2uwc6cDOZT4xcEqNzp8sUNzevKJ456/ix3zpbw31abTY4nAoXKBmsfvR38p8cMuI5uKZ4Jrf3aXY6A=
X-Received: by 2002:a05:6808:14ca:b0:335:b401:9054 with SMTP id
 f10-20020a05680814ca00b00335b4019054mr20168504oiw.241.1657110692604; Wed, 06
 Jul 2022 05:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220629160550.433980-1-hsinyi@chromium.org> <20220629160550.433980-2-hsinyi@chromium.org>
 <20220706022926.GA2357796@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220706022926.GA2357796@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 Jul 2022 14:31:21 +0200
Message-ID: <CAG3jFyu2KObuc5CiFFK=NzkE1LOTSFVoA3mNyY6r1aKs2SU3ow@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: anx7625: Convert to devm_i2c_new_dummy_device()
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hey Hsin-Yi,

On Wed, 6 Jul 2022 at 04:29, Xin Ji <xji@analogixsemi.com> wrote:
>
> Hi Hsin-Yi, thanks for your patch, looks good to me.
>
> Reviewed-by: Xin Ji <xji@analogixsemi.com>
>
> On Thu, Jun 30, 2022 at 12:05:47AM +0800, Hsin-Yi Wang wrote:
> > Simplify the resource management.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 96 +++++++----------------
> >  1 file changed, 27 insertions(+), 69 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 3710fa9ee0acd..f89e8151475f7 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -2436,82 +2436,44 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
> >  static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
> >                                             struct i2c_client *client)
> >  {
> > -     int err = 0;
> > +     struct device *dev = &ctx->client->dev;
> >
> > -     ctx->i2c.tx_p0_client = i2c_new_dummy_device(client->adapter,
> > -                                                  TX_P0_ADDR >> 1);
> > +     ctx->i2c.tx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                             TX_P0_ADDR >> 1);
> >       if (IS_ERR(ctx->i2c.tx_p0_client))
> >               return PTR_ERR(ctx->i2c.tx_p0_client);
> >
> > -     ctx->i2c.tx_p1_client = i2c_new_dummy_device(client->adapter,
> > -                                                  TX_P1_ADDR >> 1);
> > -     if (IS_ERR(ctx->i2c.tx_p1_client)) {
> > -             err = PTR_ERR(ctx->i2c.tx_p1_client);
> > -             goto free_tx_p0;
> > -     }
> > +     ctx->i2c.tx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                             TX_P1_ADDR >> 1);
> > +     if (IS_ERR(ctx->i2c.tx_p1_client))
> > +             return PTR_ERR(ctx->i2c.tx_p1_client);
> >
> > -     ctx->i2c.tx_p2_client = i2c_new_dummy_device(client->adapter,
> > -                                                  TX_P2_ADDR >> 1);
> > -     if (IS_ERR(ctx->i2c.tx_p2_client)) {
> > -             err = PTR_ERR(ctx->i2c.tx_p2_client);
> > -             goto free_tx_p1;
> > -     }
> > +     ctx->i2c.tx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                             TX_P2_ADDR >> 1);
> > +     if (IS_ERR(ctx->i2c.tx_p2_client))
> > +             return PTR_ERR(ctx->i2c.tx_p2_client);
> >
> > -     ctx->i2c.rx_p0_client = i2c_new_dummy_device(client->adapter,
> > -                                                  RX_P0_ADDR >> 1);
> > -     if (IS_ERR(ctx->i2c.rx_p0_client)) {
> > -             err = PTR_ERR(ctx->i2c.rx_p0_client);
> > -             goto free_tx_p2;
> > -     }
> > +     ctx->i2c.rx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                             RX_P0_ADDR >> 1);
> > +     if (IS_ERR(ctx->i2c.rx_p0_client))
> > +             return PTR_ERR(ctx->i2c.rx_p0_client);
> >
> > -     ctx->i2c.rx_p1_client = i2c_new_dummy_device(client->adapter,
> > -                                                  RX_P1_ADDR >> 1);
> > -     if (IS_ERR(ctx->i2c.rx_p1_client)) {
> > -             err = PTR_ERR(ctx->i2c.rx_p1_client);
> > -             goto free_rx_p0;
> > -     }
> > +     ctx->i2c.rx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                             RX_P1_ADDR >> 1);
> > +     if (IS_ERR(ctx->i2c.rx_p1_client))
> > +             return PTR_ERR(ctx->i2c.rx_p1_client);
> >
> > -     ctx->i2c.rx_p2_client = i2c_new_dummy_device(client->adapter,
> > -                                                  RX_P2_ADDR >> 1);
> > -     if (IS_ERR(ctx->i2c.rx_p2_client)) {
> > -             err = PTR_ERR(ctx->i2c.rx_p2_client);
> > -             goto free_rx_p1;
> > -     }
> > +     ctx->i2c.rx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                             RX_P2_ADDR >> 1);
> > +     if (IS_ERR(ctx->i2c.rx_p2_client))
> > +             return PTR_ERR(ctx->i2c.rx_p2_client);
> >
> > -     ctx->i2c.tcpc_client = i2c_new_dummy_device(client->adapter,
> > -                                                 TCPC_INTERFACE_ADDR >> 1);
> > -     if (IS_ERR(ctx->i2c.tcpc_client)) {
> > -             err = PTR_ERR(ctx->i2c.tcpc_client);
> > -             goto free_rx_p2;
> > -     }
> > +     ctx->i2c.tcpc_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                             TCPC_INTERFACE_ADDR >> 1);
> > +     if (IS_ERR(ctx->i2c.tcpc_client))
> > +             return PTR_ERR(ctx->i2c.tcpc_client);
> >
> >       return 0;
> > -
> > -free_rx_p2:
> > -     i2c_unregister_device(ctx->i2c.rx_p2_client);
> > -free_rx_p1:
> > -     i2c_unregister_device(ctx->i2c.rx_p1_client);
> > -free_rx_p0:
> > -     i2c_unregister_device(ctx->i2c.rx_p0_client);
> > -free_tx_p2:
> > -     i2c_unregister_device(ctx->i2c.tx_p2_client);
> > -free_tx_p1:
> > -     i2c_unregister_device(ctx->i2c.tx_p1_client);
> > -free_tx_p0:
> > -     i2c_unregister_device(ctx->i2c.tx_p0_client);
> > -
> > -     return err;
> > -}
> > -
> > -static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *ctx)
> > -{
> > -     i2c_unregister_device(ctx->i2c.tx_p0_client);
> > -     i2c_unregister_device(ctx->i2c.tx_p1_client);
> > -     i2c_unregister_device(ctx->i2c.tx_p2_client);
> > -     i2c_unregister_device(ctx->i2c.rx_p0_client);
> > -     i2c_unregister_device(ctx->i2c.rx_p1_client);
> > -     i2c_unregister_device(ctx->i2c.rx_p2_client);
> > -     i2c_unregister_device(ctx->i2c.tcpc_client);
> >  }
> >
> >  static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
> > @@ -2723,8 +2685,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
> >       if (!platform->pdata.low_power_mode)
> >               pm_runtime_put_sync_suspend(&client->dev);
> >
> > -     anx7625_unregister_i2c_dummy_clients(platform);
> > -
> >  free_wq:
> >       if (platform->workqueue)
> >               destroy_workqueue(platform->workqueue);
> > @@ -2754,8 +2714,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
> >       if (!platform->pdata.low_power_mode)
> >               pm_runtime_put_sync_suspend(&client->dev);
> >
> > -     anx7625_unregister_i2c_dummy_clients(platform);
> > -
> >       if (platform->pdata.audio_en)
> >               anx7625_unregister_audio(platform);
> >
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog

Can you fix the checkpatch --strict warnings and formatting issues in
this series?
