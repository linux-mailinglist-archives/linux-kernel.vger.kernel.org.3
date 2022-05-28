Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BC3536D91
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiE1PqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiE1PqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:46:09 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FCD0183A8
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:46:06 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24SFjqaI008307;
        Sat, 28 May 2022 17:45:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/3] tools/nolibc: fix the makefile to also work as "make -C tools ..."
Date:   Sat, 28 May 2022 17:45:44 +0200
Message-Id: <20220528154546.8261-2-w@1wt.eu>
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

As reported by Linus, the nolibc's makefile is currently broken when
invoked as per the documented method (make -C tools nolibc_<target>),
because it now relies on the ARCH and OUTPUT variables that are not
set in this case.

This patch addresses this by sourcing subarch.include, and by
presetting OUTPUT to the current directory if not set. This is
sufficient to make the commands work both as a standalone target
and as a tools/ sub-target.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 7a16d917c185..e8bac6ef3653 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -7,6 +7,22 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/include/,%,$(dir $(CURDIR)))
 endif
 
+# when run as make -C tools/ nolibc_<foo> the arch is not set
+ifeq ($(ARCH),)
+include $(srctree)/scripts/subarch.include
+ARCH = $(SUBARCH)
+endif
+
+# OUTPUT is only set when run from the main makefile, otherwise
+# it defaults to this nolibc directory.
+OUTPUT ?= $(CURDIR)/
+
+ifeq ($(V),1)
+Q=
+else
+Q=@
+endif
+
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
 all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
@@ -36,7 +52,7 @@ headers:
 
 headers_standalone: headers
 	$(Q)$(MAKE) -C $(srctree) headers
-	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)/sysroot
+	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)sysroot
 
 clean:
 	$(call QUIET_CLEAN, nolibc) rm -rf "$(OUTPUT)sysroot"
-- 
2.17.5

