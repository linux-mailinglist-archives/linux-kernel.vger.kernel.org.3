Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD70532278
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiEXFeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiEXFes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:34:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F57CDD9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:34:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j4so17198930edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=glpZuyPsUMieasA0HPPFEp5bev/OhuZq72HQPTw1Eec=;
        b=m13Q3sofpKHJXwUt3aGY8wkx25+NkwNJoIWmZFRkOY5fiTmFaAbk4p7EC9kU6eI07F
         6pkugOkaJlNZ+FduEDFc0uM038uyaP6px5I0A12zYZfKWho9oxnf3nWp2F97M0jiCbOx
         ZXeGbVwAqw5n7G/eMZl1i/TRPzu24nlrxbkeekv2v1c4m/t/qniKxammFQWTC8J3+cEK
         b4g0dwo+2+sJdxMNVmSyEGByfm7xveyZzS5Dg20YKzSp0J0ZdbUxmbCSMf0gQMGPFv1Q
         7UiGeci/bgSrtOu6nQBSl15gCzm2zsF0n3j/ZCRTlfNXoEiJrfCehg8WUkWxVg3D05iR
         bDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=glpZuyPsUMieasA0HPPFEp5bev/OhuZq72HQPTw1Eec=;
        b=rXgBKad93swKDMhK+iZgxaNai608rsNXyUQn0pRQexSOkRNp735Ea2BQGvNW9uYM4N
         7zA+ekJeJ7qZBxhpPEYGW4Kitb63KPRg8UhWtuVb5hcr9wqTlSg1ZB7lBd4hNWYYhbgw
         3Z4HHYGNTxnyll/XgFbm7oBw9o3NLvDgECiGSDWgTl5fKfCdFEXWT8rs9vNqEPrLEkAX
         QtR/Fvifl9yQc0fZje7cuCywair8GVJ/+pMpVjD/I/TKZ5fs4B/WPG4h5pmy+ZDW+ahG
         32wq07u98V/xJX63v0DYVv/s1RCX/WyCSsiFdltzLL8019To8ZgVoP4phdcfLp1p+CWF
         8SYw==
X-Gm-Message-State: AOAM530/H+oK1Eexgde/BF/ISx7TuSq8CtTlETAJIiquzd317BUt44RZ
        nKhxgqIUylM5BP7FPEulghvmOetGoPc=
X-Google-Smtp-Source: ABdhPJyNcfMlJVBHWF3Cm4qsPISnxR0Y5vPOd9gOwXchXvi71U3uzLX1UePGiaJHr7RJQ5ANXTWojA==
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id h5-20020a0564020e8500b0041d121bf436mr27329683eda.121.1653370484825;
        Mon, 23 May 2022 22:34:44 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id cy23-20020a0564021c9700b0042617ba63c8sm9113939edb.82.2022.05.23.22.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:34:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 24 May 2022 07:34:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] objtool changes for v5.19
