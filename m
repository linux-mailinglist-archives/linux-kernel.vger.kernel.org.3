Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254E85A8581
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiHaS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiHaSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40880FCA0C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E6DB82273
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D009C43146;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=P67HLCtareZHyS5w7ZkkvyTWtCvesN1SPEN962WT4qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awkdzw93uTP/OIjMot/kYfc48LiKIEhls/Ld7GN4LJ9tRh2U0SeRLzl2HDHtsQkTE
         tTFFLdrJfWBwBD23nElUNWksTJvBS/UqGOAy3+qRUQU0ewoKM2K6SjEIRtxD/VynQi
         DK9zsjRC4+EFh5Vfy1yZtH+oRKRmM4PbNJwJ1T1MW41J4YL4TQskN56d9jAvexVuOL
         CHDDR/HHFUQ2gPO4BE5eHtME7AjldYBPUGisD85aW4irhZJ7QxpJVFOAudy8ctIjDR
         TmMWe/5rst58UDGEKUQfrsIMejYbUBvSlN6ibaXwSUIgzmcMgS9f1Y3wHx0eM4dmV6
         OqWVBK6Qq7Exg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD03F5C0981; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 06/18] selftests/nolibc: implement a few tests for various syscalls
Date:   Wed, 31 Aug 2022 11:21:36 -0700
Message-Id: <20220831182148.2698489-8-paulmck@kernel.org>
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

This adds 63 tests covering about 34 syscalls. Both successes and
failures are tested. Two tests fail when run as unprivileged user
(link_dir which returns EACCESS instead of EPERM, and chroot which
returns EPERM). One test (execve("/")) expects to fail on EACCESS,
but needs to have valid arguments otherwise the kernel will log a
message. And a few tests require /proc to be mounted.

The code is not pretty since all tests are one-liners, sometimes
resulting in long lines, especially when using compount statements to
preset a line, but it's convenient and doesn't obfuscate the code,
which is important to understand what failed.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 110 +++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 49177ea9943cc..dc87832912ce4 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -388,9 +388,119 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	case __LINE__: llen += printf("%d %s", test, #name);
 
 
+/* used by some syscall tests below */
+int test_getdents64(const char *dir)
+{
+	char buffer[4096];
+	int fd, ret;
+	int err;
+
+	ret = fd = open(dir, O_RDONLY | O_DIRECTORY, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = getdents64(fd, (void *)buffer, sizeof(buffer));
+	err = errno;
+	close(fd);
+
+	errno = err;
+	return ret;
+}
+
+/* Run syscall tests between IDs <min> and <max>.
+ * Return 0 on success, non-zero on failure.
+ */
+int run_syscall(int min, int max)
+{
+	struct stat stat_buf;
+	int test;
+	int tmp;
+	int ret = 0;
+	void *p1, *p2;
+
+	for (test = min; test >= 0 && test <= max; test++) {
+		int llen = 0; // line length
+
+		/* avoid leaving empty lines below, this will insert holes into
+		 * test numbers.
+		 */
+		switch (test + __LINE__ + 1) {
+		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
+		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
+		CASE_TEST(gettid);            EXPECT_SYSNE(1, gettid(), -1); break;
+		CASE_TEST(getpgid_self);      EXPECT_SYSNE(1, getpgid(0), -1); break;
+		CASE_TEST(getpgid_bad);       EXPECT_SYSER(1, getpgid(-1), -1, ESRCH); break;
+		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
+		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
+		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESRCH); break;
+		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
+		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
+		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
+		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
+		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
+		CASE_TEST(chmod_net);         EXPECT_SYSZR(1, chmod("/proc/self/net", 0555)); break;
+		CASE_TEST(chmod_self);        EXPECT_SYSER(1, chmod("/proc/self", 0555), -1, EPERM); break;
+		CASE_TEST(chown_self);        EXPECT_SYSER(1, chown("/proc/self", 0, 0), -1, EPERM); break;
+		CASE_TEST(chroot_root);       EXPECT_SYSZR(1, chroot("/")); break;
+		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
+		CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot("/proc/self/exe"), -1, ENOTDIR); break;
+		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
+		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
+		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
+		CASE_TEST(dup_m1);            tmp = dup(-1); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
+		CASE_TEST(dup2_0);            tmp = dup2(0, 100);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
+		CASE_TEST(dup2_m1);           tmp = dup2(-1, 100); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
+		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
+		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
+		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
+		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
+		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
+		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
+		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
+		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
+		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
+		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
+		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
+		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
+		CASE_TEST(link_dir);          EXPECT_SYSER(1, link("/", "/blah"), -1, EPERM); break;
+		CASE_TEST(link_cross);        EXPECT_SYSER(1, link("/proc/self/net", "/blah"), -1, EXDEV); break;
+		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
+		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
+		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
+		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
+		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
+		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
+		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
+		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
+		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
+		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
+		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
+		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
+		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
+		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
+		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
+		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
+		CASE_TEST(wait_child);        EXPECT_SYSER(1, wait(&tmp), -1, ECHILD); break;
+		CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, ESRCH); break;
+		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
+		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
+		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		case __LINE__:
+			return ret; /* must be last */
+		/* note: do not set any defaults so as to permit holes above */
+		}
+	}
+	return ret;
+}
+
+
 /* This is the definition of known test names, with their functions */
 static struct test test_names[] = {
 	/* add new tests here */
+	{ .name = "syscall",   .func = run_syscall  },
 	{ 0 }
 };
 
-- 
2.31.1.189.g2e36527f23

