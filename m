Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05634F8B42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiDGWxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiDGWxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:53:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD69169B32
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1CD8B82956
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3583FC385A8;
        Thu,  7 Apr 2022 22:51:46 +0000 (UTC)
Date:   Thu, 7 Apr 2022 18:51:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220407185144.5ac036b7@gandalf.local.home>
In-Reply-To: <20220407215802.GB186606@roeck-us.net>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <20220407215802.GB186606@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 14:58:02 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > Add a del_timer_free() that not only does a del_timer_sync() but will mark  
> 
> This limits the use case to situations where del_timer_sync() can actually
> be called. There is, however, code where this is not possible.
> Specifically, it doesn't work if the code triggered with the timer uses a
> lock, and del_timer() is also called under that same lock. An example for
> that is the code in sound/synth/emux/emux.c. How do you suggest to handle
> that situation ?

Easy. Tell me how that situation is not a bug?

That code you point out at emux.c looks extremely buggy as well. In other
words, if you can't call del_timer_free() for the reason you mention above,
the code is very likely to have race conditions. I cannot think of a
situation that it is safe to do this.

In fact, I think that just replacing that with del_timer_free() may be good
enough. At least to show why it blows up later. I'm confused in what they
are doing by taking that lock. I can see:

	CPU1				CPU2
	----				----
				    snd_emux_timer_callback()
    spin_lock(voice_lock)
    if (timer_active)
	del_timer()
    spin_unlock(voice_lock)

				    [..]
				    	do_again++
				    [..]
				    if (do_again) {
					mod_timer()
					timer_active = 1;
				    }

    [..]
    free(emu);


BOOM!!

Hmm, perhaps I should change the code in __mod_timer() to:

	if (WARN_ON(timer->flags & TIMER_FREED))
		return;

To not rearm it.

-- Steve
