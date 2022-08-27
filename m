Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16A5A3952
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiH0RzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH0RzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:55:18 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD034C608
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661622911;
        bh=bKbi5ZoBx5MxWUm+sqTXCCyGHbgrGj3hJ6BAG+u95vg=;
        h=From:To:Cc:Subject:Date:From;
        b=TLatgV5xLXhs/ycZlzSurWpkxb+nGSnfLYGi4+TnyGGx6d455bggg0yhRZw1Gt4A7
         WccvLeYOXb1Rvamky4BBC+wmgmlSN7DFJKZKYU4s2SV5QvIobD03j/LdqMKuibyqy3
         1SoX6wtdhhWTdzj/kVPHrHlvXktpbOnp+Guui8O0=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1157:dc00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id BE665667FE;
        Sat, 27 Aug 2022 13:55:02 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 0/8] LoongArch: Support toolchain with new relocation types
Date:   Sun, 28 Aug 2022 01:54:28 +0800
Message-Id: <20220827175436.156464-1-xry111@xry111.site>
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
be be built with both old and new toolchains.

Tested by building the kernel with the following combinations:

- GCC 12 and Binutils 2.39
- GCC 12 and Binutils trunk
- GCC trunk and Binutils trunk

and running the builds with 35 in-tree modules loaded, and loading one
module with 20 GOT loads and a per-CPU variable (loaded addresses
verified by comparing with /proc/kallsyms).

This superseds "LoongArch: Support new relocation types" series.  I
don't make it a "v5" because too much things have changed so it's better
to treat this as a new series.

Xi Ruoyao (8):
  LoongArch: Add CONFIG_CC_HAS_EXPLICIT_RELOCS
  LoongArch: Only use -Wa,-mla-* options for
    !CONFIG_CC_HAS_EXPLICIT_RELOCS
  LoongArch: Define ELF relocation types added in v2.00 ABI
  LoongArch: Support R_LARCH_B26 in modules
  LoongArch: Support R_LARCH_ABS* in modules
  LoongArch: Use model("extreme") attribute for per-CPU variables in
    module if CONFIG_CC_HAS_EXPLICIT_RELOCS
  LoongArch: Support R_LARCH_PCALA* in modules
  LoongArch: Support R_LARCH_GOT_PC* in modules

 arch/loongarch/Kconfig                  |   3 +
 arch/loongarch/Makefile                 |  15 ++-
 arch/loongarch/include/asm/elf.h        |  37 +++++++
 arch/loongarch/include/asm/module.h     |  23 ++++
 arch/loongarch/include/asm/module.lds.h |   1 +
 arch/loongarch/include/asm/percpu.h     |  13 +++
 arch/loongarch/kernel/head.S            |  10 +-
 arch/loongarch/kernel/module-sections.c |  56 +++++++++-
 arch/loongarch/kernel/module.c          | 138 +++++++++++++++++++++++-
 9 files changed, 285 insertions(+), 11 deletions(-)

-- 
2.37.0

