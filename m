Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7A485770
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiAERl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbiAERlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:41:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF3C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:41:21 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so6909686pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzQ72BBdlbIwljQ9GmIvY1Y0Vph95fp3b2f0mlNY2ig=;
        b=E8W/mM5tg4uMQl+gYVBTsmLjT8y0cxNDt0JmMghEnL77yQqHQnUAuXH1cOLGRCpVqj
         MLRzKva/JfvhYIK5VRk+A+nwDfSMdZrPy7W0PoULQn2fZvRFiy3F6cCIcpAgZ5EfsGnj
         AQOTipQ6XY0wPu3WcTsTGpu1O5KHxTzYWJzB2Y7MZockAGO519UOaSa4WQTKgGyyVitq
         oNw3kKHcEcpatxlGscm+A6lys3gpHRtzBm5fulOeXypFtty+GT573xjUDkQG2E+NheI4
         KZJJO4SVSI6xX5583UYEXaPUHbRbKoDpqtQIOr/42ivp6/0yExbE8Qpw0CWX0GEZ1U+O
         G73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzQ72BBdlbIwljQ9GmIvY1Y0Vph95fp3b2f0mlNY2ig=;
        b=7G0Z2E4KQsgKEVhTrsZaA85EJDHxFO947NO6pruWXHs4M10Su0F9KPPBhx4chQjn3m
         DZk630qkF27WvUceSQmKrpgCZtvxbOAz4BzqxIIRAwSxD3zs9rC4v+4z4VIgvYCaPRQM
         2w/7pu6cLYpdb+K/mLqhJzDqv5oZjt3hnFBztkBCDACKboaWn3Ske09VuH76f64tbfTm
         EMfR0aPE3x3VOK+q13z+FZPPwe6fyczU3pJm3sJ1WYMOYD8ko/GBg3vWz2PVhtHn28ZL
         S1RBgAtkEv1nwS8frhuhxzqiUN/qDHHnkK+hR0gmL9j1zZjXawEseyP7K7MA1FFouHw9
         Y+8Q==
X-Gm-Message-State: AOAM530BzdG7lswvznpf/7CFYhTEnla7RzRATspKYBda8Tq2oi+Pk/ru
        7TfeQC7K+T85Ic9vz66wIaXj8jxVgoWWRSRjmfODRA==
X-Google-Smtp-Source: ABdhPJxN8ppKSK8GXuZut/tPMjou6EwYIg6LidumtfgGEZel8tmkV9qHTU80LjGPle7XoYStcasMHA7FIbBkapv5XUA=
X-Received: by 2002:a17:90a:5295:: with SMTP id w21mr3113121pjh.179.1641404480159;
 Wed, 05 Jan 2022 09:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20220105104113.31415-1-linmq006@gmail.com>
In-Reply-To: <20220105104113.31415-1-linmq006@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 5 Jan 2022 18:41:09 +0100
Message-ID: <CAG3jFysAF8EvNZYwZYi4XYg9PG9quQCN=rDmsReS=bwvgLJ-Nw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Add missing pm_runtime_disable() in __dw_mipi_dsi_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Thanks for submitting this fix.

On Wed, 5 Jan 2022 at 11:41, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> Add missing pm_runtime_disable() for __dw_mipi_dsi_probe.
>
> Fixes: 46fc515 ("drm/bridge/synopsys: Add MIPI DSI host controller bridge")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index e44e18a0112a..56c3fd08c6a0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -1199,6 +1199,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>         ret = mipi_dsi_host_register(&dsi->dsi_host);
>         if (ret) {
>                 dev_err(dev, "Failed to register MIPI host: %d\n", ret);
> +               pm_runtime_disable(dev);
>                 dw_mipi_dsi_debugfs_remove(dsi);
>                 return ERR_PTR(ret);
>         }
> --
> 2.17.1
>

Added r-b tag and applied to drm-misc-next

Reviewed-by: Robert Foss <robert.foss@linaro.org>
