Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137444888A0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 11:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiAIKCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 05:02:36 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:34681 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAIKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 05:02:35 -0500
Received: by mail-ua1-f44.google.com with SMTP id y4so18560659uad.1;
        Sun, 09 Jan 2022 02:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDvAPw0xd5cx+5QwR7u2cboYnfSLEx7aiq6fPxnv/Dw=;
        b=uA5B/wsqn2z4reXZDbfk7U/Jb0MdQPhZlLBEVE2NLMC6FdQgQGu1qmpvEU6LtEZEeC
         JQXtF9OIaznUoD5eV4a0lDtpUbTXJYk+38zsZrNMEvAwDQJrAyuH8qK9afs3FQr55Hna
         ydSbVYxkssQnJfVNOoy5V72wUsEzfOPdV9jnbfPZvVZiNe3kI/3a6mWJ/XpVTWHaW7LH
         wJotq7cze9l2POgqP/+zlKYV60EuiHTC/Is0Yvgzflnsfu4xD2/f7+b2RW6cfQ6NGRog
         5forF/BL7mfs3kODeNzVhAOXW7zUEBwcxqnhV6uVmWHj/4jY4AofoNjD7EkhcvAuE9tA
         N1zA==
X-Gm-Message-State: AOAM532cDhpw6dEZc8ysfM8QNFLI/I1Ryufyc9NasBav1Wkd/ZtdZtFU
        0C8zIK/zIfFk+lIPiS+PGMrxg29cAUQvRA==
X-Google-Smtp-Source: ABdhPJwFAz2EXCy2Z9kOEkv83ixLPHl4t/lg47+J2Fd1KFuTLPdNzqJBjzBn8/LoDZkv3GWRnq0kwg==
X-Received: by 2002:ab0:28cc:: with SMTP id g12mr10269069uaq.76.1641722554216;
        Sun, 09 Jan 2022 02:02:34 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id j129sm1183229vkh.16.2022.01.09.02.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 02:02:33 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id c36so18398999uae.13;
        Sun, 09 Jan 2022 02:02:33 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr16239vso.77.1641722553460;
 Sun, 09 Jan 2022 02:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20220107110723.323276-1-javierm@redhat.com> <20220107110723.323276-2-javierm@redhat.com>
In-Reply-To: <20220107110723.323276-2-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Jan 2022 11:02:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXG3xOUrzOoRQVgpb4MmuQKJ1y3yPXv=p4AiNEohrzZug@mail.gmail.com>
Message-ID: <CAMuHMdXG3xOUrzOoRQVgpb4MmuQKJ1y3yPXv=p4AiNEohrzZug@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: vga16fb: Fix logic that checks for the display standard
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kris Karas <bugs-a21@moonlit-rail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, Jan 7, 2022 at 9:00 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The vga16fb framebuffer driver supports both Enhanced Graphics Adapter
> (EGA) and Video Graphics Array (VGA) 16 color graphic cards.
>
> But the logic to check whether the EGA or VGA standard are used is not
> correct. It just checks if screen_info.orig_video_isVGA is set, but it
> should check if is set to VIDEO_TYPE_VGAC instead.
>
> This means that it assumes to be VGA even if is set to VIDEO_TYPE_EGAC.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -1332,7 +1332,7 @@ static int vga16fb_probe(struct platform_device *dev)
>         printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
>         par = info->par;
>
> -       par->isVGA = screen_info.orig_video_isVGA;
> +       par->isVGA = screen_info.orig_video_isVGA == VIDEO_TYPE_VGAC;

All non-x86 architectures (except for 2 MIPS platforms) treat
orig_video_isVGA as a boolean flag, and just assign 1 to it.
Hence this change would break them.

>         par->palette_blanked = 0;
>         par->vesa_blanked = 0;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
