Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DDD4A5881
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiBAI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:27:14 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:46663 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiBAI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:27:13 -0500
Received: by mail-vk1-f172.google.com with SMTP id z15so9908934vkp.13;
        Tue, 01 Feb 2022 00:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SL60kCkTHbJ0ciU93JjSYQJvykyB9X+JDddxZwvjxkc=;
        b=qqbagf06UgZq+v9EoU1mbrP0CKahh59Gr0Z7byOcS337FBcyuxfDhKyoqbjJ/ag56p
         ip3hIj2bOSCFVmKvwVOyrpO9yfqmsDiohNWodkkmg73LQZEuCktKTx0Qo/XWJ+tM6Rqp
         jmvBRSEkE+ovSn4L8WquQXRHeAXg+slOHesenmRy7JyOtkjmD1fAIwL3wkffGegOq1/Y
         sdNubJ3kRIfWvbB+RibBgMzkVXTvTk3Cs/VufhBa6I3K8SjetAziR3nC6tNs1W1wVhbK
         oSHfU03O/9+uxtaxbJ3tkw+AtV+17xInAzSbJp5zGp+vV+wrTX5FJPz5F6FF53inDNwP
         1FUw==
X-Gm-Message-State: AOAM531AdeupSQMgKTOR2f2cTKu4karrZR3XIvHuVaOFnNmPxGby5y8V
        45rpPqo0ljguNdxE4k80aUwdYr5L48nrHQ==
X-Google-Smtp-Source: ABdhPJyAWHr4kpBfmnOTGD2VqNM76Ug6qgA6m923+ovQ6nVVBxaMYRNkzaUsnfIxw6EnbwuZQXmJKQ==
X-Received: by 2002:a05:6122:181a:: with SMTP id ay26mr9638551vkb.5.1643704032521;
        Tue, 01 Feb 2022 00:27:12 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id u23sm3833107vsg.25.2022.02.01.00.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 00:27:11 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id p7so13400233uao.6;
        Tue, 01 Feb 2022 00:27:11 -0800 (PST)
X-Received: by 2002:a9f:3b19:: with SMTP id i25mr10161571uah.14.1643704030886;
 Tue, 01 Feb 2022 00:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
 <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
In-Reply-To: <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 09:26:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
Message-ID: <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Simon Ser <contact@emersion.fr>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 9:39 PM Simon Ser <contact@emersion.fr> wrote:
> On Monday, January 31st, 2022 at 21:36, Simon Ser <contact@emersion.fr> wrote:
>
> > This driver only advertises XRGB8888 in ssd1307_formats. It would be nice to
> > expose R8 as well so that user-space can directly produce suitable buffers.
> > It would also be nice to have some kind of preferred format, so that user-space
> > knows R8 is preferred over XRGB8888.
>
> Hm, since the format used by the hw is actually R1, adding that to drm_fourcc.h
> would be even better.

What's the story with the Rn formats?
The comments say "n bpp Red", while this is a monochrome (even
inverted) display?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
