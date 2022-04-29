Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2151537B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379756AbiD2SXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiD2SW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:22:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A0BD0A92
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:19:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h1so7564060pfv.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mr1QyK7toZWov5+9hb7qMctNRb32fdrD7SSKTJ65XRk=;
        b=kwxU7D9H31AHki6zDzMtSjs5pQMubEA7+HJltWacgCSPE1SFrx5iN4gXJC6uIyLV/m
         ChUCLsHM5rUGnlDDaTBInYXZf5QIPN5hPo5xCMA5dsBxIP30ImKzgtNvr9RVZPG5KiZh
         SNg5eRZrxGLqnU7SlKwN80qWqo3pdrN6HDvWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mr1QyK7toZWov5+9hb7qMctNRb32fdrD7SSKTJ65XRk=;
        b=mFywBJ8+4iWLQ9Yf9TLuEtY/RDRvw3Cw7z9qjve8qnjVl5eUPSRuK3S6Sd5qQoKD8b
         QkPTqYV/bsOYEBckVYBAig6cOyERbJ7Uf9xfbzRnDiE6l2liE2DBjMu93CV1HWbcARfy
         ZZ09vS/3YfaXjaQdn+7fsx2U/ilgeVCPldH+mSFOATrr4oLZfQRT+ti7V78B8zRruiGy
         A/zTDFuYkQk3XIzH5RNqhiGq2BQIMb8kJHLKFSv8BuDJmcsnuyokbOnQ7NJkI9i8xFlb
         5pI03GjF93IaKsZk1sVoZYl7L2p+zNJk/5PaJ2LkvZoFheDR3UIWBTKH/bpFcdObRBQF
         IDow==
X-Gm-Message-State: AOAM531htu18cywtkSKiEB4SVT52MSh5uVLqvkGzCg6Zq88BCHDE9Nxz
        fJtsfI2Eofti8hPjmn/l+2SK7w==
X-Google-Smtp-Source: ABdhPJywAS6ymeklCfMGXYSQMeLKBbl8Vvp7jjkxvYUU2oh5C4FCKVGyPhad1CHedDb1x0/2btFKqQ==
X-Received: by 2002:a63:580b:0:b0:3c1:a780:59f7 with SMTP id m11-20020a63580b000000b003c1a78059f7mr518871pgb.76.1651256374897;
        Fri, 29 Apr 2022 11:19:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm3920781pfl.135.2022.04.29.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 11:19:34 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:19:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH v3 2/2] selftests/seccomp: Add test for wait killable
 notifier
Message-ID: <202204291053.E04A367@keescook>
References: <20220429023113.74993-1-sargun@sargun.me>
 <20220429023113.74993-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429023113.74993-3-sargun@sargun.me>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 07:31:13PM -0700, Sargun Dhillon wrote:
