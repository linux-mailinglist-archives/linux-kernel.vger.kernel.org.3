Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79C7485751
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbiAEReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiAEReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:34:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FFC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:34:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so6900434pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzLkrKvzf4U9brrtJ/3zSRGG7qJqvKjcyzgpbg4OR7o=;
        b=bNxkLOSbNiE/cewnhs6irchlQbeHzqbhgGQrmOP9jDjSYoROJbonp3xgs8SAzJ1xpv
         PYeoKPrPjBoI3DGf3Krn5qcpuwy4t1CLIVFoPNMIxIUu0Ff4coPjxaDDbfRh0pwrjFte
         1Dyef/Z9uXNrBJWyP9xRupQ6+cPbfPOuLzLJrOkzxW3ayIsbhIYMRE1TLqTcESSdMWQZ
         R9WjbmUaIQr5WP9u1grncJhgiPf8S4D5wK1W01ZJtVtI9G9r9tNTbA/NsPqQ3g/wngsU
         QV5j5MciS99bhoO+Uz/S0wTjh1fTcI6nxh0ztsanPxJSCBiokkzACPbakcELefpTpdrc
         vCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzLkrKvzf4U9brrtJ/3zSRGG7qJqvKjcyzgpbg4OR7o=;
        b=FohUooPosuBHGqNS51qy0awcORE/G6T2kxeUvt1vO37tv2u56vOwV6fHjKxugTeGzh
         XH3AGW3W/SlDj0Dp2SEL2lzBuqtve5ulGqHNOu2i48PWNemYitTtIXFMacJtqC3au4Vl
         G+JvvuXe7cRCi7ADZjsDgrNnoivaJVm+ZCSkw4vL35j1D3N3hwGdd8g9okMLWa5z4pWr
         KRvfi2x15HqVBy4yqem/gtg6SoSXxuydZLVOH/X4gnKXsnNOvcH5rDWSfR+n6pHIN5nz
         IGcL56ey+YwR+Lpuq2MXqbmFE8qD8d0a0wBnC02DH+GSYrnhPWrklTBmhfHFHngYeKAK
         O9Hw==
X-Gm-Message-State: AOAM531Ss+o87FOU7W5dj4S5JnhK6MsR4wfQRBNBI4t0ozHRxaqikRg6
        86FQ1J4TRTkxN2PKNMZJMAyML+27IFLWl3FDzS+sSA==
X-Google-Smtp-Source: ABdhPJxT9Zl9HHHjb3sOf7PjsVVoVZqqork5XhastH019KbAUFjsGdqiHG6cQ4Q0avYjek53MPn/pTeCYyCbAlABoj8=
X-Received: by 2002:a17:903:110c:b0:149:8018:e9d4 with SMTP id
 n12-20020a170903110c00b001498018e9d4mr41928668plh.117.1641404049262; Wed, 05
 Jan 2022 09:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20220105090802.73564-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220105090802.73564-1-angelogioacchino.delregno@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 5 Jan 2022 18:33:58 +0100
Message-ID: <CAG3jFytpm95P_VVkyrzRVPsFv2yP6QSJOaLM2en6afmR6WwteQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: parade-ps8640: Link device to ensure
 suspend/resume order
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 at 10:08, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Entering suspend while the display attached to this bridge is still on
> makes the resume sequence to resume the bridge first, display last:
> when this happens, we get a timeout while resuming the bridge, as its
> MCU will get stuck due to the display being unpowered.
>
> On the other hand, on mt8173-elm, closing the lid makes the display to
> get powered off first, bridge last, so at resume time the sequence is
> swapped (compared to the first example) and everything just works
> as expected.
>
> Add a stateless device link to the DRM device that this bridge belongs
> to, ensuring a correct resume sequence and solving the unability to
> correctly resume bridge operation in the first mentioned example.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/bridge/parade-ps8640.c | 27 ++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 818704bf5e86..450bc9bdf295 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -102,6 +102,7 @@ struct ps8640 {
>         struct regulator_bulk_data supplies[2];
>         struct gpio_desc *gpio_reset;
>         struct gpio_desc *gpio_powerdown;
> +       struct device_link *link;
>         bool pre_enabled;
>  };
>
> @@ -456,14 +457,36 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>                 return ret;
>         }
>
> +       ps_bridge->link = device_link_add(bridge->dev->dev, dev, DL_FLAG_STATELESS);
> +       if (!ps_bridge->link) {
> +               dev_err(dev, "failed to create device link");
> +               ret = -EINVAL;
> +               goto err_devlink;
> +       }
> +
>         /* Attach the panel-bridge to the dsi bridge */
> -       return drm_bridge_attach(bridge->encoder, ps_bridge->panel_bridge,
> +       ret = drm_bridge_attach(bridge->encoder, ps_bridge->panel_bridge,
>                                  &ps_bridge->bridge, flags);

Bad alignment according to checkpatch --strict

> +       if (ret)
> +               goto err_bridge_attach;
> +
> +       return 0;
> +
> +err_bridge_attach:
> +       device_link_del(ps_bridge->link);
> +err_devlink:
> +       drm_dp_aux_unregister(&ps_bridge->aux);
> +
> +       return ret;
>  }
>
>  static void ps8640_bridge_detach(struct drm_bridge *bridge)
>  {
> -       drm_dp_aux_unregister(&bridge_to_ps8640(bridge)->aux);
> +       struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
> +
> +       drm_dp_aux_unregister(&ps_bridge->aux);
> +       if (ps_bridge->link)
> +               device_link_del(ps_bridge->link);
>  }
>
>  static struct edid *ps8640_bridge_get_edid(struct drm_bridge *bridge,
> --
> 2.33.1
>

Fixed alignment issue, applied to drm-misc-next and added r-b tag.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
