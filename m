Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304B51EF47
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiEHTG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354848AbiEHSeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:34:11 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD32DF7;
        Sun,  8 May 2022 11:30:20 -0700 (PDT)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 248IU6Hg021713;
        Mon, 9 May 2022 03:30:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 248IU6Hg021713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652034607;
        bh=lYdfiXpHTiwBCIC8Ig2nInkqB5OuwCT5uW2/zGo7dOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N9Qtj8XTZZpzZImTNAb2diQQG3iM7RCIb9vpt++PynIkvAhBO/Aq5pa79mSFUk7BD
         fpaPTY5OpD0RiGhvHMmhRfZ7bv+V1yElb9Vola0sKt6ljrKMnR0X/cDbO6Ahn06rE0
         JRV3aqnnl+y8YCk4gspRXgxEoTbGE5/ntk1yqS+WuMkkJ+HeggorYy3jzpfyekeGup
         wscBlaOmn7ENTdsQCTnJGN2aQdzU3XixtiDBSW7G/mB172v+dmHRVihhGIBC+RPvO5
         Zx2lQVtBZFbwIWvgZcSg+IH+ShFDxV+6dS5Ke94eNROPBCWqFwCMpLlRCNJRODxwmL
         nmKAjiAn5iaLg==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id bo5so10468308pfb.4;
        Sun, 08 May 2022 11:30:06 -0700 (PDT)
X-Gm-Message-State: AOAM5321nUQDmkNs36fpsxDNR90BlKMbqLoEk0A4/8b2gPfdEpsCkPcn
        nv0fZNHEiBTiha7b4ONieKSX6Eb0j2CvO2xR1Ew=
X-Google-Smtp-Source: ABdhPJzSZw3CPCsDznAcGlLU11AUbvg46ozEB8e0OAnUju+5EAH166Q3DSIdjEyp9NwVCGBOR0PvXe4zM/kxvMm2SEI=
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id
 d12-20020a056a0024cc00b0050d58bf5104mr12632485pfv.36.1652034605828; Sun, 08
 May 2022 11:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220505072244.1155033-1-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 May 2022 03:28:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQg2JG2DAuRJmNLryDh_o_PoFUXnJ+6C=-AE+NXZy9pTg@mail.gmail.com>
Message-ID: <CAK7LNAQg2JG2DAuRJmNLryDh_o_PoFUXnJ+6C=-AE+NXZy9pTg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS)
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-um@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 4:24 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This is the third batch of cleanups in this development cycle.
>
> Major changes in v3:
>
>  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
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
> Masahiro Yamada (15):
>   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
>   modpost: change the license of EXPORT_SYMBOL to bool type
>   modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
>   modpost: move *.mod.c generation to write_mod_c_files()
>   kbuild: generate a list of objects in vmlinux
>   kbuild: record symbol versions in *.cmd files
>   modpost: extract symbol versions from *.cmd files
>   kbuild: link symbol CRCs at final link, removing
>     CONFIG_MODULE_REL_CRCS
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format to modpost
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   modpost: simplify the ->is_static initialization
>   modpost: use hlist for hash table implementation
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error


Only 03-06 were applied.

I will send v4 for the rest.
(I rewrote the static EXPORT checks).

>
>  arch/powerpc/Kconfig         |   1 -
>  arch/s390/Kconfig            |   1 -
>  arch/um/Kconfig              |   1 -
>  include/asm-generic/export.h |  22 +-
>  include/linux/export.h       |  30 +--
>  include/linux/symversion.h   |  13 +
>  init/Kconfig                 |   4 -
>  kernel/module.c              |  10 +-
>  scripts/Kbuild.include       |   4 +
>  scripts/Makefile.build       | 118 +++------
>  scripts/Makefile.lib         |   7 -
>  scripts/Makefile.modfinal    |   5 +-
>  scripts/Makefile.modpost     |   9 +-
>  scripts/genksyms/genksyms.c  |  18 +-
>  scripts/link-vmlinux.sh      |  46 ++--
>  scripts/mod/file2alias.c     |   2 -
>  scripts/mod/list.h           |  52 ++++
>  scripts/mod/modpost.c        | 449 ++++++++++++++++++++---------------
>  scripts/mod/modpost.h        |   2 +
>  19 files changed, 402 insertions(+), 392 deletions(-)
>  create mode 100644 include/linux/symversion.h
>
> --
> 2.32.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20220505072244.1155033-1-masahiroy%40kernel.org.



-- 
Best Regards
Masahiro Yamada
