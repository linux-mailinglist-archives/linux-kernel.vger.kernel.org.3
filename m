Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA5511360
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359345AbiD0IUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbiD0IUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:20:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7928E12;
        Wed, 27 Apr 2022 01:17:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651047449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFLr6SeRCSuxjMA6GTzB7LHQDHSnRaJltcyEgh+cjO0=;
        b=aJF2X2/avz3+HF2QHdBbVS8weBIsDYKXE2x5xzBvLNkaG25WRChNDiMnkb/dZdfco7RXYy
        te5oqgi+ax/n+a3oRYq6GEyss7oTKwh7fPEIS9qjRbni5vlFuV0mUUom4VjbFlcuy+MiGT
        Vfq5Wp2xh9OIzVEbjtsPBvqxVSKCt6hDak3PJA64SWMWfM5r3mxRHsCN1v0HL6XWWVyM/g
        eHsQJmKek//gAmI+vuzAbKpzJQkAoifOlgeM8dfCMAgHSA7yx/nrufs0rhI4laH/4qJsnL
        DP6XsV7RjcSMiYoIhaksmyEO02stdyp6MMU0Rjz3X2FdavzrdRMrmty819f8FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651047449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFLr6SeRCSuxjMA6GTzB7LHQDHSnRaJltcyEgh+cjO0=;
        b=d58LPj7BSSvwfgRcJr+dM16qMOmnuSCGuGOTWRo5CPHVqoYGqDpadPlAp1ENXtVVvkuJfQ
        KgkXi6C/4vYwQXAw==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <20220426175338.3807ca4f@gandalf.local.home>
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-2-kurt@linutronix.de>
 <20220426175338.3807ca4f@gandalf.local.home>
Date:   Wed, 27 Apr 2022 10:17:28 +0200
Message-ID: <87pml3x7mv.ffs@tglx>
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

On Tue, Apr 26 2022 at 17:53, Steven Rostedt wrote:
>> +/**
>> + * ktime_get_tai_fast_ns - NMI safe and fast access to tai clock.
>> + *
>> + * The same limitations as described for ktime_get_boot_fast_ns() apply. The
>> + * mono time and the TAI offset are not read atomically which may yield wrong
>> + * readouts. However, an update of the TAI offset is an rare event e.g., caused
>> + * by settime or adjtimex with an offset. The user of this function has to deal
>> + * with the possibility of wrong timestamps in post processing.
>> + */
>> +u64 notrace ktime_get_tai_fast_ns(void)
>> +{
>> +	struct timekeeper *tk = &tk_core.timekeeper;
>> +
>> +	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_tai)));
>
> As you are using this for tracing, can you open code the
> ktime_get_mono_fast_ns(), otherwise we need to mark that function as
> notrace.

which we should do anyway....

kernel/trace/trace.c:   { ktime_get_mono_fast_ns,       "mono", 1 },

> Not to mention, this is a fast path and using the noinline of
> __ktime_get_fast_ns() should be less overhead.
>
> That said, I hit this too:
>
>             less-5071    [000] d.h2. 498087876.351330: do_raw_spin_trylock <-_raw_spin_lock
>             less-5071    [000] d.h4. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>             less-5071    [000] d.h5. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>             less-5071    [000] d.h3. 498087876.351334: rcu_read_lock_sched_held <-lock_acquired
>             less-5071    [000] d.h5. 498087876.351337: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h5. 1651009380.982749: rcu_read_lock_held_common <-rcu_read_lock_sched_held
>     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h5. 498087876.375905: update_cfs_group <-task_tick_fair
>     kworker/u8:1-45      [003] d.h7. 498087876.375909: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>
> The clock seems to be toggling between 1651009380 and 498087876 causing the
> ftrace ring buffer to shutdown (it doesn't allow for time to go backwards).

That does not make sense. offs_tai changes only when clock is set via
adjtimex() or settimeofday().

Thanks,

        tglx
