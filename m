Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D485358B2E6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiHEXy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiHEXy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:54:27 -0400
X-Greylist: delayed 1039 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 16:54:22 PDT
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8C1AF0D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:54:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=J8J6PPB5B9eM7a3M73is6IRjHMAiGebZrLZRQe+1Ff0=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220801; t=1659741627; v=1; x=1660173627;
 b=g5XrCDNUzsVAjAjZFsZjYZ24S9aLRq7h/3KSaEGcnBcDDqaRK+RSYwnaAY90FpzwxVaQF1NF
 3MNa0IT70NknLcM1JlhzVaAvQ+T5FBHftTYXNPo4hgTx0R4UhKsKuCKHtlDfIrMx0qroqwzkrIt
 5lYn0OTCxgw9jmpERilnPHUEtyNv+qrNEGNGMyeI6gJ70td5TRT9RGCTDtcQ2E2ynutTu8f+QZy
 325oIMukW3iVu4swvQWbAfnHhPDMXBfw0p4VEurlJcPV4c+kgK6s2DXoCoGjYhXQ2oQEEzqG2dn
 +ewxJ9nfIXrleZivMz1tTsf4ESkGszpDSOmZwrlReRj5erU0nycGsjb+Uz+iGJG+1XyjtYiwYzG
 Oi3DGEclNrMEVTK+9LVsmZCrlDpLHxM9hxB0z+5YormW9a6TcAm6aQJbUiSNSBmVNio7UbtJ8NM
 vVvqS/VxfeR7kEzvghlzoRsApdAt4BUZqLt9sdJLg/uoQ1gGs9W+/Ve9qO5bXt15gGdLqS6t8Iz
 TezdH1KfzS7jZkbq+1+HLY1ujy8PLBYPz+mWB1zX6OpS2OfY0IU7uLdqojRK5CIO9IMaJ8saIUx
 HdIKZ+wnH/t556N4AH1FiEvdcRzzRzBLJM4dFqYf6bicPLvHbuIZ4LZWDTEyHA/eE1ESVmLp+mX
 ywkEoUfpnsE=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 8629941e; Fri, 05 Aug
 2022 19:20:27 -0400
MIME-Version: 1.0
Date:   Fri, 05 Aug 2022 19:20:27 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
In-Reply-To: <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
Message-ID: <2c496d24174e63b27ec047f383df6700@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro, I'm sorry to raise this after release but this seems to be 
broken on SOME architectures.  So far I have tested:

Affected - sparc, alpha
Unaffected - riscv, ia64

The affected systems are unable to load modules, similar to the 
previously reported issue.  All module loading fails with "disagrees 
about version of symbol module_layout".

Bisect blames 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b, but this does 
not revert cleanly.  Presumably CONFIG_MODVERSIONS=n would fix, but this 
is a pretty core feature.

Unlike the issue Sedat reported, this is on a GNU toolchain, no clang 
involved.

Here are the configs I am using (with make olddefconfig on upgrade to 
5.19):

Broken - sparc - https://dpaste.com/5A8F2JD6U
Broken - alpha - https://dpaste.com/FYKK23L9X
Working - riscv - https://dpaste.com/HV6Y4V6NT
Working - ia64 - https://dpaste.com/HDLDNEAK4

Please let me know if there's anything I can do to help track down this 
regression.


-------- Original Message --------
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups 
(modpost, LTO, MODULE_REL_CRCS, export.h)
Date: 2022-05-13 08:20
 From: Masahiro Yamada <masahiroy@kernel.org>
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org> 
wrote:
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
>   - Fix the build error when CONFIG_DEBUG_INFO_BTF=y (reported by 
> Nathan)
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
>     
> https://lore.kernel.org/all/20210831074004.3195284-10-masahiroy@kernel.org/
>   - New
>     Resent of my previous submission
>     
> https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/
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

