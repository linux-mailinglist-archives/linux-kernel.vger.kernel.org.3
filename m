Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415D64A3ACD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356602AbiA3Wz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:55:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39072 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiA3Wz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:55:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96A70B829CC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 22:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3242CC340EE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 22:55:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vk5Ffwm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643583321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5yL11feerAP9TQw+vK5v7aV6sNjJWs3lf2SsPfuRJk=;
        b=Vk5Ffwm5g7FtiOc9NI7YEYpOm9VcsTNTHn+gCc6bsGwHD6ntmjlVPp5bXFtBg3c9wXs0ck
        pMCWDgmPbcCKADKGomy9S0z2S1kbuPnxdHZtWs0tty2g8ihaUKmPZMtDU8fJfD6uzyiwrX
        mA0tBJyL61NU6B9AjnaK2c4OrSRhlU4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9f8c4950 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 30 Jan 2022 22:55:21 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id c6so35197500ybk.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 14:55:20 -0800 (PST)
X-Gm-Message-State: AOAM531R12jF4K9/iK6oInpbxxm5I1WDQ0NRfIo39koMhATnVQq+/Eev
        3+tBtBQBSwoLdzh0tMcE10pp8g+p4R4mxZl/iz8=
X-Google-Smtp-Source: ABdhPJxGgT43yr8HBqkG/DKyYu4rtoX0zSy6gH0vkFt7su9zas6F0qaF3yUkMywrNSxkZ0WIGnEE6ULGZq3zeONy/tI=
X-Received: by 2002:a25:ae0d:: with SMTP id a13mr26763754ybj.115.1643583319861;
 Sun, 30 Jan 2022 14:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-6-bigeasy@linutronix.de> <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
 <20211207201037.h46573oa5nfj33xq@linutronix.de> <CAHmME9pzdXyD0oRYyCoVUSqqsA9h03-oR7kcNhJuPEcEMTJYgw@mail.gmail.com>
 <Yd8Ujw4t8DKYuhZK@linutronix.de>
In-Reply-To: <Yd8Ujw4t8DKYuhZK@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 30 Jan 2022 23:55:09 +0100
X-Gmail-Original-Message-ID: <CAHmME9oXSx4JS0ZJeZTb7VC3gXoackuH389V9FDknHf_-rDJyA@mail.gmail.com>
Message-ID: <CAHmME9oXSx4JS0ZJeZTb7VC3gXoackuH389V9FDknHf_-rDJyA@mail.gmail.com>
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sebastian,

I spent the weekend thinking about this some more. I'm actually
warming up a bit to the general approach of the original solution
here, though still have questions. To summarize my understanding of
where we are:

Alternative solution we've been discussing:
- Replace spinlock_t with raw spinlocks.
- Ratelimit userspace-triggered latency inducing ioctls with
ratelimit() and an additional mutex of sorts.
- Result: pretty much the same structure we have now, but with some
added protection for PREEMPT_RT.

Your original solution:
- Absorb into the fast pool during the actual IRQ, but never dump it
into the main pool (nor fast load into the crng directly if
crng_init==0) from the hard irq.
- Instead, have irq_thread() check to see if the calling CPU's fast
pool is >= 64, and if so, dump it into the main pool (or fast load
into the crng directly if crng_init==0).

I have two questions about the implications of your original solution:

1) How often does irq_thread() run? With what we have now, we dump the
fast pool into the main pool at exactly 64 events. With what you're
proposing, we're now in >= 64 territory. How do we conceptualize how
far beyond 64 it's likely to grow before irq_thread() does something?
Is it easy to make guarantees like, "at most, probably around 17"? Or
is it potentially unbounded? Growing beyond isn't actually necessarily
a bad thing, but it could potentially *slow* the collection of
entropy. That probably matters more in the crng_init==0 mode, where
we're just desperate to get whatever we can as fast as we can. But
depending on how large that is, it could matter for the main case too.
Having some handle on the latency added here would be helpful for
thinking about this.

2) If we went with this solution, I think I'd prefer to actually do it
unconditionally, for PREEMPT_RT=y and PREEMPT_RT=n. It's easier to
track how this thing works if the state machine always works in one
way instead of two. It also makes thinking about performance margins
for the various components easier if there's only one way used. Do you
see any downsides in doing this unconditionally?

Regards,
Jason
