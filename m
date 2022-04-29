Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9154F515395
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379991AbiD2SZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379993AbiD2SZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:25:45 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8533D3716
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:22:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q12so7084314pgj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lqDxjXKGozL4JLJA55lbL4O+gqsTyufg1RUYSCEYXqk=;
        b=BGOiyxCZSMxAEyazPfI9DdXqgYukw98A9ZM4PRq0UYaSqweX5mgd5hWhstCt4s8iSp
         mSjaEhTH0AHvtkZq2mTLlyWRSO60Ge0eielBZg83IgVwATBsQ2t+gEAPLfL7lHAo+3qK
         pL7UDfR7dxORQ9EUt3Xje22xG5K8rzrqmd5Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lqDxjXKGozL4JLJA55lbL4O+gqsTyufg1RUYSCEYXqk=;
        b=AWvTbx1L+xoQWZPmzwv0+Kuvmul54ghsNoRY5VVSz8VyJU9HS1wwAMZXkU3e4GVB5M
         4bwQBviNOw8yiZA7ig29fWMtDG+GuyU0RVNB+xEHkei3g7dKazMhyERulENyrqKRyGoS
         Lb6bucxfUSDvj03/BVbXN/VZiixWkaN7Oq7f34Oy9/e7NpE0BrRwV4qNp5HvMtvJnfVZ
         OgG2y47j+Wn4amjuhXj6NNXfC8FVOwZfwN4Rzz8B7FV2VKtYsGXAmYfMs3nU/3eYxGV9
         ifPSqAMFfwCkhtueuxFHx1vECj9+Lf8XfAMXD3IKDZ2kX78yNoWcBTql8p8hn2ZH/ok/
         63pg==
X-Gm-Message-State: AOAM530BFg3KZSVO2IqKREIcPpY9MlnAT0o6VC4rrfIYbvXMpi+cR/vV
        AzNpLpH62tfZeOxmFTymjhwKxg==
X-Google-Smtp-Source: ABdhPJzyJlr+/qx4aXaKcnCljd3Kbxb+jvsroeuC4z5n24+K4Yf05Weru2LwiGmGDYpqKwwxr6HgRQ==
X-Received: by 2002:a63:4384:0:b0:3ab:9d95:a30a with SMTP id q126-20020a634384000000b003ab9d95a30amr535803pga.68.1651256545095;
        Fri, 29 Apr 2022 11:22:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e9-20020a635449000000b003c14af505edsm4040598pgm.5.2022.04.29.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 11:22:24 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:22:23 -0700
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
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
Message-ID: <202204291120.79624BD@keescook>
References: <20220429023113.74993-1-sargun@sargun.me>
 <20220429023113.74993-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429023113.74993-2-sargun@sargun.me>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 07:31:12PM -0700, Sargun Dhillon wrote:
