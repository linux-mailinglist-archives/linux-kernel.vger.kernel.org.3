Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867635A9C2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiIAPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiIAPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:49:49 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B03D8C03F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:49:43 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 33C9C40737AF;
        Thu,  1 Sep 2022 15:49:39 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 01 Sep 2022 18:49:39 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
In-Reply-To: <YxAq2jYvGG8QOypu@gmail.com>
References: <YxAq2jYvGG8QOypu@gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <fed91ee96b861aaf8db3d72c1b7eb135@ispras.ru>
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

On 2022-09-01 06:45, Andrei Vagin wrote:
> On Tue, Aug 30, 2022 at 6:18 PM Andrei Vagin <avagin@gmail.com> wrote:
>> On Tue, Aug 30, 2022 at 10:49:43PM +0300, Alexey Izbyshev wrote:
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
>>> Similarly, even after a normal vfork(), time namespace switch could 
>>> be
>>> silently skipped if the parent dies before "tsk->vfork_done" is read. 
>>> Again,
>>> I don't know whether anybody cares, but this behavior seems 
>>> non-obvious and
>>> probably unintended to me.
>> This is the more interesting case. I will try to find out how we can
>> handle it properly.
> 
> It might not be a good idea to use vfork_done in this case. Let's
> think about what we have and what we want to change. We don't want to
> allow switching timens if a process mm is used by someone else. But we
> forgot to handle execve that creates a new mm, and we can't change this
> behavior right now because it can affect current users. Right?
> 
> So maybe the best choice, in this case, is to change behavior by adding
> a new control that enables it. The first interface that comes to my 
> mind
> is to introduce a new ioctl for a namespace file descriptor. Here is a
> draft patch below that should help to understand what I mean.
> 
While I'm not a user of time namespaces (at least yet), I welcome a 
change that makes time namespace switching and inheritance semantics 
easier to understand and document. Here is my understanding of how that 
evolved.

Before the original patch that allowed vfork():

* Switching happens only on clone(~CLONE_VM).
* clone(CLONE_VM) is forbidden after unshare(CLONE_NEWTIME) (thereby 
vfork() and pthread_create() fail).
* time_ns/time_ns_for_children is preserved across execve().

After that patch:

* Switching happens on clone(~CLONE_VM).
* Switching also happens on execve() if the current task is a 
vfork-child whose creator task is still alive (because of reliance on 
"vfork_done").
* clone(CLONE_VM) is forbidden after unshare(CLONE_NEWTIME) unless it's 
clone(CLONE_VM|CLONE_VFORK), in which case time_ns/time_ns_for_children 
is inherited.
* time_ns/time_ns_for_children is preserved across execve() unless 
switched as described above.

Note that switching conditions on execve() are very subtle. Apart from 
the motivating use case of "unshare(CLONE_NEWTIME) -> vfork() -> 
execve()", it would also happen on e.g. "vfork() -> 
unshare(CLONE_NEWTIME) -> execve()", because unshare(CLONE_NEWTIME) is 
not forbidden for tasks which share mm.

With the current patch:

* Switching happens on clone(~CLONE_VM).
* Switching also happens on execve() if ioctl(TIMENS_SET_SWITCH_ON_EXEC) 
was called on time_ns_for_children.
* clone(CLONE_VM) is forbidden after unshare(CLONE_NEWTIME) unless it's 
clone(CLONE_VM|CLONE_VFORK) without CLONE_THREAD, in which case 
time_ns/time_ns_for_children is inherited. Thereby vfork() is permitted, 
while pthread_create() is not.
* time_ns/time_ns_for_children is preserved across execve() unless 
switched as described above.

So in terms of cognitive complexity it seems like a clear improvement 
that regains some of the simplicity of the initial implementation.

However, I'd like to point out that while for a narrow fix of the 
original issue (vfork() doesn't work when fork() does) time ns switching 
on execve() is not required at all, removing "automatic" switching in 
posix_spawn()-like cases could potentially surprise time namespace 
users. In the initial time ns implementation, "unshare(CLONE_NEWTIME); 
posix_spawn(...)" would either succeed with the expected effect (an 
executable is running in a new time ns) or fail, depending on whether 
posix_spawn() uses fork() or vfork(). With the first patch, vfork-based 
posix_spawn() would *usually* behave as a fork-based one (modulo the 
parent death issue). But with the current patch, unless user space is 
modified to set switch_on_exec, vfork-based posix_spawn() will succeed 
but the exe will be running in the parent's time ns. I'm not in a 
position to estimate whether any actual time ns users are affected, 
though it still looks like something that could affect *future* time ns 
users that are not careful enough.

Regarding the interface to control switching on execve(), one possible 
alternative to ioctl() is a separate file in /proc like 
/proc/$PID/setgroups that was added in a somewhat similar situation 
(fixing a problem with user namespaces implementation). Regardless of 
the interface, it'd probably be nice to also have the ability to get the 
current value of switch_on_exec flag.

Thanks,
Alexey

