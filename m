Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7724D76EB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiCMQh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiCMQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:37:26 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91F2C11F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:36:17 -0700 (PDT)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 22DGZfZD007647
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:35:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 22DGZfZD007647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1647189342;
        bh=cl5EZIZji6pwKaRvzWqBIuMA6UDOCMDjUF+UkD+yEIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H0/1e5UgD8xsh3QuBpExc4ri+FtKfT3TGYWernbeRHC/JgULZvblrkXGqv0C4q4JB
         AvohwxzJeAtHzzkc6HyiyAWYG4qFNl0j+y2f7+M8/CYhHDJpIG2ww1h87s5veE3mZ6
         IPYXWm4vFohSzCSLIIPULQH0V89ZRtv6yDexyj1N6uCSeWZzFTzh4x6w8MpK4GWcpo
         aJ5aiLaLqcZjHxTyssCJaUb+flKEWfXBIPRw38eXWQJNs+vj8Q+hYCRzFYJSJZ1CU0
         FWErU+6ZE6sse/4jKuzzQqtRzP79RB0aXxsqJrdMcUnEJNMR775Ujb9C1k6BWWofZk
         iO0IZAhc8lA7w==
X-Nifty-SrcIP: [209.85.215.182]
Received: by mail-pg1-f182.google.com with SMTP id c11so11750507pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:35:42 -0700 (PDT)
X-Gm-Message-State: AOAM532iQ2NSV3/1wIrWdz+cAsEwjzrzoKahxb2MsILMwLYf3m2qTL0d
        4Jf35VcYDYj8zvAf54gOLH5xq4PM0J5r7cz4nAs=
X-Google-Smtp-Source: ABdhPJwdwdZcJbTaikr/hlEWY5nr/JVoVODYOoyzNQpQ2GVGzq2BdGvyFDWtMkfHh29UtALrmk7vzfcmIUx1q8f71tY=
X-Received: by 2002:a63:ce04:0:b0:381:3e22:4e74 with SMTP id
 y4-20020a63ce04000000b003813e224e74mr380242pgf.352.1647189341167; Sun, 13 Mar
 2022 09:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211030175258.1716178-1-masahiroy@kernel.org> <Yis7Z90qvPz+EcTk@shell.armlinux.org.uk>
In-Reply-To: <Yis7Z90qvPz+EcTk@shell.armlinux.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 14 Mar 2022 01:35:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4k=Cseox6jEunLxU+w=VTQ08c9gdmt6=K2vvvSL49bg@mail.gmail.com>
Message-ID: <CAK7LNAT4k=Cseox6jEunLxU+w=VTQ08c9gdmt6=K2vvvSL49bg@mail.gmail.com>
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

On Fri, Mar 11, 2022 at 9:07 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Sun, Oct 31, 2021 at 02:52:58AM +0900, Masahiro Yamada wrote:
> > As commit 7ae4a78daacf ("ARM: 8969/1: decompressor: simplify libfdt
> > builds") stated, copying source files during the build time may not
> > end up with as clean code as expected.
> >
> > Do similar for the other library files for further cleanups of the
> > Makefile and .gitignore.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Hi,
>
> I am now seeing the following every time I run a build:
>
>   GEN     Makefile
>   CALL    .../linux-rmk/scripts/atomic/check-atomics.sh
>   CALL    .../linux-rmk/scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   Kernel: arch/arm/boot/Image is ready
>   AS      arch/arm/boot/compressed/lib1funcs.o
>   AS      arch/arm/boot/compressed/ashldi3.o
>   AS      arch/arm/boot/compressed/bswapsdi2.o
>   LD      arch/arm/boot/compressed/vmlinux
>   OBJCOPY arch/arm/boot/zImage
>   Kernel: arch/arm/boot/zImage is ready
>
> In other words, those three objects are always rebuilt even though
> they haven't changed.
>
> I've tried removing the arch/arm/boot/compressed directory in the
> build tree, but that doesn't make any difference.
>
> Running with V=2 shows:
>
>   AS      arch/arm/boot/compressed/lib1funcs.o - due to lib1funcs.o not in $(tar
> gets)
>   AS      arch/arm/boot/compressed/ashldi3.o - due to ashldi3.o not in $(targets)
>   AS      arch/arm/boot/compressed/bswapsdi2.o - due to bswapsdi2.o not in $(targets)
>
> It looks to me like:
> OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o
>
> in your patch should have been added before:
>
> targets       := vmlinux vmlinux.lds piggy_data piggy.o \
>                  head.o $(OBJS)
>
> Please confirm.


Sorry for my late reply.

Yes, you are right.

OBJS    += lib1funcs.o ashldi3.o bswapsdi2.o

should come before the 'targets' assignment.





-- 
Best Regards
Masahiro Yamada
