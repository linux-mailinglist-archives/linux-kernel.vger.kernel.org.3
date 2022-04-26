Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD36D510B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355567AbiDZV4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiDZV4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:56:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D4EE4DF;
        Tue, 26 Apr 2022 14:53:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82B05B82169;
        Tue, 26 Apr 2022 21:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CA7C385AD;
        Tue, 26 Apr 2022 21:53:40 +0000 (UTC)
Date:   Tue, 26 Apr 2022 17:53:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock
 tai
Message-ID: <20220426175338.3807ca4f@gandalf.local.home>
In-Reply-To: <20220414091805.89667-2-kurt@linutronix.de>
References: <20220414091805.89667-1-kurt@linutronix.de>
        <20220414091805.89667-2-kurt@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 11:18:03 +0200
Kurt Kanzenbach <kurt@linutronix.de> wrote:

I finally ran this series through my tests, and it has some issues.

> Introduce fast/NMI safe accessor to clock tai for tracing. The Linux kernel
> tracing infrastructure has support for using different clocks to generate
> timestamps for trace events. Especially in TSN networks it's useful to have TAI
> as trace clock, because the application scheduling is done in accordance to the
> network time, which is based on TAI. With a tai trace_clock in place, it becomes
> very convenient to correlate network activity with Linux kernel application
> traces.
> 
> Use the same implementation as ktime_get_boot_fast_ns() does by reading the
> monotonic time and adding the TAI offset. The same limitations as for the fast
> boot implementation apply. The TAI offset may change at run time e.g., by
> setting the time or using adjtimex() with an offset. However, these kind of
> offset changes are rare events. Nevertheless, the user has to be aware and deal
> with it in post processing.
> 
> An alternative approach would be to use the same implementation as
> ktime_get_real_fast_ns() does. However, this requires to add an additional u64
> member to the tk_read_base struct. This struct together with a seqcount is
> designed to fit into a single cache line on 64 bit architectures. Adding a new
> member would violate this constraint.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  Documentation/core-api/timekeeping.rst |  1 +
>  include/linux/timekeeping.h            |  1 +
>  kernel/time/timekeeping.c              | 17 +++++++++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
> index 729e24864fe7..22ec68f24421 100644
> --- a/Documentation/core-api/timekeeping.rst
> +++ b/Documentation/core-api/timekeeping.rst
> @@ -132,6 +132,7 @@ Some additional variants exist for more specialized cases:
>  .. c:function:: u64 ktime_get_mono_fast_ns( void )
>  		u64 ktime_get_raw_fast_ns( void )
>  		u64 ktime_get_boot_fast_ns( void )
> +		u64 ktime_get_tai_fast_ns( void )
>  		u64 ktime_get_real_fast_ns( void )
>  
>  	These variants are safe to call from any context, including from
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index 78a98bdff76d..fe1e467ba046 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -177,6 +177,7 @@ static inline u64 ktime_get_raw_ns(void)
>  extern u64 ktime_get_mono_fast_ns(void);
>  extern u64 ktime_get_raw_fast_ns(void);
>  extern u64 ktime_get_boot_fast_ns(void);
> +extern u64 ktime_get_tai_fast_ns(void);
>  extern u64 ktime_get_real_fast_ns(void);
>  
>  /*
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index dcdcb85121e4..2c22023fbf5f 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -532,6 +532,23 @@ u64 notrace ktime_get_boot_fast_ns(void)
>  }
>  EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
>  
> +/**
> + * ktime_get_tai_fast_ns - NMI safe and fast access to tai clock.
> + *
> + * The same limitations as described for ktime_get_boot_fast_ns() apply. The
> + * mono time and the TAI offset are not read atomically which may yield wrong
> + * readouts. However, an update of the TAI offset is an rare event e.g., caused
> + * by settime or adjtimex with an offset. The user of this function has to deal
> + * with the possibility of wrong timestamps in post processing.
> + */
> +u64 notrace ktime_get_tai_fast_ns(void)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +
> +	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_tai)));

As you are using this for tracing, can you open code the
ktime_get_mono_fast_ns(), otherwise we need to mark that function as
notrace. Not to mention, this is a fast path and using the noinline of
__ktime_get_fast_ns() should be less overhead.

That said, I hit this too:

            less-5071    [000] d.h2. 498087876.351330: do_raw_spin_trylock <-_raw_spin_lock
            less-5071    [000] d.h4. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
            less-5071    [000] d.h5. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
            less-5071    [000] d.h3. 498087876.351334: rcu_read_lock_sched_held <-lock_acquired
            less-5071    [000] d.h5. 498087876.351337: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
    kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
    kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
    kworker/u8:1-45      [003] d.h5. 1651009380.982749: rcu_read_lock_held_common <-rcu_read_lock_sched_held
    kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
    kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
    kworker/u8:1-45      [003] d.h5. 498087876.375905: update_cfs_group <-task_tick_fair
    kworker/u8:1-45      [003] d.h7. 498087876.375909: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns

The clock seems to be toggling between 1651009380 and 498087876 causing the
ftrace ring buffer to shutdown (it doesn't allow for time to go backwards).

This is running on a 32 bit x86.

-- Steve


> +}
> +EXPORT_SYMBOL_GPL(ktime_get_tai_fast_ns);
> +
>  static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
>  {
>  	struct tk_read_base *tkr;

