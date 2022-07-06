Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984265688C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiGFM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGFM4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:56:17 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA73122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:56:16 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id k2so5343641vsc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftHZZjzjHuQ5RstQIIDyF6vKwdb+4jCrB5fE7wJXhXI=;
        b=OYMHe00vhSCdQKounufbbnq7t4ywQ/6Qz1qrQd965AUAXyEOlAWrR9cwKIK/kx6wc9
         dqafYJyTSY+T9AZIcn5RnkMFQ1uVu+SI2QMxoF36hlh4WBXbaOzx1n5OOeBH9ihVB3M4
         caIlT0KaYNUnbxTywtFHT8PYllnBRE0fbPRZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftHZZjzjHuQ5RstQIIDyF6vKwdb+4jCrB5fE7wJXhXI=;
        b=TxQ8RzZfb4FHoLAi1oiBHozbleFstlBd886dGL70nzxjj4Ipk2/R3tzqaNYxSItTzT
         RcSgJp2s7h9jbJWOvM81Yu8oGjKsAOKmr42CvSE7PVIWw4rPPLMSjsRwNG0V3PA6b7p2
         l6AbWeuxse9u4+yLUAjv62EHNd22dlaXK6Q4wpaN9sBulbxQas92Ug4RQ1NUfBh3BWTV
         hq8jgXzuTQQFwllwAFiTEP0Y3zQOcoO2ppLdm+c9L8OaPnWXqNsEUCqmqg3gawXM65sc
         ewhaG3EiJPNbvPRIG2wA36/AwSRFiubKXCt0Wpp6vXyDuvLJrNwlAE61InmtMxrBw2gn
         HqjA==
X-Gm-Message-State: AJIora+jayKmBHXfL+N/vFLo4cFNr/Prb91LvgSDIdOH6mIklmsMimbc
        yBTj6GFkl5mqRucY9bQG/GnVMDEU0RueXD8ubNslGg==
X-Google-Smtp-Source: AGRyM1v8+1lLl6CxRomPKuorDgyLBosxmWFekpHYOOEPWv1JdKZP/TrygR3Ms8/Co+uxT6oA8JlZ8VyKJzwG6s7mGJ0=
X-Received: by 2002:a67:e196:0:b0:356:f35c:a5d with SMTP id
 e22-20020a67e196000000b00356f35c0a5dmr5343260vsl.19.1657112175366; Wed, 06
 Jul 2022 05:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220629160550.433980-1-hsinyi@chromium.org> <20220629160550.433980-2-hsinyi@chromium.org>
 <20220706022926.GA2357796@anxtwsw-Precision-3640-Tower> <CAG3jFyu2KObuc5CiFFK=NzkE1LOTSFVoA3mNyY6r1aKs2SU3ow@mail.gmail.com>
