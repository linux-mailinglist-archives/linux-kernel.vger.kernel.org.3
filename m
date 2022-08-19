Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A2599D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349354AbiHSO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349540AbiHSO1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:27:16 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A80E9918
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:27:15 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4M8PGT4wqQz9shj;
        Fri, 19 Aug 2022 16:27:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HSF6PGJSbxdw; Fri, 19 Aug 2022 16:27:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4M8PGT3vmVz9shX;
        Fri, 19 Aug 2022 16:27:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CA168B77C;
        Fri, 19 Aug 2022 16:27:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VR3B-w3mshBH; Fri, 19 Aug 2022 16:27:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.4.22])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 363C28B763;
        Fri, 19 Aug 2022 16:27:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27JER0s52215678
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 16:27:00 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27JER07u2215676;
        Fri, 19 Aug 2022 16:27:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl_booke: Make calc_cam_sz() static
Date:   Fri, 19 Aug 2022 16:26:49 +0200
Message-Id: <a7469848371b2cf5e8f654ec79800e209d88595e.1660919200.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1660919208; l=1525; s=20211009; h=from:subject:message-id; bh=L++ineN4VN9rQJojH00UC9wJeQDuvg5jehPZxtCRR14=; b=44Ckq1p6dYPBPH9yh/gW7H9Bedd744QkOwzzcd3CYSxrEL6+7gS/yQbuz3WlTrewkshhvRouORv4 WjTlGF2rAN2YQrcVzO/5RMnqklqKz1fh7JxnjZ8HSDRHqaVsQPBL
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

calc_cam_sz() is used only in fsl_book3e.c, make it static.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mmu_decl.h          | 2 --
 arch/powerpc/mm/nohash/fsl_book3e.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 8f5afad1b6af..6dd4744cc56a 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -122,8 +122,6 @@ unsigned long mmu_mapin_ram(unsigned long base, unsigned long top);
 #ifdef CONFIG_PPC_FSL_BOOK3E
 extern unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx,
 				     bool dryrun, bool init);
-extern unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
-				 phys_addr_t phys);
 #ifdef CONFIG_PPC32
 extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
diff --git a/arch/powerpc/mm/nohash/fsl_book3e.c b/arch/powerpc/mm/nohash/fsl_book3e.c
index b8ae6c08c06f..c1ad173de318 100644
--- a/arch/powerpc/mm/nohash/fsl_book3e.c
+++ b/arch/powerpc/mm/nohash/fsl_book3e.c
@@ -135,8 +135,8 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	tlbcam_addrs[index].phys = phys;
 }
 
-unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
-			  phys_addr_t phys)
+static unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
+				 phys_addr_t phys)
 {
 	unsigned int camsize = __ilog2(ram);
 	unsigned int align = __ffs(virt | phys);
-- 
2.37.1