Message-ID: <Yoxucp7aUrCaV9uE@gmail.com>
References: <You3JC/BOIyEnmQj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <You3JC/BOIyEnmQj@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest objtool/core git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2022-05-23
> 
>    # HEAD: 22682a07acc308ef78681572e19502ce8893c4d4 objtool: Fix objtool regression on x32 systems
> 
> Objtool changes for this cycle were:
> 
>  - Comprehensive interface overhaul:
>    =================================
> 
>    Objtool's interface has some issues:
> 
>      - Several features are done unconditionally, without any way to turn
>        them off.  Some of them might be surprising.  This makes objtool
>        tricky to use, and prevents porting individual features to other
>        arches.
> 
>      - The config dependencies are too coarse-grained.  Objtool enablement is
>        tied to CONFIG_STACK_VALIDATION, but it has several other features
>        independent of that.
> 
>      - The objtool subcmds ("check" and "orc") are clumsy: "check" is really
>        a subset of "orc", so it has all the same options.  The subcmd model
>        has never really worked for objtool, as it only has a single purpose:
>        "do some combination of things on an object file".
> 
>      - The '--lto' and '--vmlinux' options are nonsensical and have
>        surprising behavior.
> 
>    Overhaul the interface:
> 
>       - get rid of subcmds
> 
>       - make all features individually selectable
> 
>       - remove and/or clarify confusing/obsolete options
> 
>       - update the documentation
> 
>       - fix some bugs found along the way
> 
>  - Fix x32 regression
> 
>  - Fix Kbuild cleanup bugs
> 
>  - Add scripts/objdump-func helper script to disassemble a single function from an object file.
> 
>  - Rewrite scripts/faddr2line to be section-aware, by basing it on 'readelf',
>    moving it away from 'nm', which doesn't handle multiple sections well,
>    which can result in decoding failure.
> 
>  - Rewrite & fix symbol handling - which had a number of bugs wrt. object files
>    that don't have global symbols - which is rare but possible. Also fix a
>    bunch of symbol handling bugs found along the way.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>  Thanks,
> 
> 	Ingo
> 
> ------------------>
> Borislav Petkov (1):
>       x86/cpu: Load microcode during restore_processor_state()
> 
> Dmitry Monakhov (1):
>       x86/unwind/orc: Recheck address range after stack info was updated
> 
> Josh Poimboeuf (27):
>       MAINTAINERS: Add x86 unwinding entry
>       objtool: Enable unreachable warnings for CLANG LTO
>       x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
>       x86/retpoline: Add ANNOTATE_NOENDBR for retpolines
>       x86/uaccess: Add ENDBR to __put_user_nocheck*()
>       x86/xen: Add ANNOTATE_NOENDBR to startup_xen()
>       objtool: Print data address for "!ENDBR" data warnings
>       objtool: Use offstr() to print address of missing ENDBR
>       libsubcmd: Fix OPTION_GROUP sorting
>       objtool: Reorganize cmdline options
>       objtool: Ditch subcommands
>       objtool: Don't print parentheses in function addresses
>       objtool: Add option to print section addresses
>       objtool: Make stack validation optional
>       objtool: Rework ibt and extricate from stack validation
>       objtool: Extricate sls from stack validation
>       objtool: Add CONFIG_OBJTOOL
>       objtool: Make stack validation frame-pointer-specific
>       objtool: Make static call annotation optional
>       objtool: Make jump label hack optional
>       objtool: Make noinstr hacks optional
>       objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
>       objtool: Add HAVE_NOINSTR_VALIDATION
>       objtool: Remove --lto and --vmlinux in favor of --link
>       objtool: Update documentation
>       scripts: Create objdump-func helper script
>       scripts/faddr2line: Fix overlapping text section failures
> 
> Mikulas Patocka (1):
>       objtool: Fix objtool regression on x32 systems
> 
> Nur Hussein (1):
>       x86/Kconfig: fix the spelling of 'becoming' in X86_KERNEL_IBT config
> 
> Peter Zijlstra (5):
>       lib/strn*,objtool: Enforce user_access_begin() rules
>       x86,xen,objtool: Add UNWIND hint
>       x86,objtool: Mark cpu_startup_entry() __noreturn
>       x86,objtool: Explicitly mark idtentry_body()s tail REACHABLE
>       objtool: Fix symbol creation
> 
> Tiezhu Yang (2):
>       objtool: Remove inat-tables.c when make clean
>       objtool: Remove libsubcmd.a when make clean
> 
> Tony Luck (1):
>       x86/cpu: Add new Alderlake and Raptorlake CPU model numbers
> 
> 
>  MAINTAINERS                                        |   9 +
>  Makefile                                           |   2 +-
>  arch/Kconfig                                       |  18 +-
>  arch/x86/Kconfig                                   |  23 +-
>  arch/x86/Kconfig.debug                             |   2 +-
>  arch/x86/entry/entry_64.S                          |   3 +
>  arch/x86/include/asm/intel-family.h                |   3 +
>  arch/x86/include/asm/jump_label.h                  |   6 +-
>  arch/x86/include/asm/microcode.h                   |   2 +
>  arch/x86/include/asm/static_call.h                 |   1 +
>  arch/x86/kernel/alternative.c                      |   6 +-
>  arch/x86/kernel/cpu/microcode/core.c               |   6 +-
>  arch/x86/kernel/unwind_orc.c                       |   8 +-
>  arch/x86/lib/putuser.S                             |   4 +
>  arch/x86/lib/retpoline.S                           |   2 +-
>  arch/x86/platform/pvh/head.S                       |   1 +
>  arch/x86/power/cpu.c                               |  10 +-
>  arch/x86/xen/xen-head.S                            |   1 +
>  include/linux/compiler.h                           |   6 +-
>  include/linux/cpu.h                                |   2 +-
>  include/linux/instrumentation.h                    |   6 +-
>  include/linux/objtool.h                            |   6 +-
>  kernel/trace/Kconfig                               |   1 +
>  lib/Kconfig.debug                                  |  22 +-
>  lib/Kconfig.kcsan                                  |   4 +-
>  lib/Kconfig.ubsan                                  |   2 +-
>  lib/strncpy_from_user.c                            |   2 +-
>  lib/strnlen_user.c                                 |   2 +-
>  scripts/Makefile.build                             |  23 +-
>  scripts/faddr2line                                 | 150 ++++---
>  scripts/link-vmlinux.sh                            |  66 +--
>  scripts/objdump-func                               |  29 ++
>  scripts/package/builddeb                           |   2 +-
>  tools/include/linux/objtool.h                      |   6 +-
>  tools/lib/subcmd/parse-options.c                   |  17 +-
>  tools/objtool/Build                                |  12 +-
>  .../{stack-validation.txt => objtool.txt}          | 122 +++++-
>  tools/objtool/Makefile                             |  10 +-
>  tools/objtool/arch/x86/decode.c                    |   2 +-
>  tools/objtool/arch/x86/special.c                   |   2 +-
>  tools/objtool/builtin-check.c                      | 156 +++++--
>  tools/objtool/builtin-orc.c                        |  73 ----
>  tools/objtool/check.c                              | 466 +++++++++++----------
>  tools/objtool/elf.c                                | 211 ++++++----
>  tools/objtool/include/objtool/builtin.h            |  34 +-
>  tools/objtool/include/objtool/elf.h                |  16 +-
>  tools/objtool/include/objtool/warn.h               |  35 +-
>  tools/objtool/objtool.c                            | 103 +----
>  tools/objtool/weak.c                               |   9 +-
>  49 files changed, 1004 insertions(+), 700 deletions(-)
>  create mode 100755 scripts/objdump-func
>  rename tools/objtool/Documentation/{stack-validation.txt => objtool.txt} (80%)
>  delete mode 100644 tools/objtool/builtin-orc.c

