Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668CC511EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbiD0PbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiD0PbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:31:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CD939D24C;
        Wed, 27 Apr 2022 08:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3124B8284F;
        Wed, 27 Apr 2022 15:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A997C385A7;
        Wed, 27 Apr 2022 15:28:01 +0000 (UTC)
Date:   Wed, 27 Apr 2022 11:27:59 -0400
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
Message-ID: <20220427112759.1cedda69@gandalf.local.home>
In-Reply-To: <87r15i9azg.fsf@kurt>
References: <20220414091805.89667-1-kurt@linutronix.de>
        <20220414091805.89667-2-kurt@linutronix.de>
        <20220426175338.3807ca4f@gandalf.local.home>
        <87r15i9azg.fsf@kurt>
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

On Wed, 27 Apr 2022 10:38:59 +0200
Kurt Kanzenbach <kurt@linutronix.de> wrote:

> Looking at the other functions used for tracing:
> 
>  - ktime_get_mono_fast_ns - no annotations
>  - ktime_get_raw_fast_ns  - no annotations
>  - ktime_get_boot_fast_ns - notrace
>  - ktime_get_tai_fast_ns  - notrace

Yeah, all should be notrace.

> 
> Seems a little bit inconsistent.
> 
> >
> > That said, I hit this too:
> >
> >             less-5071    [000] d.h2. 498087876.351330: do_raw_spin_trylock <-_raw_spin_lock
> >             less-5071    [000] d.h4. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >             less-5071    [000] d.h5. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >             less-5071    [000] d.h3. 498087876.351334: rcu_read_lock_sched_held <-lock_acquired
> >             less-5071    [000] d.h5. 498087876.351337: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >     kworker/u8:1-45      [003] d.h5. 1651009380.982749: rcu_read_lock_held_common <-rcu_read_lock_sched_held
> >     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >     kworker/u8:1-45      [003] d.h5. 498087876.375905: update_cfs_group <-task_tick_fair
> >     kworker/u8:1-45      [003] d.h7. 498087876.375909: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
> >
> > The clock seems to be toggling between 1651009380 and 498087876 causing the
> > ftrace ring buffer to shutdown (it doesn't allow for time to go backwards).
> >
> > This is running on a 32 bit x86.  
> 
> Hm. The only problem is that the TAI offset may change. That should only
> happen if the time is set or similar. For the TSN use case I've ran
> ptp4l and phc2sys. phc2sys in the default configuration sets the offset
> hard once and uses frequency adjustments from that point on. I didn't
> observe any time jumps. Nevertheless, my test systems is based on
> arm64. I'll do some testing on x86.


I'm able to trigger this on x86 64bit too.

One thing I noticed, is that the two numbers I have (from a different
trace, but very similar to the above)

$ printf "%llx\n" 498151194674148935
6e9c9df4afd3647

$ printf "%llx\n" 1651072699280995911
16e9c9df4afd3647

That is, the last nibble either is 0 or 1, causing the change?

06e9c9df4afd3647
16e9c9df4afd3647

The numbers are the same except for that last nibble.

-- Steve



