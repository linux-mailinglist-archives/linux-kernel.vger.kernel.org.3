Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A66462768
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhK2XE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbhK2XC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:02:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E95C09B13C;
        Mon, 29 Nov 2021 14:07:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638223628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VcafwLYNhrJW69eNQHQrd8QPnmKaRMfcifi134FHleo=;
        b=GOTYhVTNavk2gbi2z4w0aj7RZLTtB51Vn6HS2AkfHQBvSdlXjaw2nTY3Q10BeaOgdaM2fC
        60B7Kcz48QZt/jLbaNe31k5qRrQEswosZtHKXKLFaGp3Iyenw+HMgiUtAi7GxVYYpbf2It
        gQyAfDGs6MYCFy+wXxOe7VWRJb+lEj9f42gkbPaBz/KSOIG9tk5n/2CsAnI4ioHasSBUJk
        3QW8U7aNPxFhkBt0xP/EoiqixiI+VbuqF9MD7sP4R5UwsPAoFUGwF7f6slYeXS8CJJR/4p
        Mxmkx9Y5GMcoOe/KSRVJDunNM4TXf3CYGclZsgpN0Nk0LdGMT1hFp8DFe6fJMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638223628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VcafwLYNhrJW69eNQHQrd8QPnmKaRMfcifi134FHleo=;
        b=J8KSx28OF9ucEAH1adFsORwKLCXgLyojfURVqr79bv+Z9NC7wkp6asUN0QEJkygkzykBj2
        U8Mom8g3SxKVnzDA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
In-Reply-To: <YaFXDYm7s7A6HDTG@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124211927.GG721624@worktop.programming.kicks-ass.net>
 <877dcuhbbe.ffs@tglx> <YaFXDYm7s7A6HDTG@hirez.programming.kicks-ass.net>
Date:   Mon, 29 Nov 2021 23:07:07 +0100
Message-ID: <87r1ayd3as.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26 2021 at 22:52, Peter Zijlstra wrote:
> On Fri, Nov 26, 2021 at 10:11:17PM +0100, Thomas Gleixner wrote:
>> On Wed, Nov 24 2021 at 22:19, Peter Zijlstra wrote:
>> > On Mon, Nov 22, 2021 at 01:13:24PM -0800, Peter Oskolkov wrote:
>> >
>> >> +	 * Timestamp: a 46-bit CLOCK_MONOTONIC timestamp, at 16ns resolution.
>> >
>> >> +static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
>> >> +				bool may_fault)
>> >> +{
>> >> +	u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
>> >> +	u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
>> >
>> > I'm still very hesitant to use ktime (fear the HPET); but I suppose it
>> > makes sense to use a time base that's accessible to userspace. Was
>> > MONOTONIC_RAW considered?
>> 
>> MONOTONIC_RAW is not really useful as you can't sleep on it and it won't
>> solve the HPET crap either.
>
> But it's ns are of equal size to sched_clock(), if both share TSC IIRC.
> Whereas MONOTONIC, being subject to ntp rate stuff, has differently
> sized ns.

The size is the same, i.e. 1 bit per nanosecond :)

> The only time that's relevant though is when you're going to mix these
> timestamps with CLOCK_THREAD_CPUTIME_ID, which might just be
> interesting.

Uuurg. If you want to go towards CLOCK_THREAD_CPUTIME_ID, that's going
to be really nasty. Actually you can sleep on that clock, but that's a
completely different universe. If anything like that is desired then we
need to rewrite that posix CPU timer muck completely with all the bells
and whistels and race conditions attached to it. *Shudder*

Thanks,

        tglx


