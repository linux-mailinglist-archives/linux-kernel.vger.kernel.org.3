Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9D4B32F9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 05:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiBLE2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 23:28:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBLE2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 23:28:51 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7228E29
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:28:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x3so6221446pll.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgktAnMyQV8XmOFvmPrbI1fjqTx70lJS+/GJGKFg5Dk=;
        b=cycbFQ18OsaTXolp85tbhsU5ysSl6wQ2+XHBRXTFySF/48z/07XhkqnelcXE9J3iTr
         nSD0IgV8vg5z5StKfyaetKO0yholM9dxtd/lbJwSThUzmQGuvQG3C+CYyW5IuXnGEM+I
         GSn1DDd4JvFGxkjT0/P3GgwWEE24qhQ5kpGNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KgktAnMyQV8XmOFvmPrbI1fjqTx70lJS+/GJGKFg5Dk=;
        b=z4gIjVxvhZpecnfrfoh/iTUYFsfcrvLGjOhtZzIzVpsQ/Fl4LfGdi2ScKl2WaauLbR
         ZnyG0W7gTgpX0G5xJhzOrHgsPM4YPGpFNvnIIzehc++MSaatKdD1/QOgupsd8fvZAVyG
         GvuuJRRsOoFVL5VK718bDV93ZtY1uYaYB85RH1RdqkRn3BIhhIM8DiN16lDmlcrRdzm7
         FB/+8H66hfMcUiWmt1DJPVOmSpcJwD27Y97bUxeEerZZJoRNxn66Io3ze8LF4bnp2WVS
         uc1GYNea7QKzG4ecFxjsNx8fHTuTyHmZcEyq/JYId1Fuaqg1vfHWRsJiyJykJmHkly4T
         Npzw==
X-Gm-Message-State: AOAM5301+iXZ/+mSkgsKArBhC/Nu6zi+o9zz6Yp3BF8004BjpjztmeOH
        99AkCe8STuBNIfO7+s/cqR6GlQ==
X-Google-Smtp-Source: ABdhPJwW4B9UBaWVq4xUpnOwGsaDM4DTG1uUli1Ye17djY99VVEyUtBB8Yh0xDEhdJc/idk9jwSQhQ==
X-Received: by 2002:a17:90b:2248:: with SMTP id hk8mr3683027pjb.242.1644640128933;
        Fri, 11 Feb 2022 20:28:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm27226970pfm.119.2022.02.11.20.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 20:28:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RFC] Get siginfo from unreaped task
Date:   Fri, 11 Feb 2022 20:28:43 -0800
Message-Id: <20220212042843.2993537-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6322; h=from:subject; bh=y0/xaB0q0yddSF0EmbpT28oabYdHCkprnUmnhMq2bLQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBzd61bZSzb0DFXL8Uftb29a+ETNBryjwSp8Cy3X5 R6Hoxz6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgc3egAKCRCJcvTf3G3AJmlOD/ 491PzsFwJwaWa2D38uLWLRrnXt6ytUK0OLzEs9ue7cxany9QnaZ1O49cb/FxWQOGWc/t59Qwa5Spe4 pSQYvOK63IfqH5ARNORE9XEFN5dKlSCBalNNlz0IwPGVAAgSgcj6rkAihk8/sDp48BJzDHlQsjoZb8 MdiX9UsatQ47vlp+Ta6Ia2VKtkkrYLWah7oJQMpdpDDPi60jP8Mncd7spaPg4fj/Vksulx5u1gxVUS oesk3tFymYBOow5DD/EN9X+5d8h/h7AmZTSathYs1kHw1VUevtIuW9fq7LBNW1fwQe5qtd1xf21zUY MjwLAwfCJFjUFJRs26QxMK5fZf3hn16KYIM6qugi6vbEJ+QbM4Y8PofZ0+c12vzIIP6BlKuQVD/7Op Rq+ucgpOv1TBOAw9tT2pjgih3ugArdj6kd2thdYZe44vDdhlr99rxxyLu0ddQvQgzJj9vE4ZooDRnO TOB2HhibT7mAq/VibBamp20X6eSgBDtTsFNGBkDaSznMkTlKM5CdytkaSKTpAWN7AKf5lJvql3YM+y apNw8rKwj5XVtmeOxz7FBQkaJliQcaAN2A1GI74dSjGQ9q2QX7cy9QB4fU7CL7NypIWhYJxF2EBFm2 Epr4PCM2ZAMKF1nxL2dkZcLLiMaUhVxyy98FJzlR3pgVXIUNSVx4/kmQ1bhQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make siginfo available through PTRACE_GETSIGINFO after process death,
without needing to have already used PTRACE_ATTACH. Uses 48 more bytes
in task_struct, though I bet there might be somewhere else we could
stash a copy of it?

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/sched.h                         |   1 +
 kernel/ptrace.c                               |  12 +-
 kernel/signal.c                               |   4 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 119 ++++++++++++++++++
 4 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..e40789e801ef 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1178,6 +1178,7 @@ struct task_struct {
 #endif
 	/* Ptrace state: */
 	unsigned long			ptrace_message;
+	kernel_siginfo_t		death_siginfo;
 	kernel_siginfo_t		*last_siginfo;
 
 	struct task_io_accounting	ioac;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index eea265082e97..990839c57842 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1304,8 +1304,16 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 
 	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
 				  request == PTRACE_INTERRUPT);
