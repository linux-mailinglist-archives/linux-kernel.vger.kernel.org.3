Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55E462DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhK3Hmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbhK3Hmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:42:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992EC061748
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 23:39:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so83089074edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 23:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tna3JPKRhWY1uP0rsupBuba16Q1n89Qg33bMQyE+rfw=;
        b=W3TDq8BSpAjmm2cg7aSRA29YAH82BOy+ZOxfR4yyOuyP0QO2I3dd2MT0Iw/pQEiSFW
         jqYk7tKOoeRyhrcQIbS6II8y1cAah32QpzQ9n/HCgEifysPHzso9AAAKpSsXBXXbiLWi
         Nr2CnNz1IX0VC7vp8+/oOH4B3R0TncAoHaDsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tna3JPKRhWY1uP0rsupBuba16Q1n89Qg33bMQyE+rfw=;
        b=eiuOPTU4e2R7pA0PYw0luYfDtk3X8pUloZJLaYqNLvoBAZ1iHQ414rROK0r5Jhbe1d
         40NEFy+n2cZQEqJdtOlQw4HMBoHdsCwHLs6KQTnWiNnhqZKzlbTf+rD9Pvz8pkbnpsb7
         VVITk+fmEdk4aMx3otdwH3s+Ny8lTcjd7isOsnfcNLPimTVKErKNf8zUMp7k4UMwXa4n
         3II+78JqXZGj/77Fqw9uCLmDs3eClU+iAZ9ckz6dzRnyqsVa7zF6cBVD48NQqYchUV4B
         SkpyZHfR/cW0m/Xmw8ubmr6l7SwyyRvAVaYNqQf65txOWj8zIVpGumKGZ+JrthKo7BRL
         EmhQ==
X-Gm-Message-State: AOAM533/lRoCIqUWhj+ghJR+I4V7UVLhYMzIRoN0Sc0LY/xubbS7WcZx
        l0Tc8TS/tsW+Zt/Qyy93mA7END5LNhmGa2GFZI0sCQ==
X-Google-Smtp-Source: ABdhPJyvFBMkasn5akObf5bg3IXw2Ui+pvjGrejGeGmB2kfl2QwndmOA0FUs6kErURgqcBJIMLwObeqDMWrQhb9V2/c=
X-Received: by 2002:a17:907:6d28:: with SMTP id sa40mr64638869ejc.201.1638257948621;
 Mon, 29 Nov 2021 23:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20211126101518.938783-1-kieran.bingham+renesas@ideasonboard.com> <20211126101518.938783-5-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20211126101518.938783-5-kieran.bingham+renesas@ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 30 Nov 2021 13:08:57 +0530
Message-ID: <CAMty3ZA3rTqkPtmC2yBq8zSExGd9jRjOPR06tpt2fB_AXHRxdQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm: rcar-du: mipi-dsi: Support bridge probe ordering
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Fri, Nov 26, 2021 at 3:45 PM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> The bridge probe ordering for DSI devices has been clarified and further
> documented in
>
> To support connecting with the SN65DSI86 device after commit c3b75d4734cb
> ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe"),
> update to the new probe ordering to remove a perpetual -EPROBE_DEFER
> loop between the two devices.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c | 48 +++++++++++++------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> index 833f4480bdf3..f783bacee8da 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> @@ -639,6 +639,8 @@ static int rcar_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>                                         struct mipi_dsi_device *device)
>  {
>         struct rcar_mipi_dsi *dsi = host_to_rcar_mipi_dsi(host);
> +       struct drm_panel *panel;
> +       int ret;
>
>         if (device->lanes > dsi->num_data_lanes)
>                 return -EINVAL;
> @@ -646,12 +648,36 @@ static int rcar_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>         dsi->lanes = device->lanes;
>         dsi->format = device->format;
>
> +       ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
> +                                         &dsi->next_bridge);
> +       if (ret) {
> +               dev_err_probe(dsi->dev, ret, "could not find next bridge\n");
> +               return ret;
> +       }
> +
> +       if (!dsi->next_bridge) {
> +               dsi->next_bridge = devm_drm_panel_bridge_add(dsi->dev, panel);
> +               if (IS_ERR(dsi->next_bridge)) {
> +                       dev_err(dsi->dev, "failed to create panel bridge\n");
> +                       return PTR_ERR(dsi->next_bridge);
> +               }
> +       }

Can we use the new function devm_drm_of_get_bridge instead of the entire code?

Jagan.
