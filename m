Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C202D46AFFD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhLGBrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhLGBrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:47:46 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628CCC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 17:44:17 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v64so36504093ybi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 17:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrU3KhtTgg381kj17PJrqccz0ypSCPSlO0sRdaZRzPg=;
        b=Nug4pPs9k6ecc/x/AL5gLUAspwxwOHkJOqReCL5hPRhvzCKYIhF0gWoHfIXobPwrMt
         igNZY/6Lkg4pIH8gm0d+8x6cx/y/V3NOBd9Cc48Prd/joFqf7+AJ36vvzlo5wCfca+jO
         u6wtbs4t3E9qqM6LZfN0LoWp5fGGSXGlx5Mog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrU3KhtTgg381kj17PJrqccz0ypSCPSlO0sRdaZRzPg=;
        b=8GWuS5IXCiuKWc3jMrMXGAE5N9jtyhcdsgX6VJOOvi9iZ6XgCqUQduKZ3cQiru6v80
         KvCdUVj77omQfB7WPsh6sKfz3aAxesU7siR4xtoeTJk+p2JIEQmS/UL6j+o9fwUOx3uk
         jjUTEWraQgX/UyG0co79KAUbayn0/joLoSY1VCZN5NrAjDC2DnxYQVLAOh2mXz5doM1I
         LMLqd2CntJmXRPB4nIUEaTeF9783DlcMh4r6fqS1BiOsEXsEtFnilq8NJ4bBjDqSN0pA
         m+IXNx2EMA4hFjVmeLIp6DrmNFUl3TAWuhcIjZsMuCVcxFrbyhoqnUisMPGM8J1TqhGb
         dtTg==
X-Gm-Message-State: AOAM530vy6cwcqOlV17A7cbvhSIyTdEvdREYO2UedBgf6779sy56Gz30
        lTXuymoBQ4qND+YwUiIX6tG9s4LVdnpvUQf4XWUSQQ==
X-Google-Smtp-Source: ABdhPJxSgV6Tsffy+vfKun4mMv3o3NKstkB0DXF9fTRCw88ysIZ8VhEzI6QFuoT8dOek5FGvtAL6j+2jHDmTby4u5II=
X-Received: by 2002:a25:aea4:: with SMTP id b36mr49161795ybj.182.1638841456597;
 Mon, 06 Dec 2021 17:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20211206162907.1.I1f5d1eba741e4663050ec1b8e39a753f6e42e38b@changeid>
In-Reply-To: <20211206162907.1.I1f5d1eba741e4663050ec1b8e39a753f6e42e38b@changeid>
From:   Philip Chen <philipchen@chromium.org>
Date:   Mon, 6 Dec 2021 17:44:05 -0800
Message-ID: <CA+cxXhkmsUMCCJrvbz76nx-ctzSZhg0BFb50qD3nzUon3-Gp+w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Add backpointer to drm_device
 in drm_dp_aux
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Dec 6, 2021 at 4:29 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> When we added the support for the AUX channel in commit 13afcdd7277e
> ("drm/bridge: parade-ps8640: Add support for AUX channel") we forgot
> to set "drm_dev" to avoid the warning splat at the beginning of
> drm_dp_aux_register(). Since everything was working I guess I never
> noticed the splat when testing against mainline. In any case, it's
> easy to fix. This is basically just like commit 6cba3fe43341 ("drm/dp:
> Add backpointer to drm_device in drm_dp_aux") but just for the
> parade-ps8640.
>
> Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 26898042ba3d..818704bf5e86 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -449,6 +449,7 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>         if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
>                 return -EINVAL;
>
> +       ps_bridge->aux.drm_dev = bridge->dev;
>         ret = drm_dp_aux_register(&ps_bridge->aux);
>         if (ret) {
>                 dev_err(dev, "failed to register DP AUX channel: %d\n", ret);
> --
> 2.34.1.400.ga245620fadb-goog
>

Signed-off-by: Philip Chen <philipchen@chromium.org>
