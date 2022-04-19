Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A24506121
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiDSAqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E329D2B27C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A821613F9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A22C385CA;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=UZUZd3XUKazCR3gnl766Ne/BmjRCGIHbkqdHS487CK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFaNfUAv05Znx/ADLckjJAPkzWVT74iFbUQPxrFv/icolazD3YGDaScRyuj9TiwGQ
         5FpISCd+T4UXUPryCzu9aOeRHDc34Dq7Pw65m7+6nsFVRRCu2KvNWYv1zzN98R2vlM
         fhDbKD61N6w1Nd/89KhnWHQMOTIA25p8HOH01aO0CtaQInVV0dBeTGfVOQnHIDMJVQ
         sklmiD8hYMcyIQ9wV7Z4SJS68mDxLR2B2bEnOynI3KmMEzB8GWZl0O6QBRr+jC0YMF
         mkdvvxrRU3q12Ua9j2BclnOos8fjKkU5pP0UNByy6w/FNBXHm+sq3jB0fQbfFfHE6/
         K4x/2XgnZz8XQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 27BE85C30DF; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 18/61] tools/nolibc/stdio: add a minimal set of stdio functions
Date:   Mon, 18 Apr 2022 17:41:42 -0700
Message-Id: <20220419004225.3952530-18-paulmck@kernel.org>
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

This only provides getchar(), putchar(), and puts().

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h |  1 +
 tools/include/nolibc/stdio.h  | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/include/nolibc/stdio.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index a349c88c45ff..7eaa09fe9f4d 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -88,6 +88,7 @@
 #include "types.h"
 #include "sys.h"
 #include "ctype.h"
+#include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
 
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
new file mode 100644
index 000000000000..4c6af3016e2e
--- /dev/null
+++ b/tools/include/nolibc/stdio.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * minimal stdio function definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_STDIO_H
+#define _NOLIBC_STDIO_H
+
+#include "std.h"
+#include "arch.h"
+#include "types.h"
+#include "sys.h"
+#include "stdlib.h"
+#include "string.h"
+
+#ifndef EOF
+#define EOF (-1)
+#endif
+
+static __attribute__((unused))
+int getchar(void)
+{
+	unsigned char ch;
+
+	if (read(0, &ch, 1) <= 0)
+		return EOF;
+	return ch;
+}
+
+static __attribute__((unused))
+int putchar(int c)
+{
+	unsigned char ch = c;
+
+	if (write(1, &ch, 1) <= 0)
+		return EOF;
+	return ch;
+}
+
+static __attribute__((unused))
+int puts(const char *s)
+{
+	size_t len = strlen(s);
+	ssize_t ret;
+
+	while (len > 0) {
+		ret = write(1, s, len);
+		if (ret <= 0)
+			return EOF;
+		s += ret;
+		len -= ret;
+	}
+	return putchar('\n');
+}
+
+#endif /* _NOLIBC_STDIO_H */
-- 
2.31.1.189.g2e36527f23

