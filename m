Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF924AC5A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382208AbiBGQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382075AbiBGQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:25:54 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CF66C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:25:54 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GObTb014392;
        Mon, 7 Feb 2022 17:24:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 09/42] tools/nolibc/ctype: split the is* functions to ctype.h
Date:   Mon,  7 Feb 2022 17:23:21 +0100
Message-Id: <20220207162354.14293-10-w@1wt.eu>
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

In fact there's only isdigit() for now. More should definitely be added.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/ctype.h  | 22 ++++++++++++++++++++++
 tools/include/nolibc/nolibc.h |  7 +------
 2 files changed, 23 insertions(+), 6 deletions(-)
 create mode 100644 tools/include/nolibc/ctype.h

diff --git a/tools/include/nolibc/ctype.h b/tools/include/nolibc/ctype.h
new file mode 100644
index 000000000000..6735bd906f25
--- /dev/null
+++ b/tools/include/nolibc/ctype.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * ctype function definitions for NOLIBC
+ * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_CTYPE_H
+#define _NOLIBC_CTYPE_H
+
+#include "std.h"
+
+/*
+ * As much as possible, please keep functions alphabetically sorted.
+ */
+
+static __attribute__((unused))
+int isdigit(int c)
+{
+	return (unsigned int)(c - '0') <= 9;
+}
+
+#endif /* _NOLIBC_CTYPE_H */
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index b06bd5cb5651..c96c6cb7f3ae 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -87,18 +87,13 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
+#include "ctype.h"
 #include "stdlib.h"
 #include "string.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
 
-static __attribute__((unused))
-int isdigit(int c)
-{
-	return (unsigned int)(c - '0') <= 9;
-}
-
 static __attribute__((unused))
 const char *ltoa(long in)
 {
-- 
2.35.1

