Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7D54AE61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiFNKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiFNKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:32:57 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748552126B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:32:56 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LMlBX5CSlz9tNR;
        Tue, 14 Jun 2022 12:32:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7QqG8AjRLTeg; Tue, 14 Jun 2022 12:32:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LMlBW04L7z9tNZ;
        Tue, 14 Jun 2022 12:32:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E17878B773;
        Tue, 14 Jun 2022 12:32:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2_Cop6hKjodS; Tue, 14 Jun 2022 12:32:50 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.246])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B74A8B76E;
        Tue, 14 Jun 2022 12:32:50 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25EAWaXB197837
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 12:32:36 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25EAWamx197836;
        Tue, 14 Jun 2022 12:32:36 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/32: Remove __map_without_ltlbs
Date:   Tue, 14 Jun 2022 12:32:25 +0200
Message-Id: <3422094db965d218c4c3d8580f526963a9ac897f.1655202721.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <6977314c823cfb728bc0273cea634b41807bfb64.1655202721.git.christophe.leroy@csgroup.eu>
References: <6977314c823cfb728bc0273cea634b41807bfb64.1655202721.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655202743; l=2348; s=20211009; h=from:subject:message-id; bh=79aJZFlau9V4EX0MkIvwL5a3GNFn5ZsgXUv/EMZRsRE=; b=ob065Ze7/f/8PW70jrpOG4YYD6+I92fxhm1vPQvpXLAY94M5AhPO4Ew8Tf9+4osxt6mL8m5+7yHG 7UC3UlHnCnlrvLLqpo8l7uKjNkzgpur+tQdd3e55WKB319IZhUA4
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

__map_without_ltlbs is used only for 40x, and only when
STRICT_KERNEL_RWX, KFENCE or DEBUG_PAGEALLOC is active.

Do the verification directly in 40x version of mmu_mapin_ram()
and remove __map_without_ltlbs from core ppc32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/init_32.c    | 23 -----------------------
 arch/powerpc/mm/nohash/40x.c |  9 +++++++--
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 6f2e6210c273..62d9af6606cd 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -69,29 +69,9 @@ EXPORT_SYMBOL(agp_special_page);
 
 void MMU_init(void);
 
-int __map_without_ltlbs;
-
 /* max amount of low RAM to map in */
 unsigned long __max_low_memory = MAX_LOW_MEM;
 
-/*
- * Check for command-line options that affect what MMU_init will do.
- */
-static void __init MMU_setup(void)
-{
-	if (IS_ENABLED(CONFIG_PPC_8xx))
-		return;
-
-	if (IS_ENABLED(CONFIG_KFENCE))
-		__map_without_ltlbs = 1;
-
-	if (debug_pagealloc_enabled())
-		__map_without_ltlbs = 1;
-
-	if (strict_kernel_rwx_enabled())
-		__map_without_ltlbs = 1;
-}
-
 /*
  * MMU_init sets up the basic memory mappings for the kernel,
  * including both RAM and possibly some I/O regions,
@@ -102,9 +82,6 @@ void __init MMU_init(void)
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:enter", 0x111);
 
-	/* parse args from command line */
-	MMU_setup();
-
 	/*
 	 * Reserve gigantic pages for hugetlb.  This MUST occur before
 	 * lowmem_end_addr is initialized below.
diff --git a/arch/powerpc/mm/nohash/40x.c b/arch/powerpc/mm/nohash/40x.c
index b32e465a3d52..3684d6e570fb 100644
--- a/arch/powerpc/mm/nohash/40x.c
+++ b/arch/powerpc/mm/nohash/40x.c
@@ -43,7 +43,6 @@
 
 #include <mm/mmu_decl.h>
 
-extern int __map_without_ltlbs;
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
@@ -94,7 +93,13 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	p = 0;
 	s = total_lowmem;
 
-	if (__map_without_ltlbs)
+	if (IS_ENABLED(CONFIG_KFENCE))
+		return 0;
+
+	if (debug_pagealloc_enabled())
+		return 0;
+
+	if (strict_kernel_rwx_enabled())
 		return 0;
 
 	while (s >= LARGE_PAGE_SIZE_16M) {
-- 
2.36.1

