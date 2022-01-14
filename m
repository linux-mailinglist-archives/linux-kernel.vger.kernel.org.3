Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8248F041
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiANTBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:01:05 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:35681 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiANTBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:01:03 -0500
Received: by mail-vk1-f181.google.com with SMTP id 19so6411363vkl.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CH9/Rg/LEVmPsM6ZW1nfQgVcn18gSqDV5tJys+Iu5/k=;
        b=SYBOyyOkth+oN5jloHkTOAr4QwcQXCpMzZaY/z1hor1hDS+4dMo/1SnB3OxZitKWrn
         QRcghXqY/A/JYgSkRFGn6wU9UW7ETjd7wvKebs6phvhlThwe0wGFjhgXgrFW3CHdTq2R
         8BmrjL1BOrmaHm0HE50M7q/9wPncZH0tdIQ8NlwpEyeh3grX0UfJhzEzCNic1sQWte1j
         z/xIrYLJmYIB0lRtvvh48jweWyNsRaK6Pe9+fiSgWec356jDEgzqLqcMSsJUdqA1RTdy
         iC0l5uEAcg4+FF6RigNN9sA9XmQqrC922DtSHPzgOCFcoVM2f2xcWwNiJSiZn93oFI/i
         kCEQ==
X-Gm-Message-State: AOAM532lxIrJze4KODIioLn4gAC4jL/LqPz+SwQzMven0wxjt/8n4trv
        qtimrGZ/MGQ5Qi9bq1VegavHppi2NCsexzJz
X-Google-Smtp-Source: ABdhPJzzNkGUSZzpoZWVOUjYRISSX9+SNs+IPpa0hTG65AguDTk7KcknBQcj33eopB2Tfz2gB12NsQ==
X-Received: by 2002:a05:6122:7d3:: with SMTP id l19mr4721179vkr.35.1642186862214;
        Fri, 14 Jan 2022 11:01:02 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id h132sm2226907vka.11.2022.01.14.11.01.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 11:01:01 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 78so6401239vkz.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:01:01 -0800 (PST)
X-Received: by 2002:ac5:c967:: with SMTP id t7mr4940393vkm.20.1642186861054;
 Fri, 14 Jan 2022 11:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic> <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHHrb3RGYxARLCC@mit.edu>
In-Reply-To: <YeHHrb3RGYxARLCC@mit.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 20:00:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFS1GZ_mkC3t6aZoUJKGxXsZxk_M7wSza4=Nwfi4_6Rw@mail.gmail.com>
Message-ID: <CAMuHMdVFS1GZ_mkC3t6aZoUJKGxXsZxk_M7wSza4=Nwfi4_6Rw@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Fri, Jan 14, 2022 at 7:58 PM Theodore Ts'o <tytso@mit.edu> wrote:
> On Fri, Jan 14, 2022 at 03:52:29PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Jan 14, 2022 at 3:36 PM Borislav Petkov <bp@alien8.de> wrote:
> > > Btw, pls do note that this is removing only the x86 a.out support -
> > > other arches (m68k and alpha) still select HAVE_AOUT and thus the
> > > respective glue in fs/binfmt_aout.c
> >
> > Quoting myself (do I need a canned response for this? ;-):
> >    "I think it's safe to assume no one still runs a.out binaries on m68k."
> >
> > https://lore.kernel.org/r/CAMuHMdVGT1QN8WUqNcU8ihPLncUGfrjV49wb-8nHUgHhOzLeNw@mail.gmail.com/
> > https://lore.kernel.org/r/CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com
> >
> > Of course, m68k is not encumbered by a.out Netscape binaries, unlike
> > ia32 and alpha ;-)
>
> And Alpha's a.out Netscape binary is what required OSF/1 compatible
> system calls, so if and when we ever can nuke a.out Alpha support, so
> perhaps there might also be an opporunity to remove OSF/1
> compatibility support...

As we seem to be reiterating a discussion from 2019, let's read last
time's summary first:
https://www.linuxjournal.com/content/deprecating-aout-binaries

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
