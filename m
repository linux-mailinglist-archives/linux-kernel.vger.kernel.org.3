Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77A4523613
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbiEKOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiEKOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:46:50 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653342DD6D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:46:43 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id y76so4496578ybe.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnmGA8ainxG/8m3UcH5gpShY1r3ysYYHWnV4t7QF74M=;
        b=3t1QvIMeFK5mP1pm+mtbHV+1M6nMvHDx53e5f+bT8UJgXX9hTvdaYvt/UdCBWKpDI8
         zCGkBtm8SmniRqbfBk5i6DS/pT/GsHiTvzLFlzOY3ZhV9QLx5KRIJa1gn/2OJipf4UlU
         SpwDuUNs+eGnnXhK6Fov+n9a9I468QyGh+XeCuIxep/VZhq7WJo/Xkh8iafV+OrPKoKl
         q5ZpmXV2tE3kVNzDTLaliuYPph65Goh6s+2072AVULu6/TajYWmxVP+hHqCxDfLOTT6S
         i3FVfz2HeyqK9ZXNDNs612Gz3NFog2DlWqNP5BNYTUBSwzT6yOn9yZZ59ahuJF0coHHE
         3YdQ==
X-Gm-Message-State: AOAM532P+utQwNcz25zow5pCUxBXuRUgycFflOFeSqPxORiH8jKTK9hN
        GqL2hsQ/Zhmf6omjUXS930d56L8fA0/iom23hHc=
X-Google-Smtp-Source: ABdhPJz133qXMWdxupMygY4BBcGRdChR+/DiYHApj1IKMWU/Q7kPKoCoY6f0TWiUlZt4lRx62X+4i0YPk2Pcj5ZyDFg=
X-Received: by 2002:a25:cb4b:0:b0:645:d702:eb15 with SMTP id
 b72-20020a25cb4b000000b00645d702eb15mr22111070ybg.500.1652280402426; Wed, 11
 May 2022 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510142550.1686866-1-mailhol.vincent@wanadoo.fr>
 <CAKwvOdnShyGvW9cuDuqQS+uvY7DHSmh8-55R1Bx_dxej8YQRHg@mail.gmail.com> <CAMZ6RqKD9O8OHVUGCOYK1BXm7SCOkWbxCsSb=6jjfzgKn61JEw@mail.gmail.com>
In-Reply-To: <CAMZ6RqKD9O8OHVUGCOYK1BXm7SCOkWbxCsSb=6jjfzgKn61JEw@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 11 May 2022 23:46:31 +0900
Message-ID: <CAMZ6RqJ5wO5RZ1bjKeeq8VOuYWM4ihBcCqf9y03GWrg_eovX-w@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 11 mai 2022 at 08:24, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Wed. 11 May 2022 at 07:14, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Tue, May 10, 2022 at 7:26 AM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > > The compilers provides some builtin expression equivalent to the
> > > ffs(), __ffs() and ffz() function of the kernel. The kernel uses
> > > optimized assembly which produces better code than the builtin
> > > functions. However, such assembly code can not be optimized when used
> > > on constant expression.
> > >
> > > This series relies on __builtin_constant_p to select the optimal solution:
> > >
> > >   * use kernel assembly for non constant expressions
> > >
> > >   * use compiler's __builtin function for constant expressions.
> > >
> > > I also think that the fls() and fls64() can be optimized in a similar
> > > way, using __builtin_ctz() and __builtin_ctzll() but it is a bit less
> > > trivial so I want to focus on this series first. If it get accepted, I
> > > will then work on those two additionnal function.
> > >
> > >
> > > ** Statistics **
> > >
> > > On a allyesconfig, before applying this series, I get:
> > >
> > > | $ objdump -d vmlinux.o | grep bsf | wc -l
> > > | 1081
> > >
> > > After applying this series:
> > >
> > > | $ objdump -d vmlinux.o | grep bsf | wc -l
> > > | 792
> > >
> > > So, roughly 26.7% of the call to either ffs() or __ffs() were using
> > > constant expression and can be optimized (I did not produce the
> > > figures for ffz()).
> >
> > These stats are interesting; consider putting them on patch 1/2 commit
> > message though (in addition to the cover letter). (Sending thoughts on
> > 1/2 next).
>
> The fact is that patch 1/2 changes ffs() and patch 2/2 changes
> __ffs(). For v2, I will run the stats on each patch separately in
> order not to mix the results.
>
> > >
> > > (tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)
> >
> > Here's the same measure of x86_64 allyesconfig (./scripts/config -d
> > CONFIG_HINIC) at 9be9ed2612b5aedb52a2c240edb1630b6b743cb6 with ToT
> > LLVM (~clang-15):
> >
> > Before:
> > $ objdump -d vmlinux.o | grep bsf | wc -l
> > 1454
> >
> > After:
> > $ objdump -d vmlinux.o | grep bsf | wc -l
> > 1070
> >
> > -26.4% :)
>
> Roughly same ratio. I am just surprise that the absolute number
> are different:
>
>   * GCC before: 1081, after 792
>   * clang before 1454, after 1070
>
> I wonder why clang produces more bsf instructions than GCC?

Did not find the answer yet, but while looking at this, I found
another interesting thing: on x86_64 the bsf instruction produces
tzcnt when used with the ret prefix. So ffs() produces bsf assembly
instructions but __ffs() and ffz() produces tzcnt. c.f.

http://lkml.kernel.org/r/5058741E020000780009C014@nat28.tlf.novell.com

I will update the figures in v2 and benchmark both bsf and tzcnt.

> Also, on a side note, I am not the first one to realize that
> __builtin_ffs() is able to optimize the constant variable. Some
> people already used it to locally:
>
> | $ git grep __builtin_ffs | wc -l
> | 80
