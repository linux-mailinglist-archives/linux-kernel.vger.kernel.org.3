Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9B5A7A40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiHaJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaJch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:32:37 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0F3CCE1F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:32:34 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MHf8v60Vjz9sbx;
        Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MdSRiXEzl9bZ; Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MHf8v5HKTz9sVQ;
        Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A55718B77B;
        Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2U00swej_vNY; Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AEDB8B766;
        Wed, 31 Aug 2022 11:32:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27V9WMuw1567825
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 11:32:22 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27V9WMIJ1567824;
        Wed, 31 Aug 2022 11:32:22 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/32: Allow fragmented physical memory
Date:   Wed, 31 Aug 2022 11:32:08 +0200
Message-Id: <fc9a5b8ef49f6eb86e970d4c7ccfba9b407fd4eb.1661938317.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <959d77be630b9b46a7458f0fbd41dc3a94ec811a.1661938317.git.christophe.leroy@csgroup.eu>
References: <959d77be630b9b46a7458f0fbd41dc3a94ec811a.1661938317.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661938326; l=1146; s=20211009; h=from:subject:message-id; bh=prj5etDyCJo1uNWUgN/W5vaoOc8+EtTJjUJOsFMnjIg=; b=zs/iOc7wnOiTzeqnRipZt0f0xbxkrR1hPF9iktKn4V9uaLO3IU0pvPZAUuF9zqP5x2zQ0UH75+50 7I7CqWFMBIoHsHmS6YJ2/exuwyRGg8/Gd8xSMON7wY10q8kuA+FH
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

Since commit 9e849f231c3c ("powerpc/mm/32s: use generic mmu_mapin_ram()
for all blocks.") it is possible to map all blocks as RAM on any PPC32.

Remove related restrictions.

And remove call to wii_memory_fixups() which doesn't do anything else
than checks since commit 160985f3025b ("powerpc/wii: remove
wii_mmu_mapin_mem2()")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/init_32.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 50de41042c0a..3142d7617412 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -82,15 +82,6 @@ void __init MMU_init(void)
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:enter", 0x111);
 
-	if (memblock.memory.cnt > 1) {
-#ifndef CONFIG_WII
-		memblock_enforce_memory_limit(memblock.memory.regions[0].size);
-		pr_warn("Only using first contiguous memory region\n");
-#else
-		wii_memory_fixups();
-#endif
-	}
-
 	total_lowmem = total_memory = memblock_end_of_DRAM() - memstart_addr;
 	lowmem_end_addr = memstart_addr + total_lowmem;
 
-- 
2.37.1

