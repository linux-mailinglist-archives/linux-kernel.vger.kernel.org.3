Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CBE5140A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiD2Cfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiD2Cfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:35:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A46BE9D7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:32:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so5934607pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pD7wEVjDWCs0OWLvmcopLdOCLaRUm5C47DNo4B3Tw7U=;
        b=xj8lZ+yr9k3J3mFn8VQz4YUpZJzODslf4C3U180V6cjAWmNfZaXaNGaTYLltHnvbTa
         UXBkEmkneUfjnGAZ0U/xhCYJgHMU8MsfGGxmEEHQXXjyqNN+3L96zR2bBycECwSA5Kju
         qI4nGwDNCET/RYssmMZol8OAVBESEBjpZrUsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pD7wEVjDWCs0OWLvmcopLdOCLaRUm5C47DNo4B3Tw7U=;
        b=GjVbpYN5zJrYUYJLTVP3dNgxwkgi3q4UYDa3dmZ3WlrI9KNOID7qz6Zvd2D6+90s46
         T+4/EJXbUHl7IcXp8v9tTBi55bqw/zuSF+QwgYjn6OSoGLjDBSWb7lOQl98dz5Xg69Y9
         nnHfysDl8Y49heeDfdaJvme0o4izTFomOkWqWHb+DLv1bza6pUHyvbNuX2sOnPxouvuz
         GRCrlcLzTIDUGo2RkhCIgIS67G4LNBE3/IicqUlpHxXHapCwQgGgLAzfWM5WniJO0Bbs
         RN2Xx8eyJ7LppEzACC13KcWl+aV5YDRYUKVD1BRrthi3zF4nzsuo3+LnYwSXC6znTCNY
         xj0Q==
X-Gm-Message-State: AOAM531yY3GqPf0ONwopDIzssdgX2WG7Mh7cRJRVA+4clgSObBTUMB1z
        fkrIiBg/JpMel8VHoWBlAT9ffQ==
X-Google-Smtp-Source: ABdhPJzNRCcH4nTJk7D57es2Ky8PAPBoVWour/2NQe5p7BOqVE+Y/3nfIGdt3+YQG55ZFG4v8nGGEw==
X-Received: by 2002:a17:902:c2c3:b0:15c:fd3c:7a9b with SMTP id c3-20020a170902c2c300b0015cfd3c7a9bmr26316227pla.31.1651199546488;
        Thu, 28 Apr 2022 19:32:26 -0700 (PDT)
Received: from localhost.localdomain (99-0-82-137.lightspeed.sntcca.sbcglobal.net. [99.0.82.137])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090a640500b001cd4989ff53sm8201125pjj.26.2022.04.28.19.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 19:32:25 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Subject: [PATCH v3 2/2] selftests/seccomp: Add test for wait killable notifier
Date:   Thu, 28 Apr 2022 19:31:13 -0700
Message-Id: <20220429023113.74993-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429023113.74993-1-sargun@sargun.me>
References: <20220429023113.74993-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

The pre-receive signal handling is tested elsewhere, and that codepath
remains unchanged.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 240 ++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9d126d7fabdb..825b179b6751 100644
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
@@ -4231,6 +4237,240 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+static char get_proc_stat(int pid)
+{
+	char proc_path[100] = { 0 };
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	char status;
+	FILE *f;
+	int i;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
+	f = fopen(proc_path, "r");
+	if (f == NULL)
+		ksft_exit_fail_msg("%s - Could not open %s\n", strerror(errno),
+				   proc_path);
+
+	for (i = 0; i < 3; i++) {
+		nread = getdelim(&line, &len, ' ', f);
+		if (nread <= 0)
+			ksft_exit_fail_msg("Failed to read status: %s\n",
+					   strerror(errno));
+	}
+
+	status = *line;
+	free(line);
+	fclose(f);
+
+	return status;
+}
+
+/* Returns -1 if not in syscall (running or blocked) */
+static long get_proc_syscall(int pid)
+{
+	char proc_path[100] = { 0 };
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	long ret = -1;
+	FILE *f;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/syscall", pid);
+	f = fopen(proc_path, "r");
+	if (f == NULL)
+		ksft_exit_fail_msg("%s - Could not open %s\n", strerror(errno),
+				   proc_path);
+
+	nread = getdelim(&line, &len, ' ', f);
+	if (nread <= 0)
+		ksft_exit_fail_msg("Failed to read status: %s\n",
+				   strerror(errno));
+
+	if (!strncmp("running", line, MIN(7, nread)))
+		ret = strtol(line, NULL, 16);
+
+	free(line);
+	fclose(f);
+
+	return ret;
+}
+
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
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
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
+		/* Setup the sigaction without SA_RESTART */
+		if (sigaction(SIGUSR1, &new_action, NULL)) {
+			perror("sigaction");
+			exit(1);
+		}
+
+		ret = syscall(__NR_getppid);
+		exit(ret != -1 || errno != EINTR);
+	}
+
+	while (get_proc_syscall(pid) != __NR_getppid &&
+	       get_proc_stat(pid) != 'S')
+		nanosleep(&delay, NULL);
+
+	EXPECT_EQ(kill(pid, SIGUSR1), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
+}
+
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
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
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
+	while (get_proc_syscall(pid) != __NR_getppid &&
+	       get_proc_stat(pid) != 'S')
+		nanosleep(&delay, NULL);
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	/* Kill the process to make sure it enters the wait_killable state */
+	EXPECT_EQ(kill(pid, SIGUSR1), 0);
+
+	/* TASK_KILLABLE is considered D (Disk Sleep) state */
+	while (get_proc_stat(pid) != 'D')
+		nanosleep(&delay, NULL);
+
+	resp.id = req.id;
+	resp.val = USER_NOTIF_MAGIC;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	/*
+	 * Make sure that the signal handler does get called once we're back in
+	 * userspace.
+	 */
+	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
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
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
+				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* This should never complete */
+		syscall(__NR_getppid);
+		exit(1);
+	}
+
+	while (get_proc_stat(pid) != 'S')
+		nanosleep(&delay, NULL);
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	/* Kill the process with a fatal signal */
+	EXPECT_EQ(kill(pid, SIGTERM), 0);
+
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

