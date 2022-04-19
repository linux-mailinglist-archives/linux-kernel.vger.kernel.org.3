Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B894506105
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiDSApX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbiDSApL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AE2315B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF31861351
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9ECC385B7;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=KBxg4+WCFRQHXJRwWF3oca+y8uUZrIRicem0al7Bhbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mE3SgOlNTpUgR6obtlKDT622moBURFBqcHWBiyvtx+nCUbfdmzoew84xIMg7eKbtw
         BmUzzc7IxXHQZ8ZoQSTWwc2+u5XDTJOiva4bOz4Puam3Z3dFKxmB1LJ5Gg+Ktcienf
         Oq4gVcyeb+JVdbS8E0sPd9A5kCz6m9Z8XFB+eXo+X5uV9u6oB7PqeEEllhizjrI7ql
         FiTw4us8AUqf+uasnH1q6v/9w4+5VoYMMH2bLHl3qWSmj+un16uag0UrxCu+hFmLHB
         uS4e5OcJGcAASXeZkGz8MRvLUhV+ctkCXfRUESaOOExLguZ5SyZcE5wW8BrCcIzJkX
         vMqQC9ltMsl/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1705A5C12AB; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 09/61] tools/nolibc/ctype: split the is* functions to ctype.h
Date:   Mon, 18 Apr 2022 17:41:33 -0700
Message-Id: <20220419004225.3952530-9-paulmck@kernel.org>
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

In fact there's only isdigit() for now. More should definitely be added.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

