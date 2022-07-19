Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F584578F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiGSA1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiGSA1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:27:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A394E39B9E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:27:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m8so4096028edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLmz1koPoRhwh4onE3cc+Uegs+vbvsSHwsq1PX3xnU0=;
        b=S8CT1okf0UGd1//ijRrDRkFB90Eh71sWSgEj6fzY0VDO3JCbKt47ClvQ2LV+NLzgFj
         /IcQF0NOBgLsDgZPNHCkiRk9Zvu4JivFjDmWoMLARapQvdaJZyYWjN4YWNbvYyitsQdG
         35kPOYp1b6ZkwrCwmWI2tVeFV1QJgtP8qy404=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLmz1koPoRhwh4onE3cc+Uegs+vbvsSHwsq1PX3xnU0=;
        b=Qjp7JWZFlV/NGr4XqkxWH/YJy3l87JZy+qZKwovX/u9T7iZ8zX/sEFL3/Q03h8RdIZ
         F5cJ2qdZYiOK1Tao/eOA/GNJxX1cgQvxrh7WmbHb3BPSAz1seEN6CCDee+ZItK6qL2TE
         +y0WyD7U6xa66V8pgn+aJw7va6slxBnLwYt29nO4Ga2eXxhlixc9QHSH/miQ2aPZ2KPR
         i2/tBMtp4Qt9Pk1d882VGT46llSH0+O1f4lHg7CIxd9wOtKIg+szkoGzJiIzffeojTO2
         zNJmKuO0nMUPEv3RKhJlYcJD0BLcScFXbTQ47RTh8qGtr+yz2ZSDmqxBdLQrfaJVgz0A
         XA2g==
X-Gm-Message-State: AJIora+fRsU3j5LsZdoAr0Ehj2MGnTAPO+8oyDbmBnkFdpklYci3ZeGt
        eTUDah65FVMn19KamT3lAfUD/pQmcfaPTnng
X-Google-Smtp-Source: AGRyM1vbhtIn5botukxza+i8ZZT7982kbdCRTmDpfAIhi3WyMXCKooTqFCIWLw8BW6Vkf2J1Xj+hOQ==
X-Received: by 2002:a05:6402:48:b0:43a:caa8:756b with SMTP id f8-20020a056402004800b0043acaa8756bmr40247171edu.112.1658190464894;
        Mon, 18 Jul 2022 17:27:44 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id q18-20020a056402033200b0043ab866b9e1sm9452617edw.65.2022.07.18.17.27.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 17:27:44 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id z12so19366852wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:27:43 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr24874194wrr.617.1658190463163; Mon, 18
 Jul 2022 17:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211116012912.723980-1-longman@redhat.com>
In-Reply-To: <20211116012912.723980-1-longman@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jul 2022 17:27:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
Message-ID: <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more consistent
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
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

On Mon, Nov 15, 2021 at 5:38 PM Waiman Long <longman@redhat.com> wrote:
>
> There are some inconsistency in the way that the handoff bit is being
> handled in readers and writers.
>
> Firstly, when a queue head writer set the handoff bit, it will clear it
> when the writer is being killed or interrupted on its way out without
> acquiring the lock. That is not the case for a queue head reader. The
> handoff bit will simply be inherited by the next waiter.
>
> Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
> the waiter and handoff bits are cleared if the wait queue becomes empty.
> For rwsem_down_write_slowpath(), however, the handoff bit is not checked
> and cleared if the wait queue is empty. This can potentially make the
> handoff bit set with empty wait queue.
>
> To make the handoff bit handling more consistent and robust, extract
> out handoff bit clearing code into the new rwsem_del_waiter() helper
> function.  The common function will only use atomic_long_andnot() to
> clear bits when the wait queue is empty to avoid possible race condition.
> If the first waiter with handoff bit set is killed or interrupted to
> exit the slowpath without acquiring the lock, the next waiter will
> inherit the handoff bit.
>
> While at it, simplify the trylock for loop in rwsem_down_write_slowpath()
> to make it easier to read.
>
> Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem.c | 171 ++++++++++++++++++++---------------------
>  1 file changed, 85 insertions(+), 86 deletions(-)

I've been tracking down an occasional hang at reboot on my system and
I've ended up at this as the first bad commit. I will not pretend to
understand the intricacies of the rwsem implementation, but I can
describe what I saw. I have also produced a fairly small test case
that reproduces the problem rather quickly.

First, what I saw:

My system failed to fully boot up and eventually the "hung task"
detection kicked in. Many tasks in my system were hung all waiting on
the "kernfs_rwsem". No tasks actually had the semaphore--it only had
tasks waiting.

Of the tasks waiting, 3 of them were doing a down_write(). The rest
were all waiting on down_read().

