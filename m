Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C084150611C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiDSAqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A82AC56
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21EF4613C5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27212C385D5;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=r3jA59cd78DZiQe3/m4vv1s+CMiCUg02JEu8FamNgzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHJ7Twj57EBxawQeOg+4XnTL0PtQ6KkJ6Q3ptAZSsLqO9nFLx6NAxxr+/Z0w0WMZY
         Gkdb9d/fm6YthBy6egiX0s9A2MA9ByQlppcXbpL2q8YRyVmq2PJJA2iBi52sWrEEt/
         qSkqZLmo1mAG25QS4B/vVqz6vHwCWjgCfj2ZjyhD0rg+OejIyRGgF4YrNwW/RDfavL
         JjaQfOlSfkYGRI1KdBLoK9zV7LN2MFF1G6DVe2rCRz7EgZqRHpt5nuEsJDRGfnJgGC
         QeVGdqBGo3CDL/Anjv3ozaJ5+O5R853Cdg9q4lH4VGzdAUKKa6LRjHeATMXRs1dh+U
         IAkp3cx3YW02g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 331B85C30F7; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 24/61] tools/nolibc/sys: make open() take a vararg on the 3rd argument
Date:   Mon, 18 Apr 2022 17:41:48 -0700
Message-Id: <20220419004225.3952530-24-paulmck@kernel.org>
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

Let's pass a vararg to open() so that it remains compatible with existing
code. The arg is only dereferenced when flags contain O_CREAT. The function
is generally not inlined anymore, causing an extra call (total 16 extra
bytes) but it's still optimized for constant propagation, limiting the
excess to no more than 16 bytes in practice when open() is called without
O_CREAT, and ~40 with O_CREAT, which remains reasonable.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 98689f668ed3..539af457a91b 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -7,6 +7,7 @@
 #ifndef _NOLIBC_SYS_H
 #define _NOLIBC_SYS_H
 
+#include <stdarg.h>
 #include "std.h"
 
 /* system includes */
@@ -719,7 +720,7 @@ int mount(const char *src, const char *tgt,
 
 
 /*
- * int open(const char *path, int flags, mode_t mode);
+ * int open(const char *path, int flags[, mode_t mode]);
  */
 
 static __attribute__((unused))
@@ -735,9 +736,20 @@ int sys_open(const char *path, int flags, mode_t mode)
 }
 
 static __attribute__((unused))
-int open(const char *path, int flags, mode_t mode)
+int open(const char *path, int flags, ...)
 {
-	int ret = sys_open(path, flags, mode);
+	mode_t mode = 0;
+	int ret;
+
+	if (flags & O_CREAT) {
+		va_list args;
+
+		va_start(args, flags);
+		mode = va_arg(args, mode_t);
+		va_end(args);
+	}
+
+	ret = sys_open(path, flags, mode);
 
 	if (ret < 0) {
 		SET_ERRNO(-ret);
-- 
2.31.1.189.g2e36527f23

