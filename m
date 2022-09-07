Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87A95B0091
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIGJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGJfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:35:22 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF252FD7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:35:20 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MMxtt44QYz9skZ;
        Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VlyXDmNoZbuc; Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MMxtt3KZRz9sg4;
        Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 608858B78C;
        Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8hy77BlcPQU0; Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E7928B78B;
        Wed,  7 Sep 2022 11:35:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2879Z8bw3152067
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 11:35:08 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2879Z7QH3152050;
        Wed, 7 Sep 2022 11:35:07 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/nohash: Remove pgd_huge() stub
Date:   Wed,  7 Sep 2022 11:34:44 +0200
Message-Id: <ae6aa7fce84f7abcbf67f534271a4a6dd7949b0d.1662543243.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662543257; l=1234; s=20211009; h=from:subject:message-id; bh=7hDMBtrmK2il7u822eIO2Bp0mXg/gfrXU8aF6TWndos=; b=BMYlbIFFzP5sia0vweR4QpmNJYuREFL5Mi+U5XOjobiPP6RFIje5ZG4CrMIU4ngpKxoGPnbDGSV6 qvJnwRA/ADLW/6gIgDBdn7cf+kWnK5MvAKMiIyfX2Wj7JeUceDjO
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

linux/hugetlb.h has a fallback pgd_huge() macro for when
pgd_huge is not defined.

Remove the powerpc redundant definitions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 6 ------
 arch/powerpc/include/asm/page.h           | 1 -
 2 files changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index b499da6c1a99..08429c612cdf 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -277,12 +277,6 @@ static inline int pud_huge(pud_t pud)
 	return 0;
 }
 
-static inline int pgd_huge(pgd_t pgd)
-{
-	return 0;
-}
-#define pgd_huge		pgd_huge
-
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e5f75c70eda8..c67eb9531a3f 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -311,7 +311,6 @@ static inline bool pfn_valid(unsigned long pfn)
 
 #ifndef CONFIG_HUGETLB_PAGE
 #define is_hugepd(pdep)		(0)
-#define pgd_huge(pgd)		(0)
 #endif /* CONFIG_HUGETLB_PAGE */
 
 struct page;
-- 
2.37.1

