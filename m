Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D9A5A6110
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiH3Ksp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiH3Ksh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:48:37 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35399DC5D0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661856514;
        bh=DRSUwEoTCztac7oUAw8Om3bUbvawDARF481p3R69yCc=;
        h=From:To:Cc:Subject:Date:From;
        b=TGxo0Hi8qz0Y7QGlB7/VaZv0/oO9yWi2zVUih/Pvf+NR7U0pTtqNod7V6Ikvrcpff
         4Uu3N1LkA3jRVWhXQeydtMgsTcrUOlrersduah/KbtMbA4+/JpH0xGjPENqGRHgC9E
         U2/EcZHVhwy0iyxtDNnhZZMl/WYUxU9FDJqB0lE4=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 726BD65927;
        Tue, 30 Aug 2022 06:48:28 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
Date:   Tue, 30 Aug 2022 18:48:01 +0800
Message-Id: <20220830104806.128365-1-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The version 2.00 of LoongArch ELF ABI specification introduced new
relocation types, and the development tree of Binutils and GCC has
started to use them.  If the kernel is built with the latest snapshot of
Binutils or GCC, it will fail to load the modules because of unrecognized
relocation types in modules.

Add support for GOT and new relocation types for the module loader, so
the kernel (with modules) can be built with the "normal" code model and
function properly.

This series does not break the compatibility with old toolchain using
stack-based relocation types, so with the patches applied the kernel can
be be built with both old and new toolchains.  But, the combination of
"new" Binutils and "old" GCC is not supported.

Tested by building the kernel with the following combinations:

- GCC 12 and Binutils 2.39
- GCC trunk and Binutils trunk

and running the builds with 35 in-tree modules loaded, and loading one
module with 20 GOT loads and a per-CPU variable (loaded addresses
verified by comparing with /proc/kallsyms).

Changes from v6 to v7:

- Simplify apply_r_larch_pcala.
- Remove a build check only for excluding early GCC 13 dev snapshots.
- Squash model attribute addition into the previous patch.
- Retain "-fplt".

Changes from v5 to v6:

- Restore version number.
- Rename CONFIG_CC_HAS_EXPLICIT_RELOCS to CONFIG_AS_HAS_EXPLICIT_RELOCS.
  It now only checks assembler.
- No longer support "old GCC with new Binutils", so R_LARCH_ABS* is
  dropped.
  - "Old GCC with old Binutils" is still supported until Arnd ack.
  - "New GCC with old Binutils" is still supported as it does not
    require additional code.
- Remove "cc-option" around "-mexplicit-relocs".  For unsupported
  "old GCC with new Binutils" combination, forcing -mexplicit-relocs
  makes assembling fail, instead of silently producing unloadable
  modules.
- Move the error report for "lacking model attribute" into Makefile.
- Squash the two patches for R_LARCH_B26 and R_LARCH_PCALA* into one.

Changes from v4 to v5 ("v5" missed in the subject):

- Change subject.
- Introduce CONFIG_CC_HAS_EXPLICIT_RELOCS.
- Retain -Wa,-mla-* options for old toolchains
  (!CONFIG_CC_HAS_EXPLICIT_RELOCS).
- Use __attribute__((model("extreme"))) in PER_CPU_ATTRIBUTES, to fix
  a breakage with per-CPU variables defined in modules.
- Handle R_LARCH_PCALA64_{HI12,LO12} for extreme model.
- Handle R_LARCH_ABS* for "old GCC with new Binutils".
- Separate the last patch into more small patches.
- Avoid BUG_ON() for the handling of GOT.

Changes from v3 to v4:

- No code change.  Reword the commit message of the 3rd patch again
  based on suggestion from Huacai.

Changes from v2 to v3:

- Use `union loongarch_instruction` instead of explicit bit shifts
  applying the relocation.  Suggested by Youling.
- For R_LARCH_B26, move the alignment check before the range check to be
  consistent with stack pop relocations.  Suggested by Youling.
- Reword the commit message of the 3rd patch.  Suggested by Huacai.

Changes from v1 to v2:

- Fix a stupid programming error (confusion between the number of PLT
  entries and the number of GOT entries).  (Bug spotted by Youling).
- Synthesize the _GLOBAL_OFFSET_TABLE_ symbol with module.lds, instead
  of faking it at runtime.  The 3rd patch from V1 is now merged into
  the 1st patch because it would be a one-line change.  (Suggested by
  Jinyang).
- Keep reloc_rela_handlers[] ordered by the relocation type ID.
  (Suggested by Youling).
- Remove -fplt along with -Wa,-mla-* options because it's the default.
  (Suggested by Youling).

Xi Ruoyao (5):
  LoongArch: Add CONFIG_AS_HAS_EXPLICIT_RELOCS
  LoongArch: Adjust symbol addressing for CONFIG_AS_HAS_EXPLICIT_RELOCS
  LoongArch: Define ELF relocation types added in v2.00 ABI
  LoongArch: Support PC-relative relocations in modules
  LoongArch: Support R_LARCH_GOT_PC* in modules

 arch/loongarch/Kconfig                  |  3 +
 arch/loongarch/Makefile                 | 17 +++++
 arch/loongarch/include/asm/elf.h        | 37 ++++++++++
 arch/loongarch/include/asm/module.h     | 23 ++++++
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/include/asm/percpu.h     |  8 +++
 arch/loongarch/kernel/head.S            | 10 +--
 arch/loongarch/kernel/module-sections.c | 56 +++++++++++++--
 arch/loongarch/kernel/module.c          | 93 ++++++++++++++++++++++++-
 9 files changed, 238 insertions(+), 10 deletions(-)

-- 
2.37.0

