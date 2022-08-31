Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3984B5A8584
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHaS0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiHaSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B88FBA7E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A1D61CDA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E56EC43148;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=lb42YBMvLlJW4lhYMw9xjWvBOmbnubrtUFTuevru2ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFqs+jXql95dhNhsLgp/E6VykkPUTD3fs0WXfOsZfDFEkra8Gd/eyNwUDvSIrDf63
         c3x34MVYx7EiM/qw2CMIiEfY/kRThs0L/KjcySwSUABqc/apZ/rDtaBZvFwCx2b3Dz
         nbZ+Eoy13AU4LIFECFwPPXuKOoTuIok3YUyDIspTrHDd2NPToVDv/a063RD/ntbMCV
         6A59fYamRPZNywb/lPJQOooOmIj+HibhC8biw8c8vjDIG2XBP3vUAWmovnl/avxPdX
         qCx4epYJDsXtJK2BLiItnrKDIkVS8NczIV9P8VeImjxItL9TZppRYeUjsnJZ6JGT5W
         fbkMyefLIcOAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D905F5C090A; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 04/18] selftests/nolibc: add basic infrastructure to ease creation of nolibc tests
Date:   Wed, 31 Aug 2022 11:21:34 -0700
Message-Id: <20220831182148.2698489-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

This creates a "nolibc" selftest that intends to test various parts of
the nolibc component, both in terms of build and execution for a given
architecture.

The aim is for it to be as simple to run as a kernel build, by just
passing the compiler (for the build) and the ARCH (for kernel and
execution).

It brings a basic squeleton made of a single C file that will ease testing
and error reporting. The code will be arranged so that it remains easy to
add basic tests for syscalls or library calls that may rely on a condition
to be executed, and whose result is compared to a value or to an error
with a specific errno value.

Tests will just use a relative line number in switch/case statements as
an index, saving the user from having to maintain arrays and complicated
functions which can often just be one-liners.

MAINTAINERS was updated.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 MAINTAINERS                                  |   1 +
 tools/testing/selftests/nolibc/Makefile      |  43 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 395 +++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/Makefile
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff98..89f939ad19963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14444,6 +14444,7 @@ M:	Willy Tarreau <w@1wt.eu>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
 F:	tools/include/nolibc/
