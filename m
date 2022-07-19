Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8392357A309
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiGSPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiGSPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:30:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02A856B91
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:30:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id oy13so27813631ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRQHtUHyqeXE02w1f9vvRW9skOCcxr7rzUXjEanoAUc=;
        b=YDK2QMqxLv2QZXONAHgOeupH7Ksarix8SwreCul6pebptcfGWBzdNiY3hHZAnhCMcP
         Ue84tv0gJa9DHeqsQ5W/M9GUh1thSCcFF9nXTghsKPhuPLG7Bn0+2XFoicpnfN99pqry
         FNHIB0BSreUQQY8rSPUTZtayiR52aaRV8nxE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRQHtUHyqeXE02w1f9vvRW9skOCcxr7rzUXjEanoAUc=;
        b=EJPBIMrsP+C8LFNmSlB4eFJcIzTENpCBq7vLrSRMvA5RdQ7IzweYkQx4oxFGtYaRCA
         dahl3S05SSgIUxqc8AOAXcpcY8dUQfVqu5M3LnXKrW9DXfVBHWLUDAYedMcB5+9Vgf7d
         NmtJbScoFOknxdbeJ/MMPb2Nh/2W4O0yUEvl1iJLnQsspjya/uckS5vR5OSRSaeEUlL6
         PohXhtnHtppAchio13WLjDYkH7O8HCnE9UnE8p4AYQMhKx0OGq1NXjRGwwkJFU3H0PbQ
         jYBX7NI5T61c1j/FN5Z/maz3IqLm/faJHUVe6ngIe806f8vcBVd+q264bi4LKrLjyZHi
         ChoA==
X-Gm-Message-State: AJIora/tf3R8CQ3+bgrVgkE1g1HwJ26Ild4Q6DPaIrzLRj9TOX0bqpN9
        ko+zI6POOZVEd+bNFapb55wMkQ4kEee+YZrW
X-Google-Smtp-Source: AGRyM1utobY7s1g8EYxIvOx8h2Y+8xjFiBnJJkcOgc1lgo5Tq7ZfmceDY6Ga678rARstZ8X0zX4nRg==
X-Received: by 2002:a17:907:7d91:b0:72b:4d74:f4f6 with SMTP id oz17-20020a1709077d9100b0072b4d74f4f6mr30253302ejc.314.1658244617172;
        Tue, 19 Jul 2022 08:30:17 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id m21-20020aa7d355000000b0043a7de4e526sm10665991edr.44.2022.07.19.08.30.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:30:15 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id d8so2235375wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:30:15 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr27793173wrn.138.1658244614658; Tue, 19
 Jul 2022 08:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211116012912.723980-1-longman@redhat.com> <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
 <20220719104104.1634-1-hdanton@sina.com>
