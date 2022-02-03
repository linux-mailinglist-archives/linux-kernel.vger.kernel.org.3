Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32464A8578
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbiBCNr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:47:28 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:45031 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiBCNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:47:27 -0500
Received: by mail-ua1-f47.google.com with SMTP id p26so5190513uaa.11;
        Thu, 03 Feb 2022 05:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMvPdu1FDdP95BRsv+5Teh17OUBAE/eVt5OmqC+P+NU=;
        b=p6uTcMomaYfMRVHqw4AlDMn8L9ODGmvx/+13AWgn82M+O/GgYp0hwOP9aG3yANvFAW
         GNSMOagcum4HI5XU5duIhWP+cHiuGsHaLt7cxL7EWGp9z3f+jsl1UsVCTyveVILLnddi
         s3bekcV32orNdnNUbm7rFeBBvO5uNs++K+qwEy3tUDsLHy/eh4NF7pOtZQJlPXq3VtYC
         N4wNdrCPY0Vdn8b8v2XwcLnjNbTy1h2LTTiPw/ymGBfJyHKMjPTGgkqiVC4RCyPPub03
         qEiqujKIgJq3M/ocR0QtEnhea0/9rYZBaevNR1PMhRQjGXmUFMfoso5dH+r749I6s6YH
         P2mQ==
X-Gm-Message-State: AOAM530Thr7vjodxCWtayUvRitFpT1W7+lmOFGjStN3ZK/vHLYmJ7d1W
        KCg8ztq1jLx/uADc1FX/u8iburoXilxzZg==
X-Google-Smtp-Source: ABdhPJy5bn1nh4JiCdsmgneGnr552U2kOXAgwIKliNEbLMQHv06r6sRArU1sbJaXxEUlgzk1Uhyl5Q==
X-Received: by 2002:a67:e901:: with SMTP id c1mr13975103vso.38.1643896046807;
        Thu, 03 Feb 2022 05:47:26 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id g22sm5625844vsk.26.2022.02.03.05.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 05:47:25 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id u76so5288058uau.3;
        Thu, 03 Feb 2022 05:47:25 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr13059550vsb.68.1643896045081;
 Thu, 03 Feb 2022 05:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-10-daniel.vetter@ffwll.ch> <723422bf-eb13-095f-66c5-e4011653e21d@suse.de>
In-Reply-To: <723422bf-eb13-095f-66c5-e4011653e21d@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Feb 2022 14:47:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVa2hL4ctCnd1iY68LcB4Udz1Z+oZ9rTobbkM-K-yJ5og@mail.gmail.com>
Message-ID: <CAMuHMdVa2hL4ctCnd1iY68LcB4Udz1Z+oZ9rTobbkM-K-yJ5og@mail.gmail.com>
Subject: Re: [PATCH 09/21] fbcon: Replace FBCON_FLAGS_INIT with a boolean
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>, Claudio Suarez <cssk@net-c.es>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 10:25 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 31.01.22 um 22:05 schrieb Daniel Vetter:
> > It's only one flag and slightly tidier code.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Du Cheng <ducheng2@gmail.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Claudio Suarez <cssk@net-c.es>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> > +++ b/drivers/video/fbdev/core/fbcon.h
> > @@ -18,8 +18,6 @@
> >
> >   #include <asm/io.h>
> >
> > -#define FBCON_FLAGS_INIT         1
> > -
> >      /*
> >       *    This is the interface between the low-level console driver and the
> >       *    low-level frame buffer device
> > @@ -77,7 +75,7 @@ struct fbcon_ops {
> >       int    blank_state;
> >       int    graphics;
> >       int    save_graphics; /* for debug enter/leave */
> > -     int    flags;
> > +     bool   initialized;
>
> This will add 3 bytes of padding. Maybe you can put the bool elsewhere.

Several of the int variables are used as boolean flags, too.
Perhaps convert them all to bitfields?

    unsigned int initialized : 1;
    ...

> >       int    rotate;
> >       int    cur_rotate;
> >       char  *cursor_data;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
