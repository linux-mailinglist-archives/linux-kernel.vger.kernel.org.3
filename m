Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573A8584D73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiG2Iix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiG2Iiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:38:51 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C1963C2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659083925;
        bh=nhRJetfqLKjmUCbDBNY/1f03LEEuOrUUxiVJylmuTJE=;
        h=Subject:From:To:Cc:Date:From;
        b=FUPN6Cpcxd7PojPojV6dE7ZyP1ozEemFkP/TZvrTC9cJwmTdB2ehw5D6zz21VxfkV
         R0QrPz/6vaAcqfXrA84ZZ1d8ayALTh+y+IiP3qZCiEj3GiAd1cX61IrC54bTJulrOj
         PPQ1g6inqJxLLcRKfK8uAh4rZTAP//RHm53LCnVE=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 972CE669EA;
        Fri, 29 Jul 2022 04:38:43 -0400 (EDT)
Message-ID: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
Subject: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 16:38:41 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
be be built with both old and new toolchains.

Tested by building the kernel with both Binutils & GCC master branch and
my system Binutils & GCC (without new relocation type support), running
both the builds with 35 in-tree modules loaded, and loading one module
with 20 GOT loads (loaded addresses verified by comparing with
/proc/kallsyms).

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

Xi Ruoyao (4):
  LoongArch: Add section of GOT for kernel module
  LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation type in kernel
    module
  LoongArch: Remove -fplt and -Wa,-mla-* from CFLAGS
  LoongArch: Support modules with new relocation types

 arch/loongarch/Makefile                 |  4 --
 arch/loongarch/include/asm/elf.h        | 37 ++++++++++
 arch/loongarch/include/asm/module.h     | 23 ++++++
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/head.S            | 10 +--
 arch/loongarch/kernel/module-sections.c | 51 +++++++++++--
 arch/loongarch/kernel/module.c          | 96 +++++++++++++++++++++++++
 7 files changed, 209 insertions(+), 13 deletions(-)

--=20
2.37.0


