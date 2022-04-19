Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFD506127
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiDSApv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF09729CBE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDA4061384
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7C5C385C0;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=bMnuAAz/eHf3kftehr8yMhAugyO//WQ2KN1CkNhFtfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvSJ85gPogGVnZRqCmxAjn2gffIyF4Xv/1hniEXt2828/W8cAnMigYGr4SyFAaSy0
         B+8eZS6mv81+BMlnWo/xWu8vKPBlHjQpoSFoABIclV6pkdEkAVRCmyhAGceTaQejDJ
         rrryKcWbT8CyEQdWUQnG93BnMWaweHhluwgfbC6Bt3qczdOiVxn1wsOUUZcvxD20j+
         ofPbo2tmYkVhnOQMyFFaPhAxf9+I0xIvDGZ/PaQDpT2zyPBYEdwdZ0uq+a5rnLqMf0
         /ZMdVzTtEp1jSacaD63U8/h91cLyGcPtASckX7BT6OEfwayM5a1njz5OGppUQQMdy3
         3VnfpYSDBqWTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 202D55C2B13; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 14/61] tools/nolibc/stdlib: move ltoa() to stdlib.h
Date:   Mon, 18 Apr 2022 17:41:38 -0700
Message-Id: <20220419004225.3952530-14-paulmck@kernel.org>
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

This function is not standard and performs the opposite of atol(). Let's
move it with atol(). It's been split between a reentrant function and one
using a static buffer.

There's no more definition in nolibc.h anymore now.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 22 ----------------------
 tools/include/nolibc/stdlib.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 23fb81414b1b..a349c88c45ff 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -94,26 +94,4 @@
 /* Used by programs to avoid std includes */
 #define NOLIBC
 
-static __attribute__((unused))
-const char *ltoa(long in)
-{
-	/* large enough for -9223372036854775808 */
-	static char buffer[21];
-	char       *pos = buffer + sizeof(buffer) - 1;
-	int         neg = in < 0;
-	unsigned long n = neg ? -in : in;
-
-	*pos-- = '\0';
-	do {
-		*pos-- = '0' + n % 10;
-		n /= 10;
-		if (pos < buffer)
-			return pos + 1;
-	} while (n);
-
-	if (neg)
-		*pos-- = '-';
-	return pos + 1;
-}
-
 #endif /* _NOLIBC_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 09a506aadbbe..84fc4353fb01 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -45,6 +45,38 @@ int atoi(const char *s)
 	return atol(s);
 }
 
+/* performs the opposite of atol() using a user-fed buffer. The buffer must be
+ * at least 21 bytes long (large enough for "-9223372036854775808").
+ */
+static __attribute__((unused))
+const char *ltoa_r(long in, char *buffer)
+{
+	char       *pos = buffer + 21 - 1;
+	int         neg = in < 0;
+	unsigned long n = neg ? -in : in;
+
+	*pos-- = '\0';
+	do {
+		*pos-- = '0' + n % 10;
+		n /= 10;
+		if (pos < buffer)
+			return pos + 1;
+	} while (n);
+
+	if (neg)
+		*pos-- = '-';
+	return pos + 1;
+}
+
+/* performs the opposite of atol() using a statically allocated buffer */
+static __attribute__((unused))
+const char *ltoa(long in)
+{
+	/* large enough for -9223372036854775808 */
+	static char buffer[21];
+	return ltoa_r(in, buffer);
+}
+
 static __attribute__((unused))
 int msleep(unsigned int msecs)
 {
-- 
2.31.1.189.g2e36527f23

