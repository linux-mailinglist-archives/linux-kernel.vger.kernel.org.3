Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2A52A129
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiEQMIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiEQMIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:08:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACCC44775
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:08:15 -0700 (PDT)
Date:   Tue, 17 May 2022 14:08:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652789293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MlWKxx20PpPiJYYA2REZ7bm8M284MF+NrxrqYiWpc5g=;
        b=VwW03W2gJPYveOv71nk0T9X34jzXEj4zCbZO4MDAf8pqysrB3nTpP+wHslA7LTYwQe3I5I
        DESb7jhObLVBAoRH8cv3PYfME2jRhDTzrV+/MfPQzNYISxdKcZc5g+QoVDJuAMD/QRAenM
        GP3H6YmMHrEBzIyblH89Tvqdln4PkRxF8QiVJq0vSPVD3n4gO3Xx4sJ1VeQErnneKWbCPe
        gV27Gmm+XuxYXJY9ZKo6ykUT4snQkImj5AEzp2d7pDxe3pRPUt1D1YxltLl6rfEDMW9Fo4
        jS1i+MqiLKp9m7T2GhGfPcY9UFD7eu1kq89+0vnLoEFlW6J7f/s6v7wV0Z4bCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652789293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MlWKxx20PpPiJYYA2REZ7bm8M284MF+NrxrqYiWpc5g=;
        b=q+RcdnkffWCIhp/p4g6mqFAAagFkVFLJEtvYWqcUlsY0SS2t1KlTawdVqu5ZulyWfmWF4/
        u1ZOcWOEymoYhdDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/lockdep: Use sched_clock() for random numbers.
Message-ID: <YoOQLJeQtpY9gHMm@linutronix.de>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
 <YoNwp+9ko89Tf1ep@zx2c4.com>
 <YoNx9w1QocBY/P0I@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoNx9w1QocBY/P0I@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-17 11:59:19 [+0200], Jason A. Donenfeld wrote:
> On Tue, May 17, 2022 at 11:53:43AM +0200, Jason A. Donenfeld wrote:
> > Hi Sebastian,

Hi Jason,

> > Interesting RT consideration. I hope there aren't too many of these
> > special cases that would necessitate a general mechanism. Fingers
> > crossed this is the only one.

lockdep is special here. Haven't seen other explosions so far ;)

> > On Tue, May 17, 2022 at 11:16:14AM +0200, Sebastian Andrzej Siewior wrote:
> > > -			cookie.val = 1 + (prandom_u32() >> 16);
> > > +			cookie.val = 1 + (sched_clock() & 0xffff);
> > >  			hlock->pin_count += cookie.val;
> >  
> > I have no idea what the requirements here are. What would happen if you
> > just did atomic_inc_return(&some_global) instead? That'd be faster
> > anyhow, and it's not like 16 bits gives you much variance anyway...

it might work I guess. PeterZ? Would this_cpu_inc_return() work?

> Also, what is that `1 +` doing there? If the intention is to make sure
> this is non-zero, you might want the mask to be 0xfffe? Or you're
> counting on the assigned type being a u32 so it all overflows into the
> next zone the way you want it? Kinda weird.

hmm. It used to be 1 before prandom_u32() was introduced and the point
is probably to have a cookie != 0. val and pin_count are both unsigned
int/ 32bit so that overflow doesn't matter.

> Jason

Sebastian
