Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A76484329
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiADORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiADORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:17:43 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7365C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:17:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso41034657pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCh2rgII3hbRw94echP2rRCkkf7dv31cKpRI8aiSXTA=;
        b=l1PuuWKzA4YNweLgk/f3pi3g7b816L7QVEBV0F33NTLz1JzxWTaf2rdltBVPpBjgYa
         tGiUu6ZcHojdAHpJU7syxiCN1Pq3Vnh6IKe2hjVS7oZzf5ODjG6JRUtZ0xTU37eyurI9
         OsljZimrHH1SVVxa0lF5flIjih1gMxTkc4wB3hG+pwZRvcB+gxyY9BZpfjSzD+ltvH9u
         t1NNAAdEorHJJFg1G2JnaBV/pzQvxyguVsV3tQoqCNwR41W7q/Ts8MvNpD9Snz1QE93L
         f//pCdW98dveSXJs9E6ovK9FV8jhzlqcTkjLtkVSG//IOjHfEC2EAn4td98TFfZoTUik
         f6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCh2rgII3hbRw94echP2rRCkkf7dv31cKpRI8aiSXTA=;
        b=FRhReRQWHGZvknCWCSaps8RAAaKkGzlNhTVYj1Drc5FBjfoj5CUBQisluMKhQv0XKX
         ZbOwfKScflPyMXhh5ZrDfzdW8PaZ87DdSdPlWSkDU5XWML9RYgBPy2UWP2miyuwDmsqy
         y1A5hfp4cn6xi/MebHhOTazTpBUIEXwsw3sGJ3N6AzwFUhjbW415ZmYgevKQu49xaNhW
         ST0NDBluHlWfyNeIDSlOzey+6FYWpTP494sgxPecWGE9A9ST/7WcXIvokdeC2INFpkqo
         LYfuDB7WU8jDwKUEr3ndx2BSlxlZVI3QwkpeJ/lXgsjpvztYS6szNGQZ3mcH14hBP/r5
         6CeQ==
X-Gm-Message-State: AOAM5303W1hD8R05rFj6AbQpjUfjvPTwkgk33fxfdGo4q8Cj1wByc5Wa
        NNgfia5e3Estvd71pc1roKGDy9rgkrvzCtSgiPaVAA==
X-Google-Smtp-Source: ABdhPJwDc7gBgmDrYJ15PsNoVnS2EGIzqnLgQ/NvooPZubtxchxczwltMUYunBj6IOSCZAVovVlg0oqzzWNjv2kAEbo=
X-Received: by 2002:a17:902:c40f:b0:148:f2e0:3f6e with SMTP id
 k15-20020a170902c40f00b00148f2e03f6emr48931658plk.65.1641305863209; Tue, 04
 Jan 2022 06:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20211130131113.126261-1-zhou1615@umn.edu>
In-Reply-To: <20211130131113.126261-1-zhou1615@umn.edu>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 15:17:32 +0100
Message-ID: <CAG3jFytSB4HtFs3CZuFsiE1LCX+1BDY6MPAWSBxPwjx88fUF9Q@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix a NULL pointer
 dereference in cdns_mhdp_atomic_enable()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Zhou,

Thanks for submitting this patch.

On Tue, 30 Nov 2021 at 14:11, Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In cdns_mhdp_atomic_enable(), the return value of drm_mode_duplicate()
> is assigned to mhdp_state->current_mode and used in drm_mode_set_name().
> There is a dereference of it in drm_mode_set_name(), which could lead
> to a NULL pointer dereference on failure of drm_mode_duplicate().
>
> Fix this bug by adding a check of mhdp_state->current_mode.
>
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
> Builds with CONFIG_DRM_CDNS_MHDP8546=m show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 5530fbf64f1e..347fbecf76a4 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2040,6 +2040,11 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
>         mhdp_state = to_cdns_mhdp_bridge_state(new_state);
>
>         mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
> +       if (!mhdp_state->current_mode) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +

This appears to be a problem that is handled in other drivers, but the
solution here does strike me as good.

The out-label will schedule modeset_retry_work to be executed if
ret==-ENOMEM. If drm_mode_duplicate() fails, we've had a memory
allocation issue, and failing is probably the correct solution here.
However cdns_mhdp_atomic_enable() does allow for signalling failures.

>         drm_mode_set_name(mhdp_state->current_mode);
>
>         dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
> --
> 2.25.1
>
