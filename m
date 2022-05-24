Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F05331CA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiEXTfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiEXTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:35:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AEA71D81
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:35:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rs12so25651961ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5KRQHImvI/tYSdBDQbI9GMJc2P/tsNajyqMmtD5wxo=;
        b=XE0CIXorHdxCgnuHgrTrqm4dq2TJ2M+FH4GWF8HkROFgbaeiBVLPYR7CyGfdj28odV
         QTk2uqI5KeXZ4M1G1nH//7iKOGE+BJmEaELazHotLhs4c65EO0JnIiIjVp5DXa1xO9gc
         DTZy1O06USE5xoZY3C1QoR7qK/9CcOks1vdjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5KRQHImvI/tYSdBDQbI9GMJc2P/tsNajyqMmtD5wxo=;
        b=X90jztd8kUnjEHbutp8X4RLCZr/lboILz6XEzzSqZ2kBOlTLmu7XeJ5O8srRvc2r5G
         jlCMbGnwdEowW1/pcs7hoZQDdqrrdjwMDjyl2UAkR9dk8Mg+jPHC5/qP5MlFIuI4nPk+
         baW7L9CrMuSUfCxe6AF2kYOdNzJXwmc5J1kxsI2SluCTPPJcRk2Xow3EbVdnJv0pHw9B
         Ioa8mQCRDdE5N+upsOdIekAyqmxuno2mr+byienwulE1qnvrTfKmmTFr8109QMKleCvr
         AH4NtlRSD22Ts7poPpfBpTrM2L96fatryBMzQEtYuu4PHNTul3nj4M6XrG72Uwo/tCEz
         wIkQ==
X-Gm-Message-State: AOAM533pCKALaWJ3atPb2JHg3DB1saa4VqKE43ydWrHSWcih9pMVdgfx
        4LZhkwEmZSt9+URp9RjVFNlLVYfDeCuTIFKTvs8=
X-Google-Smtp-Source: ABdhPJzgEFR/V1an/7Qzf7E7SG2orD+bNttG99vxLunSPaReFecmX39+3GAfXhgE3Xfhsx7DtMlXMA==
X-Received: by 2002:a17:906:25d8:b0:6fe:9f11:3906 with SMTP id n24-20020a17090625d800b006fe9f113906mr22332509ejb.538.1653420907702;
        Tue, 24 May 2022 12:35:07 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709067ad000b006fed8dfcf78sm2737273ejo.225.2022.05.24.12.35.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 12:35:06 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id z17so4345053wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:35:05 -0700 (PDT)
X-Received: by 2002:a05:600c:acf:b0:397:345f:fe10 with SMTP id
 c15-20020a05600c0acf00b00397345ffe10mr5160653wmr.15.1653420905484; Tue, 24
 May 2022 12:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220523060658.737-1-gaochao49@huawei.com> <20220524024551.539-1-gaochao49@huawei.com>
In-Reply-To: <20220524024551.539-1-gaochao49@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 May 2022 12:34:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8==K6fA+CkmTcdLndB31vZHxsN7aBqRQocHM_rSr2iw@mail.gmail.com>
Message-ID: <CAD=FV=X8==K6fA+CkmTcdLndB31vZHxsN7aBqRQocHM_rSr2iw@mail.gmail.com>
Subject: Re: [PATCH v2 -next] drm/panel: Fix build error when
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m
To:     gaochao <gaochao49@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, zhengbin13@huawei.com,
        Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 23, 2022 at 7:46 PM gaochao <gaochao49@huawei.com> wrote:
>
> From: Gao Chao <gaochao49@huawei.com>
>
> If CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m,
> bulding fails:
>
> drivers/gpu/drm/panel/panel-samsung-atna33xc20.o: In function `atana33xc20_probe':
> panel-samsung-atna33xc20.c:(.text+0x744): undefined reference to
>  `drm_panel_dp_aux_backlight'
> make: *** [vmlinux] Error 1
>
> Let CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 select DRM_DISPLAY_DP_HELPER and
> CONFIG_DRM_DISPLAY_HELPER to fix this error.
>
> Fixes: 32ce3b320343 ("drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Gao Chao <gaochao49@huawei.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v1->v2: fix Signed-off-by name
> ---
>  drivers/gpu/drm/panel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

The patch this is "fixing" is in mainline so theoretically this should
land in drm-misc-fixes, but it gets messy because it would need to be
adapted because commit 1e0f66420b13 ("drm/display: Introduce a DRM
display-helper module") isn't in mainline. Since this doesn't feel
urgent, I'm landing this in drm-misc/drm-misc-next.

a67664860f78 drm/panel: Fix build error when
CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m

-Doug
