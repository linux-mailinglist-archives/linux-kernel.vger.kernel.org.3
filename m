Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5B506122
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbiDSArV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241301AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4DE2A240
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E0C6142F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88615C341CA;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=j8vRrSIGA5eY2yqQxjTQ6hCoN82BQk/R3nGKaW0dpFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJTq6PT5abiZlrOjn9+yKxNrb7Z+yInWy5df4wqY5dK79d3EqqmoL/JEn6fP8eOgQ
         Fp+RJ1sePT8KM2Clpgpl3W/M46LMdE6n3F5eOPZQ0ud8Z46bEgybFvt5wTBuGv8rQB
         AZ0/R0Jxznln+heHhiMXVxC91uFXkO84WDht3sYPVwwAsr5qSYOIvbFUxj2VhMepsF
         MOCdUnvcjanR9zXmMp+3s7y+gpApv6CQyu5FX8iJyyj3ai3KkSGWRIR8DOGII2VmTB
         grbe0l8GhsKMcBXCkpzXGQVECoib3JWaZsunK7LJYBUdSfCtYRG38x/WD6+WyrpQ/D
         c+Z3bgA9uUh0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 643D05C323C; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 51/61] tools/nolibc/string: do not use __builtin_strlen() at -O0
Date:   Mon, 18 Apr 2022 17:42:15 -0700
Message-Id: <20220419004225.3952530-51-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
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

From: Willy Tarreau <w@1wt.eu>

clang wants to use strlen() for __builtin_strlen() at -O0. We don't
really care about -O0 but it at least ought to build, so let's make
sure we don't choke on this, by dropping the optimizationn for
constant strings in this case.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 0d5e870c7c0b..75a453870498 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -122,7 +122,9 @@ char *strcpy(char *dst, const char *src)
 	return ret;
 }
 
-/* this function is only used with arguments that are not constants */
+/* this function is only used with arguments that are not constants or when
+ * it's not known because optimizations are disabled.
+ */
 static __attribute__((unused))
 size_t nolibc_strlen(const char *str)
 {
@@ -132,11 +134,18 @@ size_t nolibc_strlen(const char *str)
 	return len;
 }
 
+/* do not trust __builtin_constant_p() at -O0, as clang will emit a test and
+ * the two branches, then will rely on an external definition of strlen().
+ */
+#if defined(__OPTIMIZE__)
 #define strlen(str) ({                          \
 	__builtin_constant_p((str)) ?           \
 		__builtin_strlen((str)) :       \
 		nolibc_strlen((str));           \
 })
+#else
+#define strlen(str) nolibc_strlen((str))
+#endif
 
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
-- 
2.31.1.189.g2e36527f23

