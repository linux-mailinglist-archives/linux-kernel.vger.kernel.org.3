Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13411512508
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiD0WJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiD0WJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:09:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B27F2ED75
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:06:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651097176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fs8gFf3ZL711StLZ9jERccLggUnW1SGq3CEhUrINzV0=;
        b=lNm2fzkOfKjGt1uFdPTtzYGBhEwjslUt4TR8A2eyU52xH7RNnZWoO2U0epSKTtiDGLzEr9
        WWUEDeNksHlgwlxuatHDDaGfIYO2FXPy4zw6QO87O4jAooMw6jugsI3S4sTVteaOP4h9Y2
        mLzOU1XjMoD8lapMBHl2aW+0ZxaejoKR8KX8DFK4YaWm0SUWXrWV9uiZRc2aKrl454YfhN
        gDSFHAY3cYvKD8Q4e7p7LThXXxz3c5I//Qlf+gWUFQ02US/bJEQTc7sCtEZQEhdFqYzrCg
        5KMwIEp1e0HSy3UT9ygBO5eM2SeQb+nAPAeE5/f4ySLbw1x10F+LkBw0Og7sWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651097176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fs8gFf3ZL711StLZ9jERccLggUnW1SGq3CEhUrINzV0=;
        b=GbZzHJd4aicLpdaUPaZIDklx21NZ41WOZeoc+3Lk47mVSt/uHp7/w3/aWDVl1BJ+HfZZ9c
        N6MOg7kEndzMiCCg==
To:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        prakash.sangappa@oracle.com
Subject: Re: [PATCH] ipc: Update semtimedop() to use hrtimer
In-Reply-To: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
References: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
Date:   Thu, 28 Apr 2022 00:06:16 +0200
Message-ID: <87k0baw59j.ffs@tglx>
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

Prakash,

On Mon, Apr 18 2022 at 18:51, Prakash Sangappa wrote:
> @@ -1995,7 +1995,10 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>  	int max, locknum;
>  	bool undos = false, alter = false, dupsop = false;
>  	struct sem_queue queue;
> -	unsigned long dup = 0, jiffies_left = 0;
> +	unsigned long dup = 0;
> +	ktime_t expires;
> +	int timed_out = 0;

bool perhaps?

> +	struct timespec64 end_time;
>  
>  	if (nsops < 1 || semid < 0)
>  		return -EINVAL;
> @@ -2008,7 +2011,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,

While at it, can you please replace the open coded validation of timeout
with timespec64_valid()?

>  			error = -EINVAL;
>  			goto out;
>  		}
> -		jiffies_left = timespec64_to_jiffies(timeout);
> +		ktime_get_ts64(&end_time);
> +		end_time = timespec64_add_safe(end_time, *timeout);
> +		expires = timespec64_to_ktime(end_time);

Converting to ktime first makes this cheaper:

                expires = ktime_get() + timespec64_to_ns(timeout);

Less code lines and shorter execution time because adding scalars is
obviously cheaper than adding timespecs.

Now if you add:

       ktime_t expires, *exp = NULL;

then you can do here:

                exp = &expires;
>  	}
>  
>  
> @@ -2167,7 +2172,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>  		rcu_read_unlock();
>  
>  		if (timeout)
> -			jiffies_left = schedule_timeout(jiffies_left);
> +			timed_out = !schedule_hrtimeout_range(&expires,
> +						current->timer_slack_ns,
> +						HRTIMER_MODE_ABS);
>  		else
>  			schedule();

and this can be simplified to:

                timed_out = !schedule_hrtimeout_range(exp, current->timer_slack_ns,
						      HRTIMER_MODE_ABS)

schedule_hrtimeout_range() directly invokes schedule() when @exp == NULL
and returns != 0 when woken up in that case.

> @@ -2210,7 +2217,7 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>  		/*
>  		 * If an interrupt occurred we have to clean up the queue.
>  		 */
> -		if (timeout && jiffies_left == 0)
> +		if (timeout && timed_out)

and this becomes

                if (timed_out)

>  			error = -EAGAIN;
>  	} while (error == -EINTR && !signal_pending(current)); /* spurious */

Hmm?

Done right, you should end up with a negative diffstat :)

Thanks,

        tglx
