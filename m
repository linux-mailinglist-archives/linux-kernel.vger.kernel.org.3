Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F48552813
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbiFTXRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347094AbiFTXRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBBE222AA;
        Mon, 20 Jun 2022 16:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEEB961515;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9FAC3411C;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766810;
        bh=PFW+nJeUjF0+z9b2ZiIQ19Ctf2Uib8uU1+Ln6e2nhDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwiGTaw0+1uiz5RGyeKLUrv4A701/KRlUqZwqmCI5im1OvrE4Hl6ZA2ZbDBmurscf
         UL02wlNnUKAjN947vHf6bzqgrfN3bGr93Tv923/uXB1d6LDN+mgxSUO1wddxBF8Rep
         pt5vB3/27ynR6ecKJoIj1M+rQvyJIUd9TMIXE/pBuYRPNSnG6AuCvJQiMoxtwuddCt
         VIY/XlpbgcqwkgvbRxk1evIZCbdMsVcH8hUCk0WCLO+TX7MidGraZx3snt2yN/1RO+
         NND9mWBkeGRHNxnqGQ8DddPZo03Vmj0aK1OyBU1qZtjAyZ9wjaUNGR+T9CpzD4V412
         7PLYDXfuufBhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DB69C5C05B9; Mon, 20 Jun 2022 16:13:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/5] tools/nolibc/stdlib: Support overflow checking for older compiler versions
Date:   Mon, 20 Jun 2022 16:13:24 -0700
Message-Id: <20220620231328.3845126-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

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
Acked-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 8fd32eaf80370..92378c4b96605 100644
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
2.31.1.189.g2e36527f23

