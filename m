Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF85AB65E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiIBQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiIBQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:17:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE292ED60
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:14:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x23so2315785pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/0xsXE0EPSbpRJFOjxUijygEX9+RjUSgoLGhdmwtU+4=;
        b=o+fYtvokvsIUyCNZ1p2KsaYz5WsCP3l5mewDISga8KvXjaseUFSke/OGxVmW1JCII4
         NSbF0RaygGHFHe4CdZTAgXWl/gEXcmSO2hJDVsymNvW+78VIiYFUwJuXARUCOMzwAQ52
         AAwo6Z2RrLYnQGwDrfsYVx5S8Um09sGNvNyLoJzAqiWBx5pP3bVy4aFKFVKP88w2Hy70
         lSp87N2kMlKAr9UuyCU9L4NMNG90XvYpkEMO4ozCDYw/dZ1XfEt/eGF9e24FfnZAJ9dE
         cONkT1Sxsb3fhRz1JEeeaeT6lVGv/DT1IG55kdR9X/Y9f0OVU1UXrnGeOTYzfiR20EoB
         HdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/0xsXE0EPSbpRJFOjxUijygEX9+RjUSgoLGhdmwtU+4=;
        b=Po5gNz+27Et1i+VEFamBotNBjd398/Nqc3pUYy/8GGigg3JVAQA9yixpk5T9PZAuez
         RO0ZsFLjUv8493ZcdJXhcB6CU+l5OHH3jGJf0RMYfz+d2TU/egzA2jyWPGnkAIqWzW8V
         PDN8oZ0rce+P6jC7bgJ0FbndgYIten0jS4VuKrtOTh0ND4vkU7kUu8xnQOTFGg5vodBH
         WMpbJzL1O9rOewZsrT1tzdAXgD5pCU+PTLJ6hw/DSj2oFSdNQuMnfPbOO1B+fA0Ylcb0
         1YoQ/WB0DJ26DbQRjw24vr3/GokVVHZ5oc2TJCzqTftqQwxRGbqvjT7fKdjHfnDERQwK
         MEqQ==
X-Gm-Message-State: ACgBeo05PqIOp6P/5/Cl9PZlAP+/NCjvx/iTngjlZMmlkVs4TgTVk3Ev
        CqBI+CviQK4NBlVQ0GWIdAE=
X-Google-Smtp-Source: AA6agR7SVYSKjW75WNmK2Ps4QYq2NyFZO/PpGvoO49yKoZ/B80DZxmMoz5ol9kqgO2RNzhJFAKQV1g==
X-Received: by 2002:a17:90b:3b8d:b0:1fe:1fbe:b043 with SMTP id pc13-20020a17090b3b8d00b001fe1fbeb043mr5778608pjb.63.1662135257954;
        Fri, 02 Sep 2022 09:14:17 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm1644343pjb.4.2022.09.02.09.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:14:17 -0700 (PDT)
Date:   Fri, 2 Sep 2022 09:14:15 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Alexey Izbyshev <izbyshev@ispras.ru>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <YxIr15QTmYb4Uojq@gmail.com>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87czcfhsme.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:11:37PM -0500, Eric W. Biederman wrote:
> Andrei Vagin <avagin@gmail.com> writes:
> 
> > On Tue, Aug 30, 2022 at 6:18 PM Andrei Vagin <avagin@gmail.com> wrote:
> >>On Tue, Aug 30, 2022 at 10:49:43PM +0300, Alexey Izbyshev wrote:
> > <snip>
> >>> @@ -1030,6 +1033,10 @@ static int exec_mmap(struct mm_struct *mm)
> >>>         tsk->mm->vmacache_seqnum = 0;
> >>>         vmacache_flush(tsk);
> >>>         task_unlock(tsk);
> >>> +
> >>> +       if (vfork)
> >>> +               timens_on_fork(tsk->nsproxy, tsk);
> >>> +
> >>> 
> >>> Similarly, even after a normal vfork(), time namespace switch could be
> >>> silently skipped if the parent dies before "tsk->vfork_done" is read. Again,
> >>> I don't know whether anybody cares, but this behavior seems non-obvious and
> >>> probably unintended to me.
> >> This is the more interesting case. I will try to find out how we can
> >> handle it properly.
> >
> > It might not be a good idea to use vfork_done in this case. Let's
> > think about what we have and what we want to change. We don't want to
> > allow switching timens if a process mm is used by someone else. But we
> > forgot to handle execve that creates a new mm, and we can't change this
> > behavior right now because it can affect current users. Right?
> 
> What we can't changes are things that will break existing programs.  If
> existing programs don't care we can change the behavior of the kernel.

I agree that it is very unlikely that anyone will notice
these changes. And it is hard to imagine that anyone uses the old
behavior intentionally.

