Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF451B84B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiEEHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiEEHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:00:34 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F7377EF;
        Wed,  4 May 2022 23:56:54 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2456uUBv002675;
        Thu, 5 May 2022 15:56:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2456uUBv002675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651733791;
        bh=i8UVQkDD1UoDas2ND/0n+dx2bVcfUGCIy5PTWE5iI2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NtasHN6CYnJgzyHeGmjakUgOvG3aQKwjwNspzBvJfa1nSTNKB4VJeRjgFr0h5iWGJ
         Ed2Et83jp97YZI9+ZUWaVzBXPPX1vZ//SjsMzPahP6YGDI5Rd6UKLEL/MHair6kyzE
         HPhD5JAqaR9pf4QesMJeU20UDYZQYyN+9Eq9t/5sTApSPPHiolvlKR3iSxpM9YwyXe
         2SUg+dGMYYWojipEOySJ7oKWhzNz6zcZYI7ZbcxDIqt71lS+B1o/lBT2V8FMZjjC44
         pAno5SkQ/NzVS7IwoMVpMOfRvBVdrIQlZgTvw4h4vP7BDlaSmNWsGYuPIPixYu9ei/
         PJTBm3RAS79dg==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id c9so2868684plh.2;
        Wed, 04 May 2022 23:56:31 -0700 (PDT)
X-Gm-Message-State: AOAM5311GHW8mMR+MGIR17B/xRk2rCgDmGgXiEvAmLV8Y+9CX++l37uF
        WTAUnh9wisV+08zzPQpBX0G5goKwElr2M4sYZeo=
X-Google-Smtp-Source: ABdhPJxsF51fbTyL6C4bazzUfCl2jPYlFrYotwR5hNcMGm8bZWKjxRNEqo5gx4CM+pyfrjnfAbsIB5F+gLE6/gs6RWU=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr25314570plp.162.1651733790231; Wed, 04
 May 2022 23:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220501084032.1025918-1-masahiroy@kernel.org>
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 May 2022 15:55:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3JmpfJRU4xJisuZCzpN7OkK078MP5okBT-PD=N1R9jg@mail.gmail.com>
Message-ID: <CAK7LNAQ3JmpfJRU4xJisuZCzpN7OkK078MP5okBT-PD=N1R9jg@mail.gmail.com>
Subject: Re: [PATCH v2 00/26] kbuild: yet another series of cleanups (modpost
 and LTO)
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 5:42 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This is the third batch of cleanups in this development cycle.
>
> Major changes in v2:
>
>  - V1 did not work with CONFIG_MODULE_REL_CRCS.
>    I fixed this for v2.
>
>  - Reflect some review comments in v1
>
>  - Refactor the code more
>
>  - Avoid too long argument error
>
>
>
> Masahiro Yamada (26):
>   modpost: use bool type where appropriate
>   modpost: change mod->gpl_compatible to bool type
>   modpost: import include/linux/list.h
>   modpost: traverse modules in order
>   modpost: add sym_add_unresolved() helper
>   modpost: traverse unresolved symbols in order
>   modpost: use doubly linked list for dump_lists
>   modpost: traverse the namespace_list in order
>   modpost: dump Module.symvers in the same order of modules.order
>   modpost: move static EXPORT_SYMBOL check to check_exports()
>   modpost: make multiple export error
>   modpost: make sym_add_exported() always allocate a new symbol
>   modpost: split new_symbol() to symbol allocation and hash table
>     addition
>   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
>   kbuild: record symbol versions in *.cmd files
>   kbuild: generate a list of objects in vmlinux
>   modpost: extract symbol versions from *.cmd files
>   modpost: generate linker script to collect symbol versions
>   kbuild: embed symbol versions at final link of vmlinux or modules
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format for .cmd files
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error
>   modpost: simplify the ->is_static initialization
>   modpost: use hlist for hash table implementation

Applied 01-13 to linux-kbuild
with Nick's reviewed-by.

I will send v3 for the rest.

>  .gitignore                  |   1 +
>  Makefile                    |   1 +
>  scripts/Kbuild.include      |   4 +
>  scripts/Makefile.build      | 118 +++------
>  scripts/Makefile.lib        |   7 -
>  scripts/Makefile.modfinal   |   6 +-
>  scripts/Makefile.modpost    |  10 +-
>  scripts/genksyms/genksyms.c |  17 +-
>  scripts/link-vmlinux.sh     |  34 +--
>  scripts/mod/file2alias.c    |   2 -
>  scripts/mod/list.h          | 265 +++++++++++++++++++
>  scripts/mod/modpost.c       | 501 ++++++++++++++++++++++--------------
>  scripts/mod/modpost.h       |  24 +-
>  scripts/mod/sumversion.c    |   8 +-
>  14 files changed, 650 insertions(+), 348 deletions(-)
>  create mode 100644 scripts/mod/list.h
>
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
