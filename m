Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E054B5B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiBNUXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:23:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBNUXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:23:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F931E6822
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:21:20 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d187so31131036pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DF9WT/Vv+v/rFZpH2c7Do8/144JbYcaXb42/q6Y+A0U=;
        b=QIyQthQljzLDrV1j/8Di/lSTC4O9i7AJ4h+RyA0Gbr4rcktlIyiBLn6GTX8uKH6LcT
         jHb/KGlZVkhdQXIFz3E2u6cgJcFB9mYMV6IHktSAy+pSDAun9LkQRlfDlpWDNdv8isxg
         OKtqc7zE/vmR6+ggIAD2GVAjrM2eJ1Mjo6GLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DF9WT/Vv+v/rFZpH2c7Do8/144JbYcaXb42/q6Y+A0U=;
        b=rLFidTy6tKJ2aN4QjuHBrTGfISAw161eaTMJLtO4I8dgFqMTmcCuzkaM/hLTd5VhgA
         xwr6UssqlyJwjAcBk4dG8BogpgQIeQPG9jvJmKBMqaPkrqgnvPfF6mc5k8qZHArHOiuk
         0FhQnCNeIe5T5MnW8lzeyJoe+hFnY/fCrfMOOYg/9TyCcD1VL+WTcTZYqWY1pq0Qm4zr
         Gt0ZMBcrZ0R7Rjom1QIYYii7la3z79z9i6qkY3JwLpHQW2hpVGdpAM+sedrqVHZT/hgi
         wWBWEXeVzQ7JZn3K7MijE0f7Wd8y+T1JHigty5mWB3yVx8f0AOhsNApY4A+G57j0vDuj
         8yJA==
X-Gm-Message-State: AOAM533d5WGAfk737MKdwEpL6YQoeiKQmOgUnZQoka8lLPDa/1Bmhepn
        T9/rEWiee/WC8ge7+hCFGE2j7U+z2tlo9Q==
X-Google-Smtp-Source: ABdhPJyGvGVuw3HE04nf6pE0tMBuCUxgl2p9O4asWDDxJJCfFsjyzXK4t7nX3MjYl8E01F0Y9HZ41Q==
X-Received: by 2002:a17:903:2281:: with SMTP id b1mr686528plh.158.1644869246223;
        Mon, 14 Feb 2022 12:07:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lw16sm9718884pjb.51.2022.02.14.12.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:07:25 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:07:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Will Drewry <wad@chromium.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC] Get siginfo from unreaped task
Message-ID: <202202141152.6296CD7F@keescook>
References: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
 <CF5167CE-FA1C-4CEC-9EA8-5EE8041FE7C4@amacapital.net>
 <20220213085212.cwzuqlrabpgbnbac@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220213085212.cwzuqlrabpgbnbac@wittgenstein>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 09:52:12AM +0100, Christian Brauner wrote:
> On Sat, Feb 12, 2022 at 06:32:08PM -0800, Andy Lutomirski wrote:
> > 
> > > On Feb 12, 2022, at 3:24 AM, Robert Święcki <robert@swiecki.net> wrote:
> > > 
> > > ﻿sob., 12 lut 2022 o 05:28 Kees Cook <keescook@chromium.org> napisał(a):
> > >> 
> > >> Make siginfo available through PTRACE_GETSIGINFO after process death,
> > >> without needing to have already used PTRACE_ATTACH. Uses 48 more bytes
> > >> in task_struct, though I bet there might be somewhere else we could
> > >> stash a copy of it?
> > > 
> > > An alternative way of accessing this info could be abusing the
> > > waitid() interface, with some additional, custom to Linux, flag
> > > 
> > > waitid(P_ALL, 0, &si, __WCHILDSIGINFO);
> > > 
> > > which would change what is put into si.
> > > 
> > > But maybe ptrace() is better, because it's mostly incompatible with
> > > other OSes anyway on the behavior/flag level, while waitd() seems to
> > > be POSIX/BSD standard, even if Linux specifies some additional flags.
> > > 
> > > 
> > 
> > I had a kind of opposite thought, which is that it would be very nice
> > to be able to get all the waitid() data without reaping a process or
> > even necessarily being its parent.  Maybe these can be combined?  A
> > new waitid() option like you’re suggesting could add siginfo (and
> > might need permissions).  And we could have a different waitid() flag
> > that says “maybe not my child, don’t reap” (and also needs
> > permissions).
> > 
> > Although the “don’t reap” thing is fundamentally racy. What a sane
> > process manager actually wants is an interface to read all this info
> > from a pidfd, which means it all needs to get stuck in struct pid. And
> 
> /me briefly pops out from vacation
> 
> Agreed and not just siginfo I would expect(?). We already came to that
> conclusion when we first introduced them.
> 
> > task_struct needs a completion or wait queue so you can actually wait
> > for a pidfd to exit (unless someone already did this — I had patches a
> > while back).  And this would be awesome.
> 
> Currently, you can wait for a pidfd to exit via polling and you can use
> a pidfd to pass it to waitid(P_PIDFD, pidfd, ...).
> 
> /me pops back into vacation

