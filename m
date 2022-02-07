Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA94AB9E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352839AbiBGLMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245739AbiBGLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:05:36 -0500
X-Greylist: delayed 101 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 03:05:34 PST
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84FC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:05:34 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jsjwr6tf9z9sSt;
        Mon,  7 Feb 2022 12:05:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aWLzZJ7pXfZT; Mon,  7 Feb 2022 12:05:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jsjwq2lyBz9sSs;
        Mon,  7 Feb 2022 12:05:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D3AD8B770;
        Mon,  7 Feb 2022 12:05:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QxPg5mPpH0pg; Mon,  7 Feb 2022 12:05:31 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 378C18B76C;
        Mon,  7 Feb 2022 12:05:31 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 217B5LOA1027987
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 7 Feb 2022 12:05:21 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 217B5Lh61027986;
        Mon, 7 Feb 2022 12:05:21 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>
Subject: [PATCH] mm: Remove usercopy_warn()
Date:   Mon,  7 Feb 2022 12:05:20 +0100
Message-Id: <5f26643fc70b05f8455b60b99c30c17d635fa640.1644231910.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644231919; l=1883; s=20211009; h=from:subject:message-id; bh=wIJyCP1PdT8iOVPkvJwg5OArPM4eZSb3XxPni92db5w=; b=nuqG4rtZ/oQJYKRVbabqXKW0MvZJNyKD5y3OL5BzTQXNpvgMfw2As5f1mWfBQRKn9TtZ1+CqhyL0 v0FG/1DCCf3LTYRTWGjQtGZ4FrBWle4ZaTv6W7/43Tx/tj8KmmuG
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

Users of usercopy_warn() were removed by
commit 53944f171a89 ("mm: remove HARDENED_USERCOPY_FALLBACK")

Remote it.

Cc: Stephen Kitt <steve@sk2.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/uaccess.h |  2 --
 mm/usercopy.c           | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..bca27b4e5eb2 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -401,8 +401,6 @@ static inline void user_access_restore(unsigned long flags) { }
 #endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
-void usercopy_warn(const char *name, const char *detail, bool to_user,
-		   unsigned long offset, unsigned long len);
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,
 			       unsigned long len);
diff --git a/mm/usercopy.c b/mm/usercopy.c
index d0d268135d96..e7b0cb49daa1 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -70,17 +70,6 @@ static noinline int check_stack_object(const void *obj, unsigned long len)
  * kmem_cache_create_usercopy() function to create the cache (and
  * carefully audit the whitelist range).
  */
-void usercopy_warn(const char *name, const char *detail, bool to_user,
-		   unsigned long offset, unsigned long len)
-{
-	WARN_ONCE(1, "Bad or missing usercopy whitelist? Kernel memory %s attempt detected %s %s%s%s%s (offset %lu, size %lu)!\n",
-		 to_user ? "exposure" : "overwrite",
-		 to_user ? "from" : "to",
-		 name ? : "unknown?!",
-		 detail ? " '" : "", detail ? : "", detail ? "'" : "",
-		 offset, len);
-}
-
 void __noreturn usercopy_abort(const char *name, const char *detail,
 			       bool to_user, unsigned long offset,
 			       unsigned long len)
-- 
2.33.1

