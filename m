Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529754B2B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351908AbiBKQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:59:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245403AbiBKQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:59:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB31A1;
        Fri, 11 Feb 2022 08:59:00 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:58:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644598738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UesU5GH5Yz6aViOyhXXlMKKRjVJ5Zol7Vf+S5MIZhdg=;
        b=h7+6vVtC+rCubRqvyxsZqX+UV7J4+h6vefmYCFhmwZhsRqIgZLgJZjcUE9cB+k/VEQW4zF
        1UWVk6F2jqjW0rrHfax6Pct76kGdDir+fKYVX258lK8LbKtW5TjazFUnEn3bFGf9BLDjaX
        RYsQx4GJ01ORF+ymQXFrqCSbtWArWmwRoIgQ7urnosDuRMJuLMwTVFTP0GKsewkceONQjP
        sy/0Cjd+ai1rgBJf6NCozK4nKEAbm2tx66JLDcimB9hugPWqHPYTfDlyDh+K72QGc2kGtb
        lGbTVgkFS5eQVQJ/7r+j/iJPXG6MXFmSyR9eNfr9kbdFvX/Ji2/PLEIBSx6TSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644598738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UesU5GH5Yz6aViOyhXXlMKKRjVJ5Zol7Vf+S5MIZhdg=;
        b=crlyBxVS6w6gAA/ibqmhLECZ6xtqocwr0dBCenRSA3wCqatkViBoToEqQtKrWZ1IxCYT5B
        rrd6zzbLmyiIM3Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
Message-ID: <YgaV0UZO1KfmtLLh@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de>
 <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de>
 <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 17:50:34 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> > I *think* we could drop that "fast_pool !=
> > this_cpu_ptr(&irq_randomness)" check at the top since that cmpxchg will
> > save us and redo the loop. But if I remember correctly you worried about
> > fast_pool->pool being modified (which is only a corner case if we are on
> > the other CPU while the orig CPU is back again). Either way, it would be
> > random and we would not consume more entropy.
> 
> No, we cannot, and "it's all random anyway so who cares if we corrupt
> things!" is not rigorous, as entropy may actually be thrown away as
> it's moved between words on each mix. If we're not running on the same
> CPU, one CPU can corrupt the other's view of fast pool before updating
> count. We must keep this.

Okay, I assumed something like that.

> > So if we have to keep this then please swap that migrate_disable() with
> > local_irq_disable(). Otherwise PeterZ will yell at me.
> 
> Okay, I'll do that then, and then in the process get rid of the
> cmpxchg loop since it's no longer required.

So the only reason why we have that atomic_t is for rare case where run
on the remote CPU and need to remove the upper bit in the counter?

> > >       if (unlikely(crng_init == 0)) {
> > > -             if (fast_pool->count >= 64 &&
> > > +             if (new_count >= 64 &&
> > >                   crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
> > > -                     fast_pool->count = 0;
> > > +                     atomic_set(&fast_pool->count, 0);
> > >                       fast_pool->last = now;
> >
> > I'm fine if we keep this as is for now.
> > What do we do here vs RT? I suggested this
> >   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=a2d2d54409481aa23a3e11ab9559a843e36a79ec
> >
> > Is this doable?
> 
> It might be, but last time I checked it seemed problematic. As I
> mentioned in an earlier thread, I'll take a look again at that next
> week after this patch here settles. Haven't forgotten.

Ah, cheers.

> v+1 coming up with irqs disabled.
> 
> Jason

Sebastian
