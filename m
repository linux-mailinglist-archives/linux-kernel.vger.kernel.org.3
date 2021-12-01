Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8195B4654F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352032AbhLASTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:19:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352178AbhLASSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:18:03 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638382481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZSAb6/GFXzqpAkYaa0pvVxSQ5TTrlFnUbJk4nsZrsA=;
        b=DvbCwi72msZcA00dJHqF3+3iW8LIiuY+HpMxUmh/hG36VK54nzgl3NHbhHgp0M1i+szj7n
        GxfG8XYcOhYYlWBSVILducd6aXk3m1Q0btlSojo+RDo5iS5Axgj2bE+ezh8C5lz505ensb
        bj1n1kW23SBs8jPxVvJo50UxMD/Blk5YVbf9pHVY4Or9jmcMn+ReWqXXEwqzfbaybN6ugr
        SpSWfuuC+xz4jDknr4WLRRzKwBmuid9uUr8R2cjGQTSIzidPAgI6dxPEPeLZ804fn06PTJ
        cNWzO1rMczXs1YBRiFfdvYS7LUm6R1JBti8Gz8UaImAbdu6tgQdFsJVzaboH6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638382481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZSAb6/GFXzqpAkYaa0pvVxSQ5TTrlFnUbJk4nsZrsA=;
        b=BU4nDLcVS+KX4XoXWPPEHhIV6eGmxMLyHXhp7cuQ7inHdhdJVp8fjqli2rFj4wvFCjxxJt
        oiskv79DUnb8NzCA==
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        paulmck@kernel.org, mtosatti <mtosatti@redhat.com>,
        frederic <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: Fill the gaps about entry/noinstr
 constraints
In-Reply-To: <YadU1aSE6/0yGWny@FVFF77S0Q05N>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
 <875ys9dacq.ffs@tglx> <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx> <YadU1aSE6/0yGWny@FVFF77S0Q05N>
Date:   Wed, 01 Dec 2021 19:14:41 +0100
Message-ID: <87v9088a5q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Wed, Dec 01 2021 at 10:56, Mark Rutland wrote:
> On Tue, Nov 30, 2021 at 11:31:30PM +0100, Thomas Gleixner wrote:
>> ---
>>  Documentation/core-api/entry.rst |  268 +++++++++++++++++++++++++++++++++++++++
>>  Documentation/core-api/index.rst |    8 +
>>  kernel/entry/common.c            |    1 
>
> I think the change to kernel/entry/common.c got included by accident?

That's what I get from doing such things 30 minutes before midnight...

>> +
>> +Syscall entry exit code starts obviously in low level architecture specific
>
> As a small nit, can we remove the "obviously"? It's certainly obvious to you
> and me, but it doesn't meaningfully affect the sentence either way.

Indeed.

>> +assembly code and calls out into C-code after establishing low level
>> +architecture specific state and stack frames. This low level code must not
>> +be instrumented. A typical syscall handling function invoked from low level
>> +assembly code looks like this::
>> +
>> +  noinstr void do_syscall(struct pt_regs \*regs, int nr)
>                                             ^^
>
> Is `\*` necessary here? ... and/or should this be an explicit code block (which
> IIUC doesn't require this esacping), e.g.
>
> .. code-block:: c

Right. Let me try that.

>       noinstr void do_syscall(struct pt_regs *regs, int nr)
>> +
>> +If the interrupt is raised while the CPU executes in kernel space the entry
>> +and exit handling is slightly different. RCU state is only updated when the
>> +interrupt was raised in context of the idle task because that's the only
>
> Since we have an idle task for each cpu, perhaps either:
>
>   s/the idle task/an idle task/
>   s/the idle task/the CPU's idle task/

Yes, that's more precise

>> +Note, that the update of the preemption counter has to be the first
>> +operation on enter and the last operation on exit. The reason is that both
>> +lockdep and RCU rely on in_nmi() returning true in this case. The
>> +preemption count modification in the NMI entry/exit case can obviously not
>> +be traced.
>
> Could we say "must not" instead of "can not", e.g.
>
>   The preemption count modification in the NMI entry/exit must not be traced.
>
> That way it's clearly a requirement, rather than a limitation.

Yes.

>> +Architecture specific code looks like this::
>> +
>> +  noinstr void do_nmi(struct pt_regs \*regs)
>> +  {
>> +	arch_nmi_enter(regs);
>> +	state = irqentry_nmi_enter(regs);
>> +
>> +	instrumentation_begin();
>> +
>> +	invoke_nmi_handler(regs);
>> +
>> +	instrumentation_end();
>> +	irqentry_nmi_exit(regs);
>> +  }
>
> To keep the begin/end and enter/exit calls visually balanced, should the
> instrumentation_end() call have trailing a line space, e.g.

Yup.

Thanks,

        tglx
