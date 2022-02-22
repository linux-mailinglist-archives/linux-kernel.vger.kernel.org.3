Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D74BF4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiBVJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBVJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:32:07 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2C49246
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:31:42 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id u10so20386509vsu.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9+nPoKijn+B5JvUYIGON25vpNUK9SwZAed4YYcFvJs=;
        b=OxfknFSKTM+Halj7QoCPLXU29kBce+8KsbSavrWfHyXdpMucnYoMG6+qLfkQXsbzd6
         VNEmwosmcPjPCGB0VwPIK7S8Esj71G93IStPH6eoAW2Qhsxyscl1fG2Q08VVmMhek6zl
         81B0pP2MpL5OpqkpBgKabR0sYEv0yWKrv/1lT5tfwSw8TWsSiocTuJF3qnq8+8yvvB2Z
         XOtnDKr7/RJA51Yo96Df9eBKOHn9HvKhD/KHzLpzRa4t8LRvWgCh4Kg1FrC+EYf4h0NW
         L4yDyigokgdI3SFxTS59SzACfpdikrMvYJIgUlaGMupSX3br8i5iBjMTDfoPdOqyfwFf
         FVYg==
X-Gm-Message-State: AOAM530khsSzPLZLYJzLoJWXgqYG34FMGCub0X9MSLJFCd9BMjGl+CQn
        TMdFB3e8wCle/f82qVtPRZVTpBSsMcf+lg==
X-Google-Smtp-Source: ABdhPJwF+oe0eaEJx4TXOK7R4knPjOhZP9MnouReGPJ4BlEgZinxW8fUU0qkHUHBkle7IQMLFgNYog==
X-Received: by 2002:a05:6102:158f:b0:31b:db2d:42c3 with SMTP id g15-20020a056102158f00b0031bdb2d42c3mr9938665vsv.10.1645522301763;
        Tue, 22 Feb 2022 01:31:41 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id v20sm2717845vkn.34.2022.02.22.01.31.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 01:31:40 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id j201so10050651vke.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:31:40 -0800 (PST)
X-Received: by 2002:a05:6122:114e:b0:32d:4662:65a8 with SMTP id
 p14-20020a056122114e00b0032d466265a8mr9828450vko.0.1645522300176; Tue, 22 Feb
 2022 01:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20220203093922.20754-1-tzimmermann@suse.de> <CAMuHMdWykWR4oKahC2GYF5jG4przRQ+MxNNm1BK7o62OhhGYwA@mail.gmail.com>
In-Reply-To: <CAMuHMdWykWR4oKahC2GYF5jG4przRQ+MxNNm1BK7o62OhhGYwA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 10:31:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXcRRgn4EMXn9qonnjTTp7EEfwP4F8FeVpLkQMNvB-6mg@mail.gmail.com>
Message-ID: <CAMuHMdXcRRgn4EMXn9qonnjTTp7EEfwP4F8FeVpLkQMNvB-6mg@mail.gmail.com>
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

On Tue, Feb 8, 2022 at 10:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Feb 7, 2022 at 12:31 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > As reported in [1], DRM_PANEL_EDP depends on DRM_DP_HELPER. Select
> > the option to fix the build failure. The error message is shown
> > below.
> >
> >   arm-linux-gnueabihf-ld: drivers/gpu/drm/panel/panel-edp.o: in function
> >     `panel_edp_probe': panel-edp.c:(.text+0xb74): undefined reference to
> >     `drm_panel_dp_aux_backlight'
> >   make[1]: *** [/builds/linux/Makefile:1222: vmlinux] Error 1
> >
> > The issue has been reported before, when DisplayPort helpers were
> > hidden behind the option CONFIG_DRM_KMS_HELPER. [2]
> >
> > v2:
> >         * fix and expand commit description (Arnd)
> >
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Thanks for your patch!
>
> This fixes the build errors I'm seeing, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Is this planned to be queued? This is still failing in drm-next.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
