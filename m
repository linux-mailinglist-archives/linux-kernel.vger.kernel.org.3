Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684DE4A9521
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356817AbiBDIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:31:12 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:41793 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354453AbiBDIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:31:09 -0500
Received: by mail-ua1-f54.google.com with SMTP id w18so6282680uar.8;
        Fri, 04 Feb 2022 00:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LkLCh9tgcGFKu8QRYGFG/lHSI3FKQNh68/jvHDjNJA=;
        b=sMXCtkZXutuXmeiaaxfsOfjVniAGJ5s18B0hci7ExQE5kXuR/6jZpTe6GJL0yT+LSM
         4prTI6h3nju0sTAvvHZfYejA8QHxBZojreeAZFgD4gm2tyu6sKkZrJJVaOLgD2K0Lm/N
         Rt0/bbFrGmqxRTugq7YPSopY54A0O+j6s6USe7ePIVoDKFLMm033pd+maCUUB71Re8+Q
         Qx2JTjTKlg1y9foAmRL2AXola6s2FQIqT+XGnqmxxycV7fpkm7bwHD32Q5Um5AGGrB2r
         cblZPuhqGnDohe2ap2ImUPtsbdA7l+YAJsfy4NmzEkPHlnMUoZLsrul2V3kMUN9xSObX
         tBdQ==
X-Gm-Message-State: AOAM532mlycewycQLrw4mU5xgoNDkn9n4OZ1tWtiZHPkU05d53TyxQNN
        1cUedLpmqliYP1PTF2UcsIQF0kGZ2VoVLA==
X-Google-Smtp-Source: ABdhPJyqLxW8X3j6VxHi8x73kcHaqhyjAl1kxYi0XIdlpRNnIl6vtyuKsYTRGj8uLQVBcecsonyxKA==
X-Received: by 2002:ab0:2411:: with SMTP id f17mr542585uan.125.1643963468424;
        Fri, 04 Feb 2022 00:31:08 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id n10sm267711vso.34.2022.02.04.00.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 00:31:08 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id p7so9621745uao.6;
        Fri, 04 Feb 2022 00:31:07 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr484417vsj.5.1643963467627;
 Fri, 04 Feb 2022 00:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch> <20220131210552.482606-22-daniel.vetter@ffwll.ch>
In-Reply-To: <20220131210552.482606-22-daniel.vetter@ffwll.ch>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Feb 2022 09:30:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUm76tT6u+i=A50ffh=k8hX5kgoMqH=t_wfHqH95nVOPA@mail.gmail.com>
Message-ID: <CAMuHMdUm76tT6u+i=A50ffh=k8hX5kgoMqH=t_wfHqH95nVOPA@mail.gmail.com>
Subject: Re: [PATCH 21/21] fbdev: Make registered_fb[] private to fbmem.c
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for your patch!

On Tue, Feb 1, 2022 at 9:50 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Well except when the olpc dcon fbdev driver is enabled, that thing
> digs around in there in rather unfixable ways.

Can't the actual frame buffer driver (which one?) used on olpc export
a pointer to its fb_info?

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -48,10 +48,14 @@
>  static DEFINE_MUTEX(registration_lock);
>
>  struct fb_info *registered_fb[FB_MAX] __read_mostly;
> -EXPORT_SYMBOL(registered_fb);
> -
>  int num_registered_fb __read_mostly;
> +#if IS_ENABLED(CONFIG_OLPC_DCON)

CONFIG_FB_OLPC_DCON (everywhere), cfr. the build failure reported
by the robot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
