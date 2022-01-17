Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839DE490BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiAQPml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiAQPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:42:40 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCF5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:42:40 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p37so10521493pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBse3TDhMT3P1QzjpmTykdxb+O3mXQF8X49QrJGnK9w=;
        b=LZTP5w65jwgoJGxqEXUMQBhGqnjlbTs84KuPFBpRzYEx0DwsSeJeLBikEqHqkrSW9g
         VSpBlg/Cogu47PGexznErP70Sr0aY7rxPv5bhtOLPGVsqRDI4CQFxo1/MTfyCWUNYQew
         UWHrktQHee2IMNUM2nvKprXbyMXe4Dc7lflFtBpUDqWW4OCum5RU2Vk0pHf0sT1wfHM3
         Usl/QhE1XVbcgXSbXL4IM9B7aEqPuZb8f+SzqBwnNiSi30/ryHWQKDvGlHZkLWhH/5XB
         aWjmgRDVAn8TCiUosMZQNjwfgAG8+SC0xnypzhxkf6TIGcn3v5jCcBjJ4vCGsBaOrrjt
         gKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBse3TDhMT3P1QzjpmTykdxb+O3mXQF8X49QrJGnK9w=;
        b=OxRCxDju38NdcgV/zIBhFtVic6JVdFB04tYV9KrifXUwD2RVc1d38ELYlPTCuCaC4i
         VfrcDyfzUMu1z2ncr9uIOaZvfmBS+gm9OGUWx0WWLhwEaouSsIzbbDPGku7WEWvQKyuY
         f5DqyRIJ2+orX9fIr5tw/IVaw/3nJLYBqANnP7Kc1L4PO6bu7P220xEpyTalauk1tLB5
         ++vCziq7KmJCPOS2nz1eUglIkh9l4Y8ctzem7T5ROc3H9tfNIs8F5iRx9Y6Es4jorj19
         F3keGZrsE8TN5WO/SUl++4j8nV9CuuKu5BFHhgwWnoLFPIQwsQcfj6N7dUNad++J3F8d
         4PVA==
X-Gm-Message-State: AOAM530Np1vorCIDtKmuFoyeX2C12N+Hxneoqv60zvh6CpkdqyusT6ln
        ujRX11c2IdhLDXDrUmcEGOaIW8g6XRFf0CVvsvm1eA==
X-Google-Smtp-Source: ABdhPJyK+mJqd8HpVnnFKs335VNzfb1ZQwWiuJ4tIjAYkUGYjihDvc47IddIXGdc5+gkomCMF5P6xqqjbwDuvvVxMCk=
X-Received: by 2002:a63:2b03:: with SMTP id r3mr19439606pgr.201.1642434159652;
 Mon, 17 Jan 2022 07:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20220117100949.9542-1-qwt9588@gamil.com>
In-Reply-To: <20220117100949.9542-1-qwt9588@gamil.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 17 Jan 2022 16:42:28 +0100
Message-ID: <CAG3jFytFGPZ+eksbaj2muT8R=1QmCCPRerv6yYZC6s9X+TOsbw@mail.gmail.com>
Subject: Re: [PATCH v5] drm/bridge: anx7625: Return -EPROBE_DEFER if the dsi
 host was not found
To:     owen <qwt9588@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Owen

On Mon, 17 Jan 2022 at 11:10, owen <qwt9588@gmail.com> wrote:
>
> From: owen <qwt9588@gmail.com>
>
> It will connect to the mipi dsi host and find the corresponding
> mipi dsi host node, but the node registered by the mipi dsi host
> has not been loaded yet. of_find_mipi_dsi_host_by_node() returns -EINVAL
> which causes the calling driver to fail.
>
> If the anx7625 driver is loaded afterwards the driver requesting
> the mipi dsi host will not notice this.
>
> Better approach is to return -EPROBE_DEFER in such case.
> Then when the anx7625 driver appears the driver requesting
> the mipi dsi host will be probed again.
>
> Signed-off-by: owen <qwt9588@gmail.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 2346dbcc505f..297bbeb5aae0 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1660,7 +1660,7 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>         host = of_find_mipi_dsi_host_by_node(ctx->pdata.mipi_host_node);
>         if (!host) {
>                 DRM_DEV_ERROR(dev, "fail to find dsi host.\n");
> -               return -EINVAL;
> +               return -EPROBE_DEFER;
>         }
>
>         dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> --
> 2.31.0
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
