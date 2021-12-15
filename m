Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19736475949
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbhLONEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhLONEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:04:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E4C061574;
        Wed, 15 Dec 2021 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gIifIyPg8CLByWd1i0OMSF1sa+Vo0B9xYqpV36mSTFM=; b=h0EhRqQeNDTk7ndsoAUJvE2YPS
        Xxc6KIOndvro3Qwhv3FDBt8cXpCSWlqbwD6/cFoFOa7Sz+z6JR25dvpwdjxCkqgYaFYcrvoR0Jx75
        SVZtfD6MdNFhJt5Ze68+H5d/3jIV9ZzhuCYyLzlowA6DMsXdwTnTSYRXknujnVNx4LjlD/GaU6yWz
        AEs7yx4WRJydptDq5JiRyVTXPiAYp7jzVMWoVlHGdrxk77ojBQSQxa9cuHWXmaYOY2eABP4R/iQuj
        465JXjK9hKvnzbj4XU755ZMWUqEHQulcQhpvX7dAhUOZ1qL/uhodUCr5zQrXw7WcI52XBsGCz+AhL
        DjSsoJjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxTwZ-001VUZ-Oq; Wed, 15 Dec 2021 13:03:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F33F4300348;
        Wed, 15 Dec 2021 14:03:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA61F2B324D1C; Wed, 15 Dec 2021 14:03:37 +0100 (CET)
Date:   Wed, 15 Dec 2021 14:03:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
Message-ID: <Ybnnqd6I+CCGSSJa@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:06:20AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 14, 2021 at 07:46:25PM -0800, Peter Oskolkov wrote:
> > On Tue, Dec 14, 2021 at 12:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Hi,
> > >
> > > This is actually tested code; but still missing the SMP wake-to-idle machinery.
> > > I still need to think about that.
> > 
> > Thanks, Peter!
> > 
> > At a first glance, your main patch does not look much smaller than
> > mine, and I thought the whole point of re-doing it was to throw away
> > extra features and make things smaller/simpler...
> 
> Well, simpler was the goal. I didn't really focus on size much. It isn't
> really big to begin with.
> 
> But yes, it has 5 hooks now, 3 syscalls and lots of comments and all
> that under 900 lines, not bad I'd say.
> 
> Also I think you wanted something like this? I'm not sure of the LAZY
> name, but I can't seem to come up with anything saner atm.
> 
> 
> ---
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1297,6 +1297,7 @@ struct task_struct {
>  
>  #ifdef CONFIG_UMCG
>  	/* setup by sys_umcg_ctrl() */
> +	u32			umcg_flags;
>  	clockid_t		umcg_clock;
>  	struct umcg_task __user	*umcg_task;
>  
> --- a/include/uapi/linux/umcg.h
> +++ b/include/uapi/linux/umcg.h
> @@ -133,11 +133,13 @@ struct umcg_task {
>   * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
>   * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
>   * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
> + * @UMCG_CTL_LAZY:	 don't wake server on runnable enqueue
>   */
>  enum umcg_ctl_flag {
>  	UMCG_CTL_REGISTER	= 0x00001,
>  	UMCG_CTL_UNREGISTER	= 0x00002,
>  	UMCG_CTL_WORKER		= 0x10000,
> +	UMCG_CTL_LAZY		= 0x20000,
>  };
>  
>  #endif /* _UAPI_LINUX_UMCG_H */
> --- a/kernel/sched/umcg.c
> +++ b/kernel/sched/umcg.c
> @@ -416,6 +416,27 @@ static int umcg_enqueue_runnable(struct
>  }
>  
>  /*
> + * Enqueue tsk to it's server's runnable list and wake the server for pickup if
> + * so desired. Notable LAZY workers will not wake the server and rely on the
> + * server to do pickup whenever it naturally runs next.
> + *
> + * Returns:
> + * 0:	success
> + * -EFAULT
> + */
> +static int umcg_enqueue_and_wake(struct task_struct *tsk, bool force)
> +{
> +	int ret = umcg_enqueue_runnable(tsk);
> +	if (ret)
> +		return ret;
> +
> +	if (force || !(tsk->umcg_flags & UMCG_CTL_LAZY))
> +		ret = umcg_wake_server(tsk);
> +
> +	return ret;
> +}

Aah, this has a problem when the server is otherwise idle. I think we
need that TF_IDLE thing for this too. Let me go write a test-case for
all this.
