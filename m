Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DCF492F76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbiARUh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:37:58 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:41574 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiARUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:37:57 -0500
Received: by mail-ua1-f52.google.com with SMTP id i10so413755uab.8;
        Tue, 18 Jan 2022 12:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rccm2Ng7Ygp1cY/As0QYhUzGpE8sU6W4R2NG0olHuac=;
        b=eNh/IBBk4hyYz852AMrG2ovnWsKHp758oVpVmICAFSJSZARiAAkJvGSMxD5AG0jR84
         GmYSA4nyQYFTDpx09bCKdMJdFMH62yRSWQhrluUKrFMvanvPjB6DclpVRVlMcPjCMRFa
         XaHnLivk2i3uU50WuMafS3HD6ZWN/NOyWPOxSRFhm8ClFx+kSMYmrEuFuECUzoFEav/E
         mFS4d3yFoIMpBivYQ5oflXRs4MGazy3DRJsgPBJQceZJoKiTbrkbldi9LyvuHfkNCH90
         IrN40zyEGYUAsyZLhayRFI0ThqGbZEt9S+vsOsaghT6G9kMvCkNf5X4QPldR+ZHwdmSD
         uOHw==
X-Gm-Message-State: AOAM531zXiwfL6kMz6huL3TZDAj2LwX0mSWA74UWwcVQsxtLN1f1QzMs
        66+DzYWOUmOHkCS1mn5Pdurhw2BViixUew==
X-Google-Smtp-Source: ABdhPJwxE0WRP3zsobMcA4/zbKuQzV/vmvQXpoOtg4aIYa/fy1piy51AvDYqRlqi4OqrLR0icA92Ww==
X-Received: by 2002:ab0:60d0:: with SMTP id g16mr10462759uam.121.1642538276786;
        Tue, 18 Jan 2022 12:37:56 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id u107sm387690uau.6.2022.01.18.12.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 12:37:56 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id m90so469443uam.2;
        Tue, 18 Jan 2022 12:37:56 -0800 (PST)
X-Received: by 2002:a05:6102:3581:: with SMTP id h1mr10453087vsu.5.1642538275904;
 Tue, 18 Jan 2022 12:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
 <20211129122052.GA7921@alpha.franken.de> <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
 <20211129130535.GA8644@alpha.franken.de> <CAMuHMdU94tk5pcTK4Fa-g9vm56oooCeWXkkL8nOgofk5aKbwig@mail.gmail.com>
 <alpine.DEB.2.21.2201090221150.56863@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2201090221150.56863@angie.orcam.me.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Jan 2022 21:37:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXiLk+b2RtS+9xOfurVF2ajac92i_L48UAF_9B3Let0jQ@mail.gmail.com>
Message-ID: <CAMuHMdXiLk+b2RtS+9xOfurVF2ajac92i_L48UAF_9B3Let0jQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software nodes
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Tue, Jan 18, 2022 at 8:59 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> > Took me a bit to test proper operation, as contemporary cross-toolchains
> > create userland binaries that can no longer run on MIPS-II/III CPUs,
> > and native development is slow and memory-constrained (dpkg OOM)...
>
>  You mean cross-toolchains included with (some) distributions, right?

Yep, the MIPS cross-toolchain that comes with Ubuntu.

>  I do hope so or otherwise I'd be very concerned.  Myself I've been using
> a self-built MIPS cross-compiler, running on POWER9, which builds MIPS I
> binaries just fine, e.g.:
>
> $ file install/usr/sysroot/{lib/ld-2.32.9000.so,usr/bin/gdbserver}
> install/usr/sysroot/lib/ld-2.32.9000.so: ELF 32-bit LSB pie executable, MIPS, MIPS-I version 1 (SYSV), dynamically linked, with debug_info, not stripped
> install/usr/sysroot/usr/bin/gdbserver: ELF 32-bit LSB executable, MIPS, MIPS-I version 1 (GNU/Linux), dynamically linked, interpreter /lib/ld.so.1, for GNU/Linux 3.2.0, not stripped

Debian raised the minimum requirements for MIPS, hence mine are
ELF 32-bit MSB shared object, MIPS, MIPS32 rel2 version 1 (SYSV)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
