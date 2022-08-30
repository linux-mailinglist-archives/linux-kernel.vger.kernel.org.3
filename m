Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9586D5A6007
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiH3KAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiH3J7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F9EEF29
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54A4A613FB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC56C433D6;
        Tue, 30 Aug 2022 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661853475;
        bh=Ssn7cmiIywpsSge5agKX75TgbInRd7Fb0Hu6sZ26Pzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUJJ98KPL+WaRSfrlGLodpL602skq7Xf6wZdUQO5jOk8I1QpYlgFVL++RiRa4/AFm
         clJaZoqo+vwagZltBMRmZXXQriSLG1HejtNlBuVcc9R4KbgROqALoqD3MpUmal2AWj
         /V4pW6ULiTTKWv7MF77/OmoT4tA+QR8Lj9+N3bpeM/rTxnESIXwdTSOhgzjnzIo31w
         QxIAzz47naYK26cQIqEcWqp17GxDGzvLNK3U+xU1qA5h8y1BXoMck4Gj5ZB0dnjs3o
         xsp9qQxD4AXfdatBflbUeloW4cB6PJvBih/v8XJfs1V11BWMEamrnLnOch0IGrqbkb
         HTM0C1zGH5xXA==
Date:   Tue, 30 Aug 2022 11:57:50 +0200
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
Subject: Re: [PATCH 1/4] seccomp: don't use semaphore and wait_queue together
Message-ID: <20220830095750.ljtdk7hekmmzhf2b@wittgenstein>
References: <20220830014356.5364-1-avagin@gmail.com>
 <20220830014356.5364-2-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830014356.5364-2-avagin@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:43:53PM -0700, Andrei Vagin wrote:
> Here is no reason to use two different primitives that do similar things.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---

I dug into the old threads a bit and there was no specific reason given
why we used the sempahore afaict. It was there from the beginning and
the wait queue got added to support polling. Maybe I'm missing why we
need both but it's not obvious to me right now as well. So I tend to
agree that we should get rid of it.

>  kernel/seccomp.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index e9852d1b4a5e..667fd2d89464 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -145,7 +145,7 @@ struct seccomp_kaddfd {
>   * @notifications: A list of struct seccomp_knotif elements.
>   */
>  struct notification {
> -	struct semaphore request;
> +	atomic_t requests;
>  	u64 next_id;
>  	struct list_head notifications;
>  };
> @@ -1116,7 +1116,7 @@ static int seccomp_do_user_notification(int this_syscall,
>  	list_add_tail(&n.list, &match->notif->notifications);
>  	INIT_LIST_HEAD(&n.addfd);
>  
> -	up(&match->notif->request);
> +	atomic_add(1, &match->notif->requests);

atomic_inc()?

>  	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
>  
>  	/*
> @@ -1388,8 +1388,10 @@ static long seccomp_set_mode_strict(void)
>  #ifdef CONFIG_SECCOMP_FILTER
>  static void seccomp_notify_free(struct seccomp_filter *filter)
>  {
> -	kfree(filter->notif);
> -	filter->notif = NULL;
> +	struct notification *notif = filter->notif;
> +
> +	WRITE_ONCE(filter->notif, NULL);
> +	kfree_rcu(notif);
>  }
>  
>  static void seccomp_notify_detach(struct seccomp_filter *filter)
> @@ -1450,6 +1452,16 @@ find_notification(struct seccomp_filter *filter, u64 id)
>  	return NULL;
>  }
>  
> +static bool notify_wakeup(struct seccomp_filter *filter)
> +{
> +	bool ret;
> +
> +	rcu_read_lock();
> +	ret = atomic_add_unless(&filter->notif->requests, -1, 0);

Can you please spell out why the change to wait_event_interruptible()
below that calls notify_wakeup() makes it necessary to rcu protect
->notif?

Given that you're using rcu_read_lock() here and the
WRITE_ONCE(fitler->notify, NULL) + kfree_rcu() sequence in
seccomp_notify_free() it seems to imply that filter->notif could be NULL
here and so would need a non-NULL check on ->notif before incrementing?

> +	rcu_read_unlock();
> +
> +	return ret;
> +}
>  
>  static long seccomp_notify_recv(struct seccomp_filter *filter,
>  				void __user *buf)
> @@ -1467,7 +1479,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  
>  	memset(&unotif, 0, sizeof(unotif));
>  
> -	ret = down_interruptible(&filter->notif->request);
> +	ret = wait_event_interruptible(filter->wqh, notify_wakeup(filter));
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1515,7 +1527,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  			if (should_sleep_killable(filter, knotif))
>  				complete(&knotif->ready);
>  			knotif->state = SECCOMP_NOTIFY_INIT;
> -			up(&filter->notif->request);
> +			atomic_add(1, &filter->notif->requests);

atomic_inc()?

> +			wake_up_poll(&filter->wqh, EPOLLIN | EPOLLRDNORM);
>  		}
>  		mutex_unlock(&filter->notify_lock);
>  	}
> @@ -1771,15 +1784,15 @@ static const struct file_operations seccomp_notify_ops = {
>  static struct file *init_listener(struct seccomp_filter *filter)
>  {
>  	struct file *ret;
> +	struct notification *notif;
>  
>  	ret = ERR_PTR(-ENOMEM);
> -	filter->notif = kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
> -	if (!filter->notif)
> +	notif = kzalloc(sizeof(*notif), GFP_KERNEL);
> +	if (!notif)
>  		goto out;
>  
> -	sema_init(&filter->notif->request, 0);
> -	filter->notif->next_id = get_random_u64();
> -	INIT_LIST_HEAD(&filter->notif->notifications);
> +	notif->next_id = get_random_u64();
> +	INIT_LIST_HEAD(&notif->notifications);
>  
>  	ret = anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
>  				 filter, O_RDWR);
> @@ -1788,10 +1801,11 @@ static struct file *init_listener(struct seccomp_filter *filter)
>  
>  	/* The file has a reference to it now */
>  	__get_seccomp_filter(filter);
> +	WRITE_ONCE(filter->notif, notif);
>  
>  out_notif:
>  	if (IS_ERR(ret))
> -		seccomp_notify_free(filter);
> +		kfree(notif);
>  out:
>  	return ret;
>  }
> -- 
> 2.37.2
> 
> 
