Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDFC4B13DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiBJRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:06:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbiBJRG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:06:28 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464A6C10;
        Thu, 10 Feb 2022 09:06:29 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id m24so7172404vsp.7;
        Thu, 10 Feb 2022 09:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZ3cH0FU++BGKzJo9VuS5Ab2ppvdiiMqMLbf8RhGMsg=;
        b=Grg9wOHd1qWSZTkk9MEBIS0oN1exdpNjb/XEsByDNLKzAI9CiWXq1/DF+m98y/nMLm
         EIuQZUVo4LRpaPjfPjP0q//c2wuD3QwNi1NWW8Bg6qhaYkihmL67ghFpNt4HmkoKO09q
         YM9/acNt9zu7cfErtNvCI2hxKzJaO9sBQt561bdBWDERFsMlYJK08lzGMkw6LQSGQQeM
         GuWQEpdVxV1t62V/dAsXyTmId3hzFbhxMNsfrwQVNi4f1cQX+ttYTSElgERI6EFjx5+E
         V08u/2OoWKlr0l8pH4bQePdPy6IX6xf5sCwwG1D+EDY/ctnDTfTfOCvWmcR3OQatr5Pc
         1rdA==
X-Gm-Message-State: AOAM532raiOLcne/FCks9zIEOJC+uHpHxJtIpSpnuqBo3watOVe59f+h
        /MtK6X70PLsNhXi7ilij/ntyP6iHbWbgZA==
X-Google-Smtp-Source: ABdhPJztBpj2vO4DubXI/HAAhBknXIkKuEN8YhpvQDPxD9EiQOqDTWycowptsR1lFkYTkUaR5O53TQ==
X-Received: by 2002:a05:6102:c87:: with SMTP id f7mr2656595vst.49.1644512788382;
        Thu, 10 Feb 2022 09:06:28 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id z3sm201748vsk.25.2022.02.10.09.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:06:27 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id u65so2963940vkg.8;
        Thu, 10 Feb 2022 09:06:26 -0800 (PST)
X-Received: by 2002:a1f:294c:: with SMTP id p73mr2998419vkp.0.1644512786734;
 Thu, 10 Feb 2022 09:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20220209090314.2511959-1-javierm@redhat.com> <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
In-Reply-To: <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Feb 2022 18:06:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVKmfOAdTG70KF+eAw3noXHSGCPyGjw3cSVyQOvzUafhQ@mail.gmail.com>
Message-ID: <CAMuHMdVKmfOAdTG70KF+eAw3noXHSGCPyGjw3cSVyQOvzUafhQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
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

On Wed, Feb 9, 2022 at 1:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Feb 9, 2022 at 10:03 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> > This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> > SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
>
> [...]

> The logo is not shown, even when I create a 16-color or 224-color
> version of the small monochrome logo I'm using.

My mistake, I messed up the hook-up, causing it to pick a different
logo that was too large to be displayed.

Of course it's using the 224-color logo reduced to monochrome instead
of the real monochrome logo, as fbcon thinks it's running on XRGB8888.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
