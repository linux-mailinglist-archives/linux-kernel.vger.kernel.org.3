Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA51D4ABC4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385397AbiBGLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382624AbiBGLUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:20:25 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440CC03E948
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:20:11 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jsjtv1jtXz9sSq;
        Mon,  7 Feb 2022 12:03:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YAmRq4QJUMWg; Mon,  7 Feb 2022 12:03:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jsjtv0l7Pz9sSp;
        Mon,  7 Feb 2022 12:03:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 076C88B770;
        Mon,  7 Feb 2022 12:03:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 17no10m552pl; Mon,  7 Feb 2022 12:03:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA3C78B76C;
        Mon,  7 Feb 2022 12:03:50 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 217AtJFD1027425
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 7 Feb 2022 11:55:19 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 217AtJq91027424;
        Mon, 7 Feb 2022 11:55:19 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: Outline copy_overflow()
Date:   Mon,  7 Feb 2022 11:55:18 +0100
Message-Id: <b9a31b025e729394e7081257870f0a0e73355a04.1644229010.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644231317; l=2079; s=20211009; h=from:subject:message-id; bh=B2+X2j+KlBBxIWK5drKA6NAvxrzcwOQtuyC1RfeAjSY=; b=bZ5BynnluxfvRODMh3aFzFl1M2ciHtt6MWLm8ji0Xq/x1+XEM1/JqA/RoWq2ey4KtZrThO9aiQFD As+Pc3klDGfKqGr0q+iSl63oUo8kGGNqdyF+pAHaSnm2RB4OIwh3
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

While building a small config with CONFIG_CC_OPTIMISE_FOR_SIZE,
I ended up with more than 50 times the following function in vmlinux:

	c00243bc <copy_overflow>:
	c00243bc:	94 21 ff f0 	stwu    r1,-16(r1)
	c00243c0:	7c 85 23 78 	mr      r5,r4
	c00243c4:	7c 64 1b 78 	mr      r4,r3
	c00243c8:	3c 60 c0 62 	lis     r3,-16286
	c00243cc:	7c 08 02 a6 	mflr    r0
	c00243d0:	38 63 5e e5 	addi    r3,r3,24293
	c00243d4:	90 01 00 14 	stw     r0,20(r1)
	c00243d8:	4b ff 82 45 	bl      c001c61c <__warn_printk>
	c00243dc:	0f e0 00 00 	twui    r0,0
	c00243e0:	80 01 00 14 	lwz     r0,20(r1)
	c00243e4:	38 21 00 10 	addi    r1,r1,16
	c00243e8:	7c 08 03 a6 	mtlr    r0
	c00243ec:	4e 80 00 20 	blr

That function being a non conditional warning on an error path,
it is not worth inlining.

Outline it.

This reduces the size of vmlinux by almost 4kbytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/thread_info.h | 5 +----
 mm/maccess.c                | 5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 73a6f34b3847..1087d1e2be5c 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -209,10 +209,7 @@ __bad_copy_from(void);
 extern void __compiletime_error("copy destination size is too small")
 __bad_copy_to(void);
 
-static inline void copy_overflow(int size, unsigned long count)
-{
-	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
-}
+void copy_overflow(int size, unsigned long count);
 
 static __always_inline __must_check bool
 check_copy_size(const void *addr, size_t bytes, bool is_source)
diff --git a/mm/maccess.c b/mm/maccess.c
index d3f1a1f0b1c1..d15c7b2324b4 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -335,3 +335,8 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count)
 
 	return ret;
 }
+
+void copy_overflow(int size, unsigned long count)
+{
+	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
+}
-- 
2.33.1

