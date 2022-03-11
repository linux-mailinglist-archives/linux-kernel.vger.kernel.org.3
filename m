Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D625D4D6484
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349103AbiCKP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348909AbiCKP0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:26:17 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E11C027B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:25:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t1so11114579edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwx2dquPgXqVb9I6BHmiQ+yT5s0mktYKdstbqhp11lo=;
        b=LZw05L5Lr1SXFIo6n9NicjBiQs9xio5ncAzPl86VwNojgxdv5FPbVwMMXuEcJz2S20
         ot3tgRK3A5u9pbBVwcgTi2rS4v13JgC5uYbnVZmyUnMWKjqhW5TNSobrzT5CLci/ll6v
         VKRbsmHUHjxAMKGUnVtLcdXXgpKMegfNZ1Xz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwx2dquPgXqVb9I6BHmiQ+yT5s0mktYKdstbqhp11lo=;
        b=4MUfFXSxcIfwp8R4qECnfs4Yux73a0pUNWNwpc323KgirJ9hA4Zt/hdalFNGrWcDS3
         csSm9/Vk0garYTKI4Lt1K9F34a8lJ/MgjUQRywFwHnSJQ/m2gYfSYdL4v0xFofvE+tOs
         6zvV7g6bApaQvZuntZTXyps1McHao9WL8Xr/ajcfBTIlloyPMPixHeaHvxmghPoTQhfH
         5OL7G/h5PzYjGrz4LEoGm8Jh79rYPEglFecHgALyt1N5zaCt6o3ysHY58vzTwl10d9Pg
         LuEUzV4DMGe1EGxTWEhg3eYSIw8JiB/Y7nTiFp6OZH7k58sRCJ7pPuSR2GqicBbliufl
         M0fg==
X-Gm-Message-State: AOAM532iPTSRAHF5B8P2+GGVLzKUm9U4LY4QE4dfgrYHfa/p+LqMUE9S
        ODvuF/pojHwp9+PJ0HwWH8v3olnavifyAup+3LU=
X-Google-Smtp-Source: ABdhPJxFvbA78NbLUyxP3pZ3SALzNDUkR/X24Q/MRFSLm8UZAK1K5LEwJJAKmOKVQFKBMtiQ4xEplA==
X-Received: by 2002:a05:6402:4315:b0:416:9c6f:f724 with SMTP id m21-20020a056402431500b004169c6ff724mr9312737edc.400.1647012307906;
        Fri, 11 Mar 2022 07:25:07 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id g1-20020a056402424100b00416c6cbfa4csm1512223edb.54.2022.03.11.07.25.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 07:25:06 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso5545713wmr.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:25:05 -0800 (PST)
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id
 o24-20020a1c7518000000b0037c07ebf255mr15836065wmc.29.1647012305467; Fri, 11
 Mar 2022 07:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20220310152227.2122960-1-kieran.bingham+renesas@ideasonboard.com>
 <20220310152227.2122960-4-kieran.bingham+renesas@ideasonboard.com>
 <CAD=FV=UqTh-FLDyXvH=ED-4cbJ6ggDLsTGqhTeqNMsKDphbzYA@mail.gmail.com> <164697764297.2392702.10094603553189733655@Monstersaurus>
In-Reply-To: <164697764297.2392702.10094603553189733655@Monstersaurus>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Mar 2022 07:24:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6+VdLL0UM_j++fc5Wu7akm9LyJ_Ac19VCqbgPZiw3ZA@mail.gmail.com>
Message-ID: <CAD=FV=U6+VdLL0UM_j++fc5Wu7akm9LyJ_Ac19VCqbgPZiw3ZA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: ti-sn65dsi86: Support hotplug detection
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 10, 2022 at 9:47 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> > > +static void ti_sn_bridge_hpd_disable(struct drm_bridge *bridge)
> > > +{
> > > +       struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
> > > +
> > > +       regmap_write(pdata->regmap, SN_IRQ_HPD_REG, 0);
> > > +       pm_runtime_put_autosuspend(pdata->dev);
> >
> > Before doing the pm_runtime_put_autosuspend() it feels like you should
> > ensure that the interrupt has finished. Otherwise we could be midway
> > through processing an interrupt and the pm_runtime reference could go
> > away, right? Maybe we just disable the irq which I think will wait for
> > anything outstanding to finish?
>
> Should the IRQ handler also call pm_runtime_get/put then?

I thought about that, but I suspect it's cleaner to disable the IRQ
handler (and block waiting for it to finish if it was running). That
will ensure that the core isn't notified about HPD after HPD was
disabled.  Once you do that then there's no need to get/put in the irq
handler since we always hold a pm_runtime reference when the IRQ
handler is enabled.


> > > @@ -1247,9 +1342,29 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
> > >         pdata->bridge.type = pdata->next_bridge->type == DRM_MODE_CONNECTOR_DisplayPort
> > >                            ? DRM_MODE_CONNECTOR_DisplayPort : DRM_MODE_CONNECTOR_eDP;
> > >
> > > -       if (pdata->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
> > > +       if (pdata->bridge.type == DRM_MODE_CONNECTOR_DisplayPort) {
> > >                 pdata->bridge.ops = DRM_BRIDGE_OP_EDID;
> > >
> > > +               if (!pdata->no_hpd)
> > > +                       pdata->bridge.ops |= DRM_BRIDGE_OP_DETECT;
> > > +       }
> > > +
> > > +       if (!pdata->no_hpd && pdata->irq > 0) {
> > > +               dev_err(pdata->dev, "registering IRQ %d\n", pdata->irq);
> > > +
> > > +               ret = devm_request_threaded_irq(pdata->dev, pdata->irq, NULL,
> > > +                                               ti_sn65dsi86_irq_handler,
> > > +                                               IRQF_ONESHOT, "sn65dsi86-irq",
> > > +                                               pdata);
> > > +               if (ret)
> > > +                       return dev_err_probe(pdata->dev, ret,
> > > +                                            "Failed to register DP interrupt\n");
> > > +
> > > +               /* Enable IRQ based HPD */
> > > +               regmap_write(pdata->regmap, SN_IRQ_EN_REG, IRQ_EN);
> >
> > Why not put the above regmap_write() in the ti_sn_bridge_hpd_enable() call?
>
> I assumed the IRQ handler may get used by other non-HPD events. Which is
> also why it was originally registered in the main probe(). HPD is just
> one feature of the interrupts. Of course it's only used for HPD now
> though. I guess I could have solved the bridge dependency by splitting
> the IRQ handler to have a dedicated HPD handler function which would
> return if the bridge wasn't initialised, but went with the deferred
> registration of the handler.
>
> I can move this and then leave it to anyone else implementing further
> IRQ features to refactor if needed.

Sounds good. In general the pm_runtime_get reference need to go with
the IRQ enabling, so if someone else finds a non-HPD need then they'll
have to move that too.
