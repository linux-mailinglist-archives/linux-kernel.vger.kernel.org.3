Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B14AC639
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356981AbiBGQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbiBGQfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:05 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2591EC0401DD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOfQI014419;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 35/42] tools/nolibc/string: export memset() and memmove()
Date:   Mon,  7 Feb 2022 17:23:47 +0100
Message-Id: <20220207162354.14293-36-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"clang -Os" and "gcc -Ofast" without -ffreestanding may ignore memset()
and memmove(), hoping to provide their builtin equivalents, and finally
not find them. Thus we must export these functions for these rare cases.
Note that as they're set in their own sections, they will be eliminated
by the linker if not used. In addition, they do not prevent gcc from
identifying them and replacing them with the shorter "rep movsb" or
"rep stosb" when relevant.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index c1661589cb3c..4554b6fcb400 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -47,7 +47,10 @@ void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
 	return dst;
 }
 
-static __attribute__((unused))
+/* might be ignored by the compiler without -ffreestanding, then found as
+ * missing.
+ */
+__attribute__((weak,unused,section(".text.nolibc_memmove")))
 void *memmove(void *dst, const void *src, size_t len)
 {
 	size_t dir, pos;
@@ -75,7 +78,10 @@ void *memcpy(void *dst, const void *src, size_t len)
 	return _nolibc_memcpy_up(dst, src, len);
 }
 
-static __attribute__((unused))
+/* might be ignored by the compiler without -ffreestanding, then found as
+ * missing.
+ */
+__attribute__((weak,unused,section(".text.nolibc_memset")))
 void *memset(void *dst, int b, size_t len)
 {
 	char *p = dst;
-- 
2.35.1