-	if (ret < 0)
-		goto out_put_task_struct;
+	if (ret < 0) {
+		/*
+		 * Allow PTRACE_GETSIGINFO if process is dead
+		 * and we could otherwise ptrace it.
+		 */
+		if (request != PTRACE_GETSIGINFO ||
+		    !child->exit_state ||
+		    !ptrace_may_access(child, PTRACE_MODE_READ_REALCREDS))
+			goto out_put_task_struct;
+	}
 
 	ret = arch_ptrace(child, request, addr, data);
 	if (ret || request != PTRACE_DETACH)
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b04631acde8..41f6ba6b7aa7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2825,6 +2825,10 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 	fatal:
+		/* Allow siginfo to be queried until reaped. */
+		copy_siginfo(&current->death_siginfo, &ksig->info);
+		current->last_siginfo = &current->death_siginfo;
+
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
 			cgroup_leave_frozen(true);
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9d126d7fabdb..d2bbf9e32f22 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -268,6 +268,10 @@ struct seccomp_notif_addfd_big {
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH (1UL << 4)
 #endif
 
+#ifndef SYS_SECCOMP
+#define SYS_SECCOMP	1
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -765,6 +769,121 @@ TEST_SIGNAL(KILL_one_arg_six, SIGSYS)
 	close(fd);
 }
 
+FIXTURE(SIGINFO) {
+	pid_t child_pid;
+};
+
+FIXTURE_SETUP(SIGINFO)
+{
+	self->child_pid = 0;
+}
+
+FIXTURE_TEARDOWN(SIGINFO)
+{
+	if (self->child_pid > 0)
+		waitpid(self->child_pid, NULL, WNOHANG);
+}
+
+TEST_F(SIGINFO, child)
+{
+	int status;
+	siginfo_t info = { };
+	/* Kill only when calling __NR_prctl. */
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_PROCESS | 0xBA),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	self->child_pid = fork();
+	ASSERT_LE(0, self->child_pid);
+	if (self->child_pid == 0) {
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+			TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+		}
+		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
+		prctl(PR_GET_SECCOMP, 0, 0, 0, 0);
+		/* Should have died now. */
+		_exit(37);
+	}
+
+	/* Check siginfo_t contents. */
+	EXPECT_EQ(waitid(P_PID, self->child_pid, &info, WEXITED | WNOWAIT), 0);
+#if 0
+	struct {
+	        int si_signo;
+	        int si_code;
+	        int si_errno;
+	        union __sifields _sifields;
+	}
+
+	/* SIGCHLD */
+	struct {
+		__kernel_pid_t _pid;	/* which child */
+		__kernel_uid32_t _uid;	/* sender's uid */
+		int _status;		/* exit code */
+		__ARCH_SI_CLOCK_T _utime;
+		__ARCH_SI_CLOCK_T _stime;
+	} _sigchld;
+#endif
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	EXPECT_TRUE(info.si_code == CLD_KILLED || info.si_code == CLD_DUMPED);
+	EXPECT_TRUE(info.si_errno == 0);
+	EXPECT_EQ(info.si_pid, self->child_pid);
+
+	ASSERT_TRUE(WIFSIGNALED(info.si_status));
+	/* TODO: why doesn't this WCOREDUMP() agree with below? */
+	/* EXPECT_TRUE(WCOREDUMP(status)); */
+	EXPECT_EQ(WTERMSIG(info.si_status), SIGSYS);
+
+	memset(&info, 0, sizeof(info));
+	ASSERT_EQ(ptrace(PTRACE_GETSIGINFO, self->child_pid, NULL, &info), 0);
+#if 0
+	/* SIGSYS */
+	struct {
+		void __user *_call_addr;/* calling user insn */
+		int _syscall;		/* triggering system call number */
+		unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
+	} _sigsys;
+
+	info.si_signo = SIGSYS;
+	info.si_code = SYS_SECCOMP;
+	info.si_call_addr = (void __user *)KSTK_EIP(current);
+	info.si_errno = reason;
+	info.si_arch = syscall_get_arch(current);
+	info.si_syscall = syscall;
+
+#endif
+	ASSERT_EQ(info.si_signo, SIGSYS);
+	EXPECT_EQ(info.si_code, SYS_SECCOMP);
+	/*
+	 * The syscall will have happened somewhere near the libc
+	 * prctl implementation.
+	 */
+	EXPECT_TRUE(info.si_call_addr >= (void *)prctl &&
+		    info.si_call_addr <= (void *)prctl + PAGE_SIZE) {
+		TH_LOG("info.si_call_addr: %p", info.si_call_addr);
+		TH_LOG("prctl            : %p", prctl);
+	}
+	EXPECT_EQ(info.si_errno, 0xBA);
+	/* EXPECT_EQ(info.si_arch, ...native arch...); */
+	EXPECT_EQ(info.si_syscall, __NR_prctl);
+
+	/* Check status contents. */
+	ASSERT_EQ(waitpid(self->child_pid, &status, 0), self->child_pid);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	/* TODO: why doesn't this WCOREDUMP() agree with above? */
+	/* EXPECT_TRUE(WCOREDUMP(status)); */
+	EXPECT_EQ(WTERMSIG(status), SIGSYS);
+	self->child_pid = 0;
+}
+
 /* This is a thread task to die via seccomp filter violation. */
 void *kill_thread(void *data)
 {
-- 
2.30.2

