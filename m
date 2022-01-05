Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220CB4857AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbiAERvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbiAERvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:51:19 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5EFC0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:51:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id p37so32505pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02jPdn5t6Ff/0d55zQvjcjTFcLTmmCYTOM0kxLOQ3iQ=;
        b=Cueq/b8lSSVzXegMttx9Vx8pSA/UhhD3m1o20cmLoHcVqhZ6XXgaaXVafKRtYqDlyj
         8IWvTSJ4pZRKFoIIksCwBB2tNfs2J0aGabT4tNvI3Hlm9znMm1dx0KTz0GpJYxFfRyHY
         jrH0+K1kTBtqfXd1eTy28XjLXNBnJl+uTMPKOOb+xyXPkVBi4JzW3e3Rcs83nN7N7//g
         6UgSi1nSCBXw0Gt5bX2BgStF2nDTix2tKCIs4SamDY8bgF/zCgAck1Z87gI1rkvMRt5m
         x9rAHWDk//z8+cJw72x+/WCoqS7t1n0w1qB+W9LfWPbidp95ahJF+UwGN3CcSJCWjYTp
         Okzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02jPdn5t6Ff/0d55zQvjcjTFcLTmmCYTOM0kxLOQ3iQ=;
        b=RSlVf0jFpgbyWeqXZ2r5D0gag0PMaIycZNAdn/O5dAOVxfmzsvBfhVBKje+GUe/RvJ
         iacIEOSJFeLEKuLF5LMPnRxDm3kKep/W8q1X5Qrbajo91Hk2gNiC/UNDZRfrWu7Az8BQ
         cepZmJ4p6MK9X1nt3/md++T92BB5JytH7xy4dRuj6tsX7tWlf5BZ3KhVG31iuFC8N1nY
         S9/nF0Jj4wVMD6AK8z+e2M15uVB0gR8MwE0duGHs/M//mHsen0ABF28vuV3oNHhs5ZhE
         j5McXyNK6tH346mm15/wo7w01LHx5L1yPPzQ/n7AkXvzG9Fsv5VNm3QMPhq7GXhAQUJy
         29dw==
X-Gm-Message-State: AOAM533qwH/PE/z+geaHU0bYuYXoi5p3RmZD9bT2bPRl3Cbpj4lNgBlA
        wZEaa+ARP49pMFwPF8DiQ9zFtWOx2+RP4ZK77sb63Q==
X-Google-Smtp-Source: ABdhPJzLGp9Lu53gKwRN5ecOY+UDsR90b4q8ivNS1uGwZU7RHIkl+SxX9b3LNJIDkOIJFrv+kyaNYuHnIMw14ADw3RU=
X-Received: by 2002:a63:854a:: with SMTP id u71mr48636668pgd.201.1641405078557;
 Wed, 05 Jan 2022 09:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20220105104826.1418-1-linmq006@gmail.com>
In-Reply-To: <20220105104826.1418-1-linmq006@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 5 Jan 2022 18:51:07 +0100
Message-ID: <CAG3jFyvUcGgELW=N4OXwU_SVtV9YpyKQynTj2Oz77P_C1YMOkg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Fix PM disable depth imbalance in nwl_dsi_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miaoqian,

Thanks for submitting this patch!

On Wed, 5 Jan 2022 at 11:48, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> The pm_runtime_enable will increase power disable depth.
> Thus a pairing decrement is needed on the error handling
> path to keep it balanced according to context.
>
> Fixes: 44cfc62 ("drm/bridge: Add NWL MIPI DSI host controller support")

In the future, please use 12 chars of the hash. I'll fix it this time,
but please use 12 characters going forward.

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index a7389a0facfb..fc3ad9fab867 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -1206,6 +1206,7 @@ static int nwl_dsi_probe(struct platform_device *pdev)
>
>         ret = nwl_dsi_select_input(dsi);
>         if (ret < 0) {
> +               pm_runtime_disable(dev);
>                 mipi_dsi_host_unregister(&dsi->dsi_host);
>                 return ret;
>         }
> --
> 2.17.1
>

Fixed commit hash length, added my r-b and applied to drm-misc-next.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
