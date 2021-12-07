Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B267246C49A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhLGUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLGUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:30:35 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A098C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:27:05 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i9so237468ilu.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8JlKV57a9V9sennPSYrTCjGTKh7q+B4XLkSCRyp0vI=;
        b=OyGGu7hDrNO24qeRpn0VzEiM2XdNfaluplhUq7WJQBiujEgb4/TREnIV8iBagDU5p7
         QASEKmnW0keiTwY9shZye/JhmIPsRdveSJX8ZK1d7EgAPI3fgLsqyR+0mgRg37okek52
         BEYSA5oYOq0+9DrS+y3nspapqAJUqL3DTFuoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8JlKV57a9V9sennPSYrTCjGTKh7q+B4XLkSCRyp0vI=;
        b=SZuB8/e4UGxKFEqEkWP7s/++z/6ecsX1dm0v7iPloSpObg39Au0E+1aBhCHUNoWT/O
         W26kAlwIghb3a83XlWHuLeEC1xKKkG33DNStLYuDUK1bVQbUAdhPZH5f5Z0Xcm6Acczi
         y8B1stgTVKMpk+cGk7vGHHXdcZS2ZDJwn14NPQVl2WT7WvU5Pg/ebr6rtps/Dv+2Cp3H
         lyaDgadtzCNosxDOf7h5zWEqyb6UONoutBdo4Us4EsKIRT1K6IYCwJGWp0WT/szkJ5QM
         yql3f5fxY9avFU7nLl2/BYTt7Iqmtj4GhGnGfmXzgvIG+T2LqARzasiDlrg3GbrvpQvq
         C7ZA==
X-Gm-Message-State: AOAM531A9cewlcRdSP99dUBAROhDPFbxWygBMb3vhfgeRYKGA/14Ji7c
        C+L+A6tCl9IM46+ajncNYdAbn5h/k+xXIQ==
X-Google-Smtp-Source: ABdhPJyVF2bEMj7nPKoNoePESYko20pxyBDZQiaUxw4Wo8rjdbL8RKKhtIybKO7sRa6RRIyZtLW4dg==
X-Received: by 2002:a92:50a:: with SMTP id q10mr1793890ile.23.1638908824487;
        Tue, 07 Dec 2021 12:27:04 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id h12sm563351ila.81.2021.12.07.12.27.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 12:27:04 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id m9so517972iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:27:03 -0800 (PST)
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr1821503iov.98.1638908823019;
 Tue, 07 Dec 2021 12:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20211207200906.609673-1-robdclark@gmail.com>
In-Reply-To: <20211207200906.609673-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Dec 2021 12:26:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X81r4eBPYz_v6vju8bpUJX+HWS1vUuO+oC0AJUWsnCRg@mail.gmail.com>
Message-ID: <CAD=FV=X81r4eBPYz_v6vju8bpUJX+HWS1vUuO+oC0AJUWsnCRg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: sn65dsi86: defer if there is no dsi host
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 7, 2021 at 12:03 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Otherwise we don't get another shot at it if the bridge probes before
> the dsi host is registered.  It seems like this is what *most* (but not
> all) of the other bridges do.
>
> It looks like this was missed in the conversion to attach dsi host at
> probe time.
>
> Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 02b490671f8f..3684e12fbac3 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -716,7 +716,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
>         host = of_find_mipi_dsi_host_by_node(pdata->host_node);
>         if (!host) {
>                 DRM_ERROR("failed to find dsi host\n");
> -               return -ENODEV;
> +               return -EPROBE_DEFER;

Can you delete the DRM_ERROR line?

Thanks!

-Doug
