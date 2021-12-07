Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F5046BCBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhLGNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhLGNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:42:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C4EC0698D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:38:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638884315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bX1NR0j+bztPs3e2FHXqPDFi5nwq1W3dms8h8Wa/owE=;
        b=kA4YToSdJwK2cJnYyIGH5UHdicorNCukcaDzw7CGlVr6i00SvsdJ9GOqhlDukdJTf2zM3m
        jxKYFCF0YpjKt2X7eAC+HBOXH40LJIYVFoN3F88SGr7Y1u3wzinySDiVDT9VciayRRy1cR
        hyTB0VNKB61MWdmWmyumkbgyYg+i+5f549bD4qksHDBydFGgGlMlIbzCcC9vjTgbG14aN5
        i9sV48QM8GFC47yG5VxgFrVYbaPN/q+Pbri41iP3pZU5AE2Ik7aByG375Cb5F4my4lYXUj
        YUSb+gjI8j+OIRmL2X0/bh6+ebZucxXmw/TPW6YNZph1rqWtXSWot2DWMUiHog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638884315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bX1NR0j+bztPs3e2FHXqPDFi5nwq1W3dms8h8Wa/owE=;
        b=SclE7/lvMWOoowNRGdIXSuzTpXd02XpgWh5Ld9DKkq8JtjATTHU2BOrYcr8NdmkoU8QL8e
        jpS7bOrPlE0/6lCw==
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [x86/signal]  3aac3ebea0:  will-it-scale.per_thread_ops -11.9%
 regression
In-Reply-To: <20211207012128.GA16074@xsang-OptiPlex-9020>
References: <20211207012128.GA16074@xsang-OptiPlex-9020>
Date:   Tue, 07 Dec 2021 14:38:34 +0100
Message-ID: <87bl1s357p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Dec 07 2021 at 09:21, kernel test robot wrote:

> (please be noted we made some further analysis before reporting out,
> and thought it's likely the regression is related with the extra spinlock
> introducded by enalbling DYNAMIC_SIGFRAME. below is the full report.)
>
> FYI, we noticed a -11.9% regression of will-it-scale.per_thread_ops due t=
o commit:

Does that use sigaltstack() ?

> 1bdda24c4af64cd2 3aac3ebea08f2d342364f827c89=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \=20=20
>     754824 =C2=B1  2%     -11.9%     664668 =C2=B1  2%  will-it-scale.16.=
threads
>      47176 =C2=B1  2%     -11.9%      41541 =C2=B1  2%  will-it-scale.per=
_thread_ops
>     754824 =C2=B1  2%     -11.9%     664668 =C2=B1  2%  will-it-scale.wor=
kload
>    1422782 =C2=B1  8%  +3.3e+05     1751520 =C2=B1 12%  syscalls.sys_getp=
id.noise.5%

Somehow the printout got confused ...

>  1.583e+10            -2.1%   1.55e+10        perf-stat.i.instructions
>    6328594 =C2=B1  2%     +11.1%    7032338 =C2=B1  2%  perf-stat.overall=
.path-length
>  1.578e+10            -2.1%  1.545e+10        perf-stat.ps.instructions
>  4.774e+12            -2.2%  4.671e+12        perf-stat.total.instructions
>       0.00            +6.3        6.33 =C2=B1  8%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigaltsta=
ck.restore_altstack.__x64_sys_rt_sigreturn
>       0.00            +6.5        6.51 =C2=B1  8%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock_irq.do_sigaltstack.restore_altstack.__x64_sys_rt_=
sigreturn.do_syscall_64
>       0.00            +6.6        6.58 =C2=B1  8%  perf-profile.calltrace=
.cycles-pp.do_sigaltstack.restore_altstack.__x64_sys_rt_sigreturn.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe
>       0.00            +6.6        6.62 =C2=B1  8%  perf-profile.calltrace=
.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe.raise
>       0.00            +6.9        6.88 =C2=B1  9%  perf-profile.calltrace=
.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwfr=
ame.raise
>       7.99 =C2=B1 12%      +6.0       14.00 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.__x64_sys_rt_sigreturn
>       0.05 =C2=B1 44%      +6.6        6.62 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.restore_altstack
>       0.00            +6.6        6.58 =C2=B1  8%  perf-profile.children.=
cycles-pp.do_sigaltstack

It looks like it does. The problem is that sighand->lock is process
wide.

Can you test whether the below cures it?

Not pretty, but that's what I came up with for now.

Thanks,

        tglx
---
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -457,10 +457,10 @@ static inline void fpu_inherit_perms(str
 	if (fpu_state_size_dynamic()) {
 		struct fpu *src_fpu =3D &current->group_leader->thread.fpu;
=20
-		spin_lock_irq(&current->sighand->siglock);
+		read_lock(&current->sighand->sigaltstack_lock);
 		/* Fork also inherits the permissions of the parent */
 		dst_fpu->perm =3D src_fpu->perm;
-		spin_unlock_irq(&current->sighand->siglock);
+		read_unlock(&current->sighand->sigaltstack_lock);
 	}
 }
