Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE694AD62C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357451AbiBHLWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiBHJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:39:58 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B2C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:39:57 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id l14so9389324vko.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZ5YoyypaVIdNJWNBuLZoYFhoOEVTGQBx0XSyV/K64g=;
        b=jeyr0wuPVimQL0N8PbP6BFhZ3a2R5bQH4kwC87gq6i/LZnldDGPmh3/YESeyUuFlbX
         vXiyR9iBvdc7HbkTof3iGd4b717M9sRYwL27JRPWFEssWJ2ecaE0Ol1j2GmCygZGn2am
         HOwkLe0HANyrkghwVAfpjn3PnE+hHBXOQniz4cLJtfgpCAy5qqbgyEWajaZ7krO3GLIV
         rObrA72+aKAURZJSwV+MZeWqOR5LU5QwEFttf3VPgoGb63FXQVSoKlWrZrQb23v63u/h
         Q3EgNhxZpds5V2osZcTxxs9Tv01glbND/kt9Oaf4cBVBh6FUz2ku0MXsqDwCHrpj9TGn
         VRKA==
X-Gm-Message-State: AOAM531EwJv7VrKxi0DURTz2v7rW3zdgNAcXhxp7CKt/Vo+OwC/uOV4R
        YNAVButcLGS9GWKfp8dIXW1tCth1A9XelQ==
X-Google-Smtp-Source: ABdhPJw1ivY13u6iKbBhQWUi/zuhCXaaU9/3fVVSEhZuVNrHJ8Wv5TLnZSnbEEyhJIOCpIJhmzXh2g==
X-Received: by 2002:a05:6122:218f:: with SMTP id j15mr1321825vkd.20.1644313196491;
        Tue, 08 Feb 2022 01:39:56 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id u23sm2512202vsg.25.2022.02.08.01.39.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:39:55 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id t10so2697775vsp.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:39:55 -0800 (PST)
X-Received: by 2002:a67:fd63:: with SMTP id h3mr1094926vsa.77.1644313195369;
 Tue, 08 Feb 2022 01:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20220203093922.20754-1-tzimmermann@suse.de>
In-Reply-To: <20220203093922.20754-1-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Feb 2022 10:39:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWykWR4oKahC2GYF5jG4przRQ+MxNNm1BK7o62OhhGYwA@mail.gmail.com>
Message-ID: <CAMuHMdWykWR4oKahC2GYF5jG4przRQ+MxNNm1BK7o62OhhGYwA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Feb 7, 2022 at 12:31 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
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

Thanks for your patch!

This fixes the build errors I'm seeing, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
