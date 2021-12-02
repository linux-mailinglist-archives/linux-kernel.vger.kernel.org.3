Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2581466B33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348982AbhLBU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbhLBU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:56:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E85C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 12:52:47 -0800 (PST)
Date:   Thu, 2 Dec 2021 21:52:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638478365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4n0sknzkmi7VuoSng9K0HLRTNiaT0f1gpjJ4GLCoNlc=;
        b=ua+10bjsncU87hT3urZpdt+xQ2jBRjRRy5kqIn1kTRp/L3nVNpnCM6MaO2tNeJJ8FV6hnM
        lXZCy+6b7eEOX2OAOF5Z+LD+Bs/pkr4R2X2gDet5i6TJpTHm4TUtPCjPEp8EiWSoW37mLP
        vOE+u+Qbb1feLA8yfp5tKlrQZVbmxEJ+K0q5N0Oi4pDhAWv/HHgvTRp/OxEWan/QFMV5C1
        wahTYbCxS3viyy8cdvhU1itfxKPYHZvkFyIW0T0DqlTUeAwDIdGnvM9sLqLk1mOuLPQdRf
        MO9KixLvWPRKW+sXWelFwmE8umAFmwdfs/sjsikb996g5p12VQw04uN2fDoBjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638478365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4n0sknzkmi7VuoSng9K0HLRTNiaT0f1gpjJ4GLCoNlc=;
        b=T+bsyCRCJYvHYV+ytwdtlELHySBI1gaK3bGRGQNdJnl5AK6D+dtoldp9oXP8jrfcS+OOC1
        MDsN1fd5Nm+uSICw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Gregor Beck <gregor.beck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 REPOST] fscache: Use only one fscache_object_cong_wait.
Message-ID: <20211202205240.giqxuxqemlxxoobw@linutronix.de>
References: <20211118165442.hekmz7xgisdzsyuh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118165442.hekmz7xgisdzsyuh@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-18 17:54:44 [+0100], To linux-cachefs@redhat.com wrote:
> In the commit mentioned below, fscache was converted from slow-work to
> workqueue. slow_work_enqueue() and slow_work_sleep_till_thread_needed()
> did not use a per-CPU workqueue. They choose from two global waitqueues
> depending on the SLOW_WORK_VERY_SLOW bit which was not set so it always
> one waitqueue.
> 
> I can't find out how it is ensured that a waiter on certain CPU is woken
> up be the other side. My guess is that the timeout in schedule_timeout()
> ensures that it does not wait forever (or a random wake up).
> 
> fscache_object_sleep_till_congested() must be invoked from preemptible
> context in order for schedule() to work. In this case this_cpu_ptr()
> should complain with CONFIG_DEBUG_PREEMPT enabled except the thread is
> bound to one CPU.
> 
> wake_up() wakes only one waiter and I'm not sure if it is guaranteed
> that only one waiter exists.
> 
> Replace the per-CPU waitqueue with one global waitqueue.
> 
> Fixes: 8b8edefa2fffb ("fscache: convert object to use workqueue instead of slow-work")
> Reported-by: Gregor Beck <gregor.beck@gmail.com>
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I noticed that -next gained commit
   608bfec640edb ("fscache: Remove the contents of the fscache driver, pending rewrite")

which removes slow_work_sleep_till_thread_needed() and the per-CPU
variable. Since it looks like a bug, what happens stable wise?

> ---
> Previous post
>   https://lore.kernel.org/all/20211029083839.xwwt7jgzru3kcpii@linutronix.de/
> 
>  fs/fscache/internal.h |    1 -
>  fs/fscache/main.c     |    6 ------
>  fs/fscache/object.c   |   13 +++++--------
>  3 files changed, 5 insertions(+), 15 deletions(-)
> 
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -81,7 +81,6 @@ extern unsigned fscache_debug;
>  extern struct kobject *fscache_root;
>  extern struct workqueue_struct *fscache_object_wq;
>  extern struct workqueue_struct *fscache_op_wq;
> -DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
>  
>  extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
>  
> --- a/fs/fscache/main.c
> +++ b/fs/fscache/main.c
> @@ -41,8 +41,6 @@ struct kobject *fscache_root;
>  struct workqueue_struct *fscache_object_wq;
>  struct workqueue_struct *fscache_op_wq;
>  
> -DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
> -
>  /* these values serve as lower bounds, will be adjusted in fscache_init() */
>  static unsigned fscache_object_max_active = 4;
>  static unsigned fscache_op_max_active = 2;
> @@ -138,7 +136,6 @@ unsigned int fscache_hash(unsigned int s
>  static int __init fscache_init(void)
>  {
>  	unsigned int nr_cpus = num_possible_cpus();
> -	unsigned int cpu;
>  	int ret;
>  
>  	fscache_object_max_active =
> @@ -161,9 +158,6 @@ static int __init fscache_init(void)
>  	if (!fscache_op_wq)
>  		goto error_op_wq;
>  
> -	for_each_possible_cpu(cpu)
> -		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
> -
>  	ret = fscache_proc_init();
>  	if (ret < 0)
>  		goto error_proc;
> --- a/fs/fscache/object.c
> +++ b/fs/fscache/object.c
> @@ -798,6 +798,8 @@ void fscache_object_destroy(struct fscac
>  }
>  EXPORT_SYMBOL(fscache_object_destroy);
>  
> +static DECLARE_WAIT_QUEUE_HEAD(fscache_object_cong_wait);
> +
>  /*
>   * enqueue an object for metadata-type processing
>   */
> @@ -806,16 +808,12 @@ void fscache_enqueue_object(struct fscac
>  	_enter("{OBJ%x}", object->debug_id);
>  
>  	if (fscache_get_object(object, fscache_obj_get_queue) >= 0) {
> -		wait_queue_head_t *cong_wq =
> -			&get_cpu_var(fscache_object_cong_wait);
>  
>  		if (queue_work(fscache_object_wq, &object->work)) {
>  			if (fscache_object_congested())
> -				wake_up(cong_wq);
> +				wake_up(&fscache_object_cong_wait);
>  		} else
>  			fscache_put_object(object, fscache_obj_put_queue);
> -
> -		put_cpu_var(fscache_object_cong_wait);
>  	}
>  }
>  
> @@ -833,16 +831,15 @@ void fscache_enqueue_object(struct fscac
>   */
>  bool fscache_object_sleep_till_congested(signed long *timeoutp)
>  {
> -	wait_queue_head_t *cong_wq = this_cpu_ptr(&fscache_object_cong_wait);
>  	DEFINE_WAIT(wait);
>  
>  	if (fscache_object_congested())
>  		return true;
>  
> -	add_wait_queue_exclusive(cong_wq, &wait);
> +	add_wait_queue_exclusive(&fscache_object_cong_wait, &wait);
>  	if (!fscache_object_congested())
>  		*timeoutp = schedule_timeout(*timeoutp);
> -	finish_wait(cong_wq, &wait);
> +	finish_wait(&fscache_object_cong_wait, &wait);
>  
>  	return fscache_object_congested();
>  }

Sebastian
