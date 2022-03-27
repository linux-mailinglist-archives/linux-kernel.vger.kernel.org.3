Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A24E8688
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiC0HeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiC0HeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:34:19 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483C4312
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 00:32:41 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KR6x35gvdz9sSV;
        Sun, 27 Mar 2022 09:32:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l9UUxVPIjdLE; Sun, 27 Mar 2022 09:32:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KR6x34b9Wz9sSS;
        Sun, 27 Mar 2022 09:32:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 830848B768;
        Sun, 27 Mar 2022 09:32:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ThPcLHWlEFUZ; Sun, 27 Mar 2022 09:32:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F4358B763;
        Sun, 27 Mar 2022 09:32:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22R7WSvO2282414
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 27 Mar 2022 09:32:28 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22R7WROw2282413;
        Sun, 27 Mar 2022 09:32:27 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: Fix build failure with allyesconfig in book3s_64_entry.S
Date:   Sun, 27 Mar 2022 09:32:26 +0200
Message-Id: <89cf27bf43ee07a0b2879b9e8e2f5cd6386a3645.1648366338.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648366345; l=1222; s=20211009; h=from:subject:message-id; bh=96+kSaCqQqSaoNnej1U3MksSs1dXsAqDN4zXM01iUoE=; b=XAD5BO+OzdTkf5MAnzN4AkWLh4nvU/V8fJpknb7mgYHef9EEspZjhq7TWZzxjRIGxkpZLRgzoMSX x5lxDSECADEKy/rpKTvPKPUMIK3FPfiudeaOqHmqrMnUqBt0667A
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

Using conditional branches between two files is hasardous,
they may get linked to far from each other.

	arch/powerpc/kvm/book3s_64_entry.o:(.text+0x3ec): relocation truncated
	to fit: R_PPC64_REL14 (stub) against symbol `system_reset_common'
	defined in .text section in arch/powerpc/kernel/head_64.o

Reorganise the code to use non conditional branches.

Cc: Nicholas Piggin <npiggin@gmail.com>
Fixes: 89d35b239101 ("KVM: PPC: Book3S HV P9: Implement the rest of the P9 path in C")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kvm/book3s_64_entry.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
index 05e003eb5d90..99fa36df36fa 100644
--- a/arch/powerpc/kvm/book3s_64_entry.S
+++ b/arch/powerpc/kvm/book3s_64_entry.S
@@ -414,10 +414,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_DAWR1)
 	 */
 	ld	r10,HSTATE_SCRATCH0(r13)
 	cmpwi	r10,BOOK3S_INTERRUPT_MACHINE_CHECK
-	beq	machine_check_common
+	beq	1f
 
 	cmpwi	r10,BOOK3S_INTERRUPT_SYSTEM_RESET
-	beq	system_reset_common
+	bne	.
 
-	b	.
+	b	system_reset_common
+1:	b	machine_check_common
 #endif
-- 
2.35.1

