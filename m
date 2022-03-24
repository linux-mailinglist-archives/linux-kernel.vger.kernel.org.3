Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D64E5CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbiCXBvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiCXBvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:51:37 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89F673FA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:50:05 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 24 Mar
 2022 09:49:58 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 24 Mar
 2022 09:49:57 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] powerpc/xmon: Fix warning comparing pointer to 0
Date:   Thu, 24 Mar 2022 09:49:56 +0800
Message-ID: <1648086596-26899-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/powerpc/xmon/spu-dis.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
index 4b0a4e6..6078aa5 100644
--- a/arch/powerpc/xmon/spu-dis.c
+++ b/arch/powerpc/xmon/spu-dis.c
@@ -34,7 +34,7 @@ init_spu_disassemble (void)
       int o = spu_opcodes[i].opcode;
       if (o >= SPU_DISASM_TBL_SIZE)
 	continue; /* abort (); */
-      if (spu_disassemble_table[o] == 0)
+      if (!spu_disassemble_table[o])
 	spu_disassemble_table[o] = &spu_opcodes[i];
     }
 }
@@ -48,30 +48,30 @@ get_index_for_opcode (unsigned int insn)
 
   /* Init the table.  This assumes that element 0/opcode 0 (currently
    * NOP) is always used */
-  if (spu_disassemble_table[0] == 0)
+  if (!spu_disassemble_table[0])
     init_spu_disassemble ();
 
-  if ((index = spu_disassemble_table[opcode & 0x780]) != 0
+  if ((index = spu_disassemble_table[opcode & 0x780]) != NULL
       && index->insn_type == RRR)
     return index;
 
-  if ((index = spu_disassemble_table[opcode & 0x7f0]) != 0
+  if ((index = spu_disassemble_table[opcode & 0x7f0]) != NULL
       && (index->insn_type == RI18 || index->insn_type == LBT))
     return index;
 
-  if ((index = spu_disassemble_table[opcode & 0x7f8]) != 0
+  if ((index = spu_disassemble_table[opcode & 0x7f8]) != NULL
       && index->insn_type == RI10)
     return index;
 
-  if ((index = spu_disassemble_table[opcode & 0x7fc]) != 0
+  if ((index = spu_disassemble_table[opcode & 0x7fc]) != NULL
       && (index->insn_type == RI16))
     return index;
 
-  if ((index = spu_disassemble_table[opcode & 0x7fe]) != 0
+  if ((index = spu_disassemble_table[opcode & 0x7fe]) != NULL
       && (index->insn_type == RI8))
     return index;
 
-  if ((index = spu_disassemble_table[opcode & 0x7ff]) != 0)
+  if ((index = spu_disassemble_table[opcode & 0x7ff]) != NULL)
     return index;
 
   return NULL;
@@ -89,7 +89,7 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 
   index = get_index_for_opcode (insn);
 
-  if (index == 0)
+  if (!index)
     {
       printf(".long 0x%lx", insn);
     }
-- 
2.7.4

