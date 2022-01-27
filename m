Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1149E8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbiA0RUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiA0RUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:20:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF5CC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:20:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n8so2423277wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HG+B3ka5o61XAmKDHkpQiSigUAPVl+07ct5c4XYqWFQ=;
        b=guM6Q9dlGU0Z9WElYRigG8WTm+c5Rh33xQHlTJZZrknIHg9Kyr87naQZvMGL2YZYEK
         wGi0jHj67SbDDZTKuo5RQWqP319mapoFCKL/hErtMveIzFB5+W4mbngoS5LRfhExpQV9
         wxLn1+6DqIlLyaAQPMvfWWEfcd8+tnHPIiRIo+dlv2+s64fC7B7xAZXCkCYcFbABtCwI
         l6tPf0/oIDMz7j4kEFtgqhrYsYHVMx8NqsyMsY2CVPIXu8pFSb/2Kz0J+Wv9uaFwe71I
         6FAbmoG1Fh+V/jmFCpq9BMNpiOFmUpkScXvcyeY9Rx7nidfsDM+3UpASGgK6Ak7rfWO2
         96Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HG+B3ka5o61XAmKDHkpQiSigUAPVl+07ct5c4XYqWFQ=;
        b=yQCcmMN/4NE+q+tkk6TxM0c8eBERg/N9OuSCxs8ao6Z3/rZhm4YwK2rdzkWUAT5lyt
         BdtNaZcu3u4U1kwVd0ig3ZNk9KdrsKoLpi4PoEfs1XAGKAoJfoev6KvQkjOMlMPatCD1
         dy0lB+x4OjDPeAmO2xrlbOm2yLCAad8E8FTC9sjGOjXAgZJ0EjNwhjZ3J2HGtKwAayrB
         5efXZkwxFkPnJd5XSgMOJh/HwmSZ1NzPBfAm3h+Z/zUdfxO4xOIucMCix4RJJ/4SkrrA
         WarQdbbcGHMl/WOD8/tgGmGXiTYj3nFFS3RmIjrh7k/Id2bvhpVJ4kdgF5Ij2ik0k7PW
         DW+g==
X-Gm-Message-State: AOAM533arx+MnO/TM2MR1S1zcKKrhWKAJtMvpUN6eINNM1x4/NFg6k9s
        ZrdlWlKZprf6RCqEPoExa9g7SqEXoDh92njjyXBg3HYAAo8=
X-Google-Smtp-Source: ABdhPJwAKAez3UoD9h5QcDBpaZ/e3nP3CX0/IVYilKMz+CBL+i0FSLJtIl+lKtNSiUS2rSv/Su43mcfqKjswq2uBGTc=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr3979079wmq.53.1643304052680;
 Thu, 27 Jan 2022 09:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com> <20220113233940.3608440-5-posk@google.com>
 <20220127153749.GP20638@worktop.programming.kicks-ass.net>
In-Reply-To: <20220127153749.GP20638@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 27 Jan 2022 09:20:41 -0800
Message-ID: <CAPNVh5e8vBDnZwDa+2f9f0S76uU4hD8++roSyA3i7y=DP1gaOw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched: UMCG: add a blocked worker list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 7:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 13, 2022 at 03:39:39PM -0800, Peter Oskolkov wrote:
>
> > This change introduces the following benefits:
> > - block detection how behaves similarly to wake detection;
> >   without this patch worker wakeups added wakees to the list
> >   and woke the server, while worker blocks only woke the server
> >   without adding blocked workers to a list, forcing servers
> >   to explicitly check worker's state;
>
> > - if the blocked worker woke sufficiently quickly, the server
> >   woken on the block event would observe its worker now as
> >   RUNNABLE, so the block event had to be inferred rather than
> >   explicitly signalled by the worker being added to the blocked
> >   worker list;
>
> This I think is missing the point, there is no race if the server checks
> curr->state == RUNNING.
>
> > - it is now possible for a single server to control several
> >   RUNNING workers, which makes writing userspace schedulers
> >   simpler for smaller processes that do not need to scale beyond
> >   one "server";
>
> How about something like so on top?

This will work, I think. Thanks!

----------