> 
> > So maybe the best choice, in this case, is to change behavior by adding
> > a new control that enables it. The first interface that comes to my mind
> > is to introduce a new ioctl for a namespace file descriptor. Here is a
> > draft patch below that should help to understand what I mean.
> 
> I don't think adding a new control works, because programs that are
> calling vfork or posix_spawn today will stop working.
> 
> We should recognize that basing things off of CLONE_VFORK was a bad idea
> as CLONE_VFORK is all about waiting for the created task to exec or
> exit, and really has nothing to do with creating a new mm.
> 
> Instead I think the rule should be that a new time namespaces is
> installed as soon as we have a new mm.
> 
> That will be a behavioral change if the time ns is unshared and then the
> program exec's instead of forking children, but I suspect it is the
> proper behavior all the same, and that existing userspace won't care.
> Especially since all of the vfork_done work is new behavior as
> of v6.0-rc1.
> 
> Ugh.  I just spotted another bug.  The function timens_on_fork as
> written is not safe to call without first creating a fresh copy
> of the nsproxy, and we don't do that during exec.  Because nsproxy
> is shared between tasks and processes updating the values needs to
> create a new nsproxy or other tasks/processes can be affected.
> Not hard to handle just something that needs to be addressed.

You are right. Thanks.

> 
> Say something like this:
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9a5ca7b82bfc..8a6947e631dd 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -979,12 +979,10 @@ static int exec_mmap(struct mm_struct *mm)
>  {
>  	struct task_struct *tsk;
>  	struct mm_struct *old_mm, *active_mm;
> -	bool vfork;
>  	int ret;
>  
>  	/* Notify parent that we're no longer interested in the old VM */
>  	tsk = current;
> -	vfork = !!tsk->vfork_done;
>  	old_mm = current->mm;
>  	exec_mm_release(tsk, old_mm);
>  	if (old_mm)
> @@ -1030,9 +1028,6 @@ static int exec_mmap(struct mm_struct *mm)
>  	vmacache_flush(tsk);
>  	task_unlock(tsk);
>  
> -	if (vfork)
> -		timens_on_fork(tsk->nsproxy, tsk);
> -
>  	if (old_mm) {
>  		mmap_read_unlock(old_mm);
>  		BUG_ON(active_mm != old_mm);
> @@ -1303,6 +1298,10 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	bprm->mm = NULL;
>  
> +	retval = exec_task_namespaces();
> +	if (retval)
> +		goto out_unlock;
> +
>  #ifdef CONFIG_POSIX_TIMERS
>  	spin_lock_irq(&me->sighand->siglock);
>  	posix_cpu_timers_exit(me);
> diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
> index cdb171efc7cb..fee881cded01 100644
> --- a/include/linux/nsproxy.h
> +++ b/include/linux/nsproxy.h
> @@ -94,6 +94,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
>  int copy_namespaces(unsigned long flags, struct task_struct *tsk);
>  void exit_task_namespaces(struct task_struct *tsk);
>  void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
> +int exec_task_namespaces(void);
>  void free_nsproxy(struct nsproxy *ns);
>  int unshare_nsproxy_namespaces(unsigned long, struct nsproxy **,
>  	struct cred *, struct fs_struct *);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 90c85b17bf69..b4a799d9c50f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2043,18 +2043,6 @@ static __latent_entropy struct task_struct *copy_process(
>  			return ERR_PTR(-EINVAL);
>  	}
>  
> -	/*
> -	 * If the new process will be in a different time namespace
> -	 * do not allow it to share VM or a thread group with the forking task.
> -	 *
> -	 * On vfork, the child process enters the target time namespace only
> -	 * after exec.
> -	 */
> -	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
> -		if (nsp->time_ns != nsp->time_ns_for_children)
> -			return ERR_PTR(-EINVAL);
> -	}

pls don't remove this part. It was one of the concerns that vfork
doesn't work after unshare(CLONE_NEWTIME), but it is one of the standard
ways of creating a new process. For example, posix_spawn uses it.

> -
>  	if (clone_flags & CLONE_PIDFD) {
>  		/*
>  		 * - CLONE_DETACHED is blocked so that we can potentially
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index b4cbb406bc28..b6647846fe42 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -255,6 +255,24 @@ void exit_task_namespaces(struct task_struct *p)
>  	switch_task_namespaces(p, NULL);
>  }
>  
> +int exec_task_namespaces(void)
> +{
> +	struct task_struct *tsk = current;
> +	struct nsproxy *new;
> +
> +	if (tsk->nsproxy->time_ns_for_children == tsk->nsproxy->time_ns)
> +		return 0;
> +
> +	new = create_new_namespaces(0, tsk, current_user_ns(), tsk->fs);
> +	if (IS_ERR(new))
> +		return PTR_ERR(new);
> +
> +	timens_on_fork(new, tsk);
> +	switch_task_namespaces(tsk, new);
> +	return 0;
> +}
> +
> +
>  static int check_setns_flags(unsigned long flags)
>  {
>  	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
> 
> 
> 
> To keep things from being too confusing it probably makes sense to
> rename the nsproxy variable from time_ns_for_children to
> time_ns_for_new_mm.  Likewise timens_on_fork can be renamed
> timens_on_new_mm.
> 
> But that would be follow up work.
> 
> How does the above change sound to folks?

It looks good to me.

Thanks,
Andrei
