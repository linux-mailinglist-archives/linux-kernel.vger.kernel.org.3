Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF785B0092
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiIGJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiIGJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:35:27 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0205D0FD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:35:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MMxtv3njQz9sg4;
        Wed,  7 Sep 2022 11:35:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PdWygxaEbxp6; Wed,  7 Sep 2022 11:35:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MMxtt3Krlz9sj9;
        Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61EF98B78D;
        Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DUFADMmpvT9c; Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CF968B763;
        Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2879Z8KU3152071
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 11:35:08 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2879Z8ru3152070;
        Wed, 7 Sep 2022 11:35:08 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Rely on generic definition of hugepd_t and is_hugepd when unused
Date:   Wed,  7 Sep 2022 11:34:45 +0200
Message-Id: <da81462d93069bb90fe5e762dd3283a644318937.1662543243.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <ae6aa7fce84f7abcbf67f534271a4a6dd7949b0d.1662543243.git.christophe.leroy@csgroup.eu>
References: <ae6aa7fce84f7abcbf67f534271a4a6dd7949b0d.1662543243.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662543257; l=3051; s=20211009; h=from:subject:message-id; bh=dwvDuzlvq8SONoorrKNa3VmFaR8M1glUWqk5WhAXBgo=; b=vDUAQ9zt8ZjKgw7JWG6OHZMPKGrg9wlKqPAq1rwSdhtsZp4W32W4E66xE+EkG62IH7nmh/UZratW 8tkhhJDoDEUpXX9Y4Hmh8iJumy/XhgKFMnvrlsLn+ykkPVaW0NLD
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

CONFIG_ARCH_HAS_HUGEPD is used to tell core mm when huge page
directories are used.

When they are not used, no need to provide hugepd_t or is_hugepd(),
just rely on the core mm fallback definition.

For that, change core mm behaviour so that CONFIG_ARCH_HAS_HUGEPD
is used instead of indirect is_hugepd macro existence.

powerpc being the only user of huge page directories, there is no
impact on other architectures.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/page.h             | 5 -----
 arch/powerpc/include/asm/pgtable-be-types.h | 2 ++
 arch/powerpc/include/asm/pgtable-types.h    | 2 ++
 include/linux/hugetlb.h                     | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index c67eb9531a3f..7f20636d13ed 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -308,11 +308,6 @@ static inline bool pfn_valid(unsigned long pfn)
 #include <asm/pgtable-types.h>
 #endif
 
-
-#ifndef CONFIG_HUGETLB_PAGE
-#define is_hugepd(pdep)		(0)
-#endif /* CONFIG_HUGETLB_PAGE */
-
 struct page;
 extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,
diff --git a/arch/powerpc/include/asm/pgtable-be-types.h b/arch/powerpc/include/asm/pgtable-be-types.h
index b169bbf95fcb..82633200b500 100644
--- a/arch/powerpc/include/asm/pgtable-be-types.h
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -101,6 +101,7 @@ static inline bool pmd_xchg(pmd_t *pmdp, pmd_t old, pmd_t new)
 	return pmd_raw(old) == prev;
 }
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 typedef struct { __be64 pdbe; } hugepd_t;
 #define __hugepd(x) ((hugepd_t) { cpu_to_be64(x) })
 
@@ -108,5 +109,6 @@ static inline unsigned long hpd_val(hugepd_t x)
 {
 	return be64_to_cpu(x.pdbe);
 }
+#endif
 
 #endif /* _ASM_POWERPC_PGTABLE_BE_TYPES_H */
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index efed0db7b1db..082c85cc09b1 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -83,11 +83,13 @@ static inline bool pte_xchg(pte_t *ptep, pte_t old, pte_t new)
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 typedef struct { unsigned long pd; } hugepd_t;
 #define __hugepd(x) ((hugepd_t) { (x) })
 static inline unsigned long hpd_val(hugepd_t x)
 {
 	return x.pd;
 }
+#endif
 
 #endif /* _ASM_POWERPC_PGTABLE_TYPES_H */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a0d8b3..1ec1535be04f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -17,7 +17,7 @@ struct ctl_table;
 struct user_struct;
 struct mmu_gather;
 
-#ifndef is_hugepd
+#ifndef CONFIG_ARCH_HAS_HUGEPD
 typedef struct { unsigned long pd; } hugepd_t;
 #define is_hugepd(hugepd) (0)
 #define __hugepd(x) ((hugepd_t) { (x) })
-- 
2.37.1

