Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEBE4F99FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiDHP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbiDHP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:57:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8AF6416
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4413FB82BCB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E45FC385A6;
        Fri,  8 Apr 2022 15:55:32 +0000 (UTC)
Date:   Fri, 8 Apr 2022 11:55:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220408115530.0ccdf2e8@gandalf.local.home>
In-Reply-To: <87pmlrkgi3.ffs@tglx>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <87pmlrkgi3.ffs@tglx>
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

On Fri, 08 Apr 2022 12:37:40 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> +++ b/include/linux/timer.h
> @@ -183,12 +183,17 @@ extern int timer_reduce(struct timer_lis
>  extern void add_timer(struct timer_list *timer);
>  
>  extern int try_to_del_timer_sync(struct timer_list *timer);
> +extern int __del_timer_sync(struct timer_list *timer, bool free);

Do we really want to expose this to all the kernel?

That is, we do not need to make the static inlines in the header, but
instead do the split in the timer.c file. Not to mention, why have the
"free" parameter be created by the callers? It duplicates the work of
updating the second parameter around the kernel, instead of just in one
place.

One concern I have is that I wanted to keep the "free" version right next
to the del_timer() prototype. That way it becomes more visible to users and
they will be more likely to see it. I'm wondering if some of the issue
with not using del_timer_sync() is because it is not next to the other
prototypes, and people may have missed it.

>  
> -#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)

Is the above not important for del_timer_sync() anymore?

Can we just have a del_timer_sync() prototype and not have this macro logic
anymore?

Anyway, I'll take this code and make my updates and send out a v2.

Thanks,

-- Steve

> -  extern int del_timer_sync(struct timer_list *timer);
> -#else
> -# define del_timer_sync(t)		del_timer(t)
> -#endif
> +static inline int del_timer_sync(struct timer_list *timer)
> +{
> +	return __del_timer_sync(timer, false);
> +}
> +
> +static inline int del_timer_sync_free(struct timer_list *timer)
> +{
> +	return __del_timer_sync(timer, true);
> +}
>  
>  #define del_singleshot_timer_sync(t) del_timer_sync(t)
