Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054994E2F17
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349030AbiCURfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348477AbiCURe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F9566628
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXOSO007576;
        Mon, 21 Mar 2022 18:33:24 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 7/8] tools/nolibc: add a makefile to install headers
Date:   Mon, 21 Mar 2022 18:33:13 +0100
Message-Id: <20220321173314.7519-8-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a target "headers_standalone" which installs the nolibc's
arch-specific headers with "arch.h" taken from the current arch (or a
concatenation of both i386 and x86_64 for arch=x86), then installs
kernel headers. This creates a convenient sysroot which is directly
usable by a bare-metal compiler to create any executable.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/include/nolibc/Makefile

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
new file mode 100644
index 000000000000..7d4d61b08637
--- /dev/null
+++ b/tools/include/nolibc/Makefile
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for nolibc installation and tests
+include ../../scripts/Makefile.include
+
+# we're in ".../tools/include/nolibc"
+ifeq ($(srctree),)
+srctree := $(patsubst %/tools/include/,%,$(dir $(CURDIR)))
+endif
+
+nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
+arch_file := arch-$(nolibc_arch).h
+all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
+             sys.h time.h types.h unistd.h
+
+# install all headers needed to support a bare-metal compiler
+all:
+
+# Note: when ARCH is "x86" we concatenate both x86_64 and i386
+headers:
+	$(Q)mkdir -p $(OUTPUT)sysroot
+	$(Q)mkdir -p $(OUTPUT)sysroot/include
+	$(Q)cp $(all_files) $(OUTPUT)sysroot/include/
+	$(Q)if [ "$(ARCH)" = "x86" ]; then      \
+		sed -e                          \
+		  's,^#ifndef _NOLIBC_ARCH_X86_64_H,#if !defined(_NOLIBC_ARCH_X86_64_H) \&\& defined(__x86_64__),' \
+		  arch-x86_64.h;                \
+		sed -e                          \
+		  's,^#ifndef _NOLIBC_ARCH_I386_H,#if !defined(_NOLIBC_ARCH_I386_H) \&\& !defined(__x86_64__),' \
+		  arch-i386.h;                  \
+	elif [ -e "$(arch_file)" ]; then        \
+		cat $(arch_file);               \
+	else                                    \
+		echo "Fatal: architecture $(ARCH) not yet supported by nolibc." >&2; \
+		exit 1;                         \
+	fi > $(OUTPUT)sysroot/include/arch.h
+
+headers_standalone: headers
+	$(Q)$(MAKE) -C $(srctree) headers
+	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)/sysroot
+
+clean:
+	$(call QUIET_CLEAN, nolibc) rm -rf "$(OUTPUT)sysroot"
+
-- 
2.35.1

