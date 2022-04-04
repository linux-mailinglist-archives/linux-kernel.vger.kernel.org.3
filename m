Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6F4F1109
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiDDIeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDDIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:34:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7A35268
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:32:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649061167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QD9Nb7yJabZzo/4wQdWDUvSpWf7rTbKauGlMZ2wI9I4=;
        b=BDdixwPuv6Sc1CB0q0w75VqdaMnSHVZhfcGr1zxwC+BJn+oDayYQ9hIPWw3z8vUz+8IGWS
        h4rBqMyo15a9gaabE7WiT8CpfO3n/5dYuNAMwlNp8hn1IAqBuHTiFcjvfUVVUVLAN+o0oS
        LJLgLyhCrwN45JSBN2b0Mrn+Bwpta6sxcq/BXA+Nb1G61WYDoIRgAbel1QNk1ssVKCW6Mw
        xjzgDQv+Fnc1XWd4XnNSl7L8YXIBuHM8oLPyhZ+OjDBFx4LSdBdtyg5oTP17v4zWz0lNMZ
        rPuBRS9eYXpZo126u4zR6dxFWX1C5IYjkxgX0WHkOflbuC60kQgqbgvvozc+0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649061167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QD9Nb7yJabZzo/4wQdWDUvSpWf7rTbKauGlMZ2wI9I4=;
        b=lRWZ7MgFKxPyOkDySzlC40J/O5OtqKbz8MwSLvMjPf+lUNANwIHw+OpklTwEvotsJ4cX0q
        1M6eI6d32cKXu7Bg==
To:     Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: UML time-travel warning from __run_timers
In-Reply-To: <ff314e8556aba7e231ab80c46b30701142e82a43.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
 <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
 <877d86m978.ffs@tglx>
 <32423b7c0e3a490093ceaca750e8669ac67902c6.camel@sipsolutions.net>
 <87pmlykksj.ffs@tglx>
 <ff314e8556aba7e231ab80c46b30701142e82a43.camel@sipsolutions.net>
Date:   Mon, 04 Apr 2022 10:32:46 +0200
Message-ID: <87ee2dl041.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04 2022 at 09:02, Johannes Berg wrote:
> On Sun, 2022-04-03 at 21:51 +0200, Thomas Gleixner wrote:
>> but that's fine and it is overwritten by every timer which is inserted
>> to expire before that. So that's not an issue as the prandom timer is
>> firing and rearmed.
>
> No, as I said before, there's never any timer with base 1 (BASE_DEF) in
> the config we have. The prandom timer is not TIMER_DEFERRABLE (it
> probably could be, but it's not now). There's no deferrable timer at
> all. Once there is at least one, the warning goes away.

Groan. I overlooked the deferrable part. Yes, you are right. next_expiry
of the deferrable base is stale when there is no timer queued up to the
point where base->clk reaches the initial next_expiry value. So the
check is bogus.

Thanks,

        tglx
---
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1724,9 +1724,8 @@ static inline void __run_timers(struct t
 		/*
 		 * The only possible reason for not finding any expired
 		 * timer at this clk is that all matching timers have been
-		 * dequeued.
+		 * dequeued or no timer has been ever queued.
 		 */
-		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
 





