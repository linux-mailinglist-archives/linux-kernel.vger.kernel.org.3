Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3F04B41F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbiBNG1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:27:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiBNG1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:27:12 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9855499
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:27:03 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JxvQF72nXz9sSV;
        Mon, 14 Feb 2022 07:27:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CcvDBiVlpTGQ; Mon, 14 Feb 2022 07:27:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JxvQF62XPz9sST;
        Mon, 14 Feb 2022 07:27:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B68248B768;
        Mon, 14 Feb 2022 07:27:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 54KbfFUlKOnC; Mon, 14 Feb 2022 07:27:01 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E5458B763;
        Mon, 14 Feb 2022 07:27:01 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21E6Qsku2064992
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 07:26:54 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21E6QsM32064991;
        Mon, 14 Feb 2022 07:26:54 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v6] mm: Uninline copy_overflow()
Date:   Mon, 14 Feb 2022 07:26:53 +0100
Message-Id: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644820013; l=2946; s=20211009; h=from:subject:message-id; bh=BkbZOFoVwjCYtAh4mbluDExLZ2VZuVGDEbW30wjsWT0=; b=nJf7OmDU/LItjDZsdMCkTDCY6BJLEHk5n+TMa4y0kIwcDqL6wBkmw4SkQ5gSQBadM2ojbCL0glJg 4kFYYtLoDqCVLk0PcfML/vvi8fthC271kGlKjWlS+hUvGQU/oyH5
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
I ended up with more than 50 times the following function in vmlinux
because GCC doesn't honor the 'inline' keyword:

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

With -Winline, GCC tells:

	/include/linux/thread_info.h:212:20: warning: inlining failed in call to 'copy_overflow': call is unlikely and code size would grow [-Winline]

copy_overflow() is a non conditional warning called by
check_copy_size() on an error path.

check_copy_size() have to remain inlined in order to benefit
from constant folding, but copy_overflow() is not worth inlining.

Uninline the warning when CONFIG_BUG is selected.

When CONFIG_BUG is not selected, WARN() does nothing so skip it.

This reduces the size of vmlinux by almost 4kbytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v6: I should have gone sleeping yesterday night instead of sending v5 out. Sorry for the noise. Fix EXPORT_SYMBOL()

v5: Change to EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL()

v4: Make copy_overflow() a no-op when CONFIG_BUG is not selected

v3: Added missing ; after EXPORT_SYMBOL()

v2: Added missing EXPORT_SYMBOL() and enhanced commit message
---
 include/linux/thread_info.h | 5 ++++-
 mm/maccess.c                | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 73a6f34b3847..9f392ec76f2b 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -209,9 +209,12 @@ __bad_copy_from(void);
 extern void __compiletime_error("copy destination size is too small")
 __bad_copy_to(void);
 
+void __copy_overflow(int size, unsigned long count);
+
 static inline void copy_overflow(int size, unsigned long count)
 {
-	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
+	if (IS_ENABLED(CONFIG_BUG))
+		__copy_overflow(size, count);
 }
 
 static __always_inline __must_check bool
diff --git a/mm/maccess.c b/mm/maccess.c
index d3f1a1f0b1c1..3fed2b876539 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -335,3 +335,9 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count)
 
 	return ret;
 }
+
+void __copy_overflow(int size, unsigned long count)
+{
+	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
+}
+EXPORT_SYMBOL(__copy_overflow);
-- 
2.34.1

