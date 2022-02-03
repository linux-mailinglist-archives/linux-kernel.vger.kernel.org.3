Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5214A8006
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiBCHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:54:08 -0500
Received: from mail-ua1-f47.google.com ([209.85.222.47]:43594 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiBCHyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:54:06 -0500
Received: by mail-ua1-f47.google.com with SMTP id a24so3647581uat.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 23:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1bdeogaytIIEqH3oTS2dReCAL1IGEgvZjy30/0m0Ag=;
        b=iYTk/hlwhZGji/2XOkXI02Xpd5YxkEpoiiaX4uMsep/65shsNWfeWvU+5mDq23zxaH
         bUCDtNIQO0ZmsVxW1QwORrj7cpB6XR6ZSyUt8qUsHPhTeWMJD/+Q3CB8qU7vuj+NNJAZ
         dyLrfDW1XG3/9RmoW7tM0RBNmCihh8+fsgzb92vwQTWylgwdbvev+osI2bIDTeqe8Wys
         E6gvupgy6ZpjR7MlaxtuvFU3yuxRfaEY9ZMYBpf4VY8pnO6C9jbyLy+UwVwtlnRFxw/0
         ohmFyROE3frs+zW8HR2Ox5iv4qQuOKZtjJ7iEynmirW2xBGyA1T+3s6Gvh326Ua4gUA7
         /VJA==
X-Gm-Message-State: AOAM532MGhOYlseVlin4OXxJEC54uCQFqnbPEBtHwohQh5vQVml7EEhe
        YbJZROG0YomHMyvj5pGxgu0Yh54VMFTuRA==
X-Google-Smtp-Source: ABdhPJz4C8Qz329rfRxQtH8wEzFVvMn80cTAPWezuDpqFwd0gbr1/tYGscu7bUoStKmPzALdoaf5hg==
X-Received: by 2002:a05:6102:508:: with SMTP id l8mr846615vsa.51.1643874845630;
        Wed, 02 Feb 2022 23:54:05 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id g22sm6447892vkm.3.2022.02.02.23.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 23:54:05 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id 60so3748284uae.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 23:54:04 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr12672642vsb.68.1643874844762;
 Wed, 02 Feb 2022 23:54:04 -0800 (PST)
MIME-Version: 1.0
References: <87838c92-484e-d9f0-4840-f9e9db712c9d@oracle.com>
In-Reply-To: <87838c92-484e-d9f0-4840-f9e9db712c9d@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Feb 2022 08:53:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxYf2+skr3TN4ZmMx-=Eghe9Prm8KgDvFskovMG0MeOw@mail.gmail.com>
Message-ID: <CAMuHMdXxYf2+skr3TN4ZmMx-=Eghe9Prm8KgDvFskovMG0MeOw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 3] video: fbdev: cirrusfb: check pixclock to
 avoid divide by zero
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

CC Helge, linux-fbdev

On Wed, Feb 2, 2022 at 7:23 PM George Kennedy <george.kennedy@oracle.com> wrote:
> Do a sanity check on pixclock value to avoid divide by zero.
>
> If the pixclock value is zero, the cirrusfb driver will round up
> pixclock to get the derived frequency as close to maxclock as
> possible.
>
> Syzkaller reported a divide error in cirrusfb_check_pixclock.
>
> divide error: 0000 [#1] SMP KASAN PTI
> CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
> RIP: 0010:cirrusfb_check_var+0x6f1/0x1260
>
> Call Trace:
>   fb_set_var+0x398/0xf90
>   do_fb_ioctl+0x4b8/0x6f0
>   fb_ioctl+0xeb/0x130
>   __x64_sys_ioctl+0x19d/0x220
>   do_syscall_64+0x3a/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Cc: <stable@vger.kernel.org> # 5.4.y
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Hi Andrew, can you pick this patch up?  Some of the fbdev drivers have
> maintainers but the cirrusfb.c is basically orphaned.  I sent this patch
> in Oct and again in Dec and no one picked it up.  Geert has reviewed it.
> Obviously the original code just crashed so this shouldn't be
> controversial.
>
> v2: Geert says that instead of just returning an error, this is supposed
> to find a valid pixclock and use that.
>
> RESEND: Added the Reviewed by: and Cc: <stable@vger.kernel.org>

This is already queued in the fbdev for-next branch[1], as announced
by Helge in [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?h=for-next&id=5c6f402bdcf9e7239c6bc7087eda71ac99b31379
[2] https://lore.kernel.org/all/e1e5b7d1-ea09-6e28-9c39-45b983734a85@gmx.de/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
