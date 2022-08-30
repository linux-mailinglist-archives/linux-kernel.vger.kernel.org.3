Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30055A60F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiH3KnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH3KnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:43:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167C69D67C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A96ABB80CAE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583BCC433D6;
        Tue, 30 Aug 2022 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661856197;
        bh=wvAdUIVY6hpe6fxiLXRb5WZPqoIyoTMJowVmefpw9CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McMIIDcgLYN3k22HdqQ3210A/ulerlkFQhCrVFmDSyE/WcBk3769O3xcOKnw8gOMO
         pWbUCX9OCYVZPPmem/QAoTryICIGspw5oFtbMa180FB4cDwo3SZ/L+cC13azdmHeYk
         mgujziJbokqxWfwhpEuCQoT4sEt7K95/81LB7/yJTetrbRB+/T1tF51cCRDWdul5b6
         khxWvNhb+xlzmkJ+QhYWspRpzWPe7ejvkg8DqjJZHUniO8vnEArus1AML6hApz3vLZ
         pg2pFZLn2xEiR8iyKg50C/zECmTDbrrwzOi7a7mFEKa2c4o231Mb5l1GjZRwptpvGX
         t5RdzFRVtJBFg==
Date:   Tue, 30 Aug 2022 12:43:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 4/4] seccomp: add the synchronous mode for seccomp_unotify
Message-ID: <20220830104310.cpacj4dxqpgucwh3@wittgenstein>
References: <20220830014356.5364-1-avagin@gmail.com>
 <20220830014356.5364-5-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830014356.5364-5-avagin@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:43:56PM -0700, Andrei Vagin wrote:
> seccomp_unotify allows more privileged processes does actions on behalf
> of less privileged processes.
> 
> In many cases, the workflow is fully synchronous. It means a target
> process triggers a system call and passes controls to a supervisor
> process that handles the system call and returns controls to the target
> process. In this context, "synchronous" means that only one process is
> running and another one is waiting.
> 
> There is the WF_CURRENT_CPU flag that is used to advise the scheduler to
> move the wakee to the current CPU. For such synchronous workflows, it
> makes context switches a few times faster.
> 
> Right now, each interaction takes 12µs. With this patch, it takes about
> 3µs.

Seems like a nice idea though I leave it to the sched people to judge
whether this is sane or not. So the supervisor which gets woken will be
moved to the current cpu in this synchronous scenario.

I have no strong opinions on this patch. There are two things I wonder
about. First, how meaningful is that speed up given that the supervisor
will most often do a lot of heavy-handed things anyway.

Second, this flag is a very specific thing and I wonder how much
userspace will really use this and what's more use this correctly.

Just to note that LXD - one of the biggest user of this feature - isn't
synchronous iiuc for example. Each container gets a separate seccomp
supervisor thread (well, go routine but whatever) which exposes a socket
that the container manager connects to and sends the seccomp
notifications it received from its payload according to an api we
established. And each notification is handled in a separate thread
(again, go routine but whatever).

> 
> This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
> it used to enable the sync mode.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  include/uapi/linux/seccomp.h |  4 ++++
>  kernel/seccomp.c             | 35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 0fdc6ef02b94..dbfc9b37fcae 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -115,6 +115,8 @@ struct seccomp_notif_resp {
>  	__u32 flags;
>  };
>  
> +#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
> +
>  /* valid flags for seccomp_notif_addfd */
>  #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
>  #define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
> @@ -150,4 +152,6 @@ struct seccomp_notif_addfd {
>  #define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3, \
>  						struct seccomp_notif_addfd)
>  
> +#define SECCOMP_IOCTL_NOTIF_SET_FLAGS	SECCOMP_IOW(4, __u64)
> +
>  #endif /* _UAPI_LINUX_SECCOMP_H */
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 667fd2d89464..c24900eb8ced 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -143,11 +143,14 @@ struct seccomp_kaddfd {
>   *           filter->notify_lock.
>   * @next_id: The id of the next request.
>   * @notifications: A list of struct seccomp_knotif elements.
> + * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
>   */
> +
>  struct notification {
>  	atomic_t requests;
>  	u64 next_id;
>  	struct list_head notifications;
> +	int flags;
>  };
>  
>  #ifdef SECCOMP_ARCH_NATIVE
> @@ -1117,7 +1120,10 @@ static int seccomp_do_user_notification(int this_syscall,
>  	INIT_LIST_HEAD(&n.addfd);
>  
>  	atomic_add(1, &match->notif->requests);
> -	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> +	if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> +		wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLRDNORM);
> +	else
> +		wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);

(We're accumulating a lot of conditional wake primitives in the notifier.)

>  
>  	/*
>  	 * This is where we wait for a reply from userspace.
> @@ -1574,7 +1580,10 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
>  	knotif->error = resp.error;
>  	knotif->val = resp.val;
>  	knotif->flags = resp.flags;
> -	complete(&knotif->ready);
> +	if (filter->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> +		complete_on_current_cpu(&knotif->ready);
> +	else
> +		complete(&knotif->ready);
>  out:
>  	mutex_unlock(&filter->notify_lock);
>  	return ret;
> @@ -1604,6 +1613,26 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
>  	return ret;
>  }
>  
> +static long seccomp_notify_set_flags(struct seccomp_filter *filter,
> +				    void __user *buf)
> +{
> +	u64 flags;
> +	long ret;
> +
> +	if (copy_from_user(&flags, buf, sizeof(flags)))
> +		return -EFAULT;
> +
> +	if (flags & ~SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> +		return -EINVAL;
> +
> +	ret = mutex_lock_interruptible(&filter->notify_lock);
> +	if (ret < 0)
> +		return ret;
> +	filter->notif->flags = flags;

Might be better to just keep the uapi type and the in-kernel type in sync.

> +	mutex_unlock(&filter->notify_lock);
> +	return ret;
> +}
> +
>  static long seccomp_notify_addfd(struct seccomp_filter *filter,
>  				 struct seccomp_notif_addfd __user *uaddfd,
>  				 unsigned int size)
> @@ -1733,6 +1762,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
>  	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
>  	case SECCOMP_IOCTL_NOTIF_ID_VALID:
>  		return seccomp_notify_id_valid(filter, buf);
> +	case SECCOMP_IOCTL_NOTIF_SET_FLAGS:
> +		return seccomp_notify_set_flags(filter, buf);
>  	}
>  
>  	/* Extensible Argument ioctls */
> -- 
> 2.37.2
> 
> 
