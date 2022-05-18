Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE552C664
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiERWih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiERWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:38:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6346987204
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:38:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a23so4169096ljd.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gdFSEosSAzTBXsu35THTpPMw3mGz0j3zFfiuE2MhAY=;
        b=DBCDYEj9O79QGw1FqBTNKBN+UG/9b8MI+aWVV/QwexN4gbJ2Amb3SPW+GCbUY5i3+N
         SgYOwJHat25fpLjb6YVNE2HgjKIRAfAC09GzTJhO8vnLvQa+7yhkGDObb4amXFRV1Kyw
         +Cw+laGn/BdFpRqa7l8fZp9kbEtzow+apOaSmIEp4/S+6l/SK6aCTFPHQwQDhWe9mY8D
         Md2X1lcXvFI6DY3j8QVa0t7FPC9yHcAdGEwIxC/cjgZaMcT4mRr41hc6BU9r2FO8zojX
         nsum4g2gea72U9JYJVhZdK/3nJIIKkAH8NO3jVj8DR+RTBDjtSlKAdY0KKnyeWNDnBaA
         NVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gdFSEosSAzTBXsu35THTpPMw3mGz0j3zFfiuE2MhAY=;
        b=FvuVkhMYMhCfIZJdTt6C1y5f6mYkLZdt99CrNBtQk9S+DZetuN/9VVuzxB1YartPUo
         /pBYzVX9ZqCNagFFoQ1TU7HiMpzeln6wPitzV4wkX8tuDq0F9OF1H2YehTSljaUuEoHr
         dnctkIiyc92salhMoA05LNKpcfdzXIdy0QjRmuvx7T1CRaXkI1AavJa4MWlJar5J5486
         DT64TnDVmKtLAgKAZu7Pmj+B1wNVLtiz2U0Nq5EKBgLsBLq4HtRz+RGvUZh42S94Hpu5
         XBRS8h9PcHGDhWwUsQtl/AW39T8XxyMZ9eDchOJs01vDAAZMMP9Cbq56pvpgi9Hl46N6
         PmIw==
X-Gm-Message-State: AOAM531AJWSH3lM68Y8v7ftsZSSGi6NjgmVoFO+zwBT4aCcslaJGmI0q
        31wxz+gz5bmJwqu2hbik1cXvdBIk7idVAwUTUqcRAg==
X-Google-Smtp-Source: ABdhPJxIvkMHr6Wdqc9RtIs7R9Iciobl7SAFqpROG3q5kajc4MrpS/iRKSLKPONXjr32ZMmvkbRxQg1q/DnFVMkdTfY=
X-Received: by 2002:a2e:a7c8:0:b0:24f:700a:4df5 with SMTP id
 x8-20020a2ea7c8000000b0024f700a4df5mr916472ljp.472.1652913510399; Wed, 18 May
 2022 15:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220516210954.1660716-5-ndesaulniers@google.com> <202205180917.RNpZaxIl-lkp@intel.com>
In-Reply-To: <202205180917.RNpZaxIl-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 May 2022 15:38:18 -0700
Message-ID: <CAKwvOdmkd2PxvMUZA=A-72eATGDZkqDj--Bv1W+Xt_K_LWdROA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: pass -march= only to compiler
To:     David Spickett <david.spickett@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lore thread, for context:
https://lore.kernel.org/llvm/20220516210954.1660716-1-ndesaulniers@google.com/

On Tue, May 17, 2022 at 6:26 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nick,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on 0ac824f379fba2c2b17b75fd5ada69cd68c66348]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulniers/pass-march-only-to-compiler/20220517-051756
> base:   0ac824f379fba2c2b17b75fd5ada69cd68c66348
> config: arm-randconfig-r026-20220516 (https://download.01.org/0day-ci/archive/20220518/202205180917.RNpZaxIl-lkp@intel.com/config)

^ looks like this is a THUMB2 build.

> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/6da98100eed87e4316be5ec584fe415134f25a3e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Nick-Desaulniers/pass-march-only-to-compiler/20220517-051756
>         git checkout 6da98100eed87e4316be5ec584fe415134f25a3e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> arch/arm/crypto/poly1305-core.S:16:1: error: target does not support ARM mode
>    .code 32
>    ^

It looks like arch/arm/crypto/poly1305-core.S has a preprocessor guard
for __thumb2__.

My change changes the command line from:

from:
$(CC) ... -march=armv7-m ...
to:
$(CC ... -Wa,-march=armv7-m ...

(where ... contains `-mthumb -Wa,-mthumb` for BOTH).

$ arm-linux-gnueabi-gcc -march=armv7-m -mthumb -dM -E - < /dev/null | grep thumb
#define __thumb2__ 1
#define __thumb__ 1
$ arm-linux-gnueabi-gcc -Wa,-march=armv7-m -mthumb -dM -E - <
/dev/null | grep thumb
#define __thumb__ 1
$ clang --target=arm-linux-gnueabi -march=armv7-m -mthumb -dM -E - <
/dev/null | grep thumb
#define __thumb2__ 1
#define __thumb__ 1
$ clang --target=arm-linux-gnueabi -Wa,-march=armv7-m -mthumb -dM -E -
< /dev/null | grep thumb
#define __thumb__ 1
$

(so it seems that the preprocessor definition of `__thumb2__` is
dependent on `-march=`, not `-Wa,-march=`).

David, we might have a very subtle bug in clang:

$ clang --target=arm-linux-gnueabi -mthumb -Wa,-mthumb -march=armv7-m
-Wa,-march=armv7-m -x assembler-with-cpp
-Wunused-command-line-argument - < /dev/null -dM -E
<prints a bunch of preprocessor defines, but no instance of
-Wunused-command-line-argument>
$ clang --target=arm-linux-gnueabi -mthumb -Wa,-mthumb -march=armv7-m
-Wa,-march=armv7-m -x assembler-with-cpp
-Wunused-command-line-argument - < /dev/null -dM -c
clang-15: warning: argument unused during compilation:
'-march=armv7-m' [-Wunused-command-line-argument]

That seems weird because -c vs -E have different behaviors regarding
-Wunused-command-line-argument, and it seems like for `-x
assembler-with-cpp` that the -march= flag without -Wa, prefix *is*
expected to control the behavior of certain preprocessor defines like
`__thumb2__`.

Perhaps a more straightforward test case:
```asm
@ x.S
@ clang --target=arm-linux-gnueabi -mthumb -Wa,-mthumb -march=armv7-m \
@   -Wa,-march=armv7-m -Wunused-command-line-argument x.S -c
.syntax unified
.text
foo:
  movs r0, #__thumb2__
```

$ clang --target=arm-linux-gnueabi -mthumb -Wa,-mthumb -march=armv7-m
-Wa,-march=armv7-m -Wunused-command-line-argument x.S -c
clang-15: warning: argument unused during compilation:
'-march=armv7-m' [-Wunused-command-line-argument]

$ llvm-objdump -dr x.o | tail -n 2
00000000 <foo>:
       0: 01 20        movs r0, #1

Obviously that warning about `-Wunused-command-line-argument` is
incorrect; the value of `__thumb2__` comes from the preprocessor and
is controlled by `-march=armv7-m`. It can't be simultaneously "unused"
and used to define particular preprocessor directives.

Using the above command line invocation without `-march=armv7-m`
produces the assembler-time failure:
/tmp/x-03ab60.s:10:3: error: unsupported relocation on symbol
  movs r0, #__thumb2__
  ^
because __thumb2__ is not defined.

(perhaps `#ifundef __thumb2__ #error "oops" #endif` would be simpler yet).


>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>


--
Thanks,
~Nick Desaulniers
