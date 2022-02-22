Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FEC4C045D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiBVWKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:10:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE0F106C81
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s24so33898085edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncJM2T87X2o8pTyVRveZGSOn+a2+yRMOSUhJC3B/Gq4=;
        b=Ivl+fOAzjwZVikAE//GhKXqrg3FgwasunygzL6X3K7tmMukt25sYmGH/BgwYn33eey
         2oGVVJytRTJ3g4D06lpohmTyGRsIdaXZQWvxUoiiNWjYdiWXL/9J4CrtB84gRRQ47W25
         ecpmNDu6kl1oulpWSeokNUQNW6BZAhhT25Rls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncJM2T87X2o8pTyVRveZGSOn+a2+yRMOSUhJC3B/Gq4=;
        b=T11FC9ECq0pjrK3G2bLdtACbJ303JVkiJdMzA5eOgYQakE3L1i+iImJME/qIrMfGLR
         OlX8GqszlkE24YaIrqjyG6PHhxmLpjl8wpYXPFcqUUOJlckXtbuf7RecLjoJ4LmafSpV
         sHJo5yFlHrMTihPLbcNBeMXNQLOJzqVTbv+jQWBlD/N8u1+aaEDSZrb4+a2KEpQSAboz
         Kc9CFSLf0gMCoM2wzOO6OT92Oc6DLg6bh4RKHL9hkqBv2hRNrckMrnbYvArJIMLrTqSY
         VGLLadoIL91Uvj28a8OmjVr/dDU3v9JFpLWzXpveos2BhU3k8REwcfhiU0v0qclQEqwL
         HuJA==
X-Gm-Message-State: AOAM533aCqkW5WKh5z5KucNXaGQnXKiZIU5CdGRUjdED57CjqSaO2TMA
        oyrxIXINTpfVClioPhie6XeoLZsCuoAVOoj4+k0=
X-Google-Smtp-Source: ABdhPJxe50hceczChxk2DIaE6k8CznYqnlzwPk/ZekbFQgaj4+CNSYy9VB6njYTIn0d4WotydKli4w==
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id f15-20020a50bf0f000000b00410c512cb6fmr28319619edk.262.1645567805661;
        Tue, 22 Feb 2022 14:10:05 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id s30sm6705984ejm.158.2022.02.22.14.10.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 14:10:04 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id d28so8322387wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:10:04 -0800 (PST)
X-Received: by 2002:adf:ef07:0:b0:1e3:333f:a101 with SMTP id
 e7-20020adfef07000000b001e3333fa101mr21559376wro.301.1645567804216; Tue, 22
 Feb 2022 14:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20220217144136.v3.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
 <20220217144136.v3.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid>
In-Reply-To: <20220217144136.v3.2.I48b18ab197c9b649d376cf8cfd934e59d338f86d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 14:09:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UudBo7aZqD8oGHAu94LEYovMtFq7hjwOG2_8yxUeNi_w@mail.gmail.com>
Message-ID: <CAD=FV=UudBo7aZqD8oGHAu94LEYovMtFq7hjwOG2_8yxUeNi_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: analogix_dp: Enable autosuspend
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sean Paul <sean@poorly.run>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 17, 2022 at 2:42 PM Brian Norris <briannorris@chromium.org> wrote:
>
> DP AUX transactions can consist of many short operations. There's no
> need to power things up/down in short intervals.
>
> I pick an arbitrary 100ms; for the systems I'm testing (Rockchip
> RK3399), runtime-PM transitions only take a few microseconds.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v3:
>  - New in v3
>
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 16be279aed2c..d82a4ddf44e7 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1121,7 +1121,7 @@ static int analogix_dp_get_modes(struct drm_connector *connector)
>
>                 pm_runtime_get_sync(dp->dev);
>                 edid = drm_get_edid(connector, &dp->aux.ddc);
> -               pm_runtime_put(dp->dev);
> +               pm_runtime_put_autosuspend(dp->dev);

So I think you can fully get rid of these ones now and rely on the
ones in the aux transfer, right?


>                 if (edid) {
>                         drm_connector_update_edid_property(&dp->connector,
>                                                            edid);
> @@ -1642,7 +1642,7 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
>
>         ret = analogix_dp_transfer(dp, msg);
>  out:
> -       pm_runtime_put(dp->dev);
> +       pm_runtime_put_autosuspend(dp->dev);
>
>         return ret;
>  }
> @@ -1775,6 +1775,8 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
>         if (ret)
>                 return ret;
>
> +       pm_runtime_use_autosuspend(dp->dev);
> +       pm_runtime_set_autosuspend_delay(dp->dev, 100);

It's explicitly listed in the Documentation that you need the
corresponding pm_runtime_dont_use_autosuspend(). Specifically, it
says:

> Drivers in ->remove() callback should undo the runtime PM changes done
> in ->probe(). Usually this means calling pm_runtime_disable(),
> pm_runtime_dont_use_autosuspend() etc.

Not that it's very common to see anyone actually get it right, but I
seem to remember running into an issue when I didn't do it. I think
ti-sn65dsi86 still has it wrong since I found out about this later.
Need to write a patch up for that... Basically you want to put it
right before the two calls in your driver to pm_runtime_disable().

-Doug
