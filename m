Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90D484340
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiADOXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiADOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:23:05 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80DC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:23:05 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f5so3474776pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16BCa8vmo/R1Nhv2OFH0NIv+n8wUvm3BXfP8bb/BoGM=;
        b=fuLzQV6Uwi3akPblo17SMWMdezrTUj9KlzsDiUIeTS7D3SmEnJK6MWe84mC3mMP5Zb
         gphbkezPqvortF+B/NNBNu27I0198v9ztUqAMBgyFnivZ49/CNV7D3h2qpB/Y7YiU/3q
         DIcjepf6RnVabqblVazivn+qX5dLqQLzfLlutCPJ+AlIDV+CXoWuxiqqw0sDJX3QS/MP
         CX0O+2v8uDQasIRhmnQTOsPaBPF0pBed0fcpmNJEuhBvfWitm8AxdynVjkG1ntjJhJ1L
         JWM1Liae6/l/oyP9wRANfPNnRqYtQxSNDSb7xI0onOmC2ZuF4C26wBToKuC4/cLhjeuh
         zM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16BCa8vmo/R1Nhv2OFH0NIv+n8wUvm3BXfP8bb/BoGM=;
        b=dPbeeJhvmyG/+L5jAxqyivQKD5aR52nDsoM5jooCmAG9wdSW+lEzFw8tGoI5qhzDE1
         ZRydLYi2VFN9DzkwAve317lYBI5Wz6ib5d1YMvng7WuqovS0r++ZjldIqKFzhJ0Pm6N4
         MV5dEBNen9NXq13YUEvgVmkoGzwW3SFvR5jl3qqgC5Vx2a+3tjAi620o/K61nArbQ1NQ
         qjAozu1GdKm8cJlcWU0bwmVGcoQvP/JS4sUX4GuzznomW/iHeorWSxteECYZvtGKm2kI
         Dg2S7Uw4ndpA+PJrZNujUVPGVS+Y5EEmXOhcALLGJxN7yr2+z26Ifp5BvcROBbIz7Ixw
         dbsw==
X-Gm-Message-State: AOAM530CrNhgFMPgZABEwJQJ2QTtEt/YXnSpxXkzS7CgXCnuCVR8xZly
        6zsd7Hh1L+Wf02DTbe8gLeUrX4A7zFc1qgYQaq1kkg==
X-Google-Smtp-Source: ABdhPJxlbp0iiJUgRFs9x7jwIl0nsOxY7EM34iksnLwZtzwXXTwlxtRr5FwqsCLWkaK2jl4TOjkY8ZkQBHO0eIh9ex4=
X-Received: by 2002:a62:d044:0:b0:4ba:6f3b:ab08 with SMTP id
 p65-20020a62d044000000b004ba6f3bab08mr51280950pfg.29.1641306184521; Tue, 04
 Jan 2022 06:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20211102130428.444795-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20211102130428.444795-1-angelogioacchino.delregno@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 15:22:53 +0100
Message-ID: <CAG3jFys2Js0urfL9q3nk_KDweLcX+cOZeURCk8=gyps9h6TPcA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Link device to ensure
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

Hey AngeloGioacchino,

On Tue, 2 Nov 2021 at 14:08, AngeloGioacchino Del Regno
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
>  drivers/gpu/drm/bridge/parade-ps8640.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 45100edd745b..191cc196c9d1 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -100,6 +100,7 @@ struct ps8640 {
>         struct regulator_bulk_data supplies[2];
>         struct gpio_desc *gpio_reset;
>         struct gpio_desc *gpio_powerdown;
> +       struct device_link *link;
>         bool powered;
>  };
>
> @@ -460,10 +461,23 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>                 goto err_aux_register;
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
> +       if (ret)
> +               goto err_bridge_attach;
>
> +err_bridge_attach:
> +       device_link_del(ps_bridge->link);
> +err_devlink:
> +       drm_dp_aux_unregister(&ps_bridge->aux);
>  err_aux_register:
>         mipi_dsi_detach(dsi);
>  err_dsi_attach:
> @@ -473,7 +487,11 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
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

This patch does not apply on drm-misc-next, could you rebase it on the
current branch?
