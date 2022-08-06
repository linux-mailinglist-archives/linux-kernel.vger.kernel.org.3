Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF55758B433
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiHFHYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiHFHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:24:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D362CDD8;
        Sat,  6 Aug 2022 00:24:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r195so118066oie.6;
        Sat, 06 Aug 2022 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DqLHDIJbDfQP8RYZFwuqrU0lfisp6NcZ+Sa72zIHLtM=;
        b=dgooMi6em5wkFiLP/ep+hNtXssvR7dzv2HAj/FjYe+9vnEWLFNkJLloGfHgAVuknKA
         sL7eBPnTv3M/xLl9UTGaQqRV2di84y6+5rIUa4C8rCRAwIdSI8wfy0i0xthVt1LoRaP5
         6Ojj0u+GNaRHMkN0So9CJSBgocM1s7Ct4AKezY7svu/ls19hSwIdjP1/pjIYlsYv8do8
         LVWKvV03XkeAmtcyaCya3UnVpOoTPBE7oFaTwc0a0Ed/rCdhpfHNxVuqTOREQo7fiZKY
         0ZaiiaYnVTyilez6NvweP/pB8va+1BwRDf1+2yB+x1L8Uyr8I+QpL0vaugu90uPSD3dR
         7BSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DqLHDIJbDfQP8RYZFwuqrU0lfisp6NcZ+Sa72zIHLtM=;
        b=pTxlUEIof4vvCZ+XOY9sy9VcCX2oAPRkh1diLSnzRW79obFcjLF253iBr6wbANSjrm
         YJN+8naiPim4VLlM8/H/mTRswOSrgMMQtwfgwD1hHCRL1yXxCku//Col3Y0I9gABQt8g
         EjOl+SffuOa99HnO+FUDCaswm7ZhMrRCgZcbVQP1rO8DgFzM7eRtEXqVOa7uvG5wNUlc
         BTAKVBnVMe/TdsR13qv4abIWZRg93vzXiA+/JwjV8dUQ6ryDxqro2Dm1+ZVSzdO1hEvz
         jIlS61J/tCx74w0SQalbWUfPG5sItVTsosjrqIPOtWfUdcMYngUTYV8xZcY92obPYiMR
         Up7w==
X-Gm-Message-State: ACgBeo0Bk33fWNugZoVHyxRV4KvED2wMk9PfXjSZk7yMDFzoy3NT8jZv
        MjWUhu3FyyAnlfJq4+OVx4HRcFWN5RiR8Z+uPl4=
X-Google-Smtp-Source: AA6agR5Yu1m8zB1puiKvJ657y6RpT3Ebe3CqbFQsTWNqXhlg8TYDAqsExpUC4iQtTM/QUWB6iZqBjqBxLxMR2e0Z18c=
X-Received: by 2002:a05:6808:bd5:b0:33f:dd8:c545 with SMTP id
 o21-20020a0568080bd500b0033f0dd8c545mr4458971oik.252.1659770656469; Sat, 06
 Aug 2022 00:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <2c496d24174e63b27ec047f383df6700@matoro.tk>
In-Reply-To: <2c496d24174e63b27ec047f383df6700@matoro.tk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Aug 2022 09:23:40 +0200
Message-ID: <CA+icZUWkDEZhJ+fVGPJ3LE5p9k0yWjg-XtAk7evES2crjbADUA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 6, 2022 at 1:40 AM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
>
> Hi Masahiro, I'm sorry to raise this after release but this seems to be
> broken on SOME architectures.  So far I have tested:
>
> Affected - sparc, alpha
> Unaffected - riscv, ia64
>

What do you mean by "release"?

Checking the kernel-version from your paste-URLs:

# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 5.18.16-gentoo Kernel Configuration

# Automatically generated file; DO NOT EDIT.
# Linux/alpha 5.18.15-gentoo Kernel Configuration

# Automatically generated file; DO NOT EDIT.
# Linux/riscv 5.19.0-gentoo Kernel Configuration

# Automatically generated file; DO NOT EDIT.
# Linux/ia64 5.19.0-gentoo Kernel Configuration

Maybe you should try "Affected - sparc, alpha" with Linux v5.19.0
instead of 5.18.x :-)?

-Sedat-

