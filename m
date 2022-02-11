Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C34B2591
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349954AbiBKMYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:24:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiBKMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:24:08 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B5DC3;
        Fri, 11 Feb 2022 04:24:07 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id u134so5221540vsu.8;
        Fri, 11 Feb 2022 04:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sjk1d99Bi6DMu1w/ZtC6Jgj+o43T7072qer7CkYT+IA=;
        b=IDABzAEuvUOqXcg6I85tbruXJ19fIP61nHjenawqclCfSdCmqPTMNw/3hr2NW0fSHS
         ImFmewrguVdCj9iXeA/nAUwjeTLNckHcpJoKYpej2DaXMETwrx7kUD6URnuQstRcUr/w
         KiKqcuWY5M2QcwJkVag29Lkqq7EQS9lmvPzkalau29ucOaM8l13pyiM6zEYXorVGuu1I
         UmtHHiqzzQRT48QecoiaX4dmTxWIiCahwZ3lmDGBbxgCi2E0JIgsbmGcFB3mvKzVUYsq
         yWtEIoMoqtAFNKERrMj2lmBq1EKAxOyBEWIo7wAyrDLdA+dehdCR0So8N6+BknmrOUfT
         tZPQ==
X-Gm-Message-State: AOAM532H3N22AfzrYdtCKIjoHVPm2IXXejYiypJIgLVgJmSM8AUqac3i
        i3JD0H0kl6tR0aa7Cpsu9CqngZbP2OUf7w==
X-Google-Smtp-Source: ABdhPJwVHpEBkAd9vScaAcxXnkM22TrJn7k/6UfPWEbnsOWwSM3nT0qh/PIGbcQvFVQPmV+ukuFBEA==
X-Received: by 2002:a67:d704:: with SMTP id p4mr405397vsj.4.1644582246736;
        Fri, 11 Feb 2022 04:24:06 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id i17sm146214vkk.35.2022.02.11.04.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:24:06 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id g18so4602748uak.5;
        Fri, 11 Feb 2022 04:24:05 -0800 (PST)
X-Received: by 2002:ab0:384c:: with SMTP id h12mr396518uaw.122.1644582245661;
 Fri, 11 Feb 2022 04:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20220211091927.2988283-1-javierm@redhat.com> <20220211091927.2988283-4-javierm@redhat.com>
 <YgZJpi4llqr93U9Y@smile.fi.intel.com> <eed8200c-7716-ce4f-dac5-bd6f0345b631@redhat.com>
In-Reply-To: <eed8200c-7716-ce4f-dac5-bd6f0345b631@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Feb 2022 13:23:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLmUwgCWui4OiZqvqpVWzA-d9QhjZLa_idgC19XeEEjA@mail.gmail.com>
Message-ID: <CAMuHMdVLmUwgCWui4OiZqvqpVWzA-d9QhjZLa_idgC19XeEEjA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] drm: Add driver for Solomon SSD130x OLED displays
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, Feb 11, 2022 at 1:06 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 2/11/22 12:33, Andy Shevchenko wrote:
> > On Fri, Feb 11, 2022 at 10:19:24AM +0100, Javier Martinez Canillas wrote:
> >> This adds a DRM driver for SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
> >> OLED display controllers.
> >>
> >> It's only the core part of the driver and a bus specific driver is needed
> >> for each transport interface supported by the display controllers.

> >> +    bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
> >> +                                        &ssd130xfb_bl_ops, NULL);
> >> +    if (IS_ERR(bl)) {
> >
> >> +            ret = PTR_ERR(bl);
> >> +            dev_err_probe(dev, ret, "Unable to register backlight device\n");
> >> +            return ERR_PTR(ret);
> >
> >               dev_err_probe(dev, PTR_ERR(bl), "Unable to register backlight device\n");
> >               return bl;
> >
> > ?
>
> No, because this function's return value is a struct ssd130x_device pointer,
> not a struct backlight_device pointer.

Hence

    return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
                                 "Unable to register backlight device\n"));

?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
