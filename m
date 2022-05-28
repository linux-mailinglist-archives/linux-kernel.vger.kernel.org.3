Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD1536D94
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244852AbiE1Pql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243709AbiE1Pqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:46:38 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C06018D
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:46:29 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24SFjqCt008309;
        Sat, 28 May 2022 17:45:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/3] tools/nolibc: add a help target to list supported targets
Date:   Sat, 28 May 2022 17:45:46 +0200
Message-Id: <20220528154546.8261-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220528154546.8261-1-w@1wt.eu>
References: <20220528154546.8261-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "help" target simply presents the list of supported targets
and the current set of variables being used to build the sysroot.

Since the help in tools/ suggests to use "install", which is
supported by most tools while such a target is not really relevant
here, an "install" target was also added, redirecting to "help".

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 9768819abd55..cfd06764b5ae 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -31,6 +31,23 @@ all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
 # install all headers needed to support a bare-metal compiler
 all: headers
 
+install: help
+
+help:
+	@echo "Supported targets under nolibc:"
+	@echo "  all                 call \"headers\""
+	@echo "  clean               clean the sysroot"
+	@echo "  headers             prepare a sysroot in tools/include/nolibc/sysroot"
+	@echo "  headers_standalone  like \"headers\", and also install kernel headers"
+	@echo "  help                this help"
+	@echo ""
+	@echo "These targets may also be called from tools as \"make nolibc_<target>\"."
+	@echo ""
+	@echo "Currently using the following variables:"
+	@echo "  ARCH    = $(ARCH)"
+	@echo "  OUTPUT  = $(OUTPUT)"
+	@echo ""
+
 # Note: when ARCH is "x86" we concatenate both x86_64 and i386
 headers:
 	$(Q)mkdir -p $(OUTPUT)sysroot
-- 
2.17.5

