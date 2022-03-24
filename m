Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030984E6542
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351058AbiCXOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiCXOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:33:23 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE5A27DD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:31:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSMJ1WQSz9sTx;
        Thu, 24 Mar 2022 15:31:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7KTf5loOKX99; Thu, 24 Mar 2022 15:31:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSLy72bdz9sTt;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D88278B788;
        Thu, 24 Mar 2022 15:30:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rhUQYIxNomRP; Thu, 24 Mar 2022 15:30:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACDC68B78C;
        Thu, 24 Mar 2022 15:30:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEUepc1811678
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:30:40 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEUbsN1811676;
        Thu, 24 Mar 2022 15:30:37 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 00/22] powerpc: ftrace optimisation and cleanup and more [v1]
Date:   Thu, 24 Mar 2022 15:29:50 +0100
Message-Id: <cover.1648131740.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132150; l=2522; s=20211009; h=from:subject:message-id; bh=1kdeof/3p6R0MrXJo/S/TdRiyM63GQANW/OO7r8vz4Y=; b=kGMMi2rAvo8giIT/mEJWlVTPCKKZwoheEmWvvyBG+7zESHejT96yufouHjLeQoG5X/EU69OMbzVc AjNllGhEBAsKp4sZyXEVQ73PYz5+rAcO5xvLleT24WRBY65rlcq9
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

Christophe Leroy (22):
  powerpc/ftrace: Refactor prepare_ftrace_return()
  powerpc/ftrace: Remove redundant create_branch() calls
  powerpc/code-patching: Inline is_offset_in_{cond}_branch_range()
  powerpc/ftrace: Use is_offset_in_branch_range()
  powerpc/code-patching: Inline create_branch()
  powerpc/ftrace: Inline ftrace_modify_code()
  powerpc/ftrace: Use patch_instruction() return directly
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
  powerpc/modules: Use PPC_INST_BRANCH_MASK instead of opencoding
  powerpc/inst: Remove PPC_INST_BL
  powerpc/opcodes: Remove unused PPC_INST_XXX macros

 arch/powerpc/include/asm/book3s/32/pgtable.h |   2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |   2 +-
 arch/powerpc/include/asm/code-patching.h     |  53 ++-
 arch/powerpc/include/asm/inst.h              |  13 +-
 arch/powerpc/include/asm/module.h            |   6 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |   2 +-
 arch/powerpc/include/asm/ppc-opcode.h        |  20 +-
 arch/powerpc/include/asm/sections.h          |  24 +-
 arch/powerpc/kernel/module_32.c              |  29 +-
 arch/powerpc/kernel/module_64.c              |  10 +-
 arch/powerpc/kernel/trace/Makefile           |   5 +-
 arch/powerpc/kernel/trace/ftrace.c           | 390 ++++++-------------
 arch/powerpc/lib/code-patching.c             |  47 ---
 arch/powerpc/lib/feature-fixups.c            |   2 +-
 arch/powerpc/net/bpf_jit.h                   |   2 +-
 15 files changed, 229 insertions(+), 378 deletions(-)

-- 
2.35.1

