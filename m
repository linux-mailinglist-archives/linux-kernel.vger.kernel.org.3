Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43BC4904EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiAQJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiAQJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:30:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:30:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l21-20020a17090b079500b001b49df5c4dfso3056924pjz.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CypZ2O0aOlLYoEWjzj8LBaIlTHfP284kF/aI9kD9Oi0=;
        b=F0lYJHcNkJ4Tt8/+tLCR2AdNzLJeYYHixlTpRYn8nq8A9eQ3MC/AqMUv2sQY54+FCk
         MbElzvIO5ON3FF2RMklVS3uFQVF/GVEYjbiS8OMTm2km4AMVFNeERUFC8RRh9Z9TgZEu
         pTWbldJd/DlasbIpzIkbkviL7rPcKjrksiIUtgaoJfwRtHhTeyNJMdIZ3m6kqftr52vH
         Yd66AK6GGfA7Np9TU/6M6V8mAXVwQV7N2vpm2qMTi2ygJ91yrZw0Kp5KkiZPIPh9ApHv
         HkMr9OJbH77gY3ihOVAzdmW2dSaDkURsBx1/fcPzjXT00zhg2/K8/dk6/0PWQ1Qxf6Y3
         J0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CypZ2O0aOlLYoEWjzj8LBaIlTHfP284kF/aI9kD9Oi0=;
        b=pNTjxdd1FN/OdMZ/F3AV85hagQWS6U64kxuTUHqG4g0Q+PKJHXPTtpsGZMRn3ipzwp
         G7NkacfeZz2SvK0PNi9vde9O52BiVK4vpkFidgVvCXZUj7S3K8u9zvouP2ZSQ+F53qW7
         c9toTAFR46Gekj9CXs7fqEjTHbUqXV6CWMeBBfP3/zKBk1+IffkAWP8sbi+tyvyiRLo8
         cmJ5Hcq9OCFFfd8tgjoDjCccBxkY636/wtQA4loB7UAemYqm20fo66X44giOE4c6OORM
         6WvOWNch/zBonJgdvOFqTfzjEIUp4KW5H8mdsAe0VUjFzjdRyrkH3aRmodGORn6LRqz7
         njmQ==
X-Gm-Message-State: AOAM532JYBpXGDwdtRpD9eZb40XQVk5PZc2oMc72A+qimeTCPvmNPxSQ
        wKlCSvj3yojimX6FSVdQCXRFdw28qSoLXdQgM6sexOXLBxZe8w==
X-Google-Smtp-Source: ABdhPJxK0U9MlTiUUxHtfSgC3lqiJHtxmlZTFYZyL0/lOpEOPkoo9p85ByTfesogvIVuCUA+0pqLXr+igjTH2NjHqdU=
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr17855889pjb.179.1642411831985;
 Mon, 17 Jan 2022 01:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20220117052146.75811-1-julianbraha@gmail.com>
In-Reply-To: <20220117052146.75811-1-julianbraha@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 17 Jan 2022 10:30:20 +0100
Message-ID: <CAG3jFyvs_J218R0q=geUaO7V25bkdu_zjW7GMKBoP+phHnXACQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm: bridge: fix unmet dependency on DRM_KMS_HELPER
 for DRM_PANEL_BRIDGE
To:     Julian Braha <julianbraha@gmail.com>
Cc:     narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jagan@amarulasolutions.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 at 06:22, Julian Braha <julianbraha@gmail.com> wrote:
>
> When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
>   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
>   Selected by [y]:
>   - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]
>
> This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
> without depending on or selecting DRM_KMS_HELPER,
> despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.
>
> This unmet dependency bug was detected by Kismet,
> a static analysis tool for Kconfig.
> Please advise if this is not the appropriate solution.
>
> Fixes: ce517f18944e ("drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge")
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> v2:
> - changed from "select" to "depends on"
>
> v3:
> - new line now uses tabs instead of spaces.
>
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 61db5a66b493..a1b52eaf26e0 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,6 +30,7 @@ config DRM_CDNS_DSI
>  config DRM_CHIPONE_ICN6211
>         tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
>         depends on OF
> +       depends on DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL_BRIDGE
>         help
> --

Applied to drm-misc-next.
