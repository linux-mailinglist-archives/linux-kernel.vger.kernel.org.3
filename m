Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1345657C2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiGUDgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGUDgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:36:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8A77A7B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:36:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv24so440178wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii19w1Ut2aUcfdVV3PNVKcEkBr0s3CQoYUOtE8NhVhc=;
        b=InbVoCWzVc8S6JN/3UC/jnTQirpL9qgCLqHsjABV/UBKZ1o32Gai5hgjTjnbarll4w
         /BSOVtSZGNoOsqiN5jVQKpWvowMP7SH4wy0KywW61TH/J4IYrmyIGye3xOUXNLLJTuwJ
         rpFMNyAOoNWa0wMbRTSub0FTMphS+24UYt06maeC/W2MAYs0WgW9f1+3YoB+Qj1PAQKP
         QIBf3JAv6pM9J6FKl9tKA2ErW6AOHnQJIckHmY+0TVcdiySqRLq48TaewDwmr/SO5rnn
         fhenPzX96BFmEr+ukHWdCbGZAsZY+q8KFkN+sBASmFKuy4e12RrECIzfsMAo8sCDJdSX
         G2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii19w1Ut2aUcfdVV3PNVKcEkBr0s3CQoYUOtE8NhVhc=;
        b=B3k4nzf+QMi3yTLp5NayuiVsgPDFXLsr+ifjJ6I9QW0QvmdiaxZVRGRgoGBfYSW0Vm
         tvHjDvN0kDYKthXAc98/MJ7h79H5N08+9cAdhcuRLI5fHGnmj3TMnS2C2gDf3kOZFH2o
         dtbWlgS33ozVc1YIJkuxG8bt/GJNisr0Eitun9LJoUdzstzmMEB2mq4cl/9FCLNPdX4X
         Vglmt0wwIWX69AHpy+eTpqYXgbHCyXV6KqkXW2Xfd0/jzRZuPkm4iCRl+sYBkyd8ZdJw
         YyWtJLsh6Ni1d/4vreeubg90JAEiQYtDab1UqK1MCezzj2Ys5IOw0y+TCbuhPGUW61yn
         suKA==
X-Gm-Message-State: AJIora9i8zeQDkIkEXhN/HeSRFU2/oLuN6H5OdPBtFfGaymYhwdNAfCA
        K+HMDt3OsUoZotDM8Ihoe67a0S1cNPxC3er8naT0QAxWdws=
X-Google-Smtp-Source: AGRyM1ur1qnzRFIv6VFNPqr5CrgcJ+egfvZrUgcnMLNyYEB02waWy6np5qzVVhFqyn3Gn9uK681tqYG01/XOSLu9DYo=
X-Received: by 2002:a05:6000:1a87:b0:21d:b5b9:7666 with SMTP id
 f7-20020a0560001a8700b0021db5b97666mr33481222wry.1.1658374563728; Wed, 20 Jul
 2022 20:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220719165743.3409313-1-vschneid@redhat.com> <YthDjPq3CtWc+o0/@slm.duckdns.org>
In-Reply-To: <YthDjPq3CtWc+o0/@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 21 Jul 2022 11:35:52 +0800
Message-ID: <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to exit()
To:     Tejun Heo <tj@kernel.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
>  /**
>   * destroy_worker - destroy a workqueue worker
>   * @worker: worker to be destroyed
> @@ -1999,6 +2011,16 @@ static void destroy_worker(struct worker *worker)
>
>         list_del_init(&worker->entry);
>         worker->flags |= WORKER_DIE;
> +
> +       /*
> +        * We're sending that thread off to die, so any CPU would do. This is
> +        * especially relevant for pcpu kworkers affined to an isolated CPU:
> +        * we'd rather not interrupt an isolated CPU just for a kworker to
> +        * do_exit().
> +        */
> +       if (!(worker->flags & WORKER_UNBOUND))
> +               unbind_worker(worker);
> +
>         wake_up_process(worker->task);
>  }

destroy_worker() is called with raw_spin_lock_irq(pool->lock), so
it cannot call the sleepable set_cpus_allowed_ptr().

From __set_cpus_allowed_ptr:
> * NOTE: the caller must have a valid reference to the task, the
> * task must not exit() & deallocate itself prematurely. The
> * call is not atomic; no spinlocks may be held.

I think it needs something like task_set_cpumask_possible() which is
documented as being usable in (raw) spinlocks and set the task's cpumask
to cpu_possible_mask and let the later ttwu help migrate it to a
proper non-isolated CPU or let it keep running.


On Thu, Jul 21, 2022 at 2:03 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Jul 19, 2022 at 05:57:43PM +0100, Valentin Schneider wrote:
> > It has been reported that isolated CPUs can suffer from interference due to
> > per-CPU kworkers waking up just to die.
> >
> > A surge of workqueue activity (sleeping workfn's exacerbate this) during
> > initial setup can cause extra per-CPU kworkers to be spawned. Then, a
> > latency-sensitive task can be running merrily on an isolated CPU only to be
> > interrupted sometime later by a kworker marked for death (cf.
> > IDLE_WORKER_TIMEOUT, 5 minutes after last kworker activity).
> >
> > Affine kworkers to the wq_unbound_cpumask (which doesn't contain isolated
> > CPUs, cf. HK_TYPE_WQ) before waking them up after marking them with
> > WORKER_DIE.
> >
> > This follows the logic of CPU hot-unplug, which has been packaged into
> > helpers for the occasion.
>
> Idea-wise, seems fine to me, but we have some other issues around twiddling
> cpu affinities right now, so let's wait a bit till Lai chimes in.
>

I think there are some imperfections related to cpu affinities
which need to be fixed too.

Thanks
Lai
