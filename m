Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F13492523
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiARLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiARLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:44:51 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D025C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:44:51 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso11095668otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 03:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+NXps7/AMZd6p8CbfFu1xLGWKKhiZWwP/hikl7qUV8=;
        b=ZXMuh4JpPKQQn028vR5TW28RkJRq/wWREsIVr/rEShZKjMg/B7Z9jPda0Y+LON7jx4
         Lp1zlJGCIVdT6vqE1wktMASEE0B18XeZWHJkPEPITavWPstuRkYq9nVNCVJNlJ6rFpzd
         hlaFfUyjK1pYhhAjPmo7KoompJW6Jk7rmN/ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+NXps7/AMZd6p8CbfFu1xLGWKKhiZWwP/hikl7qUV8=;
        b=ga8KK6xp2sK/kuxTTZPmzjdsbNldL5Vq2WHWSjD03osJPrvEKvBTYeovyDdJUeBBV8
         Gl4DiY1NRnp2HsFeqBK1zBxVx7hz2Y3k03PrIZKpSqDQeuAuIDcWVhxePTxHCjpviW15
         MjjovjQG1FxTNi+/b2jcbuWY0XftoHn0PNFOg0zZlt2VqtaWOvD+VxnOOyngxM912aC5
         VMdFn0WKJM8tC0rUhCJ0yAjgy3+txLMQMIZS4w8jbV7dXPL8PcMlLNmo1Ei+cGcOCf9T
         VVeDuKDhTd1L7J99yRALtzUlJ+60aBEmxhpG1NLIGA2B1rgc4gyk7b/ag1RYoiAO0ggZ
         /fHw==
X-Gm-Message-State: AOAM530C1tL8k3x/saLe10veK6qNbSyNL94TV2zIF7SsrhU+zK7/GW6j
        SdziqbSO763zCqiXjLgMa8jFT/ulQm9cyRzVxPXB6Q==
X-Google-Smtp-Source: ABdhPJxbvQaGp+T6oYApy+hIHTb7hh7iMVhDsGckpsWeq9BaU3rN88FunYUfphQtcZoEenjamZA+BYQvRTrRz3ys6zk=
X-Received: by 2002:a9d:d12:: with SMTP id 18mr17457509oti.75.1642506290874;
 Tue, 18 Jan 2022 03:44:50 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
 <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com>
 <70530b62-7b3f-db88-7f1a-f89b824e5825@suse.de> <CAMuHMdW5M=zEuGEnQQc3JytDhoxCKRiq0QFw+HOPp0YMORzidw@mail.gmail.com>
 <57d276d3-aa12-fa40-6f90-dc19ef393679@gmx.de> <CAKMK7uE7jnTtetB5ovGeyPxHq4ymhbWmQXWmSVw-V1vP3iNAKQ@mail.gmail.com>
 <b32ffceb-ea90-3d26-f20e-29ae21c68fcf@gmx.de> <20220118062947.6kfuam6ah63z5mmn@sirius.home.kraxel.org>
 <CAMuHMdWXWA2h7zrZa_nnqR_qNdsOdHJS=Vf1YExhvs08KukoNg@mail.gmail.com>
In-Reply-To: <CAMuHMdWXWA2h7zrZa_nnqR_qNdsOdHJS=Vf1YExhvs08KukoNg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Jan 2022 12:44:39 +0100
Message-ID: <CAKMK7uEOd+N0Xfk_MRK4m6p-PFCRituimqeOzFMY925vyWcGkA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 9:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Gerd,
>
> On Tue, Jan 18, 2022 at 7:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > Also note that using a shadow framebuffer allows to decouple fbcon
> > updates and scanout framebuffer updates.  Can be used to speed up
> > things without depending on the 2d blitter.
>
> Assuming accesses to the shadow frame buffer are faster than accesses
> to the scanout frame buffer. While this is true on modern hardware,
> this is not the case on all hardware.  Especially if the shadow frame
> buffer has a higher depth (XRGB8888) than the scanout frame buffer
> (e.g. Cn)...
>
> The funny thing is that the systems we are interested in, once used
> to be known for their graphics capabilities and/or performance...

That's just a pure strawman. No one is forcing you to run your shadow
buffer with xrgb8888. You can already do C8, any any other C1 is a few
lines of code. Which I can't type for you, because I don't have such
high performance hardware, but if someone would have spent hacking
instead of typing mails any time this came up the past few years, we'd
have it long ago. It's really not hard.

Same goes for modesetting support in the fbdev emulation layer (that's
a bit more work, but really not much) and really anything. And we do
actually merge additions in the emulation support pretty quickly. If
they show up.
-Daniel

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
