Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC85A8583
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiHaS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHaSZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE87FBA56
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A3B61CE8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98829C43150;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=Aozz16IgN8xofEXnp7WD6afvGqRXQ72TKTm8qXa/snM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEgb7Sbw+XginjhLeDEeNxbBp2JEgr4wWdYgLImEAweIEbVk8bKNSlc+RSMX9ilns
         ZuHhUkKubV6fyvr+0kC4CspPkMk/ozjY4C3s4ensT3hn3UpaCYeOJtoA+Ht0pf1u4t
         r+my3LRjClmIeLQI5VGeQfgXquy3M1ogkdOgV0ukr35cF7A10F7Tf7L2Zp9dpwlGPV
         Lkn53Bzuprnkp5vru1TaSh5kYCK6ABIRF8/fDblQV/uv5cNxYM4V4OdmuI4EbeUQAW
         MYiPVtYh6R9dVZq9Sg1xi8jN6sVpfjvSZowwKBz1Nq1a3ppZCRJmnJUCbvXR+8JJXE
         XopclT0kZFzLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E77DC5C0B54; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 12/18] selftests/nolibc: support glibc as well
Date:   Wed, 31 Aug 2022 11:21:42 -0700
Message-Id: <20220831182148.2698489-14-paulmck@kernel.org>
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

Adding support for glibc can be useful to distinguish between bugs in
nolibc and bugs in the kernel when a syscall reports an unusual value.

It's not that much work and should not affect the long term
maintainability of the tests. The necessary changes can essentially be
summed up like this:
  - set _GNU_SOURCE a the top to access some definitions
  - many includes added when we know we don't come from nolibc (missing
    the stdio include guard)
  - disable gettid() which is not exposed by glibc
  - disable gettimeofday's support of bad pointers since these  crash
    in glibc
  - add a simple itoa() for errorname(); strerror() is too verbose (no
    way to get short messages). strerrorname_np() was added in modern
    glibc (2.32) to do exactly this but that 's too recent to be usable
    as the default fallback.
  - use the standard ioperm() definition. May be we need to implement
    ioperm() in nolibc if that's useful.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 47 +++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 662dea691749c..78bced95ac630 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,17 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define _GNU_SOURCE
+
 /* platform-specific include files coming from the compiler */
 #include <limits.h>
 
 /* libc-specific include files
- * The program may be built in 2 ways:
+ * The program may be built in 3 ways:
  *   $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
- *   $(CC) -nostdlib -I/path/to/nolibc/sysroot
+ *   $(CC) -nostdlib -I/path/to/nolibc/sysroot  => _NOLIBC_* guards are present
+ *   $(CC) with default libc                    => NOLIBC* never defined
  */
 #ifndef NOLIBC
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#ifndef _NOLIBC_STDIO_H
+/* standard libcs need more includes */
+#include <linux/reboot.h>
+#include <sys/io.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/reboot.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/sysmacros.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <unistd.h>
+#endif
 #endif
 
 /* will be used by nolibc by getenv() */
@@ -23,6 +47,17 @@ struct test {
 	int (*func)(int min, int max); // handler
 };
 
+#ifndef _NOLIBC_STDLIB_H
+char *itoa(int i)
+{
+	static char buf[12];
+	int ret;
+
+	ret = snprintf(buf, sizeof(buf), "%d", i);
+	return (ret >= 0 && ret < sizeof(buf)) ? buf : "#err";
+}
+#endif
+
 #define CASE_ERR(err) \
 	case err: return #err
 
@@ -431,7 +466,9 @@ int run_syscall(int min, int max)
 		switch (test + __LINE__ + 1) {
 		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
 		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
+#ifdef NOLIBC
 		CASE_TEST(gettid);            EXPECT_SYSNE(1, gettid(), -1); break;
+#endif
 		CASE_TEST(getpgid_self);      EXPECT_SYSNE(1, getpgid(0), -1); break;
 		CASE_TEST(getpgid_bad);       EXPECT_SYSER(1, getpgid(-1), -1, ESRCH); break;
 		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
@@ -460,9 +497,11 @@ int run_syscall(int min, int max)
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
+#ifdef NOLIBC
 		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
+#endif
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
@@ -703,7 +742,11 @@ int main(int argc, char **argv, char **envp)
 		 * exit with status code 2N+1 when N is written to 0x501. We
 		 * hard-code the syscall here as it's arch-dependent.
 		 */
+#if defined(_NOLIBC_SYS_H)
 		else if (my_syscall3(__NR_ioperm, 0x501, 1, 1) == 0)
+#else
+		else if (ioperm(0x501, 1, 1) == 0)
+#endif
 			asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
 		/* if it does nothing, fall back to the regular panic */
 #endif
-- 
2.31.1.189.g2e36527f23

