Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC0583E09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiG1Lts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiG1Ltq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:49:46 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7936B691DA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659008983;
        bh=RkPofTIZqMBvPv1I2e5S6bPSJnJmJKBQeR6T5MWoMVg=;
        h=Subject:From:To:Cc:Date:From;
        b=T3SoH2wVHaQNwvLDUPMw28NKQ4KvZba2cCGxyMPhwe1K/5PdlJAQbsftINrmgsN4l
         hjhDtBT+KTSVVt6gSfrkrgLgbrHhhqyg8q7t5vWosic7qeBDcCE0pYepp1o27LENsh
         iQdTiA1no4mGBMhsdfRvyImK4EnEGFbGbwT22Dac=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 71C9B667F7;
        Thu, 28 Jul 2022 07:49:41 -0400 (EDT)
Message-ID: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
Subject: [PATCH v2 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Thu, 28 Jul 2022 19:49:39 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Tested by building the kernel with Binutils & GCC master branch,
running the kernel with 35 in-tree modules loaded, and loading one
module with 20 GOT loads (both old SOP_PUSH_GPREL and new
GOT_PC_HI20/GOT_PC_LO12 relocations tested, and loaded addresses
verified by comparing with /proc/kallsyms).

Link: https://github.com/loongson/LoongArch-Documentation/pull/57
Link: https://gcc.gnu.org/r13-1834
Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Df0948=
2a

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
  LoongArch: Stop using undocumented assembler options
  LoongArch: Support modules with new relocation types

 arch/loongarch/Makefile                 |  4 --
 arch/loongarch/include/asm/elf.h        | 37 ++++++++++
 arch/loongarch/include/asm/module.h     | 23 ++++++
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/head.S            | 10 +--
 arch/loongarch/kernel/module-sections.c | 51 ++++++++++++--
 arch/loongarch/kernel/module.c          | 94 +++++++++++++++++++++++++
 7 files changed, 207 insertions(+), 13 deletions(-)

--=20
2.37.0