In-Reply-To: <CAG3jFyu2KObuc5CiFFK=NzkE1LOTSFVoA3mNyY6r1aKs2SU3ow@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 6 Jul 2022 20:55:49 +0800
Message-ID: <CAJMQK-gaOPJeSSionbG=WXvf9adF6ZFYeWV3duqcu+3TCtfXcA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: anx7625: Convert to devm_i2c_new_dummy_device()
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Xin Ji <xji@analogixsemi.com>,
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 8:31 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> Hey Hsin-Yi,
>
> On Wed, 6 Jul 2022 at 04:29, Xin Ji <xji@analogixsemi.com> wrote:
> >
> > Hi Hsin-Yi, thanks for your patch, looks good to me.
> >
> > Reviewed-by: Xin Ji <xji@analogixsemi.com>
> >
> > On Thu, Jun 30, 2022 at 12:05:47AM +0800, Hsin-Yi Wang wrote:
> > > Simplify the resource management.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 96 +++++++----------------
> > >  1 file changed, 27 insertions(+), 69 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index 3710fa9ee0acd..f89e8151475f7 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -2436,82 +2436,44 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
> > >  static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
> > >                                             struct i2c_client *client)
> > >  {
> > > -     int err = 0;
> > > +     struct device *dev = &ctx->client->dev;
> > >
> > > -     ctx->i2c.tx_p0_client = i2c_new_dummy_device(client->adapter,
> > > -                                                  TX_P0_ADDR >> 1);
> > > +     ctx->i2c.tx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > > +                                             TX_P0_ADDR >> 1);
> > >       if (IS_ERR(ctx->i2c.tx_p0_client))
> > >               return PTR_ERR(ctx->i2c.tx_p0_client);
> > >
> > > -     ctx->i2c.tx_p1_client = i2c_new_dummy_device(client->adapter,
> > > -                                                  TX_P1_ADDR >> 1);
> > > -     if (IS_ERR(ctx->i2c.tx_p1_client)) {
> > > -             err = PTR_ERR(ctx->i2c.tx_p1_client);
> > > -             goto free_tx_p0;
> > > -     }
> > > +     ctx->i2c.tx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > > +                                             TX_P1_ADDR >> 1);
> > > +     if (IS_ERR(ctx->i2c.tx_p1_client))
> > > +             return PTR_ERR(ctx->i2c.tx_p1_client);
> > >
> > > -     ctx->i2c.tx_p2_client = i2c_new_dummy_device(client->adapter,
> > > -                                                  TX_P2_ADDR >> 1);
> > > -     if (IS_ERR(ctx->i2c.tx_p2_client)) {
> > > -             err = PTR_ERR(ctx->i2c.tx_p2_client);
> > > -             goto free_tx_p1;
> > > -     }
> > > +     ctx->i2c.tx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > > +                                             TX_P2_ADDR >> 1);
> > > +     if (IS_ERR(ctx->i2c.tx_p2_client))
> > > +             return PTR_ERR(ctx->i2c.tx_p2_client);
> > >
> > > -     ctx->i2c.rx_p0_client = i2c_new_dummy_device(client->adapter,
> > > -                                                  RX_P0_ADDR >> 1);
> > > -     if (IS_ERR(ctx->i2c.rx_p0_client)) {
> > > -             err = PTR_ERR(ctx->i2c.rx_p0_client);
> > > -             goto free_tx_p2;
> > > -     }
> > > +     ctx->i2c.rx_p0_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > > +                                             RX_P0_ADDR >> 1);
> > > +     if (IS_ERR(ctx->i2c.rx_p0_client))
> > > +             return PTR_ERR(ctx->i2c.rx_p0_client);
> > >
> > > -     ctx->i2c.rx_p1_client = i2c_new_dummy_device(client->adapter,
> > > -                                                  RX_P1_ADDR >> 1);
> > > -     if (IS_ERR(ctx->i2c.rx_p1_client)) {
> > > -             err = PTR_ERR(ctx->i2c.rx_p1_client);
> > > -             goto free_rx_p0;
> > > -     }
> > > +     ctx->i2c.rx_p1_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > > +                                             RX_P1_ADDR >> 1);
> > > +     if (IS_ERR(ctx->i2c.rx_p1_client))
> > > +             return PTR_ERR(ctx->i2c.rx_p1_client);
> > >
> > > -     ctx->i2c.rx_p2_client = i2c_new_dummy_device(client->adapter,
> > > -                                                  RX_P2_ADDR >> 1);
> > > -     if (IS_ERR(ctx->i2c.rx_p2_client)) {
> > > -             err = PTR_ERR(ctx->i2c.rx_p2_client);
> > > -             goto free_rx_p1;
> > > -     }
> > > +     ctx->i2c.rx_p2_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > > +                                             RX_P2_ADDR >> 1);
> > > +     if (IS_ERR(ctx->i2c.rx_p2_client))
> > > +             return PTR_ERR(ctx->i2c.rx_p2_client);
> > >
> > > -     ctx->i2c.tcpc_client = i2c_new_dummy_device(client->adapter,
> > > -                                                 TCPC_INTERFACE_ADDR >> 1);
> > > -     if (IS_ERR(ctx->i2c.tcpc_client)) {
> > > -             err = PTR_ERR(ctx->i2c.tcpc_client);
> > > -             goto free_rx_p2;
> > > -     }
> > > +     ctx->i2c.tcpc_client = devm_i2c_new_dummy_device(dev, client->adapter,
> > > +                                             TCPC_INTERFACE_ADDR >> 1);
> > > +     if (IS_ERR(ctx->i2c.tcpc_client))
> > > +             return PTR_ERR(ctx->i2c.tcpc_client);
> > >
> > >       return 0;
> > > -
> > > -free_rx_p2:
> > > -     i2c_unregister_device(ctx->i2c.rx_p2_client);
> > > -free_rx_p1:
> > > -     i2c_unregister_device(ctx->i2c.rx_p1_client);
> > > -free_rx_p0:
> > > -     i2c_unregister_device(ctx->i2c.rx_p0_client);
> > > -free_tx_p2:
> > > -     i2c_unregister_device(ctx->i2c.tx_p2_client);
> > > -free_tx_p1:
> > > -     i2c_unregister_device(ctx->i2c.tx_p1_client);
> > > -free_tx_p0:
> > > -     i2c_unregister_device(ctx->i2c.tx_p0_client);
> > > -
> > > -     return err;
> > > -}
> > > -
> > > -static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *ctx)
> > > -{
> > > -     i2c_unregister_device(ctx->i2c.tx_p0_client);
> > > -     i2c_unregister_device(ctx->i2c.tx_p1_client);
> > > -     i2c_unregister_device(ctx->i2c.tx_p2_client);
> > > -     i2c_unregister_device(ctx->i2c.rx_p0_client);
> > > -     i2c_unregister_device(ctx->i2c.rx_p1_client);
> > > -     i2c_unregister_device(ctx->i2c.rx_p2_client);
> > > -     i2c_unregister_device(ctx->i2c.tcpc_client);
> > >  }
> > >
> > >  static int __maybe_unused anx7625_runtime_pm_suspend(struct device *dev)
> > > @@ -2723,8 +2685,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
> > >       if (!platform->pdata.low_power_mode)
> > >               pm_runtime_put_sync_suspend(&client->dev);
> > >
> > > -     anx7625_unregister_i2c_dummy_clients(platform);
> > > -
> > >  free_wq:
> > >       if (platform->workqueue)
> > >               destroy_workqueue(platform->workqueue);
> > > @@ -2754,8 +2714,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
> > >       if (!platform->pdata.low_power_mode)
> > >               pm_runtime_put_sync_suspend(&client->dev);
> > >
> > > -     anx7625_unregister_i2c_dummy_clients(platform);
> > > -
> > >       if (platform->pdata.audio_en)
> > >               anx7625_unregister_audio(platform);
> > >
> > > --
> > > 2.37.0.rc0.161.g10f37bed90-goog
>
> Can you fix the checkpatch --strict warnings and formatting issues in
> this series?

Done. Fix them in v2.

Thanks.