> The affected systems are unable to load modules, similar to the
> previously reported issue.  All module loading fails with "disagrees
> about version of symbol module_layout".
>
> Bisect blames 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b, but this does
> not revert cleanly.  Presumably CONFIG_MODVERSIONS=n would fix, but this
> is a pretty core feature.
>
> Unlike the issue Sedat reported, this is on a GNU toolchain, no clang
> involved.
>
> Here are the configs I am using (with make olddefconfig on upgrade to
> 5.19):
>
> Broken - sparc - https://dpaste.com/5A8F2JD6U
> Broken - alpha - https://dpaste.com/FYKK23L9X
> Working - riscv - https://dpaste.com/HV6Y4V6NT
> Working - ia64 - https://dpaste.com/HDLDNEAK4
>
> Please let me know if there's anything I can do to help track down this
> regression.
>
>
> -------- Original Message --------
> Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups
> (modpost, LTO, MODULE_REL_CRCS, export.h)
> Date: 2022-05-13 08:20
>  From: Masahiro Yamada <masahiroy@kernel.org>
> To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
>
> On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org>
> wrote:
> >
> >
> > This is the third batch of cleanups in this development cycle.
> >
>
>
> This series is available at
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>   lto-cleanup-v6
>
>
> >
> > Changes in v6:
> >   - Fix false-positive warnings when CONFIG_TRIM_UNUSED_KSYMS=y
> >
> > Changes in v5:
> >   - Fix the build error when CONFIG_DEBUG_INFO_BTF=y (reported by
> > Nathan)
> >   - Clean up arch/m68k/include/asm/export.h (Nick)
> >   - Keep gen_symversions (and will be removed by a later patch)
> >   - Add more comments in the script
> >
> > Changes in v4:
> >   - Rename .vmlinux-symver.c to .vmlinux.export.c
> >     because I notice this approach is useful for further cleanups,
> >     not only for modversioning but also for overall EXPORT_SYMBOL.
> >   - New patch
> >   - New.
> >     Resent of my previous submission.
> >
> > https://lore.kernel.org/all/20210831074004.3195284-10-masahiroy@kernel.org/
> >   - New
> >     Resent of my previous submission
> >
> > https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/
> >
> > Changes in v3:
> >   - New patch
> >
> > Changes in v2:
> >   - Simplify the implementation (parse .cmd files after ELF)
> >   - New patch
> >  - replace the chain of $(if ...) with $(and )
> >   - New patch
> >   - New patch
> >
> > Masahiro Yamada (10):
> >   modpost: extract symbol versions from *.cmd files
> >   kbuild: link symbol CRCs at final link, removing
> >     CONFIG_MODULE_REL_CRCS
> >   kbuild: stop merging *.symversions
> >   genksyms: adjust the output format to modpost
> >   kbuild: do not create *.prelink.o for Clang LTO or IBT
> >   kbuild: check static EXPORT_SYMBOL* by script instead of modpost
> >   kbuild: make built-in.a rule robust against too long argument error
> >   kbuild: make *.mod rule robust against too long argument error
> >   kbuild: add cmd_and_savecmd macro
> >   kbuild: rebuild multi-object modules when objtool is updated
> >
> >  arch/m68k/include/asm/Kbuild    |   1 +
> >  arch/m68k/include/asm/export.h  |   2 -
> >  arch/powerpc/Kconfig            |   1 -
> >  arch/s390/Kconfig               |   1 -
> >  arch/um/Kconfig                 |   1 -
> >  include/asm-generic/export.h    |  22 ++-
> >  include/linux/export-internal.h |  16 +++
> >  include/linux/export.h          |  30 ++--
> >  init/Kconfig                    |   4 -
> >  kernel/module.c                 |  10 +-
> >  scripts/Kbuild.include          |  10 +-
> >  scripts/Makefile.build          | 134 ++++++------------
> >  scripts/Makefile.lib            |   7 -
> >  scripts/Makefile.modfinal       |   5 +-
> >  scripts/Makefile.modpost        |   9 +-
> >  scripts/check-local-export      |  64 +++++++++
> >  scripts/genksyms/genksyms.c     |  18 +--
> >  scripts/link-vmlinux.sh         |  33 ++---
> >  scripts/mod/modpost.c           | 236 +++++++++++++++++++++-----------
> >  19 files changed, 320 insertions(+), 284 deletions(-)
> >  delete mode 100644 arch/m68k/include/asm/export.h
> >  create mode 100644 include/linux/export-internal.h
> >  create mode 100755 scripts/check-local-export
> >
> > --
> > 2.32.0
> >
>
