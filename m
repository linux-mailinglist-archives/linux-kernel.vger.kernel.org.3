Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3774AA161
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbiBDUr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:47:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34182 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbiBDUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:47:26 -0500
Date:   Fri, 4 Feb 2022 21:47:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644007645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrHK2jZ1689vU2EId7U6HmWTMJfVQXeuCyDVsInCooc=;
        b=LBMgka64d45aJLW4QEbMZHQ7I3PHs/lUdmImZsV0tq3pNjVHfjba9scHpZEhD4Ynq0dECG
        vkwTMa42KGi7OwH9pmiiri23SfxdFJrjhfE5HnIv14NjCaXNGLnzWnwui4xQKdsmbdyx7v
        T/XW/ZuQUnT1PYp8NqcG50x18Y3vInFMSVMJUqKNHAsN+u/tpukM5MKiM2tIobyAEO1XNy
        6AeRA+/S8djqa7CeKEdKlMRIxdTLgP7ySDCj1bjfWFX0IvnMjtZ8abkNFxAYZcCFlFaVPj
        weHZdVcAeJ/SVwHAh26EJWcEji2quNxHV8ixCAbBDL06dENWOyA93iS85xzQ2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644007645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BrHK2jZ1689vU2EId7U6HmWTMJfVQXeuCyDVsInCooc=;
        b=eqUHi9IQYJVE3JCELWPP+lBTAkm/6YcD7ky9YJ/QSXSbaG8XX9pP3tFYq4YzadjIYacAu6
        BPhKPhyMDuk4VJCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH RFC v1] random: do not take spinlocks in irq handler
Message-ID: <Yf2Q25T04cAxJY3H@linutronix.de>
References: <YfgPWatDzkn2ozhm@linutronix.de>
 <20220204153149.51428-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204153149.51428-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 16:31:49 [+0100], Jason A. Donenfeld wrote:
> Sebastian - what do you think of this as a deferred scheme to get rid of
> that locking? Any downsides of using workqueues like this?

I backported additionally the commit
   random: use computational hash for entropy extraction

and thrown both into my v5.17-RT tree. From the debugging it looks good.
Will do more testing more next week.
|          <idle>-0       [005] dn.h2..  9189.894548: workqueue_queue_work: work struct=00000000ad070cf1 function=mix_interrupt_randomness wor
|kqueue=events req_cpu=8192 cpu=5
|     kworker/5:2-1071    [005] .......  9189.894594: workqueue_execute_start: work struct 00000000ad070cf1: function mix_interrupt_randomness
|     kworker/5:2-1071    [005] .......  9189.894595: workqueue_execute_end: work struct 00000000ad070cf1: function mix_interrupt_randomness

>  drivers/char/random.c         | 67 +++++++++++++++++++----------------
>  include/trace/events/random.h |  6 ----
>  2 files changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 455615ac169a..a74897fcb269 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -383,12 +383,6 @@ static void _mix_pool_bytes(const void *in, int nbytes)
>  	blake2s_update(&input_pool.hash, in, nbytes);
>  }
>  
> -static void __mix_pool_bytes(const void *in, int nbytes)
> -{
> -	trace_mix_pool_bytes_nolock(nbytes, _RET_IP_);
> -	_mix_pool_bytes(in, nbytes);
> -}
> -
>  static void mix_pool_bytes(const void *in, int nbytes)
>  {
>  	unsigned long flags;
> @@ -400,11 +394,13 @@ static void mix_pool_bytes(const void *in, int nbytes)
>  }
>  
>  struct fast_pool {
> -	u32 pool[4];
> +	struct work_struct mix;
>  	unsigned long last;
> +	u32 pool[4];
> +	atomic_t count;
>  	u16 reg_idx;
> -	u8 count;
>  };
> +#define FAST_POOL_MIX_INFLIGHT (1U << 31)
>  
>  /*
>   * This is a fast mixing routine used by the interrupt randomness
> @@ -434,7 +430,6 @@ static void fast_mix(struct fast_pool *f)
>  
>  	f->pool[0] = a;  f->pool[1] = b;
>  	f->pool[2] = c;  f->pool[3] = d;
> -	f->count++;
>  }
>  
>  static void process_random_ready_list(void)
> @@ -985,12 +980,37 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
>  	return *ptr;
>  }
>  
> +static void mix_interrupt_randomness(struct work_struct *work)
> +{
> +	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
> +
> +	fast_pool->last = jiffies;
> +
> +	/* Since this is the result of a trip through the scheduler, xor in
> +	 * a cycle counter. It can't hurt, and might help.
> +	 */

