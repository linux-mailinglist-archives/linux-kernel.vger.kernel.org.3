Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27714734D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbhLMTS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242310AbhLMTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:18:52 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17576C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:52 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m15so15385795pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvO/0VEuuxkojdAmWD1zwzv62heBh3EH8sTvAtB1w9o=;
        b=byTIIFdvMhr3kIynk99d8lqZdSySoSP2rOFc417J50MHi95ieNc6zFmytfnfKE26Dj
         KyYL8daTI+lp1as+GLam+aIEQHZcjzNCxO17I/RL6AgTRyd//7IzrWlV+FjrZfz25E70
         vITwNMM0x+Vh+vSp90IgY5S8jpE0B8sjQv/ysqNEpDCjoryqmDSq/itONHoW4gwW2B1n
         fFNN+aEYJYCYZ5rl1En5JUsDVa4G3nwk51nKquK/hcw+UyKbblviL5h2XUMV7oSLU6CF
         g9gX5RQ2v+OgBpHusEcfQcuKPFePLz/vTBI0GlOqT/+uqSpD0dmnEXbAFXt+4cFJ1ntI
         d/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kvO/0VEuuxkojdAmWD1zwzv62heBh3EH8sTvAtB1w9o=;
        b=jpUoDxdUA8MD680rbHMTx9Sgma64VwK/OEGPw/8qoqjLhRqWiSCE6qna0mS61pLTaY
         V4eQpYKjoUh7i2f7lKSsAKJePS3gGxogBiaIRW6+kpfl03iTB9dDMhxeJnuah9JdLps6
         ZKxXtTTAK1jlYmz+hGK+sIk/oiwZc2q18m3NFk6uVfIfFKitMsd+SQkm1mVxhwGzPu2q
         EIjmrSkF16ng8O/dkx+O3Cj7s4qoKEdE393yv12UROCOSOpZOX90yf+FzFZoT1qbbEOo
         yEOZM0u4QgSCcNC6/77lbOv4uQSkzCt+GPHCNIIX895rY1R5A5MZY7r9lHiMKqKQ4TZt
         SfdA==
X-Gm-Message-State: AOAM532wrkKM03h0lVwQxkG64aVU2+ssbK312PYkqUJbqcMQf83LLgm2
        vJQz9OMok9C8PDHUGBCalsE=
X-Google-Smtp-Source: ABdhPJxzl8iBtAKzo4b3W7aNAW6sB2Kps0scHYPhZBeZ0ak29Jw3wkqDaV+9WX2VNqOxwZrTv5PfpA==
X-Received: by 2002:a63:6cc2:: with SMTP id h185mr433211pgc.306.1639423131470;
        Mon, 13 Dec 2021 11:18:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d4sm12908920pfj.78.2021.12.13.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] selftests: cgroup: Test open-time cgroup namespace usage for migration checks
Date:   Mon, 13 Dec 2021 09:18:33 -1000
Message-Id: <20211213191833.916632-7-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213191833.916632-1-tj@kernel.org>
References: <20211213191833.916632-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is writing to an fd opened by a different task, the perm check
should use the cgroup namespace of the latter task. Add a test for it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/cgroup/test_core.c | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 01b766506973..600123503063 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -1,11 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#define _GNU_SOURCE
 #include <linux/limits.h>
+#include <linux/sched.h>
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <unistd.h>
 #include <fcntl.h>
+#include <sched.h>
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
@@ -741,6 +744,99 @@ static int test_cgcore_lesser_euid_open(const char *root)
 	return ret;
 }
 
+struct lesser_ns_open_thread_arg {
+	const char	*path;
+	int		fd;
+	int		err;
+};
+
+static int lesser_ns_open_thread_fn(void *arg)
+{
+	struct lesser_ns_open_thread_arg *targ = arg;
+
+	targ->fd = open(targ->path, O_RDWR);
+	targ->err = errno;
+	return 0;
+}
+
+/*
+ * cgroup migration permission check should be performed based on the cgroup
+ * namespace at the time of open instead of write.
+ */
+static int test_cgcore_lesser_ns_open(const char *root)
+{
+	static char stack[65536];
+	const uid_t test_euid = 65534;	/* usually nobody, any !root is fine */
+	int ret = KSFT_FAIL;
+	char *cg_test_a = NULL, *cg_test_b = NULL;
+	char *cg_test_a_procs = NULL, *cg_test_b_procs = NULL;
+	int cg_test_b_procs_fd = -1;
+	struct lesser_ns_open_thread_arg targ = { .fd = -1 };
+	pid_t pid;
+	int status;
+
+	cg_test_a = cg_name(root, "cg_test_a");
+	cg_test_b = cg_name(root, "cg_test_b");
+
+	if (!cg_test_a || !cg_test_b)
+		goto cleanup;
+
+	cg_test_a_procs = cg_name(cg_test_a, "cgroup.procs");
+	cg_test_b_procs = cg_name(cg_test_b, "cgroup.procs");
+
+	if (!cg_test_a_procs || !cg_test_b_procs)
+		goto cleanup;
+
+	if (cg_create(cg_test_a) || cg_create(cg_test_b))
+		goto cleanup;
+
+	if (cg_enter_current(cg_test_b))
+		goto cleanup;
+
+	if (chown(cg_test_a_procs, test_euid, -1) ||
+	    chown(cg_test_b_procs, test_euid, -1))
+		goto cleanup;
+
+	targ.path = cg_test_b_procs;
+	pid = clone(lesser_ns_open_thread_fn, stack + sizeof(stack),
+		    CLONE_NEWCGROUP | CLONE_FILES | CLONE_VM | SIGCHLD,
+		    &targ);
+	if (pid < 0)
+		goto cleanup;
+
+	if (waitpid(pid, &status, 0) < 0)
+		goto cleanup;
+
+	if (!WIFEXITED(status))
+		goto cleanup;
+
+	cg_test_b_procs_fd = targ.fd;
+	if (cg_test_b_procs_fd < 0)
+		goto cleanup;
+
+	if (cg_enter_current(cg_test_a))
+		goto cleanup;
+
+	if ((status = write(cg_test_b_procs_fd, "0", 1)) >= 0 || errno != ENOENT)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	if (cg_test_b_procs_fd >= 0)
+		close(cg_test_b_procs_fd);
+	if (cg_test_b)
+		cg_destroy(cg_test_b);
+	if (cg_test_a)
+		cg_destroy(cg_test_a);
+	free(cg_test_b_procs);
+	free(cg_test_a_procs);
+	free(cg_test_b);
+	free(cg_test_a);
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct corecg_test {
 	int (*fn)(const char *root);
@@ -757,6 +853,7 @@ struct corecg_test {
 	T(test_cgcore_thread_migration),
 	T(test_cgcore_destroy),
 	T(test_cgcore_lesser_euid_open),
+	T(test_cgcore_lesser_ns_open),
 };
 #undef T
 
-- 
2.34.1

