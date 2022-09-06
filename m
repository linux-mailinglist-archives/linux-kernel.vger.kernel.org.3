Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08AC5AF7C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIFWQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIFWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:16:52 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671DCA5C47
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:16:51 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:35868)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oVgsC-00BrgX-OB; Tue, 06 Sep 2022 16:16:48 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:51774 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oVgsB-00583V-EG; Tue, 06 Sep 2022 16:16:48 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
References: <YxAq2jYvGG8QOypu@gmail.com>
        <87czcfhsme.fsf@email.froward.int.ebiederm.org>
        <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
Date:   Tue, 06 Sep 2022 17:16:05 -0500
In-Reply-To: <bdff6cf478fc29c80997a623a57dae5f@ispras.ru> (Alexey Izbyshev's
        message of "Fri, 02 Sep 2022 20:01:57 +0300")
Message-ID: <874jxkcfoa.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oVgsB-00583V-EG;;;mid=<874jxkcfoa.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Nhbm522ql4LNDdPuh6w4oteZznpAcMWg=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alexey Izbyshev <izbyshev@ispras.ru>
X-Spam-Relay-Country: 
X-Spam-Timing: total 761 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.18
        (0.2%), extract_message_metadata: 19 (2.5%), get_uri_detail_list: 4.8
        (0.6%), tests_pri_-1000: 14 (1.8%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.12 (0.1%), tests_pri_-90: 87 (11.4%), check_bayes:
        84 (11.1%), b_tokenize: 15 (2.0%), b_tok_get_all: 15 (2.0%),
        b_comp_prob: 4.3 (0.6%), b_tok_touch_all: 46 (6.0%), b_finish: 0.91
        (0.1%), tests_pri_0: 612 (80.5%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.98 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Izbyshev <izbyshev@ispras.ru> writes:

> On 2022-09-01 21:11, Eric W. Biederman wrote:
>> Andrei Vagin <avagin@gmail.com> writes:
>> 
>>> On Tue, Aug 30, 2022 at 6:18 PM Andrei Vagin <avagin@gmail.com> wrote:
>>>> On Tue, Aug 30, 2022 at 10:49:43PM +0300, Alexey Izbyshev wrote:
>>> <snip>
>>>>> @@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
>>>>>         tsk->mm->vmacache_seqnum = 0;
>>>>>         vmacache_flush(tsk);
>>>>>         task_unlock(tsk);
>>>>> +
>>>>> +       if (vfork)
>>>>> +               timens_on_fork(tsk->nsproxy, tsk);
>>>>> +
>>>>> Similarly, even after a normal vfork(), time namespace switch could 
>>>>> be
>>>>> silently skipped if the parent dies before "tsk->vfork_done" is
>>>>> read. Again,
>>>>> I don't know whether anybody cares, but this behavior seems non-obvious and
>>>>> probably unintended to me.
>>>> This is the more interesting case. I will try to find out how we can
>>>> handle it properly.
>>> It might not be a good idea to use vfork_done in this case. Let's
>>> think about what we have and what we want to change. We don't want to
>>> allow switching timens if a process mm is used by someone else. But we
>>> forgot to handle execve that creates a new mm, and we can't change this
>>> behavior right now because it can affect current users. Right?
>> What we can't changes are things that will break existing programs.  If
>> existing programs don't care we can change the behavior of the kernel.
>> 
>>> So maybe the best choice, in this case, is to change behavior by adding
>>> a new control that enables it. The first interface that comes to my mind
>>> is to introduce a new ioctl for a namespace file descriptor. Here is a
>>> draft patch below that should help to understand what I mean.
>> I don't think adding a new control works, because programs that are
>> calling vfork or posix_spawn today will stop working.
>> We should recognize that basing things off of CLONE_VFORK was a bad 
>> idea
>> as CLONE_VFORK is all about waiting for the created task to exec or
>> exit, and really has nothing to do with creating a new mm.
>> Instead I think the rule should be that a new time namespaces is
>> installed as soon as we have a new mm.
>> That will be a behavioral change if the time ns is unshared and then 
>> the
>> program exec's instead of forking children, but I suspect it is the
>> proper behavior all the same, and that existing userspace won't care.
>> Especially since all of the vfork_done work is new behavior as
>> of v6.0-rc1.
>> 
> While vfork_done work is indeed new, preservation of time_ns_for_children on
> execve() instead of switching to it is how time namespaces were originally
> implemented in 5.6. If this can be changed even now, thereby fixing the original
> design, that's great, I just want to point out that it's not the recent 6.0 work
> that is being fixed. Fixes/clarifications for man pages[1][2], which talk about
> "subsequently created children", will also be needed.
>
> [1] https://man7.org/linux/man-pages/man7/time_namespaces.7.html
> [2] https://man7.org/linux/man-pages/man2/unshare.2.html

Sorry, yes.

That is something to be double checked.

I can't see where it would make sense to unshare a time namespace and
then call exec, instead of calling exit.  So I suspect we can just
change this behavior and no one will notice. 

>> Ugh.  I just spotted another bug.  The function timens_on_fork as
>> written is not safe to call without first creating a fresh copy
>> of the nsproxy, and we don't do that during exec.  Because nsproxy
>> is shared between tasks and processes updating the values needs to
>> create a new nsproxy or other tasks/processes can be affected.
>> Not hard to handle just something that needs to be addressed.
>> Say something like this:
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
>>  	/* Notify parent that we're no longer interested in the old VM */
>>  	tsk = current;
>> -	vfork = !!tsk->vfork_done;
>>  	old_mm = current->mm;
>>  	exec_mm_release(tsk, old_mm);
>>  	if (old_mm)
>> @@ -1030,9 +1028,6 @@ static int exec_mmap(struct mm_struct *mm)
>>  	vmacache_flush(tsk);
>>  	task_unlock(tsk);
>> -	if (vfork)
>> -		timens_on_fork(tsk->nsproxy, tsk);
>> -
>>  	if (old_mm) {
>>  		mmap_read_unlock(old_mm);
>>  		BUG_ON(active_mm != old_mm);
>> @@ -1303,6 +1298,10 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  	bprm->mm = NULL;
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
>> @@ -94,6 +94,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
>>  int copy_namespaces(unsigned long flags, struct task_struct *tsk);
>>  void exit_task_namespaces(struct task_struct *tsk);
>>  void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
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
>> -	/*
>> -	 * If the new process will be in a different time namespace
>> -	 * do not allow it to share VM or a thread group with the forking task.
>> -	 *
>> -	 * On vfork, the child process enters the target time namespace only
>> -	 * after exec.
>> -	 */
>> -	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
>> -		if (nsp->time_ns != nsp->time_ns_for_children)
>> -			return ERR_PTR(-EINVAL);
>> -	}
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
>> To keep things from being too confusing it probably makes sense to
>> rename the nsproxy variable from time_ns_for_children to
>> time_ns_for_new_mm.  Likewise timens_on_fork can be renamed
>> timens_on_new_mm.
>> 
> Do you imply renaming "/proc/[pid]/ns/time_for_children" as well, or will it be
> preserved for compatibility?

Unfortunately I don't think we can change that one.  We could add
another better named one, update the tools to use it.  Then wait a
couple of millenia and remove the current name.  Depending it might be
worth it, but only if you have a lot of patience.

We should get the implementation details sorted out first, and the
in-kernel name before touching the proc files.

Eric
