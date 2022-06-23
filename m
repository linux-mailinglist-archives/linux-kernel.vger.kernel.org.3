Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5221455760E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiFWI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiFWI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:57:24 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865794666D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:57:23 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LTDfB1kRcz9t7C;
        Thu, 23 Jun 2022 10:57:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gTSDzbELHdlg; Thu, 23 Jun 2022 10:57:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LTDfB0zTBz9t6Q;
        Thu, 23 Jun 2022 10:57:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1025B8B781;
        Thu, 23 Jun 2022 10:57:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UExh2KMkcgMT; Thu, 23 Jun 2022 10:57:22 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.34])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C59898B763;
        Thu, 23 Jun 2022 10:57:21 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25N8v8mv1200361
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 10:57:08 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25N8v8Zu1200352;
        Thu, 23 Jun 2022 10:57:08 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] powerpc/64e: Rewrite p4d_populate() as a static inline function
Date:   Thu, 23 Jun 2022 10:56:57 +0200
Message-Id: <1b416f8a8fe1bc3f4e01175680ce310b7eb3a1e4.1655974565.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655974616; l=1044; s=20211009; h=from:subject:message-id; bh=mKWaYp2wYHt3KQiAnZHcT6REMirM2chYLoLkpYpljic=; b=MQlZhc2Xgg5B96C1oGtFDjruds80b3PLoSlBP03kpllyACQN3qzIcWzc4taMYbmIe8hKQ39NuZak 6ruITfp0A4djKYCaR9VN+Tx7dreqZ66+LaCO/2Gs3TaYz7bh8zzt
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

Rewrite p4d_populate() as a static inline function instead of
a macro.

This change allows typechecking and would have helped detecting
a recently found bug in map_kernel_page().

Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 668aee6017e7..e50b211becb3 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -15,7 +15,10 @@ struct vmemmap_backing {
 };
 extern struct vmemmap_backing *vmemmap_list;
 
-#define p4d_populate(MM, P4D, PUD)	p4d_set(P4D, (unsigned long)PUD)
+static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
+{
+	p4d_set(p4d, (unsigned long)pud);
+}
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-- 
2.36.1

