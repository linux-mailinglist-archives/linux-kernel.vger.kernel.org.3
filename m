Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330794983D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiAXPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:50:35 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:37482 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiAXPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:50:33 -0500
Received: by mail-ua1-f54.google.com with SMTP id b16so31784939uaq.4;
        Mon, 24 Jan 2022 07:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qn8yuU/dY9yzYdXTyBmgzczJZCif2R504KsT3GAaWuA=;
        b=EH/azo2n+xVnDTrSK+A4gHMd3HAcVFRhi2rB0XqKFePER29TQHaB5+Im9JWmRpcmtm
         56oCJLF1eM2V4nLGK3gBGslHm1XRCjctEg/Vpjz1To+gxO/yo6XKceNo+uU4l5f0utdf
         76nlIllAzZ4ZYiOkWTmJXGNkL1vks85UqmchxFbZi4Mbfhz4ZOvFTVEMVKhL9TZP2CPN
         O7J9xd0vt6M7AlRujnODdTzmxncosUE4ah2qGLeAh0yu6oUtZOTG4u84fx/Oe6ovIjCO
         pUgUOgauu1ch8oRMfVLNturACMV1306wR3nPqqazvfFGdaj9mG/NNZ78AZXz49ev6hHS
         JQKQ==
X-Gm-Message-State: AOAM533BaNM/EBbqV4w4rTwhP/vr7ZzqO46/q6Y3GPkN0C9KXSmkVhjs
        NuoAd0Venx3264koVUeF+KFrUMeo3IhSag==
X-Google-Smtp-Source: ABdhPJwRww2LRfHpBthtBVTM6QfehR063xCOsjJGa08Kmiojk9Hr6nhICQHyTXTowFCPafe7NQs3kQ==
X-Received: by 2002:a05:6102:5087:: with SMTP id bl7mr2439728vsb.22.1643039432296;
        Mon, 24 Jan 2022 07:50:32 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id y18sm2852168ual.15.2022.01.24.07.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 07:50:31 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id b16so31784769uaq.4;
        Mon, 24 Jan 2022 07:50:31 -0800 (PST)
X-Received: by 2002:a67:b009:: with SMTP id z9mr2526092vse.57.1643039430885;
 Mon, 24 Jan 2022 07:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de> <20220119110839.33187-3-deller@gmx.de>
 <YelyGDNDTn1Aq/hm@phenom.ffwll.local> <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org> <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
 <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de> <2fc200bb-4b40-7833-31c9-90a78512b601@redhat.com>
 <de6e06e1-f293-1c98-7898-b5d52c400b59@gmx.de>
In-Reply-To: <de6e06e1-f293-1c98-7898-b5d52c400b59@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jan 2022 16:50:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW-txqH1fnpkvyOSYUVkG8PTJKWkWFq_X8k-4VcdKR79Q@mail.gmail.com>
Message-ID: <CAMuHMdW-txqH1fnpkvyOSYUVkG8PTJKWkWFq_X8k-4VcdKR79Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
To:     Helge Deller <deller@gmx.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Mon, Jan 24, 2022 at 4:30 PM Helge Deller <deller@gmx.de> wrote:
> On 1/24/22 12:50, Javier Martinez Canillas wrote:
> > On 1/24/22 12:33, Thomas Zimmermann wrote:
> >
> > [snip]
> >
> >>> Thoughts?
> >>
> >> I can't say I approve keeping fbdev alive, but...
> >>
> >> With fbdev emulation, every DRM driver is an fbdev driver too. So
> >> CONFIG_FB_DRIVER is somewhat misleading. Better add an option like
> >> CONFIG_FBCON_HW_SCROLLING and have it selected by the fbdev drivers that
> >> absolutely need HW acceleration. That option would then protect the rsp
> >> code.
>
> I'm not a fan of something like CONFIG_FBCON_HW_SCROLLING, but I'm not
> against it either.
> For me it sounds that this is not the real direction you want to go,
> which is to prevent that any other drivers take the framebuffer before
> you take it with simpledrm or similiar.
> CONFIG_FBCON_HW_SCROLLING IMHO just disables the (from your POV) neglectable accleration part.
> With an option like CONFIG_FB_DRIVER (maybe better: CONFIG_FB_LEGACY_DRIVERS)
> it's an easy option for distros to disable all of the legacy drivers
> from being built & shipped.
>
> Instead of CONFIG_FBCON_HW_SCROLLING we could also choose
> CONFIG_FBCON_LEGACY_ACCELERATION, because it includes fillrect() as well...

As this is about resurrecting features indicated by the various
FBINFO_HWACCEL_* flags, what about CONFIG_FB_HWACCEL?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
