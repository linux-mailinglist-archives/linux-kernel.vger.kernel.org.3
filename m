Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811695A4E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiH2Nd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiH2Nd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:33:27 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17997284C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661780002;
        bh=+JtPz+QbXy17iHd2rQKScE85EOhFTM5MQmyitEi64FQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kQcHxJ9R3q/qAOs6rYI2NCzmtBfaoubuZs8Ko29SqZRSYxgooZ3GRr/U7OlHjZaX7
         VglnXHs+rZ3P/g2VRik/HB0Gc2CgGaNZMjVOdfbT5YTCF4whR+nNHb3unBwd7qv28f
         H7Yf9+jzzZGVUJ0cTpXPfWOQ+X5d0ArvEr01rIsw=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 3D34966901;
        Mon, 29 Aug 2022 09:33:16 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v6 0/6] LoongArch: Support toolchain with new relocation types
Date:   Mon, 29 Aug 2022 21:31:40 +0800
Message-Id: <20220829133146.15236-1-xry111@xry111.site>
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

Changes from v5 to v6:

- Restore version number.
- Rename CONFIG_CC_HAS_EXPLICIT_RELOCS to CONFIG_AS_HAS_EXPLICIT_RELOCS.
  It now only checks assembler.
- No longer support "old GCC with new Binutils", so R_LARCH_ABS* is
  dropped.
  - "Old GCC with old Binutils" is still supported until Arnd ack.
    longer support it.
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

Xi Ruoyao (6):
  LoongArch: Add CONFIG_AS_HAS_EXPLICIT_RELOCS
  LoongArch: Adjust CFLAGS for CONFIG_AS_HAS_EXPLICIT_RELOCS
  LoongArch: Use model("extreme") attribute for per-CPU variables in
    module if CONFIG_AS_HAS_EXPLICIT_RELOCS
  LoongArch: Define ELF relocation types added in v2.00 ABI
  LoongArch: Support PC-relative relocations in modules
  LoongArch: Support R_LARCH_GOT_PC* in modules

 arch/loongarch/Kconfig                  |   3 +
 arch/loongarch/Makefile                 |  22 +++++-
 arch/loongarch/include/asm/elf.h        |  37 +++++++++
 arch/loongarch/include/asm/module.h     |  23 ++++++
 arch/loongarch/include/asm/module.lds.h |   1 +
 arch/loongarch/include/asm/percpu.h     |   8 ++
 arch/loongarch/kernel/head.S            |  10 +--
 arch/loongarch/kernel/module-sections.c |  56 ++++++++++++-
 arch/loongarch/kernel/module.c          | 101 +++++++++++++++++++++++-
 9 files changed, 250 insertions(+), 11 deletions(-)

-- 
2.37.0

