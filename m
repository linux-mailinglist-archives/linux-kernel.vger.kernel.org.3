Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7B517F86
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiECIO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiECIOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:14:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D1167F2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 01:11:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so14699654pjt.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 01:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfFREWnAIM+KTJeyLZzl+cb5YVjXhixI113UYmPJpgU=;
        b=FE6dQqFeF2gZTY/fxJTPWB3JdPTQhHX+9r8wlI0aSYk1X28Lk4ag3mMWRwbcnLEiWN
         eB0SrZqDCP3BCsGQt44MKK+8nZO1F1m6JJdh2+FbMYZ2sF29Gw99iSzDCRYwlu9Yujqi
         am+KW546ZhUumHB97jtnLW/ZHYMw0feUmFArg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfFREWnAIM+KTJeyLZzl+cb5YVjXhixI113UYmPJpgU=;
        b=qHzfKvMhUwv+60cWIpAlpg4gQ6UVmo7UonAOiu9ahyJEmuo3Diuf2S/rcjeDKeVyPi
         5Ue5MpdTWVnhlnn8uot8UBncUXY7IAUdNQR4Bvgda4J0aGqKRuX8FDERaDyNTC2ZY6SJ
         6jmZL3GKhrVaFILwWeZnwaFg8x5WpJEsOaljUZHHW7INYUUhtX/siPn4GAoZwgZFXfbl
         zcI5hi1ZEc8jawyFUh6zTOvV9gHt9rjnWwx2y+5D5tH601MH+nSvSPY1Vq14NJDMmPYK
         xjv9IRrIz9rt11OgN6u7FsAenqzSskypSE/jgwKdABHwGRezOMplFq3suzsHhTt41Vw7
         igSg==
X-Gm-Message-State: AOAM533ao+wK576TXj+IewjnCvUYb1By1+qV8tvNlI+bSQIw5U7Awa5P
        XLMi1IX+XcxQtWzdkeUarEnBqQ==
X-Google-Smtp-Source: ABdhPJwUAUSc2oe4DDeYjw+beDozzp9WC2zMm02uf1xyn/WtkL4Wnigmo1IqSAiyaqB+NGf5Cgvidw==
X-Received: by 2002:a17:902:8f94:b0:14f:d9b3:52c2 with SMTP id z20-20020a1709028f9400b0014fd9b352c2mr15224110plo.103.1651565475377;
        Tue, 03 May 2022 01:11:15 -0700 (PDT)
Received: from localhost.localdomain (99-0-82-137.lightspeed.sntcca.sbcglobal.net. [99.0.82.137])
        by smtp.gmail.com with ESMTPSA id h2-20020aa786c2000000b0050dc762815dsm5821069pfo.55.2022.05.03.01.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 01:11:14 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tycho Andersen <tycho@tycho.pizza>,
        Alban Crequy <alban@kinvolk.io>
Subject: [PATCH v4 3/3] selftests/seccomp: Add test for wait killable notifier
Date:   Tue,  3 May 2022 01:09:58 -0700
Message-Id: <20220503080958.20220-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503080958.20220-1-sargun@sargun.me>
References: <20220503080958.20220-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This verifies that if a filter is set up with the wait killable feature
that it obeys the semantics that non-fatal signals are ignored during
a notification after the notification is received.

Cases tested:
 * Non-fatal signal prior to receive
 * Non-fatal signal during receive
 * Fatal signal after receive

The normal signal handling is tested in user_notification_signal. That
behaviour remains unchanged.

On an unsupported kernel, these tests will immediately bail as it relies
on a new seccomp flag.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 228 ++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 4fb5eda89223..931dd1b6d385 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -59,6 +59,8 @@
 #define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
 #endif
 
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+
 #ifndef PR_SET_PTRACER
 # define PR_SET_PTRACER 0x59616d61
 #endif
@@ -268,6 +270,10 @@ struct seccomp_notif_addfd_big {
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH (1UL << 4)
 #endif
 
+#ifndef SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV
+#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -4362,6 +4368,228 @@ TEST(user_notification_fifo)
 	}
 }
 
