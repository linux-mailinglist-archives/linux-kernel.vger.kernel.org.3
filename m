Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED655123AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbiD0UNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiD0UM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:12:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20A972B5;
        Wed, 27 Apr 2022 13:06:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651090009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeFBJ6BMGAy+Ewq+CYjwj4kASBe/7C6TdEh8x9Z5Ous=;
        b=37Rm74dwmyP9+Bs9sPwVcBKLY+b5VjDVcnyI4bPCwOHOj5eqGhNcfMBvh3OBnvyTRl4b1h
        S7YtDDWaqchUQy2Ddg+qbNRF9EagewIc/KZuy4+90/r3N9DQjRUg+j+RzxmUhOH2bquvvo
        TyzqirUSLYSFVve9DzGcz6Ynkz+E07PEPB2VBBofqxf5cqsqnzNoluKHBIaQhqlhT9Cw71
        2qc2Hq2SkpRuNfAmFpwVEhs0/pFIIixFfCpGbK71etA3D/ghvmzOelm9bmR7n7G+vec6l9
        fo39Wq2J2AN52+HZYku3/UymZjw3iBeoH/ATkB+eCiEFl2sIgHKmrQoPTAZemQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651090009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeFBJ6BMGAy+Ewq+CYjwj4kASBe/7C6TdEh8x9Z5Ous=;
        b=LU/WZ930oEEcYwjgAFTNYGBSJMy4wpTKnoYBDWEymfOcY9LETvGI2oDXv4zFTg19MEMv7U
        LM7kKyQiHGBB/mBQ==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <20220427112759.1cedda69@gandalf.local.home>
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-2-kurt@linutronix.de>
 <20220426175338.3807ca4f@gandalf.local.home> <87r15i9azg.fsf@kurt>
 <20220427112759.1cedda69@gandalf.local.home>
Date:   Wed, 27 Apr 2022 22:06:49 +0200
Message-ID: <87pml2wasm.ffs@tglx>
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

On Wed, Apr 27 2022 at 11:27, Steven Rostedt wrote:
>> >             less-5071    [000] d.h2. 498087876.351330: do_raw_spin_trylock <-_raw_spin_lock
>> >             less-5071    [000] d.h4. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >             less-5071    [000] d.h5. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >             less-5071    [000] d.h3. 498087876.351334: rcu_read_lock_sched_held <-lock_acquired
>> >             less-5071    [000] d.h5. 498087876.351337: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >     kworker/u8:1-45      [003] d.h5. 1651009380.982749: rcu_read_lock_held_common <-rcu_read_lock_sched_held
>> >     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >     kworker/u8:1-45      [003] d.h5. 498087876.375905: update_cfs_group <-task_tick_fair
>> >     kworker/u8:1-45      [003] d.h7. 498087876.375909: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>> >
>> > The clock seems to be toggling between 1651009380 and 498087876 causing the
>> > ftrace ring buffer to shutdown (it doesn't allow for time to go backwards).
>> >
>> > This is running on a 32 bit x86.  
>> 
>> Hm. The only problem is that the TAI offset may change. That should only
>> happen if the time is set or similar. For the TSN use case I've ran
>> ptp4l and phc2sys. phc2sys in the default configuration sets the offset
>> hard once and uses frequency adjustments from that point on. I didn't
>> observe any time jumps. Nevertheless, my test systems is based on
>> arm64. I'll do some testing on x86.
>
> I'm able to trigger this on x86 64bit too.
>
> One thing I noticed, is that the two numbers I have (from a different
> trace, but very similar to the above)
>
> $ printf "%llx\n" 498151194674148935
> 6e9c9df4afd3647
>
> $ printf "%llx\n" 1651072699280995911
> 16e9c9df4afd3647

TAI offset after boot is somewhere in this region:

It's 16e9d5dca2e7ac57 here. Converted to ctime:

Wed Apr 27 20:58:02 2022

and that does not change after booting on the VM I'm testing. But then
ftrace suddenly throws this warning:

[  456.444350] Delta way too big! 1152921504606861182
   ts=1651087617720667106 before=498166113113805924
   after=498166113113820130 write stamp=498166113113820130

I first set tai as trace clock and then enabled a trace point. It seems
the first hit on this trace point ended up there.

> That is, the last nibble either is 0 or 1, causing the change?
>
> 06e9c9df4afd3647
> 16e9c9df4afd3647

I added debug into ktime_get_tai_fast_ns() to emit a pr_warn() when
either the TAI offset or the result is less than 1 << 60.

That does not trigger, but ftrace still confuses itself....

There is some mumble about timestamps only requiring 59 bits and the
check which triggers the warning has:

      if (unlikely(info->delta > (1ULL << 59))) {

So something cuts off bit 60 somewhere and then the whole thing goes
into confusion mode.

When I set wall time to something before 1985, it works.

ctime(0x06e9c9df4afd3647/1e9) = Mon Oct 14 16:19:54 1985

Haven't found where ftrace loses the upper bit, but it does so
somewhere.

Thanks,

        tglx



