Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359845849DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiG2Ciw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiG2Civ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:38:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EBC63912
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:38:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h205-20020a1c21d6000000b003a34ac64bdfso351760wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPEPmu8XCL40rZ4gGMx6kz9w4dOJZlBtYNldzFCtl5M=;
        b=c7/mVGqzjJQAcMZSmKootfDYCC92C6paHGFLMmVpSlM1mLRUCHvvz1GXBnRx1LzcYw
         xVIRAP62xzobEfLZINUAe7UoA0kvYswM2tu/JLWWdEO9kh44KMe5Du7OtC7ztHLZHhZx
         eBmnL8sGEMpXV1gZztae6GGUBcGvzY3UO+7+9NCBY/5aI6KT4DBCI7Ioz+sFhsysNGd7
         pCtbVHbMlhC+j/t3SrnNSuhQu8B21gEYKxp3QK8WVyjw2m2SolOJBBHi66ZNs4JZCwmU
         DJN25kC3OAYUAklQkKQQWp+3jFVuWyFG2wdrlhantifYMOYi4sla66pZHY4t2QF9z545
         1nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPEPmu8XCL40rZ4gGMx6kz9w4dOJZlBtYNldzFCtl5M=;
        b=SwLHA2wSmgWhyuGqp0ToxgYSDD2Nah7k/N5qapISNI12cs+qQaYIwNEMqgilbyElXs
         0NBXfFNFpv4vgIwavKzRSROVRq7PL7k2cCvg7+fM+Foi397dIPnZhkZNDKVO+7wscKyx
         gnGU/URmawhpOry68ehVibjqtlC6fyJWKK8eyg70y2wkshd5I4WyRKK1CIIAOAVYGyZw
         nkInPwoPYp9lkjNBE8NCRLIAOTPECm6LqGQkJN+kEtnrKotfwTgNCvkU7hYG778EFRZb
         KoJdrb7iXpkpLXo6zB4ddTH77B2SYtU6kdQFLHcCZGj+LYhwnLGCZG+zEv9xSdpoJa0D
         1xsA==
X-Gm-Message-State: AJIora/Tk4aoZxct4Q/YGp7oU8OEKtWe7bSS8n9SfEP1uOfcD5WHdFA7
        jdJB/0+h6lNIk8Su9GyrgzokxJT4MzQ5G6LyoiA=
X-Google-Smtp-Source: AGRyM1tGi8xQ/en/Nbppmcx+mzWLdGBfK3AZG3aPixUQ40WVDeXUh6nyW0pW2DilAH0SnDih6briT30oedxckYrpB34=
X-Received: by 2002:a05:600c:1c9d:b0:3a3:2631:2fcb with SMTP id
 k29-20020a05600c1c9d00b003a326312fcbmr1244237wms.161.1659062328486; Thu, 28
 Jul 2022 19:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
In-Reply-To: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 29 Jul 2022 10:38:36 +0800
Message-ID: <CAJhGHyCbEn-gTaK57-QA7cszRS2hyBPWt2wPhmiGDY5M9x5eKg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: don't skip lockdep wq dependency in cancel_work_sync()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 8:23 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Like Hillf Danton mentioned
>
>   syzbot should have been able to catch cancel_work_sync() in work context
>   by checking lockdep_map in __flush_work() for both flush and cancel.
>
> in [1], being unable to report an obvious deadlock scenario shown below is
> broken. From locking dependency perspective, sync version of cancel request
> should behave as if flush request, for it waits for completion of work if
> that work has already started execution.
>
>   ----------
>   #include <linux/module.h>
>   #include <linux/sched.h>
>   static DEFINE_MUTEX(mutex);
>   static void work_fn(struct work_struct *work)
>   {
>     schedule_timeout_uninterruptible(HZ / 5);
>     mutex_lock(&mutex);
>     mutex_unlock(&mutex);
>   }
>   static DECLARE_WORK(work, work_fn);
>   static int __init test_init(void)
>   {
>     schedule_work(&work);
>     schedule_timeout_uninterruptible(HZ / 10);
>     mutex_lock(&mutex);
>     cancel_work_sync(&work);
>     mutex_unlock(&mutex);
>     return -EINVAL;
>   }
>   module_init(test_init);
>   MODULE_LICENSE("GPL");
>   ----------
>
> Link: https://lkml.kernel.org/r/20220504044800.4966-1-hdanton@sina.com [1]
> Reported-by: Hillf Danton <hdanton@sina.com>
> Fixes: d6e89786bed977f3 ("workqueue: skip lockdep wq dependency in cancel_work_sync()")
> Cc: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/workqueue.c | 45 ++++++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1ea50f6be843..e6df688f84db 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3000,8 +3000,7 @@ void drain_workqueue(struct workqueue_struct *wq)
>  }
>  EXPORT_SYMBOL_GPL(drain_workqueue);
>
> -static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
> -                            bool from_cancel)
> +static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
>  {
>         struct worker *worker = NULL;
>         struct worker_pool *pool;
> @@ -3043,8 +3042,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
>          * workqueues the deadlock happens when the rescuer stalls, blocking
>          * forward progress.
>          */
> -       if (!from_cancel &&
> -           (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
> +       if (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer) {
>                 lock_map_acquire(&pwq->wq->lockdep_map);
>                 lock_map_release(&pwq->wq->lockdep_map);
>         }
> @@ -3056,7 +3054,18 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
>         return false;
>  }
>
> -static bool __flush_work(struct work_struct *work, bool from_cancel)
> +/**
> + * flush_work - wait for a work to finish executing the last queueing instance
> + * @work: the work to flush
> + *
> + * Wait until @work has finished execution.  @work is guaranteed to be idle
> + * on return if it hasn't been requeued since flush started.
> + *
> + * Return:
> + * %true if flush_work() waited for the work to finish execution,
> + * %false if it was already idle.
> + */
> +bool flush_work(struct work_struct *work)
>  {
>         struct wq_barrier barr;
>
> @@ -3066,12 +3075,10 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
>         if (WARN_ON(!work->func))
>                 return false;
>
> -       if (!from_cancel) {
> -               lock_map_acquire(&work->lockdep_map);
> -               lock_map_release(&work->lockdep_map);
> -       }
> +       lock_map_acquire(&work->lockdep_map);
> +       lock_map_release(&work->lockdep_map);


IIUC, I think the change of these 5 lines of code (-3+2) is enough
to fix the problem described in the changelog.

If so, could you make a minimal patch?

I believe what the commit d6e89786bed977f3 ("workqueue: skip lockdep
wq dependency in cancel_work_sync()") fixes is real.  It is not a good
idea to revert it.

P.S.

The commit fd1a5b04dfb8("workqueue: Remove now redundant lock
acquisitions wrt. workqueue flushes") removed this lockdep check.

And the commit 87915adc3f0a("workqueue: re-add lockdep
dependencies for flushing") added it back for non-canceling cases.

It seems the commit fd1a5b04dfb8 is the culprit and 87915adc3f0a
didn't fixes all the problem of it.

So it is better to complete 87915adc3f0a by making __flush_work()
does lock_map_acquire(&work->lockdep_map) for both canceling and
non-canceling cases.
