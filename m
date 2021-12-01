Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDC465622
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbhLATJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245127AbhLATIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:08:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BFC06175A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:05:33 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r25so40131619edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHWyLuDVNYW2X/b78nVff/N/XbPJ3JSMzpXHjlHZtEg=;
        b=gEkrjsuvKlLoHFhgN2IZj6W9OqpFebRbaMyfwEQuhW6NH+CJHaydku3lOr58CarCW5
         bDpmpksK2xN9lgyM0h54Glt9DbgEiLz6o1eXhLyS4eF0/zMBCkWLz+3OWY3p8m5zH4Td
         C9GF3WsqospldedOXbfxY19ZvtITA1D0Mn/ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHWyLuDVNYW2X/b78nVff/N/XbPJ3JSMzpXHjlHZtEg=;
        b=JAXrM9WeaEuIC18HYvg5iTiLVTJKa6oIGvbV8l8hyQMMLwo2Ppg7Idn2P4s5Nv8vdK
         v5T9ccSXwG/FNwQQx3B3u/MVsMTG049PBvnhPCx8z0CKLp5APNilYAA338F1JJKvpL9H
         g9GzDuokmavgN6a2H6L5nrsizJQ2gubjEmslNv4adem1DMmBbABUxRo/UQ/ONVh9FESc
         43d5SpY+T19wTveenMTaMUm8zFxH27PCS8vmMDB8qWRfsbfhvuI/Il4my6jCwXSinAy9
         dULyONXIBodC+kFVkFoR9FzE4PWYh45KstGbbWwHnfrzkIaE5TFMPr7QpvJUDdMb0R3C
         WNPw==
X-Gm-Message-State: AOAM53053hpooK9x/yqO4CEKpuS4lQwfK0JQIx1/xs9LjNGHPVdssDnQ
        0cOjkw4RsDhJG/UTGLDywsETJkp7Ulm08yLv
X-Google-Smtp-Source: ABdhPJzwUEIywvNNlbHVa6Eh3kjE1+huvkE/fi9XuyeO/VvRKBtL7M1U9iLpSCTbiLXnKrq2gNNHoA==
X-Received: by 2002:a05:6402:2790:: with SMTP id b16mr11382079ede.24.1638385526563;
        Wed, 01 Dec 2021 11:05:26 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id ar2sm325611ejc.20.2021.12.01.11.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 11:05:25 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1898891wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:05:25 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr82787wmc.152.1638385525107;
 Wed, 01 Dec 2021 11:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <1825634.Qa45DEmgBM@localhost.localdomain> <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
 <1701119.OD4kndUEs1@localhost.localdomain> <1d05e95c-556a-a34c-99fd-8c542311e2dd@i-love.sakura.ne.jp>
 <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
In-Reply-To: <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Dec 2021 11:05:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVL_CLm-+=7qf2obF6f8D+ujysmqp5dKdAb7UEyo1cZg@mail.gmail.com>
Message-ID: <CAHk-=wjVL_CLm-+=7qf2obF6f8D+ujysmqp5dKdAb7UEyo1cZg@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 5:41 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> What do you think? Can we apply this?

I think this patch is only papering over the problem, and the issue goes deeper.

It may be that "papering over the issue" successfully hides it
completely, but it's still a horribly bad approach.

> > -     if (in_interrupt())
> > +     if (in_interrupt() || irqs_disabled())
> >               return count;

This kind of stuff is broken. Pretty much always.

And in this case, it's still broken, because things like "called under
a non-irq spinlock" would still not show up.

And no, I do *not* mean that the code should try to figure that out. I
mean that the problem goes further up, and that the fact that we get
to do_con_write() in the first place when we're in an invalid context
is wrong, wrong, wrong.

How the heck do we get here from just an ioctl?

Looking at the backtrace, I see

   n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
   tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
   __start_tty drivers/tty/tty_io.c:806 [inline]
   __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799

and apparently it's that hdlc line discipline (and
n_hdlc_send_frames() in particular) that is the problem here.

I think that's where the fix should be.

                Linus
