Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F274EAA96
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiC2Jc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiC2Jc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:32:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF41229B8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:31:14 -0700 (PDT)
Date:   Tue, 29 Mar 2022 11:31:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648546272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqR3ZXxf00+8NZqVN4Njt/+BMl84gb+Z44sVz+Vkamw=;
        b=vaMsgaB0Y8YtyQkqBOYAYOs+wyfO/U13zZioSm0qy+mjCToOS8j7BmU+uSRN7+3P9Czsjv
        YuZ2dY8Czz3d6P0R6YeUUJ95tBe8bXoZ59W2wuHQCPcytNOI4Ip/q/o1zw/z9b19x9s5S7
        YxRurfmiwD8/imfgZxbc42j+u7Z2ly9VgidAi8CUW1fNmUc0mX6MAis5vch/iazHm4xvnQ
        WJm5hEtG7JfhCXN0wPVb9ej1aP/crNgxPruo8BGat2iBUdO6EbgfNtfqTGJgSu0RRn/8EL
        xrxBeVQJPiVU9CVRM0Ecf4pgME+fTL9xymMUOYh9qYAFzEwuVoJa3EXu0erOow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648546272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqR3ZXxf00+8NZqVN4Njt/+BMl84gb+Z44sVz+Vkamw=;
        b=GPDKutsXZZE4DYw1TcWWZz2TaPH8KblS122J75briGmOC6u5obN/qXe2Po5UD8AQrFS9WA
        9jL+hgFIwOxQoFCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
Message-ID: <YkLR3rGTayl/6qIm@linutronix.de>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
 <8735j2xigt.fsf@email.froward.int.ebiederm.org>
 <YkHfokLO1UGCISGc@linutronix.de>
 <87zgl9pw82.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgl9pw82.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-28 17:07:25 [-0500], Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> We have a few other cases where we deliver signals from interrupts.
> Off the top of my head there is SAK and magic sysrq, but I think there
> are more.  So I am also not convinced that all signals you care about
> will go through force_sig_info_to_task.
> 
> What I really don't know and this is essentially a PREEMPT_RT question
> is what makes int3 special?  Why don't other faults have this problem?

int3 on x86 is delivered from the debug interrupt and at this point
interrupts are in general disabled even on PREEMPT_RT.
If you are in a section which disables interrupts via
spin_lock_irqsave() then interrupts are not disabled on PREEMPT_RT.
If you are in an interrupt handler (as per request_irq(), not the
special vector that is used for int3 handling) then interrupts are also
not disabled because the interrupt handler is threaded by default.

In both cases in_atomic() reports 0 on PREEMPT_RT. So the exception is:
- explicit usage of local_irq_{save|disable}, preempt_disable().
- usage of raw_spinlock_t locks.
- interrupts vectors which are not threaded (like int3 or the SMP IPI
  function call).

> I remember there was a change where we had threaded interrupt handlers
> to get around this for interrupt service routines.  I wonder if we need
> to do something similar with faults.  Have a fast part and a threaded
> part that runs in a schedulable way.  Although given that for a fault
> you need to be fundamentally bound to the task/thread you faulted from
> it probably just means having a way to switch to a kernel stack that you
> can schedule from, and not use a reserved per cpu stack.  The
> task_struct would certainly need to stay the same for all of the pieces.
> 
> Or maybe for PREMPT_RT you pick the i386 mechanism.  How does PREEMPT_RT
> deal with page faults, or general protection faults?

An in-kernel stack overflow will panic() with interrupts disabled.
An in-kernel NULL-pointer is also entered with disabled interrupts and
complains later about sleeping locks in do_exit(). I do remember that
the arch code conditionally enabled interrupts based on IRQ-flags on
stack.

> This is my long winded way of saying that I rather expect that if
> PREEMPT_RT is going to call code it has modified to be sleeping that it
> would also make it safe for that code to sleep.
> 
> Further (and this is probably my ignorance) I just don't see what makes
> any of this specific to just int3.  Why aren't other faults affected?

That NULL-pointer in kernel doesn't look good. If you have a test-case
(like do this) then I can definitely look into it in case more is
missed.

> Eric

Sebastian
