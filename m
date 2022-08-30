Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC25A645B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiH3NGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH3NGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED99A3479
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C19F6170C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F62C433B5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661864769;
        bh=X8RU1C3e0sntkkaG9dNAPLJlvvdFjnh43Set1ULFjOc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H2k75mrHdFosjv36ifWmMTLkCe72XhyOO5kAPpX6iHY/6OrkSUgQqm+sOV4m0zRej
         ode7RvmtMD1vrRE1fu/kLtx5xRwSQmdG0qXUsMVi0fVYPctWt3HoDNUFCUzDXa6+0D
         I8wpQergKNWmQvwxomyb/hQlCybsdZV3d4ERqovwbFOrTYsY38qJapUKJ8H6uugU8u
         T+cHo4GhzKLn9R0B+o9y5vppMEcR0NV3AXdaeByygpeJpz6yzYTK/jqwjs1WeU/ZQZ
         OA2G2ZzksZtJAEn7JZJu0XwuPwNXMDZz/8f7ttCfmviMYN2b2qjW1RTKSOlYfgmMN0
         XQ2A/TR7XBi4Q==
Received: by mail-vs1-f47.google.com with SMTP id m66so11388561vsm.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:06:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo3S/983KKy1g6hQGl0WEueb0/g18WaWPfw0xCpvc4YV667j/SgS
        qiLVk9js/tKVxhlAJd8xg11XnH/dmixCr0rT6z0=
X-Google-Smtp-Source: AA6agR4xO4pMuBb9KKlGJRO7k+h82oKb0i4lmX9YFw9m160njCSeADM64Ez0taq8rBdDmaTle0UkRg9ONK01y7GI22o=
X-Received: by 2002:a67:d582:0:b0:390:d6dd:5612 with SMTP id
 m2-20020a67d582000000b00390d6dd5612mr3760828vsj.78.1661864768263; Tue, 30 Aug
 2022 06:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site>
In-Reply-To: <20220830104806.128365-1-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 30 Aug 2022 21:05:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
Message-ID: <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

Thank you for your contribution, this whole series will be queued for
6.1. Though lkp reported some warnings, I will fix them myself.

Huacai

On Tue, Aug 30, 2022 at 6:48 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> The version 2.00 of LoongArch ELF ABI specification introduced new
> relocation types, and the development tree of Binutils and GCC has
> started to use them.  If the kernel is built with the latest snapshot of
> Binutils or GCC, it will fail to load the modules because of unrecognized
> relocation types in modules.
>
> Add support for GOT and new relocation types for the module loader, so
> the kernel (with modules) can be built with the "normal" code model and
> function properly.
>
> This series does not break the compatibility with old toolchain using
> stack-based relocation types, so with the patches applied the kernel can
> be be built with both old and new toolchains.  But, the combination of
> "new" Binutils and "old" GCC is not supported.
>
> Tested by building the kernel with the following combinations:
>
> - GCC 12 and Binutils 2.39
> - GCC trunk and Binutils trunk
>
> and running the builds with 35 in-tree modules loaded, and loading one
> module with 20 GOT loads and a per-CPU variable (loaded addresses
> verified by comparing with /proc/kallsyms).
>
> Changes from v6 to v7:
>
> - Simplify apply_r_larch_pcala.
> - Remove a build check only for excluding early GCC 13 dev snapshots.
> - Squash model attribute addition into the previous patch.
> - Retain "-fplt".
>
> Changes from v5 to v6:
>
> - Restore version number.
> - Rename CONFIG_CC_HAS_EXPLICIT_RELOCS to CONFIG_AS_HAS_EXPLICIT_RELOCS.
>   It now only checks assembler.
> - No longer support "old GCC with new Binutils", so R_LARCH_ABS* is
>   dropped.
>   - "Old GCC with old Binutils" is still supported until Arnd ack.
>   - "New GCC with old Binutils" is still supported as it does not
>     require additional code.
> - Remove "cc-option" around "-mexplicit-relocs".  For unsupported
>   "old GCC with new Binutils" combination, forcing -mexplicit-relocs
>   makes assembling fail, instead of silently producing unloadable
>   modules.
> - Move the error report for "lacking model attribute" into Makefile.
> - Squash the two patches for R_LARCH_B26 and R_LARCH_PCALA* into one.
>
> Changes from v4 to v5 ("v5" missed in the subject):
>
> - Change subject.
> - Introduce CONFIG_CC_HAS_EXPLICIT_RELOCS.
> - Retain -Wa,-mla-* options for old toolchains
>   (!CONFIG_CC_HAS_EXPLICIT_RELOCS).
> - Use __attribute__((model("extreme"))) in PER_CPU_ATTRIBUTES, to fix
>   a breakage with per-CPU variables defined in modules.
> - Handle R_LARCH_PCALA64_{HI12,LO12} for extreme model.
> - Handle R_LARCH_ABS* for "old GCC with new Binutils".
> - Separate the last patch into more small patches.
> - Avoid BUG_ON() for the handling of GOT.
>
> Changes from v3 to v4:
>
> - No code change.  Reword the commit message of the 3rd patch again
>   based on suggestion from Huacai.
>
> Changes from v2 to v3:
>
> - Use `union loongarch_instruction` instead of explicit bit shifts
>   applying the relocation.  Suggested by Youling.
> - For R_LARCH_B26, move the alignment check before the range check to be
>   consistent with stack pop relocations.  Suggested by Youling.
> - Reword the commit message of the 3rd patch.  Suggested by Huacai.
>
> Changes from v1 to v2:
>
> - Fix a stupid programming error (confusion between the number of PLT
>   entries and the number of GOT entries).  (Bug spotted by Youling).
> - Synthesize the _GLOBAL_OFFSET_TABLE_ symbol with module.lds, instead
>   of faking it at runtime.  The 3rd patch from V1 is now merged into
>   the 1st patch because it would be a one-line change.  (Suggested by
>   Jinyang).
> - Keep reloc_rela_handlers[] ordered by the relocation type ID.
>   (Suggested by Youling).
> - Remove -fplt along with -Wa,-mla-* options because it's the default.
>   (Suggested by Youling).
>
> Xi Ruoyao (5):
>   LoongArch: Add CONFIG_AS_HAS_EXPLICIT_RELOCS
>   LoongArch: Adjust symbol addressing for CONFIG_AS_HAS_EXPLICIT_RELOCS
>   LoongArch: Define ELF relocation types added in v2.00 ABI
>   LoongArch: Support PC-relative relocations in modules
>   LoongArch: Support R_LARCH_GOT_PC* in modules
>
>  arch/loongarch/Kconfig                  |  3 +
>  arch/loongarch/Makefile                 | 17 +++++
>  arch/loongarch/include/asm/elf.h        | 37 ++++++++++
>  arch/loongarch/include/asm/module.h     | 23 ++++++
>  arch/loongarch/include/asm/module.lds.h |  1 +
>  arch/loongarch/include/asm/percpu.h     |  8 +++
>  arch/loongarch/kernel/head.S            | 10 +--
>  arch/loongarch/kernel/module-sections.c | 56 +++++++++++++--
>  arch/loongarch/kernel/module.c          | 93 ++++++++++++++++++++++++-
>  9 files changed, 238 insertions(+), 10 deletions(-)
>
> --
> 2.37.0
>