Please do a proper two line comment.

> +	fast_pool->pool[3] ^= random_get_entropy();
> +
> +	if (unlikely(crng_init == 0)) {
> +		if (crng_fast_load((u8 *)&fast_pool->pool, sizeof(fast_pool->pool)) > 0)
> +			atomic_set(&fast_pool->count, 0);
> +		else
> +			atomic_and(~FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
> +		return;
> +	}
> +
> +	mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
> +	atomic_set(&fast_pool->count, 0);
> +	credit_entropy_bits(1);
> +}
> +
>  void add_interrupt_randomness(int irq)
>  {
>  	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
>  	struct pt_regs *regs = get_irq_regs();
>  	unsigned long now = jiffies;
>  	cycles_t cycles = random_get_entropy();
> +	unsigned int new_count;
>  	u32 c_high, j_high;
>  	u64 ip;
>  
> @@ -1008,29 +1028,14 @@ void add_interrupt_randomness(int irq)
>  	fast_mix(fast_pool);
>  	add_interrupt_bench(cycles);
>  
> -	if (unlikely(crng_init == 0)) {
> -		if ((fast_pool->count >= 64) &&
> -		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
> -			fast_pool->count = 0;
> -			fast_pool->last = now;
> -		}
> -		return;
> +	new_count = (unsigned int)atomic_inc_return(&fast_pool->count);
> +	if (new_count >= 64 && new_count < FAST_POOL_MIX_INFLIGHT &&
> +	    (time_after(now, fast_pool->last + HZ) || unlikely(crng_init == 0))) {
> +		if (unlikely(!fast_pool->mix.func))
> +			INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
> +		atomic_or(FAST_POOL_MIX_INFLIGHT, &fast_pool->count);

No need for atomic. If this is truly per-CPU then there will be no
cross-CPU access, right?
Therefore I would suggest to use __this_cpu_inc_return() which would avoid
the sync prefix for the inc operation. Same for __this_cpu_or(). And you
could use unsigned int.

> +		schedule_work(&fast_pool->mix);

schedule_work() has a check which ensures that the work is not scheduled
again if still pending. But we could consider it fast-path and say that
it makes sense to keep it.
You could use schedule_work_on() so it remains on the local CPU. Makes
probably even more sense on NUMA systems. Otherwise it is an unbound
worker and the scheduler (and even the worker)_could_ move it around.
With schedule_work_on() it still _could_ be moved to another CPU during
CPU hotplug. Therefore you should check in mix_interrupt_randomness() if
the worker is == this_cpu_ptr() and otherwise abort. Puh this asks for a
CPU-hotplug handler to reset FAST_POOL_MIX_INFLIGHT in the CPU-UP path.
That would be the price for using this_cpu_inc()/or ;)
This might even classify for using system_highpri_wq (e.g.
  queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
).
>  	}
> -
> -	if ((fast_pool->count < 64) && !time_after(now, fast_pool->last + HZ))
> -		return;
> -
> -	if (!spin_trylock(&input_pool.lock))
> -		return;
> -
> -	fast_pool->last = now;
> -	__mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
> -	spin_unlock(&input_pool.lock);
> -
> -	fast_pool->count = 0;
> -
> -	/* award one bit for the contents of the fast pool */
> -	credit_entropy_bits(1);
>  }
>  EXPORT_SYMBOL_GPL(add_interrupt_randomness);

Sebastian
