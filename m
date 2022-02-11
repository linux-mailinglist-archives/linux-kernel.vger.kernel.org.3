Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A54B2B05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351715AbiBKQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:50:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiBKQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:50:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A688D;
        Fri, 11 Feb 2022 08:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EECEFB82ADF;
        Fri, 11 Feb 2022 16:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368EEC340EF;
        Fri, 11 Feb 2022 16:50:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KJ2fvHFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644598247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VRUkqAEiizSu43BjAMCLBt08gHzXkwUfIwopzZR9DWk=;
        b=KJ2fvHFmvAueMObxSInqANaPBgh+1o082OX5TfXNcenXTveHp2z2lac/0duvRACKAF0tgn
        F7VoDdr7EBSEw4nRNjaHZesIrN5eWqNton7cjILhvJrpNJXR5+nm89sb2Ul7Z8pNdzZppj
        RtzVLxKVn4xT2gmlywVyAE+cO3W1yGU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9db0223 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 16:50:47 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id c6so26682348ybk.3;
        Fri, 11 Feb 2022 08:50:46 -0800 (PST)
X-Gm-Message-State: AOAM532BH+10LdoBS/4s0Fml7IP+IsAvrrxATJet6MJJL+/a9E2HohAo
        EVKSQb7cMeI+Gp6mfoJKUfQ7Do3NMcj9sL67F9A=
X-Google-Smtp-Source: ABdhPJwsxBoz8X10lIX0T70GJP92VKKL38BL7O56lyySq+NtpTS6jqgAhPDxLDLt0kjs5/lJNM3Cut/X0Lboor0uMpM=
X-Received: by 2002:a25:c006:: with SMTP id c6mr2119755ybf.457.1644598245946;
 Fri, 11 Feb 2022 08:50:45 -0800 (PST)
MIME-Version: 1.0
References: <YgZ6IEbiDgz5X1ON@linutronix.de> <20220211162515.554867-1-Jason@zx2c4.com>
 <YgaSYlVEBOxfJbSD@linutronix.de>
In-Reply-To: <YgaSYlVEBOxfJbSD@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 11 Feb 2022 17:50:34 +0100
X-Gmail-Original-Message-ID: <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
Message-ID: <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Feb 11, 2022 at 5:44 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > +
> > +     /* Check to see if we're running on the wrong CPU due to hotplug. */
> > +     migrate_disable();
> > +     if (fast_pool != this_cpu_ptr(&irq_randomness)) {
> > +             migrate_enable();
> > +             /*
> > +              * If we are unlucky enough to have been moved to another CPU,
>
> + "during CPU hotplug while the CPU was shutdown". It should not look
> like the worker can be migrated on system without CPU-hotplug involved.

Will adjust comment.

> I *think* we could drop that "fast_pool !=
> this_cpu_ptr(&irq_randomness)" check at the top since that cmpxchg will
> save us and redo the loop. But if I remember correctly you worried about
> fast_pool->pool being modified (which is only a corner case if we are on
> the other CPU while the orig CPU is back again). Either way, it would be
> random and we would not consume more entropy.

No, we cannot, and "it's all random anyway so who cares if we corrupt
things!" is not rigorous, as entropy may actually be thrown away as
it's moved between words on each mix. If we're not running on the same
CPU, one CPU can corrupt the other's view of fast pool before updating
count. We must keep this.

> So if we have to keep this then please swap that migrate_disable() with
> local_irq_disable(). Otherwise PeterZ will yell at me.

Okay, I'll do that then, and then in the process get rid of the
cmpxchg loop since it's no longer required.

> >       if (unlikely(crng_init == 0)) {
> > -             if (fast_pool->count >= 64 &&
> > +             if (new_count >= 64 &&
> >                   crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
> > -                     fast_pool->count = 0;
> > +                     atomic_set(&fast_pool->count, 0);
> >                       fast_pool->last = now;
>
> I'm fine if we keep this as is for now.
> What do we do here vs RT? I suggested this
>   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=a2d2d54409481aa23a3e11ab9559a843e36a79ec
>
> Is this doable?

It might be, but last time I checked it seemed problematic. As I
mentioned in an earlier thread, I'll take a look again at that next
week after this patch here settles. Haven't forgotten.

v+1 coming up with irqs disabled.

Jason
