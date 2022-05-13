Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B35261BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380202AbiEMMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379717AbiEMMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:22:27 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F313FD56;
        Fri, 13 May 2022 05:22:24 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24DCMAHY024757;
        Fri, 13 May 2022 21:22:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24DCMAHY024757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652444531;
        bh=N9bbKmHP6POe42Fa+GkW40EBGebzX8tThTjuBWdq8ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iTUSZMXFn0b0ySQUWXG+bN57jeWcY/6TqbY5S5aZcQ/kCoZfP7nRnS7sHgViAZRNN
         wDaiei0KZlaKsN1DmBPtcqARjKtLh8u07vqbDgot1zXlPVl8ozeINxWNhKT78anmeD
         MQsMYS3nDed1y34788+wUVXLLyUtHPQcemLYtcO3lWOjouuXJK5KAuaFkVsgLpiRHk
         5EPCMq/z3k46EHOXHAjomlBB+N/bIGiCpnFZq5SuOTa/brRI6+YlJqlwhtj1BF0veO
         c3ZcdRLraUhwKE/pE0JRarqZEMxev0+S3ZhiPXMpvvMPFVRpa7GrNHeQS9hPkyFUJv
         JtwfNw6AsK7/A==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id o69so7933024pjo.3;
        Fri, 13 May 2022 05:22:11 -0700 (PDT)
X-Gm-Message-State: AOAM530E2whA2qvySvkKq0FPrPu9j7KkEl1lBXYvnB7ssGCZf+Ob3VER
        VU8S9Z8FC+hMgQiSWWdJlywr+R2WOFzpCic0EnQ=
X-Google-Smtp-Source: ABdhPJxD5Hnw/BzpOuoc03CTdnOknz232P4SJXD9vQoGZjeOfKjWtDeamnUaHXxR78Q1KZ637m8h49Kf8LDy4D9zobk=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr4634068pjy.77.1652444530238; Fri, 13
 May 2022 05:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org>
In-Reply-To: <20220513113930.10488-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 21:20:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
Message-ID: <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This is the third batch of cleanups in this development cycle.
>


This series is available at
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 lto-cleanup-v6


>
> Changes in v6:
>   - Fix false-positive warnings when CONFIG_TRIM_UNUSED_KSYMS=y
>
> Changes in v5:
>   - Fix the build error when CONFIG_DEBUG_INFO_BTF=y (reported by Nathan)
>   - Clean up arch/m68k/include/asm/export.h (Nick)
>   - Keep gen_symversions (and will be removed by a later patch)
>   - Add more comments in the script
>
> Changes in v4:
>   - Rename .vmlinux-symver.c to .vmlinux.export.c
>     because I notice this approach is useful for further cleanups,
>     not only for modversioning but also for overall EXPORT_SYMBOL.
>   - New patch
>   - New.
>     Resent of my previous submission.
>     https://lore.kernel.org/all/20210831074004.3195284-10-masahiroy@kernel.org/
>   - New
>     Resent of my previous submission
>     https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/
>
> Changes in v3:
>   - New patch
>
> Changes in v2:
>   - Simplify the implementation (parse .cmd files after ELF)
>   - New patch
>  - replace the chain of $(if ...) with $(and )
>   - New patch
>   - New patch
>
> Masahiro Yamada (10):
>   modpost: extract symbol versions from *.cmd files
>   kbuild: link symbol CRCs at final link, removing
>     CONFIG_MODULE_REL_CRCS
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format to modpost
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   kbuild: check static EXPORT_SYMBOL* by script instead of modpost
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error
>   kbuild: add cmd_and_savecmd macro
>   kbuild: rebuild multi-object modules when objtool is updated
>
>  arch/m68k/include/asm/Kbuild    |   1 +
>  arch/m68k/include/asm/export.h  |   2 -
>  arch/powerpc/Kconfig            |   1 -
>  arch/s390/Kconfig               |   1 -
>  arch/um/Kconfig                 |   1 -
>  include/asm-generic/export.h    |  22 ++-
>  include/linux/export-internal.h |  16 +++
>  include/linux/export.h          |  30 ++--
>  init/Kconfig                    |   4 -
>  kernel/module.c                 |  10 +-
>  scripts/Kbuild.include          |  10 +-
>  scripts/Makefile.build          | 134 ++++++------------
>  scripts/Makefile.lib            |   7 -
>  scripts/Makefile.modfinal       |   5 +-
>  scripts/Makefile.modpost        |   9 +-
>  scripts/check-local-export      |  64 +++++++++
>  scripts/genksyms/genksyms.c     |  18 +--
>  scripts/link-vmlinux.sh         |  33 ++---
>  scripts/mod/modpost.c           | 236 +++++++++++++++++++++-----------
>  19 files changed, 320 insertions(+), 284 deletions(-)
>  delete mode 100644 arch/m68k/include/asm/export.h
>  create mode 100644 include/linux/export-internal.h
>  create mode 100755 scripts/check-local-export
>
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
