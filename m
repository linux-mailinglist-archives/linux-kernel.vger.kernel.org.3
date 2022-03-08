Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1134D1D34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348306AbiCHQcK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Mar 2022 11:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiCHQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:32:09 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6556750447;
        Tue,  8 Mar 2022 08:31:13 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id o22so6941220qta.8;
        Tue, 08 Mar 2022 08:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HwPCO4dFtjlzDdsvWKkUtYlqbyqtlLf5x449OlOiOMg=;
        b=flF4EFmiN6adgDdN95mu9drNHiRQIyXgbOzZlocqbpQbqi4F2M6WXZre09p/UNIKat
         z/rzYzw//insFZC+/BgV4qLD3aBSuE84URQo8ws6gj5IyAeSQ3YCWYjm5Nd9dMnjFGrD
         +FkRDxN/FhkKqdJep0MknipOAHos34vEinlfXM1CmkfBTFZFbFGcngoSNxxNE3LPIzRF
         4h2pBC0iFxCgjkuBjdinsQBtd6jDrfb0L3WXu9nZ/sBao7KScnDoMh3byEUdMIirRoQM
         V/MafWVwoJQNZ3Ud4v5XLG+U4Qg+CBohuIcQuuJ0vCa82GNEwIdg1WjFOE9c1kH0ywxK
         nPHg==
X-Gm-Message-State: AOAM532XUoDliExzBtpz2yvK6ABPLu/qJWwEfsMLULSB4SmbHrPDa+FV
        rJpbgNLM08nqh2qVGXDy1DDJd+d9RvIXCA==
X-Google-Smtp-Source: ABdhPJzpZGj+QXiThFtPfMH59R0Yms1F8RA5FP+ZWIT61/2ysdWDLgFlpjoLinr0xhe5sw9U6mNIUg==
X-Received: by 2002:a05:622a:40a:b0:2e0:7235:f7a9 with SMTP id n10-20020a05622a040a00b002e07235f7a9mr2493108qtx.500.1646757071301;
        Tue, 08 Mar 2022 08:31:11 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id i192-20020a379fc9000000b0067b314c0ff3sm2724148qke.43.2022.03.08.08.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:31:10 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id g26so38813742ybj.10;
        Tue, 08 Mar 2022 08:31:10 -0800 (PST)
X-Received: by 2002:a25:8486:0:b0:619:9fba:895e with SMTP id
 v6-20020a258486000000b006199fba895emr12806820ybk.342.1646757069990; Tue, 08
 Mar 2022 08:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20220214133710.3278506-1-javierm@redhat.com> <20220214133710.3278506-4-javierm@redhat.com>
In-Reply-To: <20220214133710.3278506-4-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 17:30:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU+29x4ZHLAiPiReyLKw_VYBCCLw0bCoQmw9s6sQ4Bxcw@mail.gmail.com>
Message-ID: <CAMuHMdU+29x4ZHLAiPiReyLKw_VYBCCLw0bCoQmw9s6sQ4Bxcw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Mon, Feb 14, 2022 at 2:37 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> This adds a DRM driver for SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
> OLED display controllers.
>
> It's only the core part of the driver and a bus specific driver is needed
> for each transport interface supported by the display controllers.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch, which is now commit a61732e808672cfa ("drm:
Add driver for Solomon SSD130x OLED displays") in drm/drm-next

Sorry for the delay, but finally I gave it a try on my Adafruit
FeatherWing 128x32 OLED.
Some of the weird issues (cursor disappears after printing some text,
more text also doesn't appear until I clear the display) are still there.
Unfortunately a regression was introduced since your v3: printed
text is mirrored upside-down. I.e. "E" is rendered correctly, but "L"
turns into "Γ" (Greek Gamma).
I suspect something went wrong with the display initialization
sequence.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
