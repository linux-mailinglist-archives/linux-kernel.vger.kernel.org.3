Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9715A8582
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiHaS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiHaSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9C6359
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F0AAB8227A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841E9C43149;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=lwk5wcOOPAaS02+SYW0iG5ev2+vHqTxry4RcwHjG3WQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG+BIk0oG+YYu4lyAQxuAJiTMvF8FjfkNg76PXl3buiLU+G7o06r9XL7K5OF/+3Pm
         SMw6tpWHY4byJC03yVcl2S2u1Ai94LTgZDJk9a0VfJ1m6tcBN7bTBr0i0miCmj9paV
         my1p79uNcbT5IGNEpnx+U4uDjxD7KtHpTz9dQ5TEhDB0Xs0TpIXuF9FfWNya4g2t0R
         rgCPh01+ZNFINUXsY+1oiYqJnORcY0iLhgEHpd0xeRGO1M37wNI1080SOJzgpZNMyz
         wRqRPgnCby+ldXYPAJcz8nm/y61PRkr17EyTSbaD3M3WV+d6uc71ZiMI+mqbsVLtSt
         1EAvF0YN0xxhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E3FCD5C0B00; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 10/18] selftests/nolibc: recreate and populate /dev and /proc if missing
Date:   Wed, 31 Aug 2022 11:21:40 -0700
Message-Id: <20220831182148.2698489-12-paulmck@kernel.org>
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

Most of the time the program will be run alone in an initramfs. There
is no value in requiring the user to populate /dev and /proc for such
tests, we can do it ourselves, and it participates to the tests at the
same time.

What's done here is that when called as init (getpid()==1) we check
if /dev exists or create it, if /dev/console and /dev/null exists,
otherwise we try to mount a devtmpfs there, and if it fails we fall
back to mknod. The console is reopened if stdout was closed. Finally
/proc is created and mounted if /proc/self cannot be found. This is
sufficient for most tests.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index eeb254749239c..a697182c87f57 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -530,6 +530,54 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+/* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
+int prepare(void)
+{
+	struct stat stat_buf;
+
+	/* It's possible that /dev doesn't even exist or was not mounted, so
+	 * we'll try to create it, mount it, or create minimal entries into it.
+	 * We want at least /dev/null and /dev/console.
+	 */
+	if (stat("/dev/.", &stat_buf) == 0 || mkdir("/dev", 0755) == 0) {
+		if (stat("/dev/console", &stat_buf) != 0 ||
+		    stat("/dev/null", &stat_buf) != 0) {
+			/* try devtmpfs first, otherwise fall back to manual creation */
+			if (mount("/dev", "/dev", "devtmpfs", 0, 0) != 0) {
+				mknod("/dev/console", 0600 | S_IFCHR, makedev(5, 1));
+				mknod("/dev/null",    0666 | S_IFCHR, makedev(1, 3));
+			}
+		}
+	}
+
+	/* If no /dev/console was found before calling init, stdio is closed so
+	 * we need to reopen it from /dev/console. If it failed above, it will
+	 * still fail here and we cannot emit a message anyway.
+	 */
+	if (close(dup(1)) == -1) {
+		int fd = open("/dev/console", O_RDWR);
+
+		if (fd >= 0) {
+			if (fd != 0)
+				dup2(fd, 0);
+			if (fd != 1)
+				dup2(fd, 1);
+			if (fd != 2)
+				dup2(fd, 2);
+			if (fd > 2)
+				close(fd);
+			puts("\nSuccessfully reopened /dev/console.");
+		}
+	}
+
+	/* try to mount /proc if not mounted. Silently fail otherwise */
+	if (stat("/proc/.", &stat_buf) == 0 || mkdir("/proc", 0755) == 0) {
+		if (stat("/proc/self", &stat_buf) != 0)
+			mount("/proc", "/proc", "proc", 0, 0);
+	}
+
+	return 0;
+}
 
 /* This is the definition of known test names, with their functions */
 static struct test test_names[] = {
@@ -550,6 +598,14 @@ int main(int argc, char **argv, char **envp)
 
 	environ = envp;
 
+	/* when called as init, it's possible that no console was opened, for
+	 * example if no /dev file system was provided. We'll check that fd#1
+	 * was opened, and if not we'll attempt to create and open /dev/console
+	 * and /dev/null that we'll use for later tests.
+	 */
+	if (getpid() == 1)
+		prepare();
+
 	/* the definition of a series of tests comes from either argv[1] or the
 	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
 	 * series of test names and optional ranges:
-- 
2.31.1.189.g2e36527f23