> This verifies that if a filter is set up with the wait killable feature
> that it obeys the semantics that non-fatal signals are ignored during
> a notification after the notification is received.
> 
> Cases tested:
>  * Non-fatal signal prior to receive
>  * Non-fatal signal during receive
>  * Fatal signal after receive
> 
> The pre-receive signal handling is tested elsewhere, and that codepath
> remains unchanged.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 240 ++++++++++++++++++
>  1 file changed, 240 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 9d126d7fabdb..825b179b6751 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -59,6 +59,8 @@
>  #define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
>  #endif
>  
> +#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
> +
>  #ifndef PR_SET_PTRACER
>  # define PR_SET_PTRACER 0x59616d61
>  #endif
> @@ -268,6 +270,10 @@ struct seccomp_notif_addfd_big {
>  #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH (1UL << 4)
>  #endif
>  
> +#ifndef SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV
> +#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
> +#endif
> +
>  #ifndef seccomp
>  int seccomp(unsigned int op, unsigned int flags, void *args)
>  {
> @@ -4231,6 +4237,240 @@ TEST(user_notification_addfd_rlimit)
>  	close(memfd);
>  }
>  
> +static char get_proc_stat(int pid)
> +{
> +	char proc_path[100] = { 0 };
> +	char *line = NULL;
> +	size_t len = 0;
> +	ssize_t nread;
> +	char status;
> +	FILE *f;
> +	int i;
> +
> +	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
> +	f = fopen(proc_path, "r");
> +	if (f == NULL)
> +		ksft_exit_fail_msg("%s - Could not open %s\n", strerror(errno),
> +				   proc_path);
> +
> +	for (i = 0; i < 3; i++) {
> +		nread = getdelim(&line, &len, ' ', f);
> +		if (nread <= 0)
> +			ksft_exit_fail_msg("Failed to read status: %s\n",
> +					   strerror(errno));
> +	}
> +
> +	status = *line;
> +	free(line);
> +	fclose(f);
> +
> +	return status;
> +}
> +
> +/* Returns -1 if not in syscall (running or blocked) */
> +static long get_proc_syscall(int pid)
> +{
> +	char proc_path[100] = { 0 };
> +	char *line = NULL;
> +	size_t len = 0;
> +	ssize_t nread;
> +	long ret = -1;
> +	FILE *f;
> +
> +	snprintf(proc_path, sizeof(proc_path), "/proc/%d/syscall", pid);
> +	f = fopen(proc_path, "r");
> +	if (f == NULL)
> +		ksft_exit_fail_msg("%s - Could not open %s\n", strerror(errno),
> +				   proc_path);
> +
> +	nread = getdelim(&line, &len, ' ', f);
> +	if (nread <= 0)
> +		ksft_exit_fail_msg("Failed to read status: %s\n",
> +				   strerror(errno));
> +
> +	if (!strncmp("running", line, MIN(7, nread)))
> +		ret = strtol(line, NULL, 16);
> +
> +	free(line);
> +	fclose(f);
> +
> +	return ret;
> +}

I think these should be merged as they're almost entirely the same. The
differences are position wanted and file read. Also, passing metadata in
will let it break out on errors.

static char *get_proc_delim(struct __test_metadata *_metadata,
			    unsigned int pid, const char *name,
			    const unsigned int position)
{
	char proc_path[100] = { 0 };
	char *line = NULL;
	size_t len = 0;
	ssize_t nread;
	unsigned int i;
	FILE *f;

	snprintf(proc_path, sizeof(proc_path), "/proc/%d/%s", pid, name);
	f = fopen(proc_path, "r");
	ASSERT_NE(f, NULL) {
		TH_LOG("%s: %s\n", proc_path, strerror(errno));
	}

	for (i = 0; i < position; i++) {
		nread = getdelim(&line, &len, ' ', f);
		ASSERT_GE(nread, 0) {
			TH_LOG("%s: %s\n", proc_path, strerror(errno));
		}
	}
	fclose(f);

	return line;
}

static char get_proc_status(struct __test_metadata *_metadata, int pid)
{
	char status;
	char *item;

	item = get_proc_delim(_metadata,, pid, "stat", 3);
	status = *line;
	free(line);

	return status;
}

static long get_proc_syscall(struct __test_metadata *_metadata, int pid)
{
	char *item;
	long syscall = -1;

	item = get_proc_delim(_metadata, pid, "syscall", 1);
	syscall = strtol(line, item, 16);

	if (!strcmp("running", item)) {
		syscall = strtol(line, NULL, 16);
		ASSERT_NE(syscall, LONG_MIN);
		ASSERT_NE(syscall, LONG_MAX);
	}
	free(item);

	return syscall;
}

> +
> +TEST(user_notification_wait_killable_pre_notification)
> +{
> +	struct sigaction new_action = {
> +		.sa_handler = signal_handler,
> +	};
> +	int listener, status, sk_pair[2];
> +	pid_t pid;
> +	long ret;
> +	char c;
> +	/* 100 ms */
> +	struct timespec delay = { .tv_nsec = 100000000 };
> +
> +	ASSERT_EQ(sigemptyset(&new_action.sa_mask), 0);
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
> +
> +
> +	listener = user_notif_syscall(__NR_getppid,
> +				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
> +				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
> +	ASSERT_GE(listener, 0);
> +
> +	/*
> +	 * Check that we can kill the process with SIGUSR1 prior to receiving
> +	 * the notification. SIGUSR1 is wired up to a custom signal handler,
> +	 * and make sure it gets called.
> +	 */
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		close(sk_pair[0]);
> +		handled = sk_pair[1];
> +
> +		/* Setup the sigaction without SA_RESTART */
> +		if (sigaction(SIGUSR1, &new_action, NULL)) {
> +			perror("sigaction");
> +			exit(1);
> +		}
> +
> +		ret = syscall(__NR_getppid);
> +		exit(ret != -1 || errno != EINTR);
> +	}

I could use more comments in here. IIUC, they would be:

> +

	/* Wait for process to block for user_notif in getppid */
> +	while (get_proc_syscall(pid) != __NR_getppid &&
> +	       get_proc_stat(pid) != 'S')
> +		nanosleep(&delay, NULL);
> +

	/* Kill process */
> +	EXPECT_EQ(kill(pid, SIGUSR1), 0);
> +

	/*
	 * Make sure the process ends happily (i.e. its getppid()
	 * failed with EINTR.
	 */
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +

	/* Also make sure the signal handler fired. */
> +	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
> +}
> +
> +TEST(user_notification_wait_killable)
> +{
> +	struct sigaction new_action = {
> +		.sa_handler = signal_handler,
> +	};
> +	struct seccomp_notif_resp resp = {};
> +	struct seccomp_notif req = {};
> +	int listener, status, sk_pair[2];
> +	pid_t pid;
> +	long ret;
> +	char c;
> +	/* 100 ms */
> +	struct timespec delay = { .tv_nsec = 100000000 };
> +
> +	ASSERT_EQ(sigemptyset(&new_action.sa_mask), 0);
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
> +
> +	listener = user_notif_syscall(__NR_getppid,
> +				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
> +				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
> +	ASSERT_GE(listener, 0);
> +
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		close(sk_pair[0]);
> +		handled = sk_pair[1];
> +
> +		/* Setup the sigaction without SA_RESTART */
> +		if (sigaction(SIGUSR1, &new_action, NULL)) {
> +			perror("sigaction");
> +			exit(1);
> +		}
> +
> +		/* Make sure that the syscall is completed (no EINTR) */
> +		ret = syscall(__NR_getppid);
> +		exit(ret != USER_NOTIF_MAGIC);
> +	}
> +
> +	while (get_proc_syscall(pid) != __NR_getppid &&
> +	       get_proc_stat(pid) != 'S')
> +		nanosleep(&delay, NULL);
> +
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> +	/* Kill the process to make sure it enters the wait_killable state */
> +	EXPECT_EQ(kill(pid, SIGUSR1), 0);
> +
> +	/* TASK_KILLABLE is considered D (Disk Sleep) state */
> +	while (get_proc_stat(pid) != 'D')
> +		nanosleep(&delay, NULL);

Should a NOWAIT waitpid() happen in this loop to make sure this doesn't
spin forever?

i.e. running these tests on a kernel that doesn't have the support
shouldn't hang -- yes it'll time out eventually but that's annoying. ;)

> +
> +	resp.id = req.id;
> +	resp.val = USER_NOTIF_MAGIC;
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> +
> +	/*
> +	 * Make sure that the signal handler does get called once we're back in
> +	 * userspace.
> +	 */
> +	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +}
> +
> +TEST(user_notification_wait_killable_fatal)
> +{
> +	struct seccomp_notif req = {};
> +	int listener, status;
> +	pid_t pid;
> +	long ret;
> +	/* 100 ms */
> +	struct timespec delay = { .tv_nsec = 100000000 };
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	listener = user_notif_syscall(__NR_getppid,
> +				      SECCOMP_FILTER_FLAG_NEW_LISTENER |
> +				      SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV);
> +	ASSERT_GE(listener, 0);
> +
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		/* This should never complete */
> +		syscall(__NR_getppid);
> +		exit(1);
> +	}
> +
> +	while (get_proc_stat(pid) != 'S')
> +		nanosleep(&delay, NULL);
> +
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> +	/* Kill the process with a fatal signal */
> +	EXPECT_EQ(kill(pid, SIGTERM), 0);
> +
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFSIGNALED(status));
> +	EXPECT_EQ(SIGTERM, WTERMSIG(status));
> +}

Should there be a test validating the inverse of this, as in _without_
SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV, how should the above tests
behave?

Otherwise, looks good! Yay tests!

-- 
Kees Cook
