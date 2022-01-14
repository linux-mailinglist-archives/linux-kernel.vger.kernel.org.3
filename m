Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642C548F069
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiANTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:21:50 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:36404 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiANTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:21:49 -0500
Received: by mail-vk1-f177.google.com with SMTP id d189so6445891vkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kg1GAtLFzCZIOEB9icyhuH5IXkxaH772X9gOCX1YFt0=;
        b=vgx0e7YEt4rS2YOzZ2dhM0JW49c8MvkXUscbgmL+GPTW80h2086ClBIt/W671EXdmk
         WlqIEIzhbbxHrzzaPAc0gVmpFoTc2iEvDwOqKEEFUUXCS/4V3CA0YDGDgMtJs+3q41O6
         ZA09zGer5ICYL8H9gBOgNHhDHvslIdGy4Mi99nMuQ26DRdJkf1zpjDEkCmuNQxGHrEH0
         8M91fKOwN1GvhU7G0RBJNDaDkuf4Jlcb/ZFfW2uO+F3G77OFlqpnEMBmqo0W5obwVB2N
         LhqyOLh5SWhlzdK2vN0aWVJX6eDicnPM7hDnpf8gXYZTTUTsEuxtpiPAY+SCk3HuGxIb
         ISag==
X-Gm-Message-State: AOAM531QsW6tcul0vbKll7OhRmlmLkCH2T1CVZqzVF0pPz7JhtR25lM+
        f2Tv6TZiYbUmmjtpSM4lKTihz5OmbDy/7Yy9
X-Google-Smtp-Source: ABdhPJxdv0zvU/ixtwEp6HEIScbgcBLRs95703jdVnOFPkGRUB5E+mB/5o72/bIfw6mzEZ1nTeNg3w==
X-Received: by 2002:a05:6122:513:: with SMTP id x19mr4794209vko.30.1642188108198;
        Fri, 14 Jan 2022 11:21:48 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id k28sm2230530vkn.46.2022.01.14.11.21.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 11:21:48 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id x33so18628292uad.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:21:47 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr4311796vso.77.1642188107764;
 Fri, 14 Jan 2022 11:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic> <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic>
In-Reply-To: <YeHLIDsjGB944GSP@zn.tnic>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 20:21:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
Message-ID: <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Fri, Jan 14, 2022 at 8:12 PM Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Jan 14, 2022 at 03:52:29PM +0100, Geert Uytterhoeven wrote:
> > Quoting myself (do I need a canned response for this? ;-):
> >    "I think it's safe to assume no one still runs a.out binaries on m68k."
>
> I remember now that I've looked at the thread from back then but what
> are you trying to say with your quote?
>
> Do you wanna see another patch which rips out a.out support from m68k?
>
> I could do one ontop but besides build-testing I can't test any other
> way on m68k...
>
> :-)

I mean that I can rip it out on m68k.

Who's gonna take care of alpha?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
