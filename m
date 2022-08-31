Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CE5A857C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiHaS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiHaSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46299FB2AF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72AA161CDF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8752FC43144;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=oWTBcWxwRcNwj5pYtUzATgnqSwPazE+3AJlhHkeS8Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClzmHyot5hQJaJf4f3olS2jN43V3At6jLwx8uaE0cAlsdnmJFMcDLLbxsKcCK3c7Y
         DHsITUky26rzvmKnwsSpYfT3X5aHTqXj7cKyc67nfc3cMU9HtpBpV9YyZVL70uAn9X
         hXGAl+gIyhs5wlXZXVWnlnU1CHTM95ZcTxAjzMA0twVUlwBWkqCs5ovFlWAyNLexBU
         SHEZD+XNxiWbLQssXULi8RmB3hGwsAsdaxkLgWskYX4OFl6txcdHEeddASC0958AHL
         bdKIymWpSR335KQ1LBmQmhgpJd2oby38bafAs5FVOTg8hjcNk0PKIcj8H2wIq0FdAT
         e3/9mb7fUqaAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E5B8B5C0B07; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 11/18] selftests/nolibc: condition some tests on /proc existence
Date:   Wed, 31 Aug 2022 11:21:41 -0700
Message-Id: <20220831182148.2698489-13-paulmck@kernel.org>
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

If /proc is not available (program run inside a chroot or without
sufficient permissions), it's better to disable the associated tests.
Some will be preserved like the ones which check for a failure to
create some entries there since they're still supposed to fail.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a697182c87f57..662dea691749c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -413,11 +413,15 @@ int test_getdents64(const char *dir)
 int run_syscall(int min, int max)
 {
 	struct stat stat_buf;
+	int proc;
 	int test;
 	int tmp;
 	int ret = 0;
 	void *p1, *p2;
 
+	/* <proc> indicates whether or not /proc is mounted */
+	proc = stat("/proc", &stat_buf) == 0;
+
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; // line length
 
@@ -438,12 +442,12 @@ int run_syscall(int min, int max)
 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
-		CASE_TEST(chmod_net);         EXPECT_SYSZR(1, chmod("/proc/self/net", 0555)); break;
-		CASE_TEST(chmod_self);        EXPECT_SYSER(1, chmod("/proc/self", 0555), -1, EPERM); break;
-		CASE_TEST(chown_self);        EXPECT_SYSER(1, chown("/proc/self", 0, 0), -1, EPERM); break;
+		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
+		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
+		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(1, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-		CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot("/proc/self/exe"), -1, ENOTDIR); break;
+		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
 		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
 		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
@@ -464,7 +468,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
 		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
 		CASE_TEST(link_dir);          EXPECT_SYSER(1, link("/", "/blah"), -1, EPERM); break;
-		CASE_TEST(link_cross);        EXPECT_SYSER(1, link("/proc/self/net", "/blah"), -1, EXDEV); break;
+		CASE_TEST(link_cross);        EXPECT_SYSER(proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
-- 
2.31.1.189.g2e36527f23

