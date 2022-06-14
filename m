Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6B854AE72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355713AbiFNKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiFNKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:34:42 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD4483A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:34:40 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LMlDZ55Ysz9tNV;
        Tue, 14 Jun 2022 12:34:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HmOK5EWRTWTv; Tue, 14 Jun 2022 12:34:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LMlDZ3y1Vz9tNR;
        Tue, 14 Jun 2022 12:34:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 704C68B766;
        Tue, 14 Jun 2022 12:34:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id viGlSsPwX9aF; Tue, 14 Jun 2022 12:34:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.246])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21BB38B763;
        Tue, 14 Jun 2022 12:34:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25EAYR2H198169
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 12:34:27 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25EAYLaA198135;
        Tue, 14 Jun 2022 12:34:21 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 1/2] powerpc/32: Call mmu_mark_initmem_nx() regardless of data block mapping.
Date:   Tue, 14 Jun 2022 12:34:08 +0200
Message-Id: <db3fc14f3bfa6215b0786ef58a6e2bc1e1f964d7.1655202804.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655202848; l=2629; s=20211009; h=from:subject:message-id; bh=CWIqUkDIpE0cTlWDObjuQQ9rCQCZ66wP1qn7E4f2HIU=; b=o4yZQIyM+TiCgO+EiPa4v7u+AtxpOfdZOftncIiUapJHJkXdLISDQwKbkXI/1PVyRODuQWUXGIa/ YGeActtVAtZWj4SFPH5la/D66PoFg8FRYbCsWKVxxDFrIWEdmiM6
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

mark_initmem_nx() calls either mmu_mark_initmem_nx() or
set_memory_attr() based on return from v_block_mapped()
of _sinittext.

But we can now handle text and data independently, so that
text may be mapped by block even when data is mapped by pages.

On the 8xx for instance, at startup 32Mbytes of memory are
pinned in TLB. So the pinned entries need to go away for sinittext.

In next patch a BAT will be set to also covers sinittext on book3s/32.
So it will also be needed to call mmu_mark_initmem_nx() even when
data above sinittext is not mapped with BATs.

As this is highly dependent on the platform, call mmu_mark_initmem_nx()
regardless of data block mapping. Then the platform will know what to
do.

Modify 8xx mmu_mark_initmem_nx() so that inittext mapping is modified
only when pagealloc debug and kfence are not active, otherwise inittext
is mapped with standard pages. And don't do anything on kernel text
which is already mapped with PAGE_KERNEL_TEXT.

Cc: Maxime Bizon <mbizon@freebox.fr>
Fixes: da1adea07576 ("powerpc/8xx: Allow STRICT_KERNEL_RwX with pinned TLB")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/8xx.c | 4 ++--
 arch/powerpc/mm/pgtable_32.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 27f9186ae374..1ee08c3efe5b 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -179,8 +179,8 @@ void mmu_mark_initmem_nx(void)
 	unsigned long boundary = strict_kernel_rwx_enabled() ? sinittext : etext8;
 	unsigned long einittext8 = ALIGN(__pa(_einittext), SZ_8M);
 
-	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, false);
-	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
+	if (!debug_pagealloc_enabled_or_kfence())
+		mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
 
 	mmu_pin_tlb(block_mapped_ram, false);
 }
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a56ade39dc68..3ac73f9fb5d5 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -135,9 +135,9 @@ void mark_initmem_nx(void)
 	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
 				 PFN_DOWN((unsigned long)_sinittext);
 
-	if (v_block_mapped((unsigned long)_sinittext)) {
-		mmu_mark_initmem_nx();
-	} else {
+	mmu_mark_initmem_nx();
+
+	if (!v_block_mapped((unsigned long)_sinittext)) {
 		set_memory_nx((unsigned long)_sinittext, numpages);
 		set_memory_rw((unsigned long)_sinittext, numpages);
 	}
-- 
2.36.1

