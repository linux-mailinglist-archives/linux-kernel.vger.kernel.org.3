Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28255831B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiG0SNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243329AbiG0SMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:12:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA533D4E03
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:13:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v17so6499001wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uE7ulaFIa4kwx6F9sA1FJbL2FsEYLVhCaPdS4NQL6NE=;
        b=QtwKvQTlpxopgXWzZwVyZVvIKkNJviXNbOV0RnVmxcomL5KudVpdpDyA1CSDdhFA9G
         T2BeZo/R7aXJypfHA0BHqW5qwg6QxagbM97wFXBBUyEayPlbkKjBengbMDzZrTJNiRlt
         5bMU9To9t0j4RVHI+kZIFOXuT4DzaD8Qd0ux+vsORm9LG/38eXMPL4qARLC3rNRrHkeI
         Eq1aGKvnOIKzxQv5un9fGnIl/R661mka9aMH6KmioCvmFn996QQTBRFfiR9mM/v6f9JZ
         EoKKOp7fnRJrJii//dBMNjshYzWlwIZj+AaU+IUbfFL36g9TQwuJn9jzCJ78DdwgJShA
         ZjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uE7ulaFIa4kwx6F9sA1FJbL2FsEYLVhCaPdS4NQL6NE=;
        b=vjCG4sdjYSGzLpsdt3VJiSzpvojHVRct1CimHQfQjer6vpKG4w/7SwNPueaapWKXea
         1b49UIfwAjvfapN/Uzrl29ECRHgcAA1R5xJXakswndTLB17xS5PkiXepysIcqjEzK5uI
         kQdc9zubv9pF5JmRwMh84Y8f1/YLZSwS2FbZBzZLpV8uz5HeechY+HTC6ykKAlMW+hvH
         ENImcjkaM8kBgGJn+pQ7FRBGGQYE37iTlhRMuJ25yYP57ZZrfkVYXn4uOlrsjgl3J85V
         R+QYZt2Q43pubGh/l6v3qLs0rsSkwN3j1eTQNm3d7KJpsGxkLuHWcXc7wSgFWmoZSeOM
         O2AA==
X-Gm-Message-State: AJIora/2v0hcO5CEpfb0aGORbcSpze4lnjVDsr+eAx7bMU/qtv9O9Pr1
        3tdzOeJRaTAYFJokqlLyKwWrBbLE/0V2M1mUUuKbX1BApk0=
X-Google-Smtp-Source: AGRyM1udqAFIoaj4ByD3Een2OVlAwifQ3KzsuwTpGOnKylqZ1Z0C8XDpw7LQdGbj1RE2gZuXn/NVPGllJCdDqQuUrFc=
X-Received: by 2002:a05:6000:1a87:b0:21d:b5b9:7666 with SMTP id
 f7-20020a0560001a8700b0021db5b97666mr15069882wry.1.1658942028599; Wed, 27 Jul
 2022 10:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220727115327.2273547-1-vschneid@redhat.com> <20220727115327.2273547-2-vschneid@redhat.com>
In-Reply-To: <20220727115327.2273547-2-vschneid@redhat.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 28 Jul 2022 01:13:37 +0800
Message-ID: <CAJhGHyCeraX1jcea9kt_FBC561zBgECuw5qx8TAdCG0EHnT6kA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] workqueue: Unbind workers before sending them
 to exit()
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
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

Quick review before going to sleep.

On Wed, Jul 27, 2022 at 7:54 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> It has been reported that isolated CPUs can suffer from interference due to
> per-CPU kworkers waking up just to die.
>
> A surge of workqueue activity during initial setup of a latency-sensitive
> application (refresh_vm_stats() being one of the culprits) can cause extra
> per-CPU kworkers to be spawned. Then, said latency-sensitive task can be
> running merrily on an isolated CPU only to be interrupted sometime later by
> a kworker marked for death (cf. IDLE_WORKER_TIMEOUT, 5 minutes after last
> kworker activity).
>
> Prevent this by affining kworkers to the wq_unbound_cpumask (which doesn't
> contain isolated CPUs, cf. HK_TYPE_WQ) before waking them up after marking
> them with WORKER_DIE.
>
> Changing the affinity does require a sleepable context, so get rid of the
> pool->idle_timer and use a delayed_work instead.
>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/workqueue.c | 109 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 81 insertions(+), 28 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1ea50f6be843..27642166dcc5 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -167,9 +167,9 @@ struct worker_pool {
>         int                     nr_workers;     /* L: total number of workers */
>         int                     nr_idle;        /* L: currently idle workers */
>
> -       struct list_head        idle_list;      /* L: list of idle workers */
> -       struct timer_list       idle_timer;     /* L: worker idle timeout */
> -       struct timer_list       mayday_timer;   /* L: SOS timer for workers */
> +       struct list_head        idle_list;        /* L: list of idle workers */
> +       struct delayed_work     idle_reaper_work; /* L: worker idle timeout */
> +       struct timer_list       mayday_timer;     /* L: SOS timer for workers */
>
>         /* a workers is either on busy_hash or idle_list, or the manager */
>         DECLARE_HASHTABLE(busy_hash, BUSY_WORKER_HASH_ORDER);
> @@ -1806,8 +1806,10 @@ static void worker_enter_idle(struct worker *worker)
>         /* idle_list is LIFO */
>         list_add(&worker->entry, &pool->idle_list);
>
> -       if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
> -               mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
> +       if (too_many_workers(pool) && !delayed_work_pending(&pool->idle_reaper_work))
> +               mod_delayed_work(system_unbound_wq,
> +                                &pool->idle_reaper_work,
> +                                IDLE_WORKER_TIMEOUT);

system_unbound_wq doesn't have a rescuer.

A new workqueue with a rescuer needs to be created and used for
this purpose.

>
>         /* Sanity check nr_running. */
>         WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
> @@ -1972,9 +1974,29 @@ static struct worker *create_worker(struct worker_pool *pool)
>         return NULL;
>  }
>
> +static void unbind_worker(struct worker *worker)
> +{
> +       kthread_set_per_cpu(worker->task, -1);
> +       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
> +}
> +
> +static void rebind_worker(struct worker *worker, struct worker_pool *pool)
> +{
> +       kthread_set_per_cpu(worker->task, pool->cpu);
> +       WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
> +}
> +
> +static void reap_worker(struct worker *worker)
> +{
> +       list_del_init(&worker->entry);
> +       unbind_worker(worker);
> +       wake_up_process(worker->task);


Since WORKER_DIE is set, the worker can be possible freed now
if there is another source to wake it up.

I think reverting a part of the commit 60f5a4bcf852("workqueue:
async worker destruction") to make use of kthread_stop()
in destroy_worker() should be a good idea.