=20
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1582,17 +1582,22 @@ static int validate_sigaltstack(unsigned
 {
 	struct task_struct *thread, *leader =3D current->group_leader;
 	unsigned long framesize =3D get_sigframe_size();
+	int ret =3D 0;
=20
-	lockdep_assert_held(&current->sighand->siglock);
+	lockdep_assert_held_write(&current->sighand->sigaltstack_lock);
=20
 	/* get_sigframe_size() is based on fpu_user_cfg.max_size */
 	framesize -=3D fpu_user_cfg.max_size;
 	framesize +=3D usize;
+	read_lock(&tasklist_lock);
 	for_each_thread(leader, thread) {
-		if (thread->sas_ss_size && thread->sas_ss_size < framesize)
-			return -ENOSPC;
+		if (thread->sas_ss_size && thread->sas_ss_size < framesize) {
+			ret =3D -ENOSPC;
+			break;
+		}
 	}
-	return 0;
+	read_unlock(&tasklist_lock);
+	return ret;
 }
=20
 static int __xstate_request_perm(u64 permitted, u64 requested)
@@ -1627,7 +1632,7 @@ static int __xstate_request_perm(u64 per
=20
 	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
 	WRITE_ONCE(fpu->perm.__state_perm, requested);
-	/* Protected by sighand lock */
+	/* Protected by sighand::sigaltstack_lock */
 	fpu->perm.__state_size =3D ksize;
 	fpu->perm.__user_state_size =3D usize;
 	return ret;
@@ -1666,10 +1671,10 @@ static int xstate_request_perm(unsigned
 		return 0;
=20
 	/* Protect against concurrent modifications */
-	spin_lock_irq(&current->sighand->siglock);
+	write_lock(&current->sighand->sigaltstack_lock);
 	permitted =3D xstate_get_host_group_perm();
 	ret =3D __xstate_request_perm(permitted, requested);
-	spin_unlock_irq(&current->sighand->siglock);
+	write_unlock(&current->sighand->sigaltstack_lock);
 	return ret;
 }
=20
@@ -1685,11 +1690,11 @@ int xfd_enable_feature(u64 xfd_err)
 	}
=20
 	/* Protect against concurrent modifications */
-	spin_lock_irq(&current->sighand->siglock);
+	read_lock(&current->sighand->sigaltstack_lock);
=20
 	/* If not permitted let it die */
 	if ((xstate_get_host_group_perm() & xfd_event) !=3D xfd_event) {
-		spin_unlock_irq(&current->sighand->siglock);
+		read_unlock(&current->sighand->sigaltstack_lock);
 		return -EPERM;
 	}
=20
@@ -1702,7 +1707,7 @@ int xfd_enable_feature(u64 xfd_err)
 	 * another task, the retrieved buffer sizes are valid for the
 	 * currently requested feature(s).
 	 */
-	spin_unlock_irq(&current->sighand->siglock);
+	read_unlock(&current->sighand->sigaltstack_lock);
=20
 	/*
 	 * Try to allocate a new fpstate. If that fails there is no way
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -939,17 +939,19 @@ static int __init strict_sas_size(char *
  * the task has permissions to use dynamic features. Tasks which have no
  * permission are checked against the size of the non-dynamic feature set
  * if strict checking is enabled. This avoids forcing all tasks on the
- * system to allocate large sigaltstacks even if they are never going
- * to use a dynamic feature. As this is serialized via sighand::siglock
- * any permission request for a dynamic feature either happened already
- * or will see the newly install sigaltstack size in the permission checks.
+ * system to allocate large sigaltstacks even if they are never going to
+ * use a dynamic feature.
+ *
+ * As this is serialized via sighand::sigaltstack_lock any permission
+ * request for a dynamic feature either happened already or will see the
+ * newly install sigaltstack size in the permission checks.
  */
 bool sigaltstack_size_valid(size_t ss_size)
 {
 	unsigned long fsize =3D max_frame_size - fpu_default_state_size;
 	u64 mask;
=20
-	lockdep_assert_held(&current->sighand->siglock);
+	lockdep_assert_held_read(&current->sighand->sigaltstack_lock);
=20
 	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
 		return true;
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -19,6 +19,9 @@
=20
 struct sighand_struct {
 	spinlock_t		siglock;
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+	rwlock_t		sigaltstack_lock;
+#endif
 	refcount_t		count;
 	wait_queue_head_t	signalfd_wqh;
 	struct k_sigaction	action[_NSIG];
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -48,6 +48,9 @@ static struct sighand_struct init_sighan
 	.action		=3D { { { .sa_handler =3D SIG_DFL, } }, },
 	.siglock	=3D __SPIN_LOCK_UNLOCKED(init_sighand.siglock),
 	.signalfd_wqh	=3D __WAIT_QUEUE_HEAD_INITIALIZER(init_sighand.signalfd_wqh=
),
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+	.sigaltstack_lock	=3D __RW_LOCK_UNLOCKED(init_sighand.sigaltstack_lock),
+#endif
 };
=20
 #ifdef CONFIG_SHADOW_CALL_STACK
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2900,6 +2900,9 @@ static void sighand_ctor(void *data)
=20
 	spin_lock_init(&sighand->siglock);
 	init_waitqueue_head(&sighand->signalfd_wqh);
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+	rwlock_init(&sighand->sigaltstack_lock);
+#endif
 }
=20
 void __init proc_caches_init(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4141,15 +4141,15 @@ int do_sigaction(int sig, struct k_sigac
=20
 #ifdef CONFIG_DYNAMIC_SIGFRAME
 static inline void sigaltstack_lock(void)
-	__acquires(&current->sighand->siglock)
+	__acquires(&current->sighand->sigaltstack_lock)
 {
-	spin_lock_irq(&current->sighand->siglock);
+	read_lock(&current->sighand->sigaltstack_lock);
 }
=20
 static inline void sigaltstack_unlock(void)
-	__releases(&current->sighand->siglock)
+	__releases(&current->sighand->sigaltstack_lock)
 {
-	spin_unlock_irq(&current->sighand->siglock);
+	read_unlock(&current->sighand->sigaltstack_lock);
 }
 #else
 static inline void sigaltstack_lock(void) { }
