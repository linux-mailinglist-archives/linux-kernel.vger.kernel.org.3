Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8E56C0E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiGHRcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbiGHRcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:32:14 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E7213D1F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:32:13 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LfgMF2zTHz9tJt;
        Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Cmxiou12xFy; Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LfgMD3jcbz9tK2;
        Fri,  8 Jul 2022 19:32:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B89F8B79F;
        Fri,  8 Jul 2022 19:32:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yGjfhU1YAOkF; Fri,  8 Jul 2022 19:32:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.202])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E26E28B76E;
        Fri,  8 Jul 2022 19:32:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 268HVwDp1000723
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Jul 2022 19:31:58 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 268HVsT81000717;
        Fri, 8 Jul 2022 19:31:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        agust@denx.de, jpoimboe@kernel.org, peterz@infradead.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, chenzhongjin@huawei.com
Subject: [PATCH v2 0/7] Implement inline static calls on PPC32 - v2
Date:   Fri,  8 Jul 2022 19:31:19 +0200
Message-Id: <cover.1657301423.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657301483; l=2522; s=20211009; h=from:subject:message-id; bh=srsHauWpCCSShw+tDnQuCN7IaYeyZicOYbEw8X38M5s=; b=9mXmhioPtuJKOkzJ526lABlrAYvbEtiTLvaEChNbWFTdSz6wSV9box2w6tlvRf+BXOtYmsrmc19/ DeWS0KGEBw0QDl9ftLF4oURG+dwMO/PJq9azqrSDFo2AfSalnNec
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series applies on top of the series v3 "objtool: Enable and
implement --mcount option on powerpc" [1] rebased on powerpc-next branch

A few modifications are done to core parts to enable powerpc
implementation:
- R_X86_64_PC32 is abstracted to R_REL32 so that it can then be
redefined as R_PPC_REL32.
- A call to static_call_init() is added to start_kernel() to avoid
every architecture to have to call it
- Trampoline address is provided to arch_static_call_transform() even
when setting a site to fallback on a call to the trampoline when the
target is too far.

[1] https://lore.kernel.org/lkml/70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu/T/#rb3a073c54aba563a135fba891e0c34c46e47beef

Christophe Leroy (7):
  powerpc: Add missing asm/asm.h for objtool
  objtool/powerpc: Activate objtool on PPC32
  objtool: Add architecture specific R_REL32 macro
  objtool/powerpc: Add necessary support for inline static calls
  init: Call static_call_init() from start_kernel()
  static_call_inline: Provide trampoline address when updating sites
  powerpc/static_call: Implement inline static calls

 arch/powerpc/Kconfig                          |  3 +-
 arch/powerpc/include/asm/asm.h                |  7 +++
 arch/powerpc/include/asm/static_call.h        |  2 +
 arch/powerpc/kernel/cpu_setup_6xx.S           | 26 ++++++---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S     |  8 ++-
 arch/powerpc/kernel/entry_32.S                |  8 ++-
 arch/powerpc/kernel/head_40x.S                |  5 +-
 arch/powerpc/kernel/head_8xx.S                |  5 +-
 arch/powerpc/kernel/head_book3s_32.S          | 29 +++++++---
 arch/powerpc/kernel/head_fsl_booke.S          |  5 +-
 arch/powerpc/kernel/static_call.c             | 56 ++++++++++++++-----
 arch/powerpc/kernel/swsusp_32.S               |  5 +-
 arch/powerpc/kvm/fpu.S                        | 17 ++++--
 arch/powerpc/platforms/52xx/lite5200_sleep.S  | 15 +++--
 arch/x86/kernel/static_call.c                 |  2 +-
 init/main.c                                   |  1 +
 kernel/static_call_inline.c                   |  2 +-
 tools/objtool/arch/powerpc/decode.c           | 16 ++++--
 tools/objtool/arch/powerpc/include/arch/elf.h |  1 +
 tools/objtool/arch/x86/include/arch/elf.h     |  1 +
 tools/objtool/check.c                         | 10 ++--
 tools/objtool/orc_gen.c                       |  2 +-
 22 files changed, 162 insertions(+), 64 deletions(-)
 create mode 100644 arch/powerpc/include/asm/asm.h

-- 
2.36.1

