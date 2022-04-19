Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D30150614D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiDSAsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D22A240
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B362B8114A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3FEC34112;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=XLKBxPeaInH970fnLFsn9FT6XVtggYy2fpWAQ09hhFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaMunXNl2EybZgBMjva+gQRnb8G4orTtUuAI/XsrzIRCia0SOk18uERQSg+lz2x5U
         Bc9MbdcXNJHd6e8o4or1YuCfT9Cy1jxc9TOfIbaC0PkiEHf6kiFYaomfcwMQmAFkYr
         v8iaB2wJYZEpkm//rqDb+kvFohyqi7BzoyocFSPKRgnINtyVFrMdT8q4Pj0QSdw0so
         AQ8b4M8HzFh2bPKf4w+TrFZDFdgCk1PRYebVGvus2TXpCNzmY07Ep8JH9CFW9+Vnbj
         B96GGB481PwHB1oWCJOBRW7aOzkE2vHwGWNcdyiA4Q7OHNBbC9RJogJiI+T0opUiJV
         38BkBqjyza1jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E1945C322A; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 39/61] tools/nolibc/signal: move raise() to signal.h
Date:   Mon, 18 Apr 2022 17:42:03 -0700
Message-Id: <20220419004225.3952530-39-paulmck@kernel.org>
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

This function is normally found in signal.h, and providing the file
eases porting of existing programs. Let's move it there.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h |  1 +
 tools/include/nolibc/signal.h | 22 ++++++++++++++++++++++
 tools/include/nolibc/stdlib.h |  7 -------
 3 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 tools/include/nolibc/signal.h

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 686726518431..0f375e901a36 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -88,6 +88,7 @@
 #include "types.h"
 #include "sys.h"
 #include "ctype.h"
+#include "signal.h"
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
new file mode 100644
index 000000000000..ef47e71e2be3
--- /dev/null
+++ b/tools/include/nolibc/signal.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * signal function definitions for NOLIBC
+ * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
+ */
+
+#ifndef _NOLIBC_SIGNAL_H
+#define _NOLIBC_SIGNAL_H
+
+#include "std.h"
+#include "arch.h"
+#include "types.h"
+#include "sys.h"
+
+/* This one is not marked static as it's needed by libgcc for divide by zero */
+__attribute__((weak,unused,section(".text.nolibc_raise")))
+int raise(int signal)
+{
+	return sys_kill(sys_getpid(), signal);
+}
+
+#endif /* _NOLIBC_SIGNAL_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 0e6bca4ee089..b46bebd48ba2 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -300,11 +300,4 @@ char *u64toa(uint64_t in)
 	return itoa_buffer;
 }
 
-/* This one is not marked static as it's needed by libgcc for divide by zero */
-__attribute__((weak,unused,section(".text.nolibc_raise")))
-int raise(int signal)
-{
-	return sys_kill(sys_getpid(), signal);
-}
-
 #endif /* _NOLIBC_STDLIB_H */
-- 
2.31.1.189.g2e36527f23