Right, so waitid already has all the infrastructure for this, so I think
adding it there makes a lot of sense. Here's what I've got:



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
diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
index 85b809fc9f11..7258cd4510ba 100644
--- a/include/uapi/linux/wait.h
+++ b/include/uapi/linux/wait.h
@@ -9,6 +9,7 @@
 #define WCONTINUED	0x00000008
 #define WNOWAIT		0x01000000	/* Don't reap, just poll status.  */
 
+#define __WCHILDSIGINFO	0x10000000	/* Report child's siginfo. */
 #define __WNOTHREAD	0x20000000	/* Don't wait on children of other threads in this group */
 #define __WALL		0x40000000	/* Wait on all children, regardless of type */
 #define __WCLONE	0x80000000	/* Wait only on non-SIGCHLD children */
diff --git a/kernel/exit.c b/kernel/exit.c
index d54efddd378b..70ecb996cecd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -953,6 +953,7 @@ struct waitid_info {
 	uid_t uid;
 	int status;
 	int cause;
+	kernel_siginfo_t siginfo;
 };
 
 struct wait_opts {
@@ -964,7 +965,7 @@ struct wait_opts {
 	int			wo_stat;
 	struct rusage		*wo_rusage;
 
-	wait_queue_entry_t		child_wait;
+	wait_queue_entry_t	child_wait;
 	int			notask_error;
 };
 
@@ -1012,11 +1013,16 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 	int state, status;
 	pid_t pid = task_pid_vnr(p);
 	uid_t uid = from_kuid_munged(current_user_ns(), task_uid(p));
-	struct waitid_info *infop;
+	struct waitid_info *infop = wo->wo_info;
 
 	if (!likely(wo->wo_flags & WEXITED))
 		return 0;
 
+	/* Before WNOWAIT so a copy can be extracted without reaping. */
+	if (unlikely(wo->wo_flags & __WCHILDSIGINFO)) {
+		if (infop && p->last_siginfo)
+			copy_siginfo(&infop->siginfo, p->last_siginfo);
+	}
 	if (unlikely(wo->wo_flags & WNOWAIT)) {
 		status = (p->signal->flags & SIGNAL_GROUP_EXIT)
 			? p->signal->group_exit_code : p->exit_code;
@@ -1121,7 +1127,6 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		release_task(p);
 
 out_info:
-	infop = wo->wo_info;
 	if (infop) {
 		if ((status & 0x7f) == 0) {
 			infop->cause = CLD_EXITED;
@@ -1564,7 +1569,7 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	unsigned int f_flags = 0;
 
 	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED|
-			__WNOTHREAD|__WCLONE|__WALL))
+			__WNOTHREAD|__WCLONE|__WALL|__WCHILDSIGINFO))
 		return -EINVAL;
 	if (!(options & (WEXITED|WSTOPPED|WCONTINUED)))
 		return -EINVAL;
@@ -1638,6 +1645,10 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 	if (!infop)
 		return err;
 
+	/* __WCHILDSIGINFO */
+	if (info->siginfo.signo)
+		return copy_siginfo_to_user(infop, &info->siginfo);
+
 	if (!user_write_access_begin(infop, sizeof(*infop)))
 		return -EFAULT;
 
@@ -1781,6 +1792,12 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 	if (!infop)
 		return err;
 
+	/* __WCHILDSIGINFO */
+	if (info->siginfo.signo)
+		return copy_siginfo_to_user32(
+				(struct compat_siginfo __user *)infop,
+				&info->siginfo);
+
 	if (!user_write_access_begin(infop, sizeof(*infop)))
 		return -EFAULT;
 


One usability question I have is:

- if the process just exited normally, should it return an empty
  siginfo, or should it ignore __WCHILDSIGINFO? (I have it ignoring it
  above.)


-- 
Kees Cook
