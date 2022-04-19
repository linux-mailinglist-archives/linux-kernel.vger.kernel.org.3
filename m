Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92074506140
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiDSAtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbiDSApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B132DD47
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF09061435
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F650C341C6;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=fO3ANS+3+Q4svTIvmIKIZkxe9FFvIXzh9NCzYaoF7rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muAXkONmum4tn/Y+1beOr/AoTCDfM2WUed+3fronYty6s9IrfhZzJC7Lc7pW7saSH
         uVoP3bDWZyYjEbLRmlazrYkOx0z/5rIVY47ni7DhLfrDerdejXe/6hzPS8emuemqKo
         8fFJp4lno4veN6QpgCCelc6W/CI1WVUVZAaokVxx/TXo/VGgxsDI6w/lA3WuAKT16g
         9gG4svnVYe8QFS/NIFwoCmxtSHuseuOVCSBJWRB+ovY4IVgwcLPoyZgS86d2Aonohd
         DRb9Xo6c9c2/pjc8h7Q3bALvLlhJjua86qHUiz7b1pC8NHq2n7TUst3qaHRbBIBmVy
         aJ43JNfiuL+XQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 60CC75C3239; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 49/61] tools/nolibc: add a makefile to install headers
Date:   Mon, 18 Apr 2022 17:42:13 -0700
Message-Id: <20220419004225.3952530-49-paulmck@kernel.org>
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

This provides a target "headers_standalone" which installs the nolibc's
arch-specific headers with "arch.h" taken from the current arch (or a
concatenation of both i386 and x86_64 for arch=x86), then installs
kernel headers. This creates a convenient sysroot which is directly
usable by a bare-metal compiler to create any executable.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/Makefile | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/include/nolibc/Makefile

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
new file mode 100644
index 000000000000..7a16d917c185
--- /dev/null
+++ b/tools/include/nolibc/Makefile
@@ -0,0 +1,42 @@
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
-- 
2.31.1.189.g2e36527f23

