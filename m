Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D874ED6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiCaJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiCaJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:22:34 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0A156C48
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:20:41 -0700 (PDT)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 22V9KOR1013625
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:20:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 22V9KOR1013625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648718425;
        bh=0tIA0n0PFKdD+i5mJMn4ub2X0H84x0kRjS0dtMRbDhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wC03OYArkGrABy/eg2KYi6BZenIAP7WkcOfLz/lYLOoffdQZvC+nAkX1nyr5KWpuS
         iLzd5X8csdOPnnv7w7/McvpWA1QhsvV1Ldcq8r8UIc07LDX8b+HxtiefkLzYP1zc6I
         jFjJ/trBEuluud4w/0LMKKsiPiUHAw8RoUUGXTTAtIVcyXWPoLl7OeF+Yd7io91Snh
         vrI7PDO9oRUhI5/cNGxr6rNvGlFkAvkjZZYRRY12LSaSVpPMAq9zZGRnyMvcX6VG/z
         U82kCYU1WskakrndJ+5cUiN8t2UrLhmIlgqA1ZCGgYobipmItxeSuLwmcBPUA2Ecck
         6cWJ7rCTlH/sw==
X-Nifty-SrcIP: [209.85.210.170]
Received: by mail-pf1-f170.google.com with SMTP id u22so21410347pfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:20:25 -0700 (PDT)
X-Gm-Message-State: AOAM531lQ2+91W0bluXji7ub+j2fODdjQZKg/83ncFVxS+SLaLcKuehz
        eyrrbKcC9KnpVXXP0WNGHeoVF06NNZJit/BcMYQ=
X-Google-Smtp-Source: ABdhPJzCAI/zt1quVeBpAXftWjzDRi1xPNDfW2QPFnvhFcwyOg030nqLf9yM6h89/lH3R0y0plXdXwso3EzdkTScUhc=
X-Received: by 2002:a63:dc53:0:b0:381:7f41:3a2d with SMTP id
 f19-20020a63dc53000000b003817f413a2dmr10147230pgj.126.1648718424144; Thu, 31
 Mar 2022 02:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211030175258.1716178-1-masahiroy@kernel.org>
 <Yis7Z90qvPz+EcTk@shell.armlinux.org.uk> <CAK7LNAT4k=Cseox6jEunLxU+w=VTQ08c9gdmt6=K2vvvSL49bg@mail.gmail.com>
 <CAK7LNARgJ7GapsRNPyG18rs-uxnXuMrQRVP=y2dKLLNRjU8tbA@mail.gmail.com> <YkSDyRoFgSx3HY8X@shell.armlinux.org.uk>
In-Reply-To: <YkSDyRoFgSx3HY8X@shell.armlinux.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Mar 2022 18:19:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgXe1yPS1orykYAm1P9bkhTGdFSFrpQEJLuG-KX+VJPA@mail.gmail.com>
Message-ID: <CAK7LNASgXe1yPS1orykYAm1P9bkhTGdFSFrpQEJLuG-KX+VJPA@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompressor: do not copy source files while building
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     patches@arm.linux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 1:22 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> Your reply was too late for me, I've been away on vacation from 14th
> March until now... and now I've got a whole truck-load of catch-up, so
> it's likely I'll forget to sort this. Please send a patch to fix it,
> thanks.

Done.

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9189/1


Thanks.




>
> On Fri, Mar 25, 2022 at 11:54:07AM +0900, Masahiro Yamada wrote:
> > Hi Russell,
> >
> >
> > Was this issue fixed?
> > (I see nothing happened in linux-next yet)
> >
> > I will not send a patch because I assume you will
> > fix this by yourself. If there is something you want
> > me, please let me know.
> >
> > Thanks.
> > Masahiro Yamada
> >
> >
> >
> >
> >
> >
> > On Mon, Mar 14, 2022 at 1:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Fri, Mar 11, 2022 at 9:07 PM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Sun, Oct 31, 2021 at 02:52:58AM +0900, Masahiro Yamada wrote:
> > > > > As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
> > > > > builds") stated, copying source files during the build time may not
> > > > > end up with as clean code as expected.
> > > > >
> > > > > Do similar for the other library files for further cleanups of the
> > > > > Makefile and .gitignore.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > >
> > > > Hi,
> > > >
> > > > I am now seeing the following every time I run a build:
> > > >
> > > >   GEN     Makefile
> > > >   CALL    .../linux-rmk/scripts/atomic/check-atomics.sh
> > > >   CALL    .../linux-rmk/scripts/checksyscalls.sh
> > > >   CHK     include/generated/compile.h
> > > >   Kernel: arch/arm/boot/Image is ready
> > > >   AS      arch/arm/boot/compressed/lib1funcs.o
> > > >   AS      arch/arm/boot/compressed/ashldi3.o
> > > >   AS      arch/arm/boot/compressed/bswapsdi2.o
> > > >   LD      arch/arm/boot/compressed/vmlinux
> > > >   OBJCOPY arch/arm/boot/zImage
> > > >   Kernel: arch/arm/boot/zImage is ready
> > > >
> > > > In other words, those three objects are always rebuilt even though
> > > > they haven't changed.
> > > >
> > > > I've tried removing the arch/arm/boot/compressed directory in the
> > > > build tree, but that doesn't make any difference.
> > > >
> > > > Running with V=2 shows:
> > > >
> > > >   AS      arch/arm/boot/compressed/lib1funcs.o - due to lib1funcs.o not in $(tar
> > > > gets)
> > > >   AS      arch/arm/boot/compressed/ashldi3.o - due to ashldi3.o not in $(targets)
> > > >   AS      arch/arm/boot/compressed/bswapsdi2.o - due to bswapsdi2.o not in $(targets)
> > > >
> > > > It looks to me like:
> > > > OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o
> > > >
> > > > in your patch should have been added before:
> > > >
> > > > targets       := vmlinux vmlinux.lds piggy_data piggy.o \
> > > >                  head.o $(OBJS)
> > > >
> > > > Please confirm.
> > >
> > >
> > > Sorry for my late reply.
> > >
> > > Yes, you are right.
> > >
> > > OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o
> > >
> > > should come before the 'targets' assignment.
> > >
> > >
> > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!



-- 
Best Regards
Masahiro Yamada
