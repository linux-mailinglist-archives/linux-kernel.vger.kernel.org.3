Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6B506153
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbiDSAtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbiDSApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2172AC56
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF396144B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CED2C341D4;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=SAi7SiqOSBsk63L/rgllGMvfAa9FDXT1VUYe+0Ta7o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZWinPR74yeyguiuPdrA5Knmu0YAGoj7UqvrymWwAgWgfV3jfNaGilpU8V0m9wbc2
         5XRGT86IYF5H1ZytQwiMRtG/JUwbcQiK6+TouYf8z1Prf6OMoXzEJePd0MrfMO30My
         UlibZXDlyYHeTRfZX60Yp+fSQWjoloUXRvf86EX4u8BgSN7qlQxQ6oqW34x1aPEeNu
         pVo0e9o7KEyiNMmnrgG+vXOIDQKJN0LGK9ObJ3wI3qEfUVbYpLrcdQDHoEABmRzTVv
         gLztyyM4gmqTM7nh9bjzO4eoiqJCdxSvZdGG+fH0itj6jBf4ppeSWN2tE7+gXH9hOY
         bYQxf9/NUpwYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 65FB75C323D; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 52/61] tools/nolibc/stdlib: only reference the external environ when inlined
Date:   Mon, 18 Apr 2022 17:42:16 -0700
Message-Id: <20220419004225.3952530-52-paulmck@kernel.org>
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

When building with gcc at -O0 we're seeing link errors due to the
"environ" variable being referenced by getenv(). The problem is that
at -O0 gcc will not inline getenv() and will not drop the external
reference. One solution would be to locally declare the variable as
weak, but then it would appear in all programs even those not using
it, and would be confusing to users of getenv() who would forget to
set environ to envp.

An alternate approach used in this patch consists in always inlining
the outer part of getenv() that references this extern so that it's
always dropped when not used. The biggest part of the function was
now moved to a new function called _getenv() that's still not inlined
by default.

Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index aca8616335e3..8a07e263f0d0 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -60,16 +60,17 @@ int atoi(const char *s)
 	return atol(s);
 }
 
-/* Tries to find the environment variable named <name> in the environment array
- * pointed to by global variable "environ" which must be declared as a char **,
- * and must be terminated by a NULL (it is recommended to set this variable to
- * the "envp" argument of main()). If the requested environment variable exists
- * its value is returned otherwise NULL is returned.
+/* getenv() tries to find the environment variable named <name> in the
+ * environment array pointed to by global variable "environ" which must be
+ * declared as a char **, and must be terminated by a NULL (it is recommended
+ * to set this variable to the "envp" argument of main()). If the requested
+ * environment variable exists its value is returned otherwise NULL is
+ * returned. getenv() is forcefully inlined so that the reference to "environ"
+ * will be dropped if unused, even at -O0.
  */
 static __attribute__((unused))
-char *getenv(const char *name)
+char *_getenv(const char *name, char **environ)
 {
-	extern char **environ;
 	int idx, i;
 
 	if (environ) {
@@ -83,6 +84,13 @@ char *getenv(const char *name)
 	return NULL;
 }
 
+static inline __attribute__((unused,always_inline))
+char *getenv(const char *name)
+{
+	extern char **environ;
+	return _getenv(name, environ);
+}
+
 /* Converts the unsigned long integer <in> to its hex representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
-- 
2.31.1.189.g2e36527f23