In-Reply-To: <20220719104104.1634-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Jul 2022 08:30:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xng_Mcd-9SaK29XSbsthDWLTR6sz53VEktAQFng6a27A@mail.gmail.com>
Message-ID: <CAD=FV=Xng_Mcd-9SaK29XSbsthDWLTR6sz53VEktAQFng6a27A@mail.gmail.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more consistent
To:     Hillf Danton <hdanton@sina.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 3:41 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 18 Jul 2022 17:27:28 -0700 Doug Anderson <dianders@chromium.org> wrote:
> >
> > I've been tracking down an occasional hang at reboot on my system and
> > I've ended up at this as the first bad commit. I will not pretend to
> > understand the intricacies of the rwsem implementation, but I can
> > describe what I saw. I have also produced a fairly small test case
> > that reproduces the problem rather quickly.
> >
> > First, what I saw:
> >
> > My system failed to fully boot up and eventually the "hung task"
> > detection kicked in. Many tasks in my system were hung all waiting on
> > the "kernfs_rwsem". No tasks actually had the semaphore--it only had
> > tasks waiting.
> >
> > Of the tasks waiting, 3 of them were doing a down_write(). The rest
> > were all waiting on down_read().
> >
> > 2 of the tasks waiting on the down_write() were locked to CPU0. One of
> > these tasks was a bound kworker. Another of these tasks was a threaded
> > IRQ handler. The threaded IRQ handler was set to "real time" priority
> > because in setup_irq_thread() you can see the call to
> > sched_set_fifo().
> >
> > At the time the hung task detector kicked in, the real time task was
> > actually active on a CPU. Specifically it was running in the for (;;)
> > loop in rwsem_down_write_slowpath(). rwsem_try_write_lock() had
> > clearly just returned false which meant we didn't get the lock.
> > Everything else was sitting in schedule().
> >
> > I managed to get the real time task into kgdb and I could analyze its
> > state as well as the state of "sem". The real time task was _not_ the
> > first waiter. The kworker was the first waiter. The
> > "waiter.handoff_set" was set to "true" for the real time task. The
> > rwsem owner was OWNER_NULL.
> >
> > Looking through the code and watching what was happening.
> >
> > 1. The function rwsem_try_write_lock() was instantly returning false
> > since `handoff` is set and we're not first.
> > 2. After we get back into rwsem_down_write_slowpath() we'll see the
> > handoff set and we'll try to spin on the owner. There is no owner, so
> > this is a noop.
> > 3. Since there's no owner, we'll go right back to the start of the loop.
> >
> > So basically the real time thread (the threaded IRQ handler) was
> > locked to CPU0 and spinning as fast as possible. The "first waiter"
> > for the semaphore was blocked from running because it could only run
> > on CPU0 but was _not_ real time priority.
> >
> > -
> >
> > So all the analysis above was done on the Chrome OS 5.15 kernel
> > branch, which has ${SUBJECT} patch from the stable tree. The code
> > looks reasonably the same on mainline.
> >
> > ...and also, I coded up a test case that can reproduce this on
> > mainline. It's ugly/hacky but it gets the job done. This reproduces
> > the problem at the top of mainline as of commit 80e19f34c288 ("Merge
> > tag 'hte/for-5.19' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux").
> >
> > For me, I was only able to reproduce this without "lockdep" enabled.
> > My lockdep configs were:
> >
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y
> > CONFIG_PROVE_RCU=y
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_DEBUG_ATOMIC_SLEEP=y
> >
> > I don't know for sure if lockdep is actually required to reproduce.
> >
> > -
> >
> > OK, so here's my hacky test case. In my case, I put a call to this
> > test function in a convenient debugfs "show" function to make it easy
> > to trigger. You can put it wherever.
> >
> > struct test_data {
> >         struct rw_semaphore *rwsem;
> >         int i;
> >         bool should_sleep;
> > };
> >
> > static int test_thread_fn(void *data)
> > {
> >         struct test_data *test_data = data;
> >         struct rw_semaphore *rwsem = test_data->rwsem;
> >         ktime_t start;
> >
> >         trace_printk("Starting\n");
> >         start = ktime_get();
> >         while (ktime_to_ms(ktime_sub(ktime_get(), start)) < 60000) {
> >                 trace_printk("About to grab\n");
> >                 down_write(rwsem);
> >                 trace_printk("Grabbed write %d\n", test_data->i);
> >                 schedule();
> >                 up_write(rwsem);
> >                 trace_printk("Released write %d\n", test_data->i);
> >                 if (test_data->should_sleep)
> >                         msleep(1);
> >         }
> >         trace_printk("Done\n");
> >
> >         return 0;
> > }
> >
> > static void test(void)
> > {
> >         static struct task_struct *t[10];
> >         static struct test_data test_data[10];
> >         static DECLARE_RWSEM(rwsem);
> >         int i;
> >
> >         trace_printk("About to create threads\n");
> >
> >         for (i = 0; i < ARRAY_SIZE(t); i++) {
> >                 test_data[i].rwsem = &rwsem;
> >                 test_data[i].i = i;
> >
> >                 if (i == ARRAY_SIZE(t) - 1) {
> >                         /*
> >                          * Last thread will be bound to CPU0 and realtime.
> >                          * Have it sleep to give other threads a chance to
> >                          * run and contend.
> >                          */
> >                         test_data[i].should_sleep = true;
> >                         t[i] = kthread_create_on_cpu(test_thread_fn,
> >                                                      &test_data[i], 0,
> >                                                      "test0 FIFO-%u");
> >                         sched_set_fifo(t[i]);
> >                 } else if (i == ARRAY_SIZE(t) - 2) {
> >                         /* 2nd to last thread will be bound to CPU0 */
> >                         t[i] = kthread_create_on_cpu(test_thread_fn,
> >                                                      &test_data[i], 0,
> >                                                      "test0-%u");
> >                 } else {
> >                         /* All other threads are just normal */
> >                         t[i] = kthread_create(test_thread_fn,
> >                                               &test_data[i], "test");
> >                 }
> >                 wake_up_process(t[i]);
> >                 msleep(10);
> >         }
> > }
> >
> > -
> >
> > With the reproducer above, I was able to:
> >
> > 1. Validate that on chromeos-5.15 I could revert ${SUBJECT} patch and
> > the problem went away.
> >
> > 2. I could go to mainline at exactly the commit hash of ${SUBJECT}
> > patch, see the problem, then revert ${SUBJECT} patch and see the
> > problem go away.
> >
> > Thus I'm fairly confident that the problem is related to ${SUBJECT} patch.
> >
> > -
> >
> > I'm hoping that someone on this thread can propose a fix. I'm happy to
> > test, but I was hoping not to have to become an expert on the rwsem
> > implementation to try to figure out the proper fix.
> >
>
> See if it makes sense to only allow the first waiter to spin on owner.
>
> Hillf
>
> --- mainline/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -337,7 +337,7 @@ struct rwsem_waiter {
>         unsigned long timeout;
>
>         /* Writer only, not initialized in reader */
> -       bool handoff_set;
> +       bool handoff_set, first;
>  };
>  #define rwsem_first_waiter(sem) \
>         list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
> @@ -604,6 +604,7 @@ static inline bool rwsem_try_write_lock(
>
>         lockdep_assert_held(&sem->wait_lock);
>
> +       waiter->first = first;
>         count = atomic_long_read(&sem->count);
>         do {
>                 bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> @@ -1114,6 +1115,7 @@ rwsem_down_write_slowpath(struct rw_sema
>         waiter.type = RWSEM_WAITING_FOR_WRITE;
>         waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>         waiter.handoff_set = false;
> +       waiter.first = false;
>
>         raw_spin_lock_irq(&sem->wait_lock);
>         rwsem_add_waiter(sem, &waiter);
> @@ -1158,7 +1160,7 @@ rwsem_down_write_slowpath(struct rw_sema
>                  * In this case, we attempt to acquire the lock again
>                  * without sleeping.
>                  */
> -               if (waiter.handoff_set) {
> +               if (waiter.handoff_set && waiter.first) {

Your patch does fix my test case, so FWIW:

Tested-by: Douglas Anderson <dianders@chromium.org>

I haven't done any stress testing other than my test case, though, so
I can't speak to whether there might be any other unintended issues.


-Doug
