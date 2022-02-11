Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC934B27E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiBKO3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:29:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiBKO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:29:44 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400DCF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:29:43 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JwGGY5x43z9sSB;
        Fri, 11 Feb 2022 15:29:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id USX2o3PF4ShW; Fri, 11 Feb 2022 15:29:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JwGGX3q5dz9sS1;
        Fri, 11 Feb 2022 15:29:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E6DC8B77D;
        Fri, 11 Feb 2022 15:29:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id F0JzPDXcZiPg; Fri, 11 Feb 2022 15:29:40 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.91])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2765F8B764;
        Fri, 11 Feb 2022 15:29:40 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21BETUUS1222886
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 15:29:30 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21BETNhO1222885;
        Fri, 11 Feb 2022 15:29:23 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Rewrite loading of AMR_KUAP_BLOCKED in assembly
Date:   Fri, 11 Feb 2022 15:29:20 +0100
Message-Id: <56f6eebc9c5c1196038d17c09a5ef1f245e1167c.1644588937.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644589759; l=1751; s=20211009; h=from:subject:message-id; bh=z/4Ca8ZC2EDmkSpiIzEao9zLZfk88V1Qa0syyqnav7w=; b=uVWHavhvA87L5pq1TuD7hAlwiQFGToKKzz1orO49d0Yag2cfxu7oI0CmOTFdeReIZ1Hl7YUYrXr/ u9pcHNHADkfFwWulU9XhQqFRJFENm3n0wpyR34RALpa4ahpa4fiT
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

Constant loading of AMR_KUAP_BLOCKED takes 5 instructions:

	c000000000016a40:       4c 00 01 2c     isync
	c000000000016a44:       3d 20 fc ff     lis     r9,-769
	c000000000016a48:       61 29 ff ff     ori     r9,r9,65535
	c000000000016a4c:       79 29 07 c6     rldicr  r9,r9,32,31
	c000000000016a50:       65 29 ff ff     oris    r9,r9,65535
	c000000000016a54:       61 29 ff ff     ori     r9,r9,65535
	c000000000016a58:       7d 3d 03 a6     mtamr   r9
	c000000000016a5c:       4c 00 01 2c     isync

Until GCC is fixed, implement it in assembly using 2 instructions:

	c000000000016a50:       4c 00 01 2c     isync
	c000000000016a54:       39 20 fc ff     li      r9,-769
	c000000000016a58:       79 29 80 02     rotldi  r9,r9,48
	c000000000016a5c:       7d 3d 03 a6     mtamr   r9
	c000000000016a60:       4c 00 01 2c     isync

With this change a ppc64_defconfig build is reduced by 15 kbytes.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94395
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/kup.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 54cf46808157..35c017ba29e1 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -338,6 +338,10 @@ static __always_inline void set_kuap(unsigned long value)
 	 * before and after the move to AMR. See table 6 on page 1134.
 	 */
 	isync();
+
+	if (__builtin_constant_p(value) && value == 0xfcffffffffffffff)
+		asm("li %0, %1 ; rotldi %0, %0, 48" : "=r"(value) : "i"(0xfffffffffffffcff));
+
 	mtspr(SPRN_AMR, value);
 	isync();
 }
-- 
2.34.1