2 of the tasks waiting on the down_write() were locked to CPU0. One of
these tasks was a bound kworker. Another of these tasks was a threaded
IRQ handler. The threaded IRQ handler was set to "real time" priority
because in setup_irq_thread() you can see the call to
sched_set_fifo().

At the time the hung task detector kicked in, the real time task was
actually active on a CPU. Specifically it was running in the for (;;)
loop in rwsem_down_write_slowpath(). rwsem_try_write_lock() had
clearly just returned false which meant we didn't get the lock.
Everything else was sitting in schedule().

I managed to get the real time task into kgdb and I could analyze its
state as well as the state of "sem". The real time task was _not_ the
first waiter. The kworker was the first waiter. The
"waiter.handoff_set" was set to "true" for the real time task. The
rwsem owner was OWNER_NULL.

Looking through the code and watching what was happening.

1. The function rwsem_try_write_lock() was instantly returning false
since `handoff` is set and we're not first.
2. After we get back into rwsem_down_write_slowpath() we'll see the
handoff set and we'll try to spin on the owner. There is no owner, so
this is a noop.
3. Since there's no owner, we'll go right back to the start of the loop.

So basically the real time thread (the threaded IRQ handler) was
locked to CPU0 and spinning as fast as possible. The "first waiter"
for the semaphore was blocked from running because it could only run
on CPU0 but was _not_ real time priority.

-

So all the analysis above was done on the Chrome OS 5.15 kernel
branch, which has ${SUBJECT} patch from the stable tree. The code
looks reasonably the same on mainline.

...and also, I coded up a test case that can reproduce this on
mainline. It's ugly/hacky but it gets the job done. This reproduces
the problem at the top of mainline as of commit 80e19f34c288 ("Merge
tag 'hte/for-5.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux").

For me, I was only able to reproduce this without "lockdep" enabled.
My lockdep configs were:

CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_PROVE_RCU=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

I don't know for sure if lockdep is actually required to reproduce.

-

OK, so here's my hacky test case. In my case, I put a call to this
test function in a convenient debugfs "show" function to make it easy
to trigger. You can put it wherever.

struct test_data {
        struct rw_semaphore *rwsem;
        int i;
        bool should_sleep;
};

static int test_thread_fn(void *data)
{
        struct test_data *test_data = data;
        struct rw_semaphore *rwsem = test_data->rwsem;
        ktime_t start;

        trace_printk("Starting\n");
        start = ktime_get();
        while (ktime_to_ms(ktime_sub(ktime_get(), start)) < 60000) {
                trace_printk("About to grab\n");
                down_write(rwsem);
                trace_printk("Grabbed write %d\n", test_data->i);
                schedule();
                up_write(rwsem);
                trace_printk("Released write %d\n", test_data->i);
                if (test_data->should_sleep)
                        msleep(1);
        }
        trace_printk("Done\n");

        return 0;
}

static void test(void)
{
        static struct task_struct *t[10];
        static struct test_data test_data[10];
        static DECLARE_RWSEM(rwsem);
        int i;

        trace_printk("About to create threads\n");

        for (i = 0; i < ARRAY_SIZE(t); i++) {
                test_data[i].rwsem = &rwsem;
                test_data[i].i = i;

                if (i == ARRAY_SIZE(t) - 1) {
                        /*
                         * Last thread will be bound to CPU0 and realtime.
                         * Have it sleep to give other threads a chance to
                         * run and contend.
                         */
                        test_data[i].should_sleep = true;
                        t[i] = kthread_create_on_cpu(test_thread_fn,
                                                     &test_data[i], 0,
                                                     "test0 FIFO-%u");
                        sched_set_fifo(t[i]);
                } else if (i == ARRAY_SIZE(t) - 2) {
                        /* 2nd to last thread will be bound to CPU0 */
                        t[i] = kthread_create_on_cpu(test_thread_fn,
                                                     &test_data[i], 0,
                                                     "test0-%u");
                } else {
                        /* All other threads are just normal */
                        t[i] = kthread_create(test_thread_fn,
                                              &test_data[i], "test");
                }
                wake_up_process(t[i]);
                msleep(10);
        }
}

-

With the reproducer above, I was able to:

1. Validate that on chromeos-5.15 I could revert ${SUBJECT} patch and
the problem went away.

2. I could go to mainline at exactly the commit hash of ${SUBJECT}
patch, see the problem, then revert ${SUBJECT} patch and see the
problem go away.

Thus I'm fairly confident that the problem is related to ${SUBJECT} patch.

-

I'm hoping that someone on this thread can propose a fix. I'm happy to
test, but I was hoping not to have to become an expert on the rwsem
implementation to try to figure out the proper fix.

Thanks!

-Doug