Not sure what happened there, a previous x86/urgent got mixed into the 
shortlog & diffstat - this is the correct shortlog & diffstat you should 
get when pulling objtool-core-2022-05-23:

Josh Poimboeuf (19):
      libsubcmd: Fix OPTION_GROUP sorting
      objtool: Reorganize cmdline options
      objtool: Ditch subcommands
      objtool: Don't print parentheses in function addresses
      objtool: Add option to print section addresses
      objtool: Make stack validation optional
      objtool: Rework ibt and extricate from stack validation
      objtool: Extricate sls from stack validation
      objtool: Add CONFIG_OBJTOOL
      objtool: Make stack validation frame-pointer-specific
      objtool: Make static call annotation optional
      objtool: Make jump label hack optional
      objtool: Make noinstr hacks optional
      objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"
      objtool: Add HAVE_NOINSTR_VALIDATION
      objtool: Remove --lto and --vmlinux in favor of --link
      objtool: Update documentation
      scripts: Create objdump-func helper script
      scripts/faddr2line: Fix overlapping text section failures

Mikulas Patocka (1):
      objtool: Fix objtool regression on x32 systems

Peter Zijlstra (2):
      Merge branch 'tip/x86/urgent'
      objtool: Fix symbol creation

Tiezhu Yang (2):
      objtool: Remove inat-tables.c when make clean
      objtool: Remove libsubcmd.a when make clean

 ================>

 Makefile                                                          |   2 +-
 arch/Kconfig                                                      |  18 ++++++-
 arch/x86/Kconfig                                                  |  21 +++++---
 arch/x86/Kconfig.debug                                            |   2 +-
 arch/x86/include/asm/jump_label.h                                 |   6 +--
 arch/x86/kernel/alternative.c                                     |   6 +--
 include/linux/compiler.h                                          |   6 +--
 include/linux/instrumentation.h                                   |   6 +--
 include/linux/objtool.h                                           |   6 +--
 kernel/trace/Kconfig                                              |   1 +
 lib/Kconfig.debug                                                 |  22 ++++----
 lib/Kconfig.kcsan                                                 |   4 +-
 lib/Kconfig.ubsan                                                 |   2 +-
 scripts/Makefile.build                                            |  23 +++++----
 scripts/faddr2line                                                | 150 +++++++++++++++++++++++++++++++++++-------------------
 scripts/link-vmlinux.sh                                           |  66 +++++++++++++++---------
 scripts/objdump-func                                              |  29 +++++++++++
 scripts/package/builddeb                                          |   2 +-
 tools/include/linux/objtool.h                                     |   6 +--
 tools/lib/subcmd/parse-options.c                                  |  17 +++++--
 tools/objtool/Build                                               |  12 ++---
 tools/objtool/Documentation/{stack-validation.txt => objtool.txt} | 122 ++++++++++++++++++++++++++++++++++++--------
 tools/objtool/Makefile                                            |  10 ++--
 tools/objtool/arch/x86/decode.c                                   |   2 +-
 tools/objtool/arch/x86/special.c                                  |   2 +-
 tools/objtool/builtin-check.c                                     | 156 +++++++++++++++++++++++++++++++++++++++++++++-----------
 tools/objtool/builtin-orc.c                                       |  73 --------------------------
 tools/objtool/check.c                                             | 463 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------------
 tools/objtool/elf.c                                               | 211 ++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 tools/objtool/include/objtool/builtin.h                           |  34 +++++++++++--
 tools/objtool/include/objtool/elf.h                               |  16 ++++--
 tools/objtool/include/objtool/warn.h                              |  35 +++++++------
 tools/objtool/objtool.c                                           | 103 ++-----------------------------------
 tools/objtool/weak.c                                              |   9 +---
 34 files changed, 959 insertions(+), 684 deletions(-)
 create mode 100755 scripts/objdump-func
 rename tools/objtool/Documentation/{stack-validation.txt => objtool.txt} (80%)
 delete mode 100644 tools/objtool/builtin-orc.c

Thanks,

	Ingo
