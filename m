Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F734AB9F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382463AbiBGLTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356831AbiBGLOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:14:00 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE194C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:13:59 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y129so2452792ybe.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBzDSSm0EEu8YlwYiGk806GwlAAQU2Z/FUPe+VsHFPA=;
        b=T/7wk3lO80aq3pJAtt4RGGIjIj2b9Fn7bwJosVKg/h32AYZ2dA8jIvLd6pmEiKsrw7
         d+wRNFaNRZgeFoOrIEg+/gDqwSn6WDA/ATztazmIrrCq+wbxfPxxQUH9LMjJ9si8qxfo
         b0EqWsW8j3n1LomWc2M8apSfSQxLrg+IdJK6kUJGejyH93NZ782fiQUsw+1shoSxVmpR
         9+jlwSU6zfSRnerI+0rcxUuO7U1Qd/6Tp+kjfYQWtmsiY0SmJb74PJgtL3uUbqpfMeLk
         GRj6KOTpjPRrRJHDrLOxTSpH1OpmLB9ZEtpJTLACHxwWTVpJk+5BIPwy5E3EndgtdwAX
         AiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBzDSSm0EEu8YlwYiGk806GwlAAQU2Z/FUPe+VsHFPA=;
        b=ic3FoAAqBiKsKq4ZsR6+8/1h9Xi9Qpqse4DpC3XgeNNTKNKKqAwQUg3yD30f2kt+eM
         e4ZP01BUcuB5BXS6HgtBdVSCc+xnFtMjnbbluWKiXEPKlLvTBxSaKkmsDA/sYPncZdYn
         ZLkWu1rtBlg1fMJCY3TgIruS/g6+PUAF3pHBEawDBMKsZOgRf+gGYVO9AdJPpD9sxkRi
         sLMjpfa1U3kp5g3U/xZD4yt93ZVkVnK1lh6EzFapHlcHC3qP/FfFd9idBB7TWsgMtQqG
         s+XTbbjwDb2lnkAlUofO5Ppi6Y5+Pq2bS9OPxLDMKlTfwKdmF0Tea0nm//ROp6lT0Y+F
         bC6Q==
X-Gm-Message-State: AOAM532kmH6YXDBZ26K09HNXaDc9pMn/Vu8IMFWa1dtDGqzENUjLcltT
        h3MmZje1ouerdxpJqx3ojzIS5U1tX4btRUJouLFjEA==
X-Google-Smtp-Source: ABdhPJwgh41dih9zlPM7REbgp2M1RRBY3okeMOFFaelkW45rQiD2UpYI1Hy/ZYL6fCL22GHQ0lPqBGm073/jol8UNeg=
X-Received: by 2002:a25:1402:: with SMTP id 2mr9089323ybu.684.1644232438681;
 Mon, 07 Feb 2022 03:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20220203093922.20754-1-tzimmermann@suse.de>
In-Reply-To: <20220203093922.20754-1-tzimmermann@suse.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Feb 2022 16:43:47 +0530
Message-ID: <CA+G9fYtZ=HMdwk7entzU9sbBh3EPcOO8jGLDGV9BE5Qp0qvoww@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, lyude@redhat.com, linus.walleij@linaro.org,
        dianders@chromium.org, ardb@kernel.org, rdunlap@infradead.org,
        arnd@arndb.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, 3 Feb 2022 at 15:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> As reported in [1], DRM_PANEL_EDP depends on DRM_DP_HELPER. Select
> the option to fix the build failure. The error message is shown
> below.
>
>   arm-linux-gnueabihf-ld: drivers/gpu/drm/panel/panel-edp.o: in function
>     `panel_edp_probe': panel-edp.c:(.text+0xb74): undefined reference to
>     `drm_panel_dp_aux_backlight'
>   make[1]: *** [/builds/linux/Makefile:1222: vmlinux] Error 1
>
> The issue has been reported before, when DisplayPort helpers were
> hidden behind the option CONFIG_DRM_KMS_HELPER. [2]
>
> v2:
>         * fix and expand commit description (Arnd)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: adb9d5a2cc77 ("drm/dp: Move DisplayPort helpers into separate helper module")
> Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/dri-devel/CA+G9fYvN0NyaVkRQmA1O6rX7H8PPaZrUAD7=RDy33QY9rUU-9g@mail.gmail.com/ # [1]
> Link: https://lore.kernel.org/all/20211117062704.14671-1-rdunlap@infradead.org/ # [2]
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

This patch fixes the repored build problem.


> ---
>  drivers/gpu/drm/panel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 434c2861bb40..0aec5a10b064 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -106,6 +106,7 @@ config DRM_PANEL_EDP
>         depends on PM
>         select VIDEOMODE_HELPERS
>         select DRM_DP_AUX_BUS
> +       select DRM_DP_HELPER
>         help
>           DRM panel driver for dumb eDP panels that need at most a regulator and
>           a GPIO to be powered up. Optionally a backlight can be attached so
> --
> 2.34.1
>


-- 
Linaro LKFT
https://lkft.linaro.org
