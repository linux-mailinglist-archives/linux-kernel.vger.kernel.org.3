Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A146F62B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhLIVvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhLIVu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:50:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4537C061353
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:47:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 133so6258393pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvO/0VEuuxkojdAmWD1zwzv62heBh3EH8sTvAtB1w9o=;
        b=FMe5AsY6f0N5gzHt3naF5X7eux1PZzynN37L6XG0iimObfC+rq0n7Qcjn+ilqFrXwR
         FHIRTCURTxqADWNEQOW+XFu6RY7SiN37nkrORSyMJTpdxnBVfNLFf+2cSM1cbI9JbclO
         nXZlHJxNrLnbqOLmDx1MqPozGqNMFlOhMya6fP3Kf8Gm3sPnXADY59dHoE9THqtZQEA4
         wplIK5CQNP6rm7O9MjsU0Er9/Y9Cp2jtmTbNH7mmCfZebzTxi0/ZAcLkHzZaKLAgnLBP
         Pm93GE9a6eeYInKlI1fV28grM5jdWzEtoNpzdZSC3ygdF2xQlr72Kh+GfvwNyu0x3AuV
         qG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kvO/0VEuuxkojdAmWD1zwzv62heBh3EH8sTvAtB1w9o=;
        b=EYPR7ggsxfLLO6MSxf1G7CCqszRgpp+yd7A56Zf57nj483l8BJGyvskz0/fwGaATCD
         NNn4vjxeiH2ntnlm0ME0Ua907INocE/HeCKLNDyM9GbwtoAoYiL6ZjN6VSh7t0zJD7Hi
         4Ey/OBSSiDGx34Vut2sj2wieQtAnf0R4hVJlAFUl76TX9zl9YoqGC/MT2TYJ+oYgoDVt
         kO7fdk0ClYf1HvJb6NOoh4hgyxN3tgFcdDt9Zp24bW8ySnBOPkZqU0GEOcw2MNteLn8f
         8EZiXyl9cLMBb4UUhK0Gg/z4Y1FZrhSDV2fXWlUQyYbvfmTg+y5Ynu0Tko1XekuWaiHp
         8PWA==
X-Gm-Message-State: AOAM532Yc+QyQELfEao9ocG2jdcSS8cAWBD4woK6Qa8tFK4SRPnKeHtm
        z+ERysi4fn6mbtXXvi9hcK1R6+YFcvQ=
X-Google-Smtp-Source: ABdhPJxqkblU3prnsDB2sCozThL0nVq0TI35lhWoUxyjk0mc3Ffofjfi1zcIVimWBVNWIMg9qtF6bg==
X-Received: by 2002:a65:6458:: with SMTP id s24mr36452913pgv.271.1639086444278;
        Thu, 09 Dec 2021 13:47:24 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o7sm562282pjf.33.2021.12.09.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:47:23 -0800 (PST)
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
Date:   Thu,  9 Dec 2021 11:47:07 -1000
Message-Id: <20211209214707.805617-7-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209214707.805617-1-tj@kernel.org>
References: <20211209214707.805617-1-tj@kernel.org>
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

