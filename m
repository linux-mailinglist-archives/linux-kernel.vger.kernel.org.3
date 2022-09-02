Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216805AB6BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiIBQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIBQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:39:35 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58410F54AE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:39:33 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 404BB40737A8;
        Fri,  2 Sep 2022 16:39:28 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 02 Sep 2022 19:39:28 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
In-Reply-To: <YxIr15QTmYb4Uojq@gmail.com>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org> <YxIr15QTmYb4Uojq@gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <b14a9802e171b3148c62f6193d08fa92@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-02 19:14, Andrei Vagin wrote:
> On Thu, Sep 01, 2022 at 01:11:37PM -0500, Eric W. Biederman wrote:
>> Andrei Vagin <avagin@gmail.com> writes:
>> 
>> > On Tue, Aug 30, 2022 at 6:18 PM Andrei Vagin <avagin@gmail.com> wrote:
>> >>On Tue, Aug 30, 2022 at 10:49:43PM +0300, Alexey Izbyshev wrote:
>> > <snip>
>> >>> @@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
>> >>>         tsk->mm->vmacache_seqnum = 0;
>> >>>         vmacache_flush(tsk);
>> >>>         task_unlock(tsk);
>> >>> +
>> >>> +       if (vfork)
>> >>> +               timens_on_fork(tsk->nsproxy, tsk);
>> >>> +
>> >>>
>> >>> Similarly, even after a normal vfork(), time namespace switch could be
>> >>> silently skipped if the parent dies before "tsk->vfork_done" is read. Again,
>> >>> I don't know whether anybody cares, but this behavior seems non-obvious and
>> >>> probably unintended to me.
>> >> This is the more interesting case. I will try to find out how we can
>> >> handle it properly.
>> >
>> > It might not be a good idea to use vfork_done in this case. Let's
>> > think about what we have and what we want to change. We don't want to
>> > allow switching timens if a process mm is used by someone else. But we
>> > forgot to handle execve that creates a new mm, and we can't change this
>> > behavior right now because it can affect current users. Right?
>> 
>> What we can't changes are things that will break existing programs.  
>> If
>> existing programs don't care we can change the behavior of the kernel.
> 
> I agree that it is very unlikely that anyone will notice
> these changes. And it is hard to imagine that anyone uses the old
> behavior intentionally.
> 
>> 
>> > So maybe the best choice, in this case, is to change behavior by adding
>> > a new control that enables it. The first interface that comes to my mind
>> > is to introduce a new ioctl for a namespace file descriptor. Here is a
>> > draft patch below that should help to understand what I mean.
>> 
>> I don't think adding a new control works, because programs that are
>> calling vfork or posix_spawn today will stop working.
>> 
>> We should recognize that basing things off of CLONE_VFORK was a bad 
>> idea
>> as CLONE_VFORK is all about waiting for the created task to exec or
>> exit, and really has nothing to do with creating a new mm.
>> 
>> Instead I think the rule should be that a new time namespaces is
>> installed as soon as we have a new mm.
>> 
>> That will be a behavioral change if the time ns is unshared and then 
>> the
>> program exec's instead of forking children, but I suspect it is the
>> proper behavior all the same, and that existing userspace won't care.
>> Especially since all of the vfork_done work is new behavior as
>> of v6.0-rc1.
>> 
>> Ugh.  I just spotted another bug.  The function timens_on_fork as
>> written is not safe to call without first creating a fresh copy
>> of the nsproxy, and we don't do that during exec.  Because nsproxy
>> is shared between tasks and processes updating the values needs to
>> create a new nsproxy or other tasks/processes can be affected.
>> Not hard to handle just something that needs to be addressed.
> 
> You are right. Thanks.
> 
>> 
>> Say something like this:
>> 
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 9a5ca7b82bfc..8a6947e631dd 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -979,12 +979,10 @@ static int exec_mmap(struct mm_struct *mm)
>>  {
>>  	struct task_struct *tsk;
>>  	struct mm_struct *old_mm, *active_mm;
>> -	bool vfork;
>>  	int ret;
>> 
>>  	/* Notify parent that we're no longer interested in the old VM */
>>  	tsk = current;
>> -	vfork = !!tsk->vfork_done;
>>  	old_mm = current->mm;
>>  	exec_mm_release(tsk, old_mm);
>>  	if (old_mm)
>> @@ -1030,9 +1028,6 @@ static int exec_mmap(struct mm_struct *mm)
>>  	vmacache_flush(tsk);
>>  	task_unlock(tsk);
>> 
>> -	if (vfork)
>> -		timens_on_fork(tsk->nsproxy, tsk);
>> -
>>  	if (old_mm) {
>>  		mmap_read_unlock(old_mm);
>>  		BUG_ON(active_mm != old_mm);
>> @@ -1303,6 +1298,10 @@ int begin_new_exec(struct linux_binprm * bprm)
>> 
>>  	bprm->mm = NULL;
>> 
>> +	retval = exec_task_namespaces();
>> +	if (retval)
>> +		goto out_unlock;
>> +
>>  #ifdef CONFIG_POSIX_TIMERS
>>  	spin_lock_irq(&me->sighand->siglock);
>>  	posix_cpu_timers_exit(me);
>> diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
>> index cdb171efc7cb..fee881cded01 100644
>> --- a/include/linux/nsproxy.h
>> +++ b/include/linux/nsproxy.h
>> @@ -94,6 +94,7 @@ static inline struct cred *nsset_cred(struct nsset 
>> *set)
>>  int copy_namespaces(unsigned long flags, struct task_struct *tsk);
>>  void exit_task_namespaces(struct task_struct *tsk);
>>  void switch_task_namespaces(struct task_struct *tsk, struct nsproxy 
>> *new);
>> +int exec_task_namespaces(void);
>>  void free_nsproxy(struct nsproxy *ns);
>>  int unshare_nsproxy_namespaces(unsigned long, struct nsproxy **,
>>  	struct cred *, struct fs_struct *);
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 90c85b17bf69..b4a799d9c50f 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2043,18 +2043,6 @@ static __latent_entropy struct task_struct 
>> *copy_process(
>>  			return ERR_PTR(-EINVAL);
>>  	}
>> 
>> -	/*
>> -	 * If the new process will be in a different time namespace
>> -	 * do not allow it to share VM or a thread group with the forking 
>> task.
>> -	 *
>> -	 * On vfork, the child process enters the target time namespace only
>> -	 * after exec.
>> -	 */
>> -	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
>> -		if (nsp->time_ns != nsp->time_ns_for_children)
>> -			return ERR_PTR(-EINVAL);
>> -	}
> 
> pls don't remove this part. It was one of the concerns that vfork
> doesn't work after unshare(CLONE_NEWTIME), but it is one of the 
> standard
> ways of creating a new process. For example, posix_spawn uses it.
> 
What do you mean? On the contrary, removing this restriction of the 
original time namespace implementation allows vfork(), pthread_create() 
and the like, solving the issue with posix_spawn() as well.

Thanks,
Alexey
>> -
>>  	if (clone_flags & CLONE_PIDFD) {
>>  		/*
>>  		 * - CLONE_DETACHED is blocked so that we can potentially
>> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
>> index b4cbb406bc28..b6647846fe42 100644
>> --- a/kernel/nsproxy.c
>> +++ b/kernel/nsproxy.c
>> @@ -255,6 +255,24 @@ void exit_task_namespaces(struct task_struct *p)
>>  	switch_task_namespaces(p, NULL);
>>  }
>> 
>> +int exec_task_namespaces(void)
>> +{
>> +	struct task_struct *tsk = current;
>> +	struct nsproxy *new;
>> +
>> +	if (tsk->nsproxy->time_ns_for_children == tsk->nsproxy->time_ns)
>> +		return 0;
>> +
>> +	new = create_new_namespaces(0, tsk, current_user_ns(), tsk->fs);
>> +	if (IS_ERR(new))
>> +		return PTR_ERR(new);
>> +
>> +	timens_on_fork(new, tsk);
>> +	switch_task_namespaces(tsk, new);
>> +	return 0;
>> +}
>> +
>> +
>>  static int check_setns_flags(unsigned long flags)
>>  {
>>  	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
>> 
>> 
>> 
>> To keep things from being too confusing it probably makes sense to
>> rename the nsproxy variable from time_ns_for_children to
>> time_ns_for_new_mm.  Likewise timens_on_fork can be renamed
>> timens_on_new_mm.
>> 
>> But that would be follow up work.
>> 
>> How does the above change sound to folks?
> 
> It looks good to me.
> 
> Thanks,
> Andrei
