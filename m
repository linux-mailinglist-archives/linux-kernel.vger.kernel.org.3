Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7A58A4BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiHECa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHECaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:30:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E4D2648
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:30:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a11so769000wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f2BJAmcvvAY58PqydeJ3rqlXHLmAQBj3QTr5P4Kw3c0=;
        b=BCWgPMUiqsf6voBMKS3E1sVghsxihJNJYf6OZNBIW1EBgukFXdjKdpXkknYwboJZmV
         Oqg80QJnNRE9vRnhZrYEE6FN4M8zsYFhNRd87LrpXvgxVp8qO43AaJjaXBa5iwfOQPPa
         tw+vo0v2ZRV+Vh+ewQct2iJyX0WkhWWL3QVKiRwe1zLaZkLJjMbe6BY7qqb3qG83QcoG
         mA2Bdy+AaF8GIYwiIzNJsCbB4/XmlsTLrpKxAMW/r+ux6DKmla4N7synfrp3WyzfHslQ
         Hac9bUR4u4M6yF+OjPnj/60AKZ+lox08y6pAEGGbISYv9LBpsiVVoZNU7uzF9B57SMOx
         PNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f2BJAmcvvAY58PqydeJ3rqlXHLmAQBj3QTr5P4Kw3c0=;
        b=mQ8ctsCcZq179Oed9yEgReOnbijtgHAsY5AHvZyMtdFrUJLI306DsEyIsNbi22k9Ch
         YqdEZV9Ga7a6YbYDjhgwjJbn/SK8JbbFADRXSdKtXNI4UxJt6tpHopLXsDKlP4qteyBA
         JEE+ygEudpL4q14NjLfInXoOiA6IHXFVZUG7QXWUIQ+Yr2IAYjbt1TmR2jjSFsPXDJ9O
         YT8ZLuNGOokcbgQ075Jxt7TMgEgvnfZmCNtmSz1DuyF+V7GIEjhXa9Q5N/KK881mSRJu
         S16VJxfTaP0bEU3sQHaLtn0LUZOdETm2/2AiPDKvPgQRfJNFu1AiXi6BfeTlwJsAIjEu
         xTNw==
X-Gm-Message-State: ACgBeo1PdvT9cGmiWSJ6PI5Caeh8S4vZHJr6YdCldv9GaQ6M6vywyINV
        XgsMI65MF43ZHlMbjxS5J6mTjE/Fz5wrEHU19Bi+OI6To4o=
X-Google-Smtp-Source: AA6agR583zdSdbt9DGt/RdC+2iBD6u4dj1TSH3PYoKW9X3RGUMvo+oo42KBSOe0pORHN4Ma+l2lvwRbIQ1IeDD0Llow=
X-Received: by 2002:a7b:cb55:0:b0:3a5:41a:829c with SMTP id
 v21-20020a7bcb55000000b003a5041a829cmr5524554wmj.153.1659666622409; Thu, 04
 Aug 2022 19:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-3-jiangshanlai@gmail.com> <20220804123520.1660-1-hdanton@sina.com>
In-Reply-To: <20220804123520.1660-1-hdanton@sina.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 5 Aug 2022 10:30:10 +0800
Message-ID: <CAJhGHyBaPPRvEMy7pJRKA6wU27tCrCMpO4MfjObhDP-vjQvjfw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/8] workqueue: Make create_worker() safe against
 prematurely wakeups
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
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

 i

On Thu, Aug 4, 2022 at 8:35 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu,  4 Aug 2022 16:41:29 +0800 Lai Jiangshan wrote:
> >
> > @@ -1942,6 +1943,7 @@ static struct worker *create_worker(struct worker_pool *pool)
> >               goto fail;
> >
> >       worker->id = id;
> > +     worker->pool = pool;
> >
> >       if (pool->cpu >= 0)
> >               snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
> > @@ -1949,6 +1951,7 @@ static struct worker *create_worker(struct worker_pool *pool)
> >       else
> >               snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
> >
> > +     reinit_completion(&pool->created);
> >       worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
> >                                             "kworker/%s", id_buf);
> >       if (IS_ERR(worker->task))
> > @@ -1957,15 +1960,9 @@ static struct worker *create_worker(struct worker_pool *pool)
> >       set_user_nice(worker->task, pool->attrs->nice);
> >       kthread_bind_mask(worker->task, pool->attrs->cpumask);
> >
> > -     /* successful, attach the worker to the pool */
> > -     worker_attach_to_pool(worker, pool);
> > -
> >       /* start the newly created worker */
> > -     raw_spin_lock_irq(&pool->lock);
> > -     worker->pool->nr_workers++;
> > -     worker_enter_idle(worker);
> >       wake_up_process(worker->task);
> > -     raw_spin_unlock_irq(&pool->lock);
> > +     wait_for_completion(&pool->created);
> >
> >       return worker;
>
>         cpu0    cpu1            cpu2
>         ===     ===             ===
>                 complete
>
>         reinit_completion
>                                 wait_for_completion

reinit_completion() and wait_for_completion() are both in
create_worker().  create_worker() itself is mutually exclusive
which means no two create_worker()s running at the same time
for the same pool.

No work item can be added before the first initial create_worker()
returns for a new or first-online per-cpu pool, so there would be no
manager for the pool during the first initial create_worker().

The manager is the only worker who can call create_worker() for a pool
except the first initial create_worker().

And there is always only one manager after the first initial
create_worker().

The document style in some of workqueue code is:
"/* locking rule: what it is */"

For example:
struct list_head        worklist;       /* L: list of pending works */
which means it is protected by pool->lock.

And for
struct completion       created;        /* create_worker(): worker created */
it means it is protected by the exclusive create_worker().

>
> Any chance for race above?