> ---
>  fs/exec.c                                   |  4 +---
>  fs/nsfs.c                                   |  3 +++
>  include/linux/proc_ns.h                     |  1 +
>  include/linux/time_namespace.h              |  1 +
>  include/uapi/linux/nsfs.h                   |  2 ++
>  kernel/fork.c                               |  3 ++-
>  kernel/time/namespace.c                     | 15 +++++++++++++++
>  tools/testing/selftests/timens/vfork_exec.c | 14 +++++++++++++-
>  8 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 9a5ca7b82bfc..961348084257 100644
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
> @@ -1030,7 +1028,7 @@ static int exec_mmap(struct mm_struct *mm)
>  	vmacache_flush(tsk);
>  	task_unlock(tsk);
> 
> -	if (vfork)
> +	if (READ_ONCE(tsk->nsproxy->time_ns_for_children->switch_on_exec))
>  		timens_on_fork(tsk->nsproxy, tsk);
> 
>  	if (old_mm) {
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 800c1d0eb0d0..723ab5f69bcd 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/user_namespace.h>
>  #include <linux/nsfs.h>
>  #include <linux/uaccess.h>
> +#include <linux/nsfs.h>
> 
>  #include "internal.h"
> 
> @@ -210,6 +211,8 @@ static long ns_ioctl(struct file *filp, unsigned 
> int ioctl,
>  		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
>  		return put_user(uid, argp);
>  	default:
> +		if (ns->ops->ioctl)
> +			return ns->ops->ioctl(ns, ioctl,  arg);
>  		return -ENOTTY;
>  	}
>  }
> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
> index 75807ecef880..b690eb1a3468 100644
> --- a/include/linux/proc_ns.h
> +++ b/include/linux/proc_ns.h
> @@ -22,6 +22,7 @@ struct proc_ns_operations {
>  	int (*install)(struct nsset *nsset, struct ns_common *ns);
>  	struct user_namespace *(*owner)(struct ns_common *ns);
>  	struct ns_common *(*get_parent)(struct ns_common *ns);
> +	long (*ioctl)(struct ns_common *ns, unsigned int ioctl, unsigned long 
> arg);
>  } __randomize_layout;
> 
>  extern const struct proc_ns_operations netns_operations;
> diff --git a/include/linux/time_namespace.h 
> b/include/linux/time_namespace.h
> index 3146f1c056c9..6569300d68ce 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -24,6 +24,7 @@ struct time_namespace {
>  	struct page		*vvar_page;
>  	/* If set prevents changing offsets after any task joined namespace. 
> */
>  	bool			frozen_offsets;
> +	bool			switch_on_exec;
>  } __randomize_layout;
> 
>  extern struct time_namespace init_time_ns;
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index a0c8552b64ee..ce3a9f9b1bcf 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -16,4 +16,6 @@
>  /* Get owner UID (in the caller's user namespace) for a user namespace 
> */
>  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> 
> +#define TIMENS_SET_SWITCH_ON_EXEC _IO(NSIO, 0x100)
> +
>  #endif /* __LINUX_NSFS_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 90c85b17bf69..1f7bf2a087e9 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2050,7 +2050,8 @@ static __latent_entropy struct task_struct 
> *copy_process(
>  	 * On vfork, the child process enters the target time namespace only
>  	 * after exec.
>  	 */
> -	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
> +	if ((clone_flags & CLONE_THREAD) ||
> +	    (clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM) {
>  		if (nsp->time_ns != nsp->time_ns_for_children)
>  			return ERR_PTR(-EINVAL);
>  	}
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index aec832801c26..9966e0bdefa7 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -17,6 +17,7 @@
>  #include <linux/cred.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
> +#include <linux/nsfs.h>
> 
>  #include <vdso/datapage.h>
> 
> @@ -439,6 +440,18 @@ int proc_timens_set_offset(struct file *file,
> struct task_struct *p,
>  	return err;
>  }
> 
> +static long timens_ioctl(struct ns_common *ns, unsigned int ioctl,
> unsigned long arg)
> +{
> +	struct time_namespace *time_ns = to_time_ns(ns);
> +
> +	switch (ioctl) {
> +	case TIMENS_SET_SWITCH_ON_EXEC:
> +		WRITE_ONCE(time_ns->switch_on_exec, true);
> +		return 0;
> +	}
> +	return -ENOTTY;
> +}
> +
>  const struct proc_ns_operations timens_operations = {
>  	.name		= "time",
>  	.type		= CLONE_NEWTIME,
> @@ -446,6 +459,7 @@ const struct proc_ns_operations timens_operations = 
> {
>  	.put		= timens_put,
>  	.install	= timens_install,
>  	.owner		= timens_owner,
> +	.ioctl		= timens_ioctl,
>  };
> 
>  const struct proc_ns_operations timens_for_children_operations = {
> @@ -456,6 +470,7 @@ const struct proc_ns_operations
> timens_for_children_operations = {
>  	.put		= timens_put,
>  	.install	= timens_install,
>  	.owner		= timens_owner,
> +	.ioctl		= timens_ioctl,
>  };
> 
>  struct time_namespace init_time_ns = {
> diff --git a/tools/testing/selftests/timens/vfork_exec.c
> b/tools/testing/selftests/timens/vfork_exec.c
> index e6ccd900f30a..5f4e2043e0a7 100644
> --- a/tools/testing/selftests/timens/vfork_exec.c
> +++ b/tools/testing/selftests/timens/vfork_exec.c
> @@ -12,6 +12,11 @@
>  #include <time.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <linux/nsfs.h>
> +
> +#define TIMENS_SET_SWITCH_ON_EXEC _IO(NSIO, 0x100)
> 
>  #include "log.h"
>  #include "timens.h"
> @@ -21,7 +26,7 @@
>  int main(int argc, char *argv[])
>  {
>  	struct timespec now, tst;
> -	int status, i;
> +	int status, i, nsfd;
>  	pid_t pid;
> 
>  	if (argc > 1) {
> @@ -45,6 +50,13 @@ int main(int argc, char *argv[])
>  	if (unshare_timens())
>  		return 1;
> 
> +	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
> +	if (nsfd < 0)
> +		return pr_perror("open");
> +	if (ioctl(nsfd, TIMENS_SET_SWITCH_ON_EXEC))
> +		return pr_perror("ioctl");
> +	close(nsfd);
> +
>  	if (_settime(CLOCK_MONOTONIC, OFFSET))
>  		return 1;
