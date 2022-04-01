Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F914EEA4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbiDAJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344465AbiDAJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:23:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9D620C2F4;
        Fri,  1 Apr 2022 02:21:21 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:21:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648804879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m1HecoWE+iiHH4ehJehxpl0caYG8Y79MmUQV70QpxUk=;
        b=x2HPDsEyOtRuRE4I4sCZBszZiUXXPB+YGf4h7GhKgJLaY8QllGQ4BSe+9E0hJAGevLmEnB
        oBXuxjR0vXvmZRTfz18PKOjrDkI4c6rmEheue1ElfzJ2dT0/iOqHOOGhef/LAyrj8cdgIa
        CyK4jCZ+aJcBtCZukYwhu3RbbZog649T6B9cUfD9nxARUMA6LpPNNdFqi189K8gaPifr2c
        DwVL1VVul7BRAg0E5q0UdA3D6dLXGpkO3wwWVe95YKKqB9nZMYTYcnh5+qfI2cNg0tvYfF
        wkCXR360bGfTZeHlwER21amcm4oMXXOsKyzmdrvx1M/EVN7BAKbYQ7srkvZznw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648804879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m1HecoWE+iiHH4ehJehxpl0caYG8Y79MmUQV70QpxUk=;
        b=O505T+RrGZwrO+BcbOCRSbXVf0T0zEZL2ELO/BWY0OvfitTgLpsdJs1nv/gusP44yMWkHl
        FyEsjq36MfC2S4Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Tejun Heo <tj@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?utf-8?B?QW5kcsOp?= Pribil <a.pribil@beck-ipc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Message-ID: <YkbEDoPBKzVUqNLb@linutronix.de>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
 <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
 <YkHyzcfiyjLfIVOo@slm.duckdns.org>
 <YkKnlUUsufZPiZxM@linutronix.de>
 <8b21ad64-ea9c-84f2-c798-222c9383e3de@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b21ad64-ea9c-84f2-c798-222c9383e3de@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-29 10:33:19 [+0200], Rasmus Villemoes wrote:
> On 29/03/2022 08.30, Sebastian Andrzej Siewior wrote:
> > On 2022-03-28 07:39:25 [-1000], Tejun Heo wrote:
> >> Hello,
> > Hi,
> > 
> >> I wonder whether it'd be useful to provide a set of wrappers which can make
> >> switching between workqueue and kworker easy. Semantics-wise, they're
> >> already mostly aligned and it shouldn't be too difficult to e.g. make an
> >> unbounded workqueue be backed by a dedicated kthread_worker instead of
> >> shared pool depending on a flag, or even allow switching dynamically.
> 
> Well, that would certainly not make it any easier for userspace to
> discover the thread it needs to chrt().

It should be configured within the tty-layer and not making a working RT
just because it is possible.

> > This could work. For the tty layer it could use 'lowlatency' attribute
> > to decide which implementation makes sense.
> 
> I have patches that merely touch the tty layer, but tying it to the
> lowlatency attribute is quite painful (which has also come up in
> previous discussions on this) - because the lowlatency flag can be
> flipped from userspace, but synchronizing which variant is used and
> switching dynamically is at least beyond my skills to make work
> robustly. So in my patches, the choice is made at open() time. However,
> I'm still not convinced code like
> 
>  struct tty_bufhead {
>         struct tty_buffer *head;        /* Queue head */
>         struct work_struct work;
> +       struct kthread_work kwork;
> +       struct kthread_worker *kworker;
> 
> 
>  bool tty_buffer_restart_work(struct tty_port *port)
>  {
> -       return queue_work(system_unbound_wq, &port->buf.work);
> +       struct tty_bufhead *buf = &port->buf;
> +
> +       if (buf->kworker)
> +               return kthread_queue_work(buf->kworker, &buf->kwork);
> +       else
> +               return queue_work(system_unbound_wq, &buf->work);
>  }
> 
> etc. is the way to go.
> 
> ===
> 
> Here's another idea: In an ideal world, the irq thread itself [people
> caring about latency use threaded interrupts] could just do the work
> immediately - then the admin only has one kernel thread to properly
> configure. However, as Sebastian pointed out, doing that leads to a
> lockdep splat [1], and it also means that there's no work item involved,
> so some other thread calling tty_buffer_flush_work() might not actually
> wait for a concurrent flush_to_ldisc() to finish. So could we create a
> struct hybrid_work { } which, when enqueued, does something like
> 
>   bool current_is_irqthread(void) { return in_task() &&
> kthread_func(current) == irq_thread; }
> 
> hwork_queue(struct hybrid_work *hwork, struct workqueue_struct *wq)
>   if (current_is_irqthread()) {
>     task_work_add(current, &hwork->twork)
>   } else {
>     queue_work(wq, &hwork->work);
>   }
> 
> (with extra bookkeeping so _flush  and _cancel_sync methods can also be
> created). It would require irqthread to learn to run its queued
> task_works in its main loop, which in turn would require finding some
> other way to do the irq_thread_dtor() cleanup, but that should be doable.
> 
> While the implementation of hybrid_work might be a bit complex, I think
> this would have potential for being used in other situations, and for
> the users, the API would be as simple as the current workqueue/struct
> kwork APIs. By letting the irq thread do more/all of the work, we'd
> probably also win some latency due to fewer threads involved and better
> cache locality. And the admin/BSP is already setting the rt priorities
> of the [irq/...] threads.

Hmmm. Sounds complicated. Especially the part where irqthread needs to
deal with irq_thread_dtor in another way.
If this is something we want for everyone and not just for the "low
latency" attribute because it seems to make sense for everyone, would it
work to add the data in one step and then flush it once all locks are
dropped? The UART driver could be extended to a threaded handler if it
is not desired/ possible to complete in the primary handler.

> Rasmus

Sebastian
