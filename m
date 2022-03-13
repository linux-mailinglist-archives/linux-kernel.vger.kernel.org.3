Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793804D7803
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiCMTnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCMTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:43:12 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23C246672
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 12:42:03 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KGqn550v2z9sSZ;
        Sun, 13 Mar 2022 20:42:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zM9WJLY_07P2; Sun, 13 Mar 2022 20:42:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KGqn546qcz9sSN;
        Sun, 13 Mar 2022 20:42:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E7E58B76C;
        Sun, 13 Mar 2022 20:42:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ANLsLKNImt6Q; Sun, 13 Mar 2022 20:42:01 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (po21526.idsi0.si.c-s.fr [192.168.202.11])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33B9F8B763;
        Sun, 13 Mar 2022 20:42:01 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22DJfsnm4033764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 13 Mar 2022 20:41:54 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22DJfqC44033756;
        Sun, 13 Mar 2022 20:41:52 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/book3e: Fix sparse report in mm/nohash/fsl_book3e.c
Date:   Sun, 13 Mar 2022 20:41:41 +0100
Message-Id: <fd0cc30b5556428ce1d8a1fc0f983b462e88a956.1647200488.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1647200500; l=1602; s=20211009; h=from:subject:message-id; bh=KMDIhx31LwVg2uPbc5GFmfgIkUCmsjznvXmZGpFhCkU=; b=C6p41C8bt6nZ5/ChYyGb6QgQVP559ZZF3gZ0MVLVrnND2t6P58hP9XSJEL3zn1eLfrMCVESA+GYB ybyPHNVtDYAL9LctUbIEw+Ikf64ya6rqPlbetNJp0EGh49xdtVXe
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

Make tlbcam_addrs[] static.

Declare TLBCAM[] in mm/mmu_decl.h

And use NULL instead of 0 as pointer when calling restore_to_as0().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mmu_decl.h          | 4 ++++
 arch/powerpc/mm/nohash/fsl_book3e.c | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 0dd4c18f8363..63c4b1a4d435 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -155,6 +155,10 @@ struct tlbcam {
 	u32	MAS3;
 	u32	MAS7;
 };
+
+#define NUM_TLBCAMS	64
+
+extern struct tlbcam TLBCAM[NUM_TLBCAMS];
 #endif
 
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_FSL_BOOKE) || defined(CONFIG_PPC_8xx)
diff --git a/arch/powerpc/mm/nohash/fsl_book3e.c b/arch/powerpc/mm/nohash/fsl_book3e.c
index dfe715e0f70a..9c5387647d1c 100644
--- a/arch/powerpc/mm/nohash/fsl_book3e.c
+++ b/arch/powerpc/mm/nohash/fsl_book3e.c
@@ -51,10 +51,9 @@
 
 unsigned int tlbcam_index;
 
-#define NUM_TLBCAMS	(64)
 struct tlbcam TLBCAM[NUM_TLBCAMS];
 
-struct tlbcamrange {
+static struct {
 	unsigned long start;
 	unsigned long limit;
 	phys_addr_t phys;
@@ -274,7 +273,7 @@ void __init adjust_total_lowmem(void)
 
 	i = switch_to_as1();
 	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM, false, true);
-	restore_to_as0(i, 0, 0, 1);
+	restore_to_as0(i, 0, NULL, 1);
 
 	pr_info("Memory CAM mapping: ");
 	for (i = 0; i < tlbcam_index - 1; i++)
-- 
2.34.1

