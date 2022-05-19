Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAB52DB13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiESRVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbiESRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:21:48 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F336A2046
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:21:47 -0700 (PDT)
Received: from integral2.. (unknown [180.242.99.67])
        by gnuweeb.org (Postfix) with ESMTPSA id 975F47E465;
        Thu, 19 May 2022 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652980906;
        bh=e3Z1rLbTrDyV0Qy1q6LaHjUA/vCayqRtvdmXJu+gLAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clzRgnDvILoQDmPoRsRlD4wK1giE6tkRIp07qlc0w0qXq5UcSmGqUkdyyvTu5hLrP
         8LiZVJYr1K0XXULIl8DVSb/XksuAMXikboMtTOilQmtJ3cGpKYFClNUJUFIKS4yHsa
         iv7C+n6ZhhjOpI5ccpXbM7H2zovVXot7RixyvqywhwggY+wfFQQJL76K86pdFcd0Ua
         VG4MEtDesqjvEFbZRlSmX0MEIVJa4aHEX0gu78qxcs2GA0J/lTSh0G1dXS0s10QtCZ
         XeExqByaex1aDR3GaNBAsw6retgUmX8fiYWE46bAjh90eLUTUiMmlVJ0nfQTIu3+DG
         Jq0cz6PIpttMQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Subject: [PATCH v1 1/2] tools/nolibc/stdlib: Support overflow checking for older compiler versions
Date:   Fri, 20 May 2022 00:21:15 +0700
Message-Id: <20220519172116.283687-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
References: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we used __builtin_mul_overflow() to check for overflow in
the multiplication operation in the calloc() function. However, older
compiler versions don't support this built-in. This patch changes the
overflow checking mechanism to make it work on any compiler version
by using a division method to check for overflow. No functional change
intended. While in there, remove the unused variable `void *orig`.

Link: https://lore.kernel.org/lkml/20220330024114.GA18892@1wt.eu
Suggested-by: Willy Tarreau <w@1wt.eu>
Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/stdlib.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 8fd32eaf8037..92378c4b9660 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -128,10 +128,9 @@ void *malloc(size_t len)
 static __attribute__((unused))
 void *calloc(size_t size, size_t nmemb)
 {
-	void *orig;
-	size_t res = 0;
+	size_t x = size * nmemb;
 
-	if (__builtin_expect(__builtin_mul_overflow(nmemb, size, &res), 0)) {
+	if (__builtin_expect(size && ((x / size) != nmemb), 0)) {
 		SET_ERRNO(ENOMEM);
 		return NULL;
 	}
@@ -140,7 +139,7 @@ void *calloc(size_t size, size_t nmemb)
 	 * No need to zero the heap, the MAP_ANONYMOUS in malloc()
 	 * already does it.
 	 */
-	return malloc(res);
+	return malloc(x);
 }
 
 static __attribute__((unused))
-- 
Ammar Faizi

