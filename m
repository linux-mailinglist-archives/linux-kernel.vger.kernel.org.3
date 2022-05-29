Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72195371E3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiE2RXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2RXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:23:50 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB28B0B9;
        Sun, 29 May 2022 10:23:48 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24THNOmv014682;
        Mon, 30 May 2022 02:23:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24THNOmv014682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653845005;
        bh=bCrnqZ73LrY+CrTrFzwBpHxyiG280vJTTT4HrcMrMgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NqxseqONBIyg0dU6gZLn3A0qzinf+XP2roYRNu9Qr0FdsW4TIg9wX1HBNd/gyCJmi
         e0SR2KxFullbbwI3Rg/wToycnGq6VIHN1jrdcFyDJhF4HTk7RQxqT6msSluLm+g4Hb
         hAjExjoQ/HNafhv/4CUdhxG64AWJfCl0G9YrElTlkX/Fje8nYNYTHCFAvphN9pNyuw
         c7V8xlCV4aC7ZwL6Ni0zYEvQbfGY4S7O7q/2twssL/A5HGNRXaG22MySddFdSqmj81
         FdCdwKT48PP83bzBvh4w363SMcVp3cOnNrNJrXMEtnFagiAF+6mgnnZtZn7snbipKs
         rF+2eycbBTNbQ==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so2233345pjo.0;
        Sun, 29 May 2022 10:23:24 -0700 (PDT)
X-Gm-Message-State: AOAM5319TTzkFBgpNMW/nvjbR9XECCt5EjulI+Twl4HQwsLiGD589oWE
        AmYDFmxqTmq6wGClHBcJWwfDzo3AsntWrCYnOhE=
X-Google-Smtp-Source: ABdhPJyCnVj3/mg2P1j7yBoOP95uSdcr/aPqUWTn1pYgrfcGChafVewLxtIHGPTwC3PlVOeAlqHNnEVjSTp76IkHZY0=
X-Received: by 2002:a17:90a:9412:b0:1e0:c0cc:8630 with SMTP id
 r18-20020a17090a941200b001e0c0cc8630mr18749651pjo.77.1653845003813; Sun, 29
 May 2022 10:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220529042318.2630379-1-masahiroy@kernel.org> <YpOLHkUZImdEr7yl@antec>
In-Reply-To: <YpOLHkUZImdEr7yl@antec>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 May 2022 02:21:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNATXjQdd2MGf2v_1WYP6zc0sMU31338Ca-2zKQttV9FYvg@mail.gmail.com>
Message-ID: <CAK7LNATXjQdd2MGf2v_1WYP6zc0sMU31338Ca-2zKQttV9FYvg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: ignore *.cmd files for objects that come from libgcc.a
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Guo Ren <guoren@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-csky@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        nicolas@debian.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 12:02 AM Stafford Horne <shorne@gmail.com> wrote:
>
> Cc Joel, Nicolas
>
> On Sun, May 29, 2022 at 01:23:18PM +0900, Masahiro Yamada wrote:
> > Guenter Roeck reported the build breakage for parisc and csky.
> > I confirmed nios2 and openrisc are broken as well.
>
> Joel reported and issue building the openrisc kernel as well with this error:
>
>     This fails at the link step:
>
>       LD      vmlinux.o
>     + or1k-elf-ld -r -o vmlinux.o --whole-archive
>     arch/openrisc/kernel/head.o init/built-in.a usr/built-in.a
>     arch/openrisc/built-in.a kernel/built-in.a certs/built-in.a
>     mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a
>     crypto/built-in.a block/built-in.a lib/built-in.a drivers/built-in.a
>     sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive
>     --start-group lib/lib.a /usr/lib/gcc/or1k-elf/12/libgcc.a --end-group
>     or1k-elf-ld: /usr/lib/gcc/or1k-elf/12/libgcc.a: error adding symbols:
>     archive has no index; run ranlib to add one
>
> Is it the same? It might be good to have details of the error in the commit
> message.


Probably, no.

I do not know when the error above happens.



I got the following error message for  ARCH=openrisc allmodconfig.

  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
.__mulsi3.o.cmd: No such file or directory
make[2]: *** [scripts/Makefile.modpost:59: vmlinux.symvers] Error 1
make[1]: *** [Makefile:1160: vmlinux] Error 2
make: *** [Makefile:350: __build_one_by_one] Error 2





>
> > The reason is that they borrow libgcc.a from the toolchains.
> >
> > For example, see this line in arch/parisc/Makefile:
> >
> >     LIBGCC          := $(shell $(CC) -print-libgcc-file-name)
> >
> > Some objects in libgcc.a are linked to vmlinux.o, but they do not have
> > .*.cmd files.
> >
> > Obviously, there is no EXPORT_SYMBOL in external objects. Ignore them.
> >
> > (Most of the architectures import library code into the kernel tree.
> > Perhaps those 4 architectures can do similar, but I am not sure.)
>
> Ill have a look at this.  Could you give an example of what you mean by import
> library code, from where?  OpenRISC imports builtins from libgcc, also we have
> string and other lib routines from within the port.
>
> -Stafford
>

"git grep __mulsi3" showed some *.S files of other architectures.

You can ask the authors of the following commits:

4e07dba7cb8c9c76a52d0e32b69f13bb583a9674
dbf4ed894c0fd85d421f7b3b9758ce95398d2925


-- 
Best Regards
Masahiro Yamada
