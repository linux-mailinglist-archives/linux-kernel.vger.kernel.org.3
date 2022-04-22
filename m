Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D183150BC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449598AbiDVP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449587AbiDVP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:56:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D11DA76;
        Fri, 22 Apr 2022 08:53:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650642805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egLwwNxV76btrQ9q6om6wjZt3PbLjlniEsPtA9utVZE=;
        b=0B/g2yGcr/YICXgS6yxrwyv3L9VyBOoE8ZDe1IZ6DiB/hNt5NOAtPBfDcbaVGnuC9NBNZr
        WzfW8KArxGYgHvrcWCVUrCfsCUZGiDLCKSsTnh0rQMZBoir0Bdf56o8yJmEZZXhQn3fvOi
        1pij3IAAlT1DL0fv/o751EUPVw2qSAezWfAOD+BpCvTQD5HqXOm5BIChszEt3x5eGIGu/b
        Cq1vZ4TjAROsrj/gm8Trlv8CuRVFPsRcRfce+81J0wg5OJUCBzNuzX69kH0UfKEhmjEwEo
        3rHc0uew53iewGSZoklZ1XUowp1GyVzmdH+YBE0l1LfmOesn9cVZML2A5eXjUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650642805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egLwwNxV76btrQ9q6om6wjZt3PbLjlniEsPtA9utVZE=;
        b=h+b8XloVx+fEEddSy+0yPJCFyuqiaW+GGnk2EUrdGujBSkcAApL+SE7A/hzyZEQRVQVwfy
        nZLkXLdKq0h2SMDg==
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, paulmck@kernel.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rcu <rcu@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re:
In-Reply-To: <1649818529.j46672mh2p.astroid@bobo.none>
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <87pmls6nt7.fsf@mpe.ellerman.id.au> <87k0bz7i1s.fsf@mpe.ellerman.id.au>
 <1649818529.j46672mh2p.astroid@bobo.none>
Date:   Fri, 22 Apr 2022 17:53:24 +0200
Message-ID: <87fsm55d3f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13 2022 at 15:11, Nicholas Piggin wrote:
> So we traced the problem down to possibly a misunderstanding between 
> decrementer clock event device and core code.
>
> The decrementer is only oneshot*ish*. It actually needs to either be 
> reprogrammed or shut down otherwise it just continues to cause 
> interrupts.

I always thought that PPC had sane timers. That's really disillusioning.

> Before commit 35de589cb879, it was sort of two-shot. The initial 
> interrupt at the programmed time would set its internal next_tb variable 
> to ~0 and call the ->event_handler(). If that did not set_next_event or 
> stop the timer, the interrupt will fire again immediately, notice 
> next_tb is ~0, and only then stop the decrementer interrupt.
>
> So that was already kind of ugly, this patch just turned it into a hang.
>
> The problem happens when the tick is stopped with an event still 
> pending, then tick_nohz_handler() is called, but it bails out because 
> tick_stopped == 1 so the device never gets programmed again, and so it 
> keeps firing.
>
> How to fix it? Before commit a7cba02deced, powerpc's decrementer was 
> really oneshot, but we would like to avoid doing that because it requires 
> additional programming of the hardware on each timer interrupt. We have 
> the ONESHOT_STOPPED state which seems to be just about what we want.
>
> Did the ONESHOT_STOPPED patch just miss this case, or is there a reason 
> we don't stop it here? This patch seems to fix the hang (not heavily
> tested though).

This was definitely overlooked, but it's arguable it is is not required
for real oneshot clockevent devices. This should only handle the case
where the interrupt was already pending.

The ONESHOT_STOPPED state was introduced to handle the case where the
last timer gets canceled, so the already programmed event does not fire.

It was not necessarily meant to "fix" clockevent devices which are
pretending to be ONESHOT, but keep firing over and over.

That, said. I'm fine with the change along with a big fat comment why
this is required.

Thanks,

        tglx