On a more general note, it looks like the original desire to keep state in
the userspace memory (TLS) instead of in task_struct has lead to a lot
of pain and complexity due to the difficulty of updating the userspace from
non-preemptible/sched contexts. And a bunch of stuff still trickled down
to task_struct.

Is it too late to revisit the design? If all state is kept in task_struct,
most of the complexity in the patchset will go away.

The only extra thing will be the fact that the kernel will maintain
the list of blocked/runnable workers, and so there will be an additional
syscall to get it out of the kernel and into the userspace. But all the pain
of pinning pages and related mm changes will go away...

>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1298,6 +1298,7 @@ struct task_struct {
>
>  #ifdef CONFIG_UMCG
>         /* setup by sys_umcg_ctrl() */
> +       u32                     umcg_flags;
>         clockid_t               umcg_clock;
>         struct umcg_task __user *umcg_task;
>
> --- a/include/uapi/linux/umcg.h
> +++ b/include/uapi/linux/umcg.h
> @@ -119,6 +119,8 @@ struct umcg_task {
>          *
>          * Readable/writable by both the kernel and the userspace: the
>          * kernel adds items to the list, userspace removes them.
> +        *
> +        * Only used with UMCG_CTL_MULTI.
>          */
>         __u64   blocked_workers_ptr;            /* r/w */
>
> @@ -147,11 +149,13 @@ enum umcg_wait_flag {
>   * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
>   * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
>   * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
> + * @UMCG_CTL_MULTI:     allow 1:n worker relations, enables blocked_workers_ptr
>   */
>  enum umcg_ctl_flag {
>         UMCG_CTL_REGISTER       = 0x00001,
>         UMCG_CTL_UNREGISTER     = 0x00002,
>         UMCG_CTL_WORKER         = 0x10000,
> +       UMCG_CTL_MULTI          = 0x20000,
>  };
>
>  #endif /* _UAPI_LINUX_UMCG_H */
> --- a/kernel/sched/umcg.c
> +++ b/kernel/sched/umcg.c
> @@ -335,7 +335,7 @@ static inline int umcg_enqueue_runnable(
>  }
>
>  /*
> - * Enqueue @tsk on it's server's blocked list
> + * Enqueue @tsk on it's server's blocked list OR ensure @tsk == server::next_tid
>   *
>   * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
>   *
> @@ -346,10 +346,34 @@ static inline int umcg_enqueue_runnable(
>   * Returns:
>   *   0: success
>   *   -EFAULT
> + *   -ESRCH    server::next_tid is not a valid UMCG task
> + *   -EINVAL   server::next_tid doesn't match @tsk
>   */
>  static inline int umcg_enqueue_blocked(struct task_struct *tsk)
>  {
> -       return umcg_enqueue(tsk, true /* blocked */);
> +       struct task_struct *next;
> +       u32 next_tid;
> +       int ret;
> +
> +       if (tsk->umcg_server->umcg_flags & UMCG_CTL_MULTI)
> +               return umcg_enqueue(tsk, true /* blocked */);
> +
> +       /*
> +        * When !MULTI, ensure this worker is the current worker,
> +        * ensuring the 1:1 relation.
> +        */
> +       if (get_user(next_tid, &tsk->umcg_server_task->next_tid))
> +               return -EFAULT;
> +
> +       next = umcg_get_task(next_tid);
> +       if (!next)
> +               return -ESRCH;
> +
> +       ret = (next == tsk) ? 0 : -EINVAL;
> +
> +       put_task_struct(next);
> +
> +       return ret;
>  }
>
>  /* pre-schedule() */
> @@ -911,6 +934,8 @@ static int umcg_register(struct umcg_tas
>                 return -EINVAL;
>         }
>
> +       current->umcg_flags = flags;
> +
>         if (current->umcg_task || !self)
>                 return -EINVAL;
>
> @@ -1061,7 +1086,7 @@ SYSCALL_DEFINE3(umcg_ctl, u32, flags, st
>
>         flags &= ~UMCG_CTL_CMD;
>
> -       if (flags & ~(UMCG_CTL_WORKER))
> +       if (flags & ~(UMCG_CTL_WORKER|UMCG_CTL_MULTI))
>                 return -EINVAL;
>
>         switch (cmd) {
