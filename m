Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0968E51F41E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiEIFsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiEIFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:44:55 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670D110312
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:41:03 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KxVKR1HpYz9sVj;
        Mon,  9 May 2022 07:36:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o9_dxTuXoPLn; Mon,  9 May 2022 07:36:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KxVKF5dFVz9sVd;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACA588B76E;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bU37uZxVXqHF; Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51AA28B776;
        Mon,  9 May 2022 07:36:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2495aR9w1591206
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 07:36:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2495aQXb1591205;
        Mon, 9 May 2022 07:36:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 00/25] powerpc: ftrace optimisation and cleanup and more [v3]
Date:   Mon,  9 May 2022 07:35:58 +0200
Message-Id: <cover.1652074503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652074581; l=3842; s=20211009; h=from:subject:message-id; bh=51wV9eNRVhtkrENuM3ARQMOo9s4nz33TjB7nd9UuZ9k=; b=5cHXoeQUSw6/s49i9T83aDQblwQx/bkwWim71GkTXPcdJAmIQN1FULV+fhrAMAr9boUqwdTVRCC7 ADMcx+S4C56WgZ2JRzvaAMU49HONnidpXa8Utb0gYagb40pokvnE
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

This series provides optimisation and cleanup of ftrace on powerpc.

With this series ftrace activation is about 20% faster on an 8xx.

At the end of the series come additional cleanups around ppc-opcode,
that would likely conflict with this series if posted separately.

Change since v2:
- The only change in v3 is in patch 21, to fix sparse problems reported by the Robot.

Main changes since v1 (details in after each individual patch description):
- Added 3 patches (8, 9, 10) that convert PPC64_ELF_ABI_v{1/2} macros by CONFIG_PPC64_ELF_ABI_V{1/2}
- Taken comments from Naveen

Christophe Leroy (25):
  powerpc/ftrace: Refactor prepare_ftrace_return()
  powerpc/ftrace: Remove redundant create_branch() calls
  powerpc/code-patching: Inline is_offset_in_{cond}_branch_range()
  powerpc/ftrace: Use is_offset_in_branch_range()
  powerpc/code-patching: Inline create_branch()
  powerpc/ftrace: Inline ftrace_modify_code()
  powerpc/ftrace: Use patch_instruction() return directly
  powerpc: Add CONFIG_PPC64_ELF_ABI_V1 and CONFIG_PPC64_ELF_ABI_V2
  powerpc: Replace PPC64_ELF_ABI_v{1/2} by CONFIG_PPC64_ELF_ABI_V{1/2}
  powerpc: Finalise cleanup around ABI use
  powerpc/ftrace: Make __ftrace_make_{nop/call}() common to PPC32 and
    PPC64
  powerpc/ftrace: Don't include ftrace.o for CONFIG_FTRACE_SYSCALLS
  powerpc/ftrace: Use CONFIG_FUNCTION_TRACER instead of
    CONFIG_DYNAMIC_FTRACE
  powerpc/ftrace: Remove ftrace_plt_tramps[]
  powerpc/ftrace: Use BRANCH_SET_LINK instead of value 1
  powerpc/ftrace: Use PPC_RAW_xxx() macros instead of opencoding.
  powerpc/ftrace: Use size macro instead of opencoding
  powerpc/ftrace: Simplify expected_nop_sequence()
  powerpc/ftrace: Minimise number of #ifdefs
  powerpc/inst: Add __copy_inst_from_kernel_nofault()
  powerpc/ftrace: Don't use copy_from_kernel_nofault() in
    module_trampoline_target()
  powerpc/inst: Remove PPC_INST_BRANCH
  powerpc/modules: Use PPC_LI macros instead of opencoding
  powerpc/inst: Remove PPC_INST_BL
  powerpc/opcodes: Remove unused PPC_INST_XXX macros

 arch/powerpc/Kconfig                     |   2 +-
 arch/powerpc/Makefile                    |  12 +-
 arch/powerpc/boot/Makefile               |   2 +
 arch/powerpc/include/asm/code-patching.h |  65 +++-
 arch/powerpc/include/asm/ftrace.h        |   4 +-
 arch/powerpc/include/asm/inst.h          |  13 +-
 arch/powerpc/include/asm/linkage.h       |   2 +-
 arch/powerpc/include/asm/module.h        |   2 -
 arch/powerpc/include/asm/ppc-opcode.h    |  22 +-
 arch/powerpc/include/asm/ppc_asm.h       |   4 +-
 arch/powerpc/include/asm/ptrace.h        |   2 +-
 arch/powerpc/include/asm/sections.h      |  24 +-
 arch/powerpc/include/asm/types.h         |   8 -
 arch/powerpc/kernel/fadump.c             |  13 +-
 arch/powerpc/kernel/head_64.S            |   2 +-
 arch/powerpc/kernel/interrupt_64.S       |   2 +-
 arch/powerpc/kernel/kprobes.c            |   6 +-
 arch/powerpc/kernel/misc_64.S            |   2 +-
 arch/powerpc/kernel/module.c             |   4 +-
 arch/powerpc/kernel/module_32.c          |  38 ++-
 arch/powerpc/kernel/module_64.c          |   7 +-
 arch/powerpc/kernel/ptrace/ptrace.c      |   6 -
 arch/powerpc/kernel/trace/Makefile       |   5 +-
 arch/powerpc/kernel/trace/ftrace.c       | 375 +++++++----------------
 arch/powerpc/kvm/book3s_interrupts.S     |   2 +-
 arch/powerpc/kvm/book3s_rmhandlers.S     |   2 +-
 arch/powerpc/lib/code-patching.c         |  49 +--
 arch/powerpc/lib/feature-fixups.c        |   2 +-
 arch/powerpc/net/bpf_jit.h               |   4 +-
 arch/powerpc/net/bpf_jit_comp.c          |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c        |   4 +-
 arch/powerpc/platforms/Kconfig.cputype   |   6 +
 32 files changed, 271 insertions(+), 422 deletions(-)

-- 
2.35.1