+/* get_proc_syscall - Get the syscall in progress for a given pid
+ *
+ * Returns the current syscall number for a given process
+ * Returns -1 if not in syscall (running or blocked)
+ */
+static long get_proc_syscall(struct __test_metadata *_metadata, int pid)
+{
+	char proc_path[100] = {0};
+	long ret = -1;
+	ssize_t nread;
+	char *line;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/syscall", pid);
+	nread = get_nth(_metadata, proc_path, 1, &line);
+	ASSERT_GT(nread, 0);
+
+	if (!strncmp("running", line, MIN(7, nread)))
+		ret = strtol(line, NULL, 16);
+
+	free(line);
+	return ret;
+}
+
+/* Ensure non-fatal signals prior to receive are unmodified */
+TEST(user_notification_wait_killable_pre_notification)
+{
+	struct sigaction new_action = {
+		.sa_handler = signal_handler,
+	};
+	int listener, status, sk_pair[2];
+	pid_t pid;
+	long ret;
+	char c;
+	/* 100 ms */
+	struct timespec delay = { .tv_nsec = 100000000 };
+
+	ASSERT_EQ(sigemptyset(&new_action.sa_mask), 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+	listener = user_notif_syscall(
+		__NR_getppid, SECCOMP_FILTER_FLAG_NEW_LISTENER |
+				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
+	ASSERT_GE(listener, 0);
+
+	/*
+	 * Check that we can kill the process with SIGUSR1 prior to receiving
+	 * the notification. SIGUSR1 is wired up to a custom signal handler,
+	 * and make sure it gets called.
+	 */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(sk_pair[0]);
+		handled = sk_pair[1];
+
+		/* Setup the non-fatal sigaction without SA_RESTART */
+		if (sigaction(SIGUSR1, &new_action, NULL)) {
+			perror("sigaction");
+			exit(1);
+		}
+
+		ret = syscall(__NR_getppid);
+		/* Make sure we got a return from a signal interruption */
+		exit(ret != -1 || errno != EINTR);
+	}
+
+	/*
+	 * Make sure we've gotten to the seccomp user notification wait
+	 * from getppid prior to sending any signals
+	 */
+	while (get_proc_syscall(_metadata, pid) != __NR_getppid &&
+	       get_proc_stat(_metadata, pid) != 'S')
+		nanosleep(&delay, NULL);
+
+	/* Send non-fatal kill signal */
+	EXPECT_EQ(kill(pid, SIGUSR1), 0);
+
+	/* wait for process to exit (exit checks for EINTR) */
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
+}
+
+/* Ensure non-fatal signals after receive are blocked */
+TEST(user_notification_wait_killable)
+{
+	struct sigaction new_action = {
+		.sa_handler = signal_handler,
+	};
+	struct seccomp_notif_resp resp = {};
+	struct seccomp_notif req = {};
+	int listener, status, sk_pair[2];
+	pid_t pid;
+	long ret;
+	char c;
+	/* 100 ms */
+	struct timespec delay = { .tv_nsec = 100000000 };
+
+	ASSERT_EQ(sigemptyset(&new_action.sa_mask), 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+	listener = user_notif_syscall(
+		__NR_getppid, SECCOMP_FILTER_FLAG_NEW_LISTENER |
+				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(sk_pair[0]);
+		handled = sk_pair[1];
+
+		/* Setup the sigaction without SA_RESTART */
+		if (sigaction(SIGUSR1, &new_action, NULL)) {
+			perror("sigaction");
+			exit(1);
+		}
+
+		/* Make sure that the syscall is completed (no EINTR) */
+		ret = syscall(__NR_getppid);
+		exit(ret != USER_NOTIF_MAGIC);
+	}
+
+	/*
+	 * Get the notification, to make move the notifying process into a
+	 * non-preemptible (TASK_KILLABLE) state.
+	 */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	/* Send non-fatal kill signal */
+	EXPECT_EQ(kill(pid, SIGUSR1), 0);
+
+	/*
+	 * Make sure the task enters moves to TASK_KILLABLE by waiting for
+	 * D (Disk Sleep) state after receiving non-fatal signal.
+	 */
+	while (get_proc_stat(_metadata, pid) != 'D')
+		nanosleep(&delay, NULL);
+
+	resp.id = req.id;
+	resp.val = USER_NOTIF_MAGIC;
+	/* Make sure the notification is found and able to be replied to */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	/*
+	 * Make sure that the signal handler does get called once we're back in
+	 * userspace.
+	 */
+	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
+	/* wait for process to exit (exit checks for USER_NOTIF_MAGIC) */
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+/* Ensure fatal signals after receive are not blocked */
+TEST(user_notification_wait_killable_fatal)
+{
+	struct seccomp_notif req = {};
+	int listener, status;
+	pid_t pid;
+	long ret;
+	/* 100 ms */
+	struct timespec delay = { .tv_nsec = 100000000 };
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(
+		__NR_getppid, SECCOMP_FILTER_FLAG_NEW_LISTENER |
+				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* This should never complete as it should get a SIGTERM */
+		syscall(__NR_getppid);
+		exit(1);
+	}
+
+	while (get_proc_stat(_metadata, pid) != 'S')
+		nanosleep(&delay, NULL);
+
+	/*
+	 * Get the notification, to make move the notifying process into a
+	 * non-preemptible (TASK_KILLABLE) state.
+	 */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	/* Kill the process with a fatal signal */
+	EXPECT_EQ(kill(pid, SIGTERM), 0);
+
+	/*
+	 * Wait for the process to exit, and make sure the process terminated
+	 * due to the SIGTERM signal.
+	 */
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFSIGNALED(status));
+	EXPECT_EQ(SIGTERM, WTERMSIG(status));
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.25.1

