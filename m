Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD34B4E69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351007AbiBNL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:29:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351306AbiBNL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:28:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5C29FC8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:07:45 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:07:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644836863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0v5ktf7hG2ixpStEOBAY+DLRwU/tcK7H3faQA+b3+P8=;
        b=pj6ktAjUSJuLELD8r09PG1k7XgEUMJLk0cM4p4FO00Eg0Gu9p1x5WB2Dvoyy8W533mBFfm
        GJmBd1UgSpAnd7casarcicEFoAkpC+Noe3SiAfeYg7HEE8HtXlTolAHYrybfU09yrMJe6m
        rKMcDbV3ICHl3rUdx4ER4+8cox9YbMC36pWFvuGWFScOEcXIJGe776BvhQ628Lu6qDqneb
        xjBYz9ijRp7xXvssJQQNe5oCb4f2mHnJqC7Ug58okBv9AEqGIuLkB1WLCc7I10KPRfiQeH
        Kgny850unC/MNMstEeDR5fKNswS0PfRqjUT/WOV6+nx7yobbQMaVvVmNi3w9PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644836863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0v5ktf7hG2ixpStEOBAY+DLRwU/tcK7H3faQA+b3+P8=;
        b=kC2uGp6B+9jbLbITtuF+GDMDCDtYNvarfxaOVveh1/MOMHRzwql95BpDNKUHeQ5BZwt3Vm
        yopdx+UoWLE/TlBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] random: set fast pool count to zero in cpuhp teardown
Message-ID: <Ygo3/puhZFpuX91x@linutronix.de>
References: <20220213215343.11652-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220213215343.11652-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-13 22:53:43 [+0100], Jason A. Donenfeld wrote:
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 805a924b1f5f..e177d806db1d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1216,6 +1216,19 @@ static void fast_mix(u32 pool[4])
> =20
>  static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
> =20
> +int random_offline_cpu(unsigned int cpu)
> +{
> +	/*
> +	 * Set the count to zero when offlining the CPU for two
> +	 * reasons: 1) so that all new accumulated irqs are fresh
> +	 * when it comes back online, and 2) so that its worker is
> +	 * permitted to schedule again when it comes back online,
> +	 * since the MIX_INFLIGHT flag will be cleared.
> +	 */
> +	per_cpu_ptr(&irq_randomness, cpu)->count =3D 0;

You registered that handler between
   CPUHP_AP_ONLINE_IDLE =E2=80=A6 CPUHP_AP_ACTIVE

That means:
- interrupts are still active. So you could schedule a worker after the
  handler run (need 64 interrupts).
- That handler will be invoked on the CPU that goes offline.
- it will be invoked before the worker is unbound from the offline-going
  CPU. Once unbound at CPUHP_AP_WORKQUEUE_ONLINE the worker may remain
  on the CPU before the scheduler pushes it away.

You could:
- keeping it at this position but
  - this_cpu_ptr() could be used.
  - move it to the online phase so it is reset for the CPU coming up
    (from this point, you could have >=3D 64 interrupts before the CPU is
    no longer serving interrupts).

- move it to CPUHP_OFFLINE =E2=80=A6 CPUHP_BRINGUP_CPU. This is invoked on
  another CPU once the is dead / before it comes up.
  - in that case the function can remain as-is. But we have "rollback".

One slight complication:
After the CPUHP_AP_WORKQUEUE_ONLINE state (going down), the worker is
tainted. It may be moved to another CPU but may remain on the (correct)
CPU and run. Moving HP-handler to an earlier point has the advantage
that you know.=20

We also have this "rollback". That means the CPU goes down and then one
step fails and it rolls back online. That means if you have your handler
at an earlier point, you don't notice it and the worker may have skipped
its turn. (Also I didn't check but I *assume* that after
CPUHP_AP_WORKQUEUE_ONLINE there is no pool bound to the CPU and any new
worker will be moved to an unbound pool).

The more I think I about it, moving the state left and right, I think
that having a CPU up handler after CPUHP_AP_WORKQUEUE_ONLINE (like you
have now (but up, not down)) doing:

	fast_pool =3D this_cpu_ptr(&irq_randomness);
	local_irq_disable();
	if (fast_pool->count & FAST_POOL_MIX_INFLIGHT) {
		fast_pool->count =3D 0;
		fast_pool->last =3D jiffies
	}
	local_irq_enable();

should work just fine. This covers:
- should a worker be scheduled while CPU is going down and do its job,
  we good.

- should a worker be scheduled while CPU is going down, moved to another
  CPU and skip its work then we have FAST_POOL_MIX_INFLIGHT set and
  nothing pending. This gets reset once the CPU is going online.
  This also covers the possible rollback scenarios.

- should a CPU already contribute entropy then the HP-handler is not
  going to reset it.

- should a CPU already contribute entropy and schedule a worker then we
  reset the FAST_POOL_MIX_INFLIGHT bit. However ->last is also reset so
  no new worker is scheduled due the time and because count =3D=3D 0.
  So either the worker runs (and does the same reset) _or_ we wait
  another 64 interrupts + jiffy (in case the worker was scheduled but
  did nothing because it was run on another CPU).

> +	return 0;
> +}
> +

Sebastian
