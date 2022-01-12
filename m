Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F079248BF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351313AbiALH55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:57:57 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:35577 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiALH54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:57:56 -0500
Received: by mail-ua1-f50.google.com with SMTP id m90so3245395uam.2;
        Tue, 11 Jan 2022 23:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlv4bb07uQ08vixl16O6rQbCEVIDaSU7CPtshf2sCJ8=;
        b=xJzZyJaRdhl50Fq/aKQNRYGE9yShXNzGnjRSCkd5XunKN0xAlQ9A9yUgOqp5QAaqQP
         iXDbcTr/gx0b33wIijpC3tGQRENo8lxOBDIgGFTXTJv9VofiJxcpChux0sxdhbvffiDP
         8Azn6zWwwHYW+cSJD1WfpxfyqzGlgP/9MeX3MZf8Sxd57s3xJkg46oWmd+1RAeHwU5yZ
         Tgpe+JFN42f2W8TBgcxqFNyl31TuwfweGUc/7BNXjhOg6mG3Ynj10b/AZ0ed0MXQBFot
         11xb9OrE7sVTRdXut59ktbaI8SO3ifcV452OZ++zrpukmw6pb5rHG7lJytdqCaUOYPx9
         2alQ==
X-Gm-Message-State: AOAM532njuS9eqPJwIne+QZ+6fckxdXvFaGatLZgKTvDLYzZK0gsim2N
        X8E+qGT1OkVkYZ/9p0pIaLplWCybDKcPzQ==
X-Google-Smtp-Source: ABdhPJzwq2lon5agsPMriD1uoDPAbBQaz8iEzso6djGSIQe/q8TY3E6qSTOJjzTONrwLWA3XqVI0/Q==
X-Received: by 2002:ab0:22c5:: with SMTP id z5mr3794812uam.100.1641974275458;
        Tue, 11 Jan 2022 23:57:55 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id u33sm7308702uau.7.2022.01.11.23.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 23:57:54 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id x33so3145138uad.12;
        Tue, 11 Jan 2022 23:57:54 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr3471391vso.77.1641974274526;
 Tue, 11 Jan 2022 23:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20220110095625.278836-1-javierm@redhat.com> <65a13d92-93fc-25d2-0009-b7e60f3392c4@moonlit-rail.com>
In-Reply-To: <65a13d92-93fc-25d2-0009-b7e60f3392c4@moonlit-rail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jan 2022 08:57:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWBfA2rqu4DhWkpDt+PmNdZLC6_zcG+W+m=8UDudO+vA@mail.gmail.com>
Message-ID: <CAMuHMdXWBfA2rqu4DhWkpDt+PmNdZLC6_zcG+W+m=8UDudO+vA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] video: A couple of fixes for the vga16fb driver
To:     "Kris Karas (Bug reporting)" <bugs-a21@moonlit-rail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kris,

On Wed, Jan 12, 2022 at 3:19 AM Kris Karas (Bug reporting)
<bugs-a21@moonlit-rail.com> wrote:
> Javier Martinez Canillas wrote:
> > Changes in v2:
> > - Make the change only for x86 (Geert Uytterhoeven)
> > - Only check the suppported video mode for x86 (Geert Uytterhoeven).
>
> I just updated Bug 215001 to reflect that I have tested this new, V2
> patch against 4 systems, one more than last time - 2 BIOS/VGAC and 2
> UEFI - and it works perfectly on all four.
>
> Thanks, Javier, for the excellent work!
> I didn't test with non-X86, but the code appears to bypass the patch on
> non-X86, so should work fine for Geert.

Note that I can no longer test the PPC use case, as the hardware
died a long time ago.

> Tested-By: Kris Karas <bugs-a21@moonlit-rail.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