> This introduces a per-filter flag (SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
> that makes it so that when notifications are received by the supervisor
> the notifying process will transition to wait killable semantics. Although
> wait killable isn't a set of semantics formally exposed to userspace,
> the concept is searchable. If the notifying process is signaled prior
> to the notification being received by the userspace agent, it will
> be handled as normal.
> 
> One quirk about how this is handled is that the notifying process
> only switches to TASK_KILLABLE if it receives a wakeup from either
> an addfd or a signal. This is to avoid an unnecessary wakeup of
> the notifying task.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  .../userspace-api/seccomp_filter.rst          |  8 ++++
>  include/linux/seccomp.h                       |  3 +-
>  include/uapi/linux/seccomp.h                  |  2 +
>  kernel/seccomp.c                              | 42 ++++++++++++++++++-
>  4 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> index 539e9d4a4860..204cf5ba511a 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -271,6 +271,14 @@ notifying process it will be replaced. The supervisor can also add an FD, and
>  respond atomically by using the ``SECCOMP_ADDFD_FLAG_SEND`` flag and the return
>  value will be the injected file descriptor number.
>  
> +The notifying process can be preempted, resulting in the notification being
> +aborted. This can be problematic when trying to take actions on behalf of the
> +notifying process that are long-running and typically retryable (mounting a
> +filesytem). Alternatively, the at filter installation time, the

typo: "the at" -> "at"

> +``SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV`` flag can be set. This flag makes it
> +such that when a user notification is received by the supervisor, the notifying
> +process will ignore non-fatal signals until the response is sent.
> +
>  It is worth noting that ``struct seccomp_data`` contains the values of register
>  arguments to the syscall, but does not contain pointers to memory. The task's
>  memory is accessible to suitably privileged traces via ``ptrace()`` or
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 0c564e5d40ff..d31d76be4982 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -8,7 +8,8 @@
>  					 SECCOMP_FILTER_FLAG_LOG | \
>  					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
>  					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
> -					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH)
> +					 SECCOMP_FILTER_FLAG_TSYNC_ESRCH | \
> +					 SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
>  
>  /* sizeof() the first published struct seccomp_notif_addfd */
>  #define SECCOMP_NOTIFY_ADDFD_SIZE_VER0 24
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 78074254ab98..0fdc6ef02b94 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -23,6 +23,8 @@
>  #define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
>  #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
>  #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
> +/* Received notifications wait in killable state (only respond to fatal signals) */
> +#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
>  
>  /*
>   * All BPF programs must return a 32-bit value.
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index db10e73d06e0..9291b0843cb2 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -201,6 +201,8 @@ static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
>   *	   the filter can be freed.
>   * @cache: cache of arch/syscall mappings to actions
>   * @log: true if all actions except for SECCOMP_RET_ALLOW should be logged
> + * @wait_killable_recv: Put notifying process in killable state once the
> + *			notification is received by the userspace listener.
>   * @prev: points to a previously installed, or inherited, filter
>   * @prog: the BPF program to evaluate
>   * @notif: the struct that holds all notification related information
> @@ -221,6 +223,7 @@ struct seccomp_filter {
>  	refcount_t refs;
>  	refcount_t users;
>  	bool log;
> +	bool wait_killable_recv;
>  	struct action_cache cache;
>  	struct seccomp_filter *prev;
>  	struct bpf_prog *prog;
> @@ -894,6 +897,10 @@ static long seccomp_attach_filter(unsigned int flags,
>  	if (flags & SECCOMP_FILTER_FLAG_LOG)
>  		filter->log = true;
>  
> +	/* Set wait killable flag, if present. */
> +	if (flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
> +		filter->wait_killable_recv = true;
> +
>  	/*
>  	 * If there is an existing filter, make it the prev and don't drop its
>  	 * task reference.
> @@ -1081,6 +1088,12 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
>  	complete(&addfd->completion);
>  }
>  
> +static bool should_sleep_killable(struct seccomp_filter *match,
> +				  struct seccomp_knotif *n)
> +{
> +	return match->wait_killable_recv && n->state == SECCOMP_NOTIFY_SENT;
> +}
> +
>  static int seccomp_do_user_notification(int this_syscall,
>  					struct seccomp_filter *match,
>  					const struct seccomp_data *sd)
> @@ -1111,11 +1124,25 @@ static int seccomp_do_user_notification(int this_syscall,
>  	 * This is where we wait for a reply from userspace.
>  	 */
>  	do {
> +		bool wait_killable = should_sleep_killable(match, &n);
> +
>  		mutex_unlock(&match->notify_lock);
> -		err = wait_for_completion_interruptible(&n.ready);
> +		if (wait_killable)
> +			err = wait_for_completion_killable(&n.ready);
> +		else
> +			err = wait_for_completion_interruptible(&n.ready);
>  		mutex_lock(&match->notify_lock);
> -		if (err != 0)
> +
> +		if (err != 0) {
> +			/*
> +			 * Check to see if the notifcation got picked up and
> +			 * whether we should switch to wait killable.
> +			 */
> +			if (!wait_killable && should_sleep_killable(match, &n))
> +				continue;
> +
>  			goto interrupted;
> +		}
>  
>  		addfd = list_first_entry_or_null(&n.addfd,
>  						 struct seccomp_kaddfd, list);
> @@ -1485,6 +1512,9 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  		mutex_lock(&filter->notify_lock);
>  		knotif = find_notification(filter, unotif.id);
>  		if (knotif) {
> +			/* Reset the process to make sure it's not stuck */
> +			if (should_sleep_killable(filter, knotif))
> +				complete(&knotif->ready);
>  			knotif->state = SECCOMP_NOTIFY_INIT;
>  			up(&filter->notif->request);
>  		}
> @@ -1830,6 +1860,14 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	    ((flags & SECCOMP_FILTER_FLAG_TSYNC_ESRCH) == 0))
>  		return -EINVAL;
>  
> +	/*
> +	 * The SECCOMP_FILTER_FLAG_WAIT_KILLABLE_SENT flag doesn't make sense
> +	 * without the SECCOMP_FILTER_FLAG_NEW_LISTENER flag.
> +	 */
> +	if ((flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV) &&
> +	    ((flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) == 0))
> +		return -EINVAL;
> +
>  	/* Prepare the new filter before holding any locks. */
>  	prepared = seccomp_prepare_user_filter(filter);
>  	if (IS_ERR(prepared))

Otherwise, looks good. Thanks for bringing this back up!

-- 
Kees Cook