+F:	tools/testing/selftests/nolibc/
 
 NSDEPS
 M:	Matthias Maennich <maennich@google.com>
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
new file mode 100644
index 0000000000000..fd0a670823340
--- /dev/null
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for nolibc tests
+include ../../../scripts/Makefile.include
+
+# we're in ".../tools/testing/selftests/nolibc"
+ifeq ($(srctree),)
+srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
+endif
+
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
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
+LDFLAGS := -s
+
+all: nolibc-test
+
+nolibc-test: nolibc-test.c
+	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $^ -lgcc
+
+initramfs: nolibc-test
+	$(QUIET_MKDIR)mkdir -p initramfs
+	$(call QUIET_INSTALL, initramfs/init)
+	$(Q)cp nolibc-test initramfs/init
+
+clean:
+	$(call QUIET_CLEAN, nolibc-test)
+	$(Q)rm -f nolibc-test
+	$(call QUIET_CLEAN, initramfs)
+	$(Q)rm -rf initramfs
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
new file mode 100644
index 0000000000000..6c050d4381fec
--- /dev/null
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* platform-specific include files coming from the compiler */
+#include <limits.h>
+
+/* libc-specific include files
+ * The program may be built in 2 ways:
+ *   $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
+ *   $(CC) -nostdlib -I/path/to/nolibc/sysroot
+ */
+#ifndef NOLIBC
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#endif
+
+/* will be used by nolibc by getenv() */
+char **environ;
+
+#define CASE_ERR(err) \
+	case err: return #err
+
+/* returns the error name (e.g. "ENOENT") for common errors, "SUCCESS" for 0,
+ * or the decimal value for less common ones.
+ */
+const char *errorname(int err)
+{
+	switch (err) {
+	case 0: return "SUCCESS";
+	CASE_ERR(EPERM);
+	CASE_ERR(ENOENT);
+	CASE_ERR(ESRCH);
+	CASE_ERR(EINTR);
+	CASE_ERR(EIO);
+	CASE_ERR(ENXIO);
+	CASE_ERR(E2BIG);
+	CASE_ERR(ENOEXEC);
+	CASE_ERR(EBADF);
+	CASE_ERR(ECHILD);
+	CASE_ERR(EAGAIN);
+	CASE_ERR(ENOMEM);
+	CASE_ERR(EACCES);
+	CASE_ERR(EFAULT);
+	CASE_ERR(ENOTBLK);
+	CASE_ERR(EBUSY);
+	CASE_ERR(EEXIST);
+	CASE_ERR(EXDEV);
+	CASE_ERR(ENODEV);
+	CASE_ERR(ENOTDIR);
+	CASE_ERR(EISDIR);
+	CASE_ERR(EINVAL);
+	CASE_ERR(ENFILE);
+	CASE_ERR(EMFILE);
+	CASE_ERR(ENOTTY);
+	CASE_ERR(ETXTBSY);
+	CASE_ERR(EFBIG);
+	CASE_ERR(ENOSPC);
+	CASE_ERR(ESPIPE);
+	CASE_ERR(EROFS);
+	CASE_ERR(EMLINK);
+	CASE_ERR(EPIPE);
+	CASE_ERR(EDOM);
+	CASE_ERR(ERANGE);
+	CASE_ERR(ENOSYS);
+	default:
+		return itoa(err);
+	}
+}
+
+static int pad_spc(int llen, int cnt, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+	int ret;
+
+	for (len = 0; len < cnt - llen; len++)
+		putchar(' ');
+
+	va_start(args, fmt);
+	ret = vfprintf(stdout, fmt, args);
+	va_end(args);
+	return ret < 0 ? ret : ret + len;
+}
+
+/* The tests below are intended to be used by the macroes, which evaluate
+ * expression <expr>, print the status to stdout, and update the "ret"
+ * variable to count failures. The functions themselves return the number
+ * of failures, thus either 0 or 1.
+ */
+
+#define EXPECT_ZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_zr(expr, llen); } while (0)
+
+static int expect_zr(int expr, int llen)
+{
+	int ret = !(expr == 0);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_NZ(cond, expr, val)			\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_nz(expr, llen; } while (0)
+
+static int expect_nz(int expr, int llen)
+{
+	int ret = !(expr != 0);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_EQ(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_eq(expr, llen, val); } while (0)
+
+static int expect_eq(int expr, int llen, int val)
+{
+	int ret = !(expr == val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_NE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ne(expr, llen, val); } while (0)
+
+static int expect_ne(int expr, int llen, int val)
+{
+	int ret = !(expr != val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_GE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ge(expr, llen, val); } while (0)
+
+static int expect_ge(int expr, int llen, int val)
+{
+	int ret = !(expr >= val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_GT(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_gt(expr, llen, val); } while (0)
+
+static int expect_gt(int expr, int llen, int val)
+{
+	int ret = !(expr > val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_LE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_le(expr, llen, val); } while (0)
+
+static int expect_le(int expr, int llen, int val)
+{
+	int ret = !(expr <= val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_LT(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_lt(expr, llen, val); } while (0)
+
+static int expect_lt(int expr, int llen, int val)
+{
+	int ret = !(expr < val);
+
+	llen += printf(" = %d ", expr);
+	pad_spc(llen, 40, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+
+#define EXPECT_SYSZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syszr(expr, llen); } while (0)
+
+static int expect_syszr(int expr, int llen)
+{
+	int ret = 0;
+
+	if (expr) {
+		ret = 1;
+		llen += printf(" = %d %s ", expr, errorname(errno));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += printf(" = %d ", expr);
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_SYSEQ(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syseq(expr, llen, val); } while (0)
+
+static int expect_syseq(int expr, int llen, int val)
+{
+	int ret = 0;
+
+	if (expr != val) {
+		ret = 1;
+		llen += printf(" = %d %s ", expr, errorname(errno));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += printf(" = %d ", expr);
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_SYSNE(cond, expr, val)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_sysne(expr, llen, val); } while (0)
+
+static int expect_sysne(int expr, int llen, int val)
+{
+	int ret = 0;
+
+	if (expr == val) {
+		ret = 1;
+		llen += printf(" = %d %s ", expr, errorname(errno));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += printf(" = %d ", expr);
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_SYSER(cond, expr, expret, experr)			\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
+
+static int expect_syserr(int expr, int expret, int experr, int llen)
+{
+	int ret = 0;
+	int _errno = errno;
+
+	llen += printf(" = %d %s ", expr, errorname(_errno));
+	if (expr != expret || _errno != experr) {
+		ret = 1;
+		llen += printf(" != (%d %s) ", expret, errorname(experr));
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_PTRZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrzr(expr, llen); } while (0)
+
+static int expect_ptrzr(const void *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%p> ", expr);
+	if (expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_PTRNZ(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_ptrnz(expr, llen); } while (0)
+
+static int expect_ptrnz(const void *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%p> ", expr);
+	if (!expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STRZR(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
+
+static int expect_strzr(const char *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STRNZ(cond, expr)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strnz(expr, llen); } while (0)
+
+static int expect_strnz(const char *expr, int llen)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (!expr) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STREQ(cond, expr, cmp)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_streq(expr, llen, cmp); } while (0)
+
+static int expect_streq(const char *expr, int llen, const char *cmp)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (strcmp(expr, cmp) != 0) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+
+#define EXPECT_STRNE(cond, expr, cmp)				\
+	do { if (!cond) pad_spc(llen, 40, "[SKIPPED]\n"); else ret += expect_strne(expr, llen, cmp); } while (0)
+
+static int expect_strne(const char *expr, int llen, const char *cmp)
+{
+	int ret = 0;
+
+	llen += printf(" = <%s> ", expr);
+	if (strcmp(expr, cmp) == 0) {
+		ret = 1;
+		llen += pad_spc(llen, 40, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 40, " [OK]\n");
+	}
+	return ret;
+}
+
+/* declare tests based on line numbers. There must be exactly one test per line. */
+#define CASE_TEST(name) \
+	case __LINE__: llen += printf("%d %s", test, #name);
+
+
+int main(int argc, char **argv, char **envp)
+{
+	int min = 0;
+	int max = __INT_MAX__;
+	int ret = 0;
+
+	environ = envp;
+
+	printf("Total number of errors: %d\n", ret);
+	printf("Exiting with status %d\n", !!ret);
+	return !!ret;
+}
-- 
2.31.1.189.g2e36527f23

