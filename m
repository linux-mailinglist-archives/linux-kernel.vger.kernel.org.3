Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB26C5A9EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIASMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiIASLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:11:51 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737346224
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:11:48 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:58536)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oTofK-004l2w-Pc; Thu, 01 Sep 2022 12:11:46 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:52540 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oTofI-007jjP-92; Thu, 01 Sep 2022 12:11:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Alexey Izbyshev <izbyshev@ispras.ru>
References: <YxAq2jYvGG8QOypu@gmail.com>
Date:   Thu, 01 Sep 2022 13:11:37 -0500
In-Reply-To: <YxAq2jYvGG8QOypu@gmail.com> (Andrei Vagin's message of "Wed, 31
        Aug 2022 20:45:30 -0700")
Message-ID: <87czcfhsme.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oTofI-007jjP-92;;;mid=<87czcfhsme.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX196iNn/InHNKd5AI4rcl44jt3Uv1L2Og/Q=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrei Vagin <avagin@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1939 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (0.5%), b_tie_ro: 8 (0.4%), parse: 1.25 (0.1%),
         extract_message_metadata: 6 (0.3%), get_uri_detail_list: 3.4 (0.2%),
        tests_pri_-1000: 3.0 (0.2%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 290 (15.0%), check_bayes:
        287 (14.8%), b_tokenize: 12 (0.6%), b_tok_get_all: 11 (0.6%),
        b_comp_prob: 3.8 (0.2%), b_tok_touch_all: 256 (13.2%), b_finish: 0.88
        (0.0%), tests_pri_0: 1600 (82.5%), check_dkim_signature: 0.73 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 0.71 (0.0%), tests_pri_10:
        4.1 (0.2%), tests_pri_500: 13 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:

> On Tue, Aug 30, 2022 at 6:18 PM Andrei Vagin <avagin@gmail.com> wrote:
>>On Tue, Aug 30, 2022 at 10:49:43PM +0300, Alexey Izbyshev wrote:
> <snip>
>>> @@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
>>>         tsk->mm->vmacache_seqnum = 0;
>>>         vmacache_flush(tsk);
>>>         task_unlock(tsk);
>>> +
>>> +       if (vfork)
>>> +               timens_on_fork(tsk->nsproxy, tsk);
>>> +
>>> 
>>> Similarly, even after a normal vfork(), time namespace switch could be
>>> silently skipped if the parent dies before "tsk->vfork_done" is read. Again,
>>> I don't know whether anybody cares, but this behavior seems non-obvious and
>>> probably unintended to me.
>> This is the more interesting case. I will try to find out how we can
>> handle it properly.
>
> It might not be a good idea to use vfork_done in this case. Let's
> think about what we have and what we want to change. We don't want to
> allow switching timens if a process mm is used by someone else. But we
> forgot to handle execve that creates a new mm, and we can't change this
> behavior right now because it can affect current users. Right?

What we can't changes are things that will break existing programs.  If
existing programs don't care we can change the behavior of the kernel.

> So maybe the best choice, in this case, is to change behavior by adding
> a new control that enables it. The first interface that comes to my mind
> is to introduce a new ioctl for a namespace file descriptor. Here is a
> draft patch below that should help to understand what I mean.

I don't think adding a new control works, because programs that are
calling vfork or posix_spawn today will stop working.

We should recognize that basing things off of CLONE_VFORK was a bad idea
as CLONE_VFORK is all about waiting for the created task to exec or
exit, and really has nothing to do with creating a new mm.

Instead I think the rule should be that a new time namespaces is
installed as soon as we have a new mm.

That will be a behavioral change if the time ns is unshared and then the
program exec's instead of forking children, but I suspect it is the
proper behavior all the same, and that existing userspace won't care.
Especially since all of the vfork_done work is new behavior as
of v6.0-rc1.

Ugh.  I just spotted another bug.  The function timens_on_fork as
written is not safe to call without first creating a fresh copy
of the nsproxy, and we don't do that during exec.  Because nsproxy
is shared between tasks and processes updating the values needs to
create a new nsproxy or other tasks/processes can be affected.
Not hard to handle just something that needs to be addressed.

Say something like this:

diff --git a/fs/exec.c b/fs/exec.c
index 9a5ca7b82bfc..8a6947e631dd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -979,12 +979,10 @@ static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
-	bool vfork;
 	int ret;
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
-	vfork = !!tsk->vfork_done;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
 	if (old_mm)
@@ -1030,9 +1028,6 @@ static int exec_mmap(struct mm_struct *mm)
 	vmacache_flush(tsk);
 	task_unlock(tsk);
 
-	if (vfork)
-		timens_on_fork(tsk->nsproxy, tsk);
-
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
@@ -1303,6 +1298,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	bprm->mm = NULL;
 
+	retval = exec_task_namespaces();
+	if (retval)
+		goto out_unlock;
+
 #ifdef CONFIG_POSIX_TIMERS
 	spin_lock_irq(&me->sighand->siglock);
 	posix_cpu_timers_exit(me);
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index cdb171efc7cb..fee881cded01 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -94,6 +94,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
 int copy_namespaces(unsigned long flags, struct task_struct *tsk);
 void exit_task_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
+int exec_task_namespaces(void);
 void free_nsproxy(struct nsproxy *ns);
 int unshare_nsproxy_namespaces(unsigned long, struct nsproxy **,
 	struct cred *, struct fs_struct *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..b4a799d9c50f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2043,18 +2043,6 @@ static __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * If the new process will be in a different time namespace
-	 * do not allow it to share VM or a thread group with the forking task.
-	 *
-	 * On vfork, the child process enters the target time namespace only
-	 * after exec.
-	 */
-	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
-		if (nsp->time_ns != nsp->time_ns_for_children)
-			return ERR_PTR(-EINVAL);
-	}
-
 	if (clone_flags & CLONE_PIDFD) {
 		/*
 		 * - CLONE_DETACHED is blocked so that we can potentially
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index b4cbb406bc28..b6647846fe42 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -255,6 +255,24 @@ void exit_task_namespaces(struct task_struct *p)
 	switch_task_namespaces(p, NULL);
 }
 
+int exec_task_namespaces(void)
+{
+	struct task_struct *tsk = current;
+	struct nsproxy *new;
+
+	if (tsk->nsproxy->time_ns_for_children == tsk->nsproxy->time_ns)
+		return 0;
+
+	new = create_new_namespaces(0, tsk, current_user_ns(), tsk->fs);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	timens_on_fork(new, tsk);
+	switch_task_namespaces(tsk, new);
+	return 0;
+}
+
+
 static int check_setns_flags(unsigned long flags)
 {
 	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |



To keep things from being too confusing it probably makes sense to
rename the nsproxy variable from time_ns_for_children to
time_ns_for_new_mm.  Likewise timens_on_fork can be renamed
timens_on_new_mm.

But that would be follow up work.

How does the above change sound to folks?

Eric
