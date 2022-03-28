Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0994E9C13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiC1QTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiC1QTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:19:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2E32047
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:17:42 -0700 (PDT)
Date:   Mon, 28 Mar 2022 18:17:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648484260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hbYA4pr/7V9YSLY17NfEjlZ2+P4uEVzodOPhVwnPoy4=;
        b=PKEb9WOvW47U+FlQR0QfBlqa3/5HwPQfkoORBez8u/Deuh1isKjiPTHZ34mT6sTjkhAfHb
        e6qN+Gm2fm3N7BHVfnxJdLP9O7IdP+KAhOvCuxQSIMg1kpfuN3UZKJDQQvxvfzFsrHjKAr
        gB68Anrx/1VUL0oE7ozeYH8eefJK15U93nO38yw1+EhyyYEnkT4Ehbodm38oOQuYH5qJfd
        N2q2/C89rdpmObo/MoM3mpSPUhni0miXeV/7RMUsyF8IGv+GIwPgWqBU+Qi4Ec51982PpO
        SAp3R4EGG1xrKSYne+whleJKdeSBPDLD/xBTfJoVf/YVL6WjJ0f5Ff3Ggsocaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648484260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hbYA4pr/7V9YSLY17NfEjlZ2+P4uEVzodOPhVwnPoy4=;
        b=pEWN/35RFm+MCAH1KE/4kZ3kdHYSPbdtNs2CnAGqqH750ufSqfi1N4CI60kP/MqMGVcRe6
        D9JZkr2tiFs7XaAg==
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
Message-ID: <YkHfokLO1UGCISGc@linutronix.de>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
 <8735j2xigt.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735j2xigt.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-28 09:25:06 [-0500], Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> Folks I really would have appreciated being copied on a signal handling
> patch like this.

Sorry for that. For the whole ptrace/signal part is no maintainer listed
and I got the feeling that Oleg knows these bits.

> It is too late to nack, but I think this buggy patch deserved one.  Can
> we please fix PREEMPT_RT instead?

Sure.

> As far as I can tell this violates all of rules from
> implementing/maintaining the RT kernel.  Instead of coming up with new
> abstractions that makes sense and can use by everyone this introduces
> a hack only for PREEMPT_RT and a pretty horrible one at that.
>
> This talks about int3, but the code looks for in_atomic().  Which means
> that essentially every call of force_sig will take this path as they
> almost all come from exception handlers.  It is the nature of signals
> that report on faults.  An exception is raised and the kernel reports it
> to userspace with a fault signal (aka force_sig_xxx).

The int3 is invoked with disabled interrupts. There are also a few
others path which are explicit with disabled interrupts or with a
raw_spinlock_t which lead to an atomic section on PREEMPT_RT. Call
chains with spinlock_t or a rwlock_t don't lead to a atomic section on
PREEMPT_RT. Therefore I don't think this is "essentially every call of
force_sig" that is going to use that.

> Further this code is buggy.  TIF_NOTIFY_RESUME is not the correct
> flag to set to enter into exit_to_usermode_loop.  TIF_NOTIFY_RESUME is
> about that happens after signal handling.  This very much needs to be
> TIF_SIGPENDING with recalc_sigpending and friends updated to know about
> "task->force_info".
> 
> Does someone own this problem?  Can that person please fix this
> properly?

Sure. Instead setting TIF_NOTIFY_RESUME you want the code updated to use
recalc_sigpending() only. Or do you have other suggestions regarding
fixing this properly?

> I really don't think it is going to be maintainable for PREEMPT_RT to
> maintain a separate signal delivery path for faults from the rest of
> linux.

Okay.

> Eric

Sebastian
