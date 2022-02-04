Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAD4AA2DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbiBDWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:08:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53720 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiBDWIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:08:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF436198D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC3CC340EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 22:08:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZE+NVOfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644012528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRvVOXCbkZBW7mENo7woBzmh4pVFhQ8gpBun5sIWACc=;
        b=ZE+NVOfgN/CbvqOnJmTZf2H5tqX0B2oAVqoKEcANaRL3TGY7Cqx8JdQbhaMuovh3hgXwpC
        5M9gsa5AQCp8LyGp4VdrdJhegUM3G0jjc3eZa3epqknpW2FyZh0aXESjaFgUlPJtcknLAy
        sBHl+jKH6NAM0P9d9EPVdq75nNdElQQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ad6f4fc3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 4 Feb 2022 22:08:47 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id g14so22595005ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 14:08:47 -0800 (PST)
X-Gm-Message-State: AOAM533qoCbfagHb6CSESevOnEDlbsmqyoECV1I29AiRnHO68BgQnSKz
        zKBqBcx8g05Fm6LL5Fkd2+zYxw7VmG0JEdQ+dDw=
X-Google-Smtp-Source: ABdhPJyENoWipZY7LU4mv9ijhI/tarqnBrTFshQpFWcq83RJ3ridzcqZXD/rVf1zyfkuoeO3bxTBayr+1H5NANV+N8k=
X-Received: by 2002:a05:6902:726:: with SMTP id l6mr1352344ybt.115.1644012526199;
 Fri, 04 Feb 2022 14:08:46 -0800 (PST)
MIME-Version: 1.0
References: <YfgPWatDzkn2ozhm@linutronix.de> <20220204153149.51428-1-Jason@zx2c4.com>
 <Yf2Q25T04cAxJY3H@linutronix.de>
In-Reply-To: <Yf2Q25T04cAxJY3H@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 23:08:35 +0100
X-Gmail-Original-Message-ID: <CAHmME9oYj6tp+THaz_74SWikpTLSzukH-DynypB+7SZ56hucog@mail.gmail.com>
Message-ID: <CAHmME9oYj6tp+THaz_74SWikpTLSzukH-DynypB+7SZ56hucog@mail.gmail.com>
Subject: Re: [PATCH RFC v1] random: do not take spinlocks in irq handler
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Feb 4, 2022 at 9:47 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> No need for atomic. If this is truly per-CPU then there will be no
> cross-CPU access, right?
> Therefore I would suggest to use __this_cpu_inc_return() which would avoid
> the sync prefix for the inc operation. Same for __this_cpu_or(). And you
> could use unsigned int.

Good thinking. Done.

>
> > +             schedule_work(&fast_pool->mix);
>
> schedule_work() has a check which ensures that the work is not scheduled
> again if still pending. But we could consider it fast-path and say that
> it makes sense to keep it.

The PENDING flag is cleared after the work item has been assigned to a
worker, but _before_ the function has actually run. This means you
might wind up scheduling for that work to run again while it's already
running, which isn't what we want. So ORing in that flag lets us track
things until the end of that function.

> You could use schedule_work_on() so it remains on the local CPU. Makes
> probably even more sense on NUMA systems. Otherwise it is an unbound
> worker and the scheduler (and even the worker)_could_ move it around.

Was just thinking about that too. Will do.

> With schedule_work_on() it still _could_ be moved to another CPU during
> CPU hotplug. Therefore you should check in mix_interrupt_randomness() if
> the worker is == this_cpu_ptr() and otherwise abort. Puh this asks for a
> CPU-hotplug handler to reset FAST_POOL_MIX_INFLIGHT in the CPU-UP path.
> That would be the price for using this_cpu_inc()/or ;)

Not a fan of adding a hotplug handler. However, actually I think we
don't need the worker==this_cpu_ptr() check. If a CPU is taken
offline, yet that CPU contributed a healthy set of IRQs to the fast
pool such that the worker got queued up, then we should just go ahead
and ingest them. In the worst case, the CPU comes back online midway
and contributes a little bit more than usual, but this is already the
race we have with the worker itself being interrupted by an irq, so it
seems fine.

> This might even classify for using system_highpri_wq (e.g.
>   queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);

Good thinking.

Re:crng_fast_load, you said:
> RT wise we _could_ acquire that spinlock_t in IRQ context early during
> boot as long as system_state < SYSTEM_SCHEDULING. After that, we could
> dead lock.

Unfortunately, I don't think that's a guarantee we have on all systems
:-\. I'll try to think more carefully through the consequences of just
_removing those spinlocks_ and letting it race, and see if there's a
way that makes sense. I'm not sure it does, but I'll need to put my
thinking cap on. Either way, it seems like that's now a third puzzle
we'll wind up addressing separately.

I'll roll a v2.

Jason
