Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFD852F424
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351442AbiETT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiETT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:59:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F96319C39F;
        Fri, 20 May 2022 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BKP5a5pHHBYXwyuiYqA00KUXwchZ92uDPjXicGU1+N4=; b=f3i3OO4NtAt4RShav01WKmUiP+
        599WE/SJ21kBjnzJesrvpTcA+dh6R3VaK0B5Qid5F817Vt30vklE58KbJef4mZ2dtOa8xUNUYZF8Z
        NrZNbvX/S+Hr+7EkhtRTVmLRYa5ssrGbzgrvWMl/2I+/8LLWLsQ6Tukep0XyzL0QX0v9ZaevzZr9i
        H0fxG+hX221jPI8Jj/owdXD5vy72TVl0IyF2r+St0wXN52t5fBL7jajkFEkkLa9drGkA4sMsL6xG1
        ROdDN77gZUweIL3el5tIWIk5t3pRaeQjP8N7Zv+ce5IkvIbtebaz/bFnHaBN8fH9XzF3JlVv9v6yX
        EyHktMqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns8lu-00E5EI-Jc; Fri, 20 May 2022 19:58:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2737981243; Fri, 20 May 2022 21:58:48 +0200 (CEST)
Date:   Fri, 20 May 2022 21:58:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
Message-ID: <20220520195848.GY2578@worktop.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <YodEWlfo4kFd8+mt@linutronix.de>
 <87wnegyp87.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnegyp87.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:32:24PM -0500, Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> > On 2022-05-18 17:49:50 [-0500], Eric W. Biederman wrote:
> >> 
> >> For ptrace_stop to work on PREEMT_RT no spinlocks can be taken once
> >> ptrace_freeze_traced has completed successfully.  Which fundamentally
> >> means the lock dance of dropping siglock and grabbing tasklist_lock does
> >> not work on PREEMPT_RT.  So I have worked through what is necessary so
> >> that tasklist_lock does not need to be grabbed in ptrace_stop after
> >> siglock is dropped.
> > …
> > It took me a while to realise that this is a follow-up I somehow assumed
> > that you added a few patches on top. Might have been the yesterday's
> > heat. b4 also refused to download this series because the v4 in this
> > thread looked newer… Anyway. Both series applied:
> >
> > | =============================
> > | WARNING: suspicious RCU usage
> > | 5.18.0-rc7+ #16 Not tainted
> > | -----------------------------
> > | include/linux/ptrace.h:120 suspicious rcu_dereference_check() usage!
> > |
> > | other info that might help us debug this:
> > |
> > | rcu_scheduler_active = 2, debug_locks = 1
> > | 2 locks held by ssdd/1734:
> > |  #0: ffff88800eaa6918 (&sighand->siglock){....}-{2:2}, at: lock_parents_siglocks+0xf0/0x3b0
> > |  #1: ffff88800eaa71d8 (&sighand->siglock/2){....}-{2:2}, at: lock_parents_siglocks+0x115/0x3b0
> > |
> > | stack backtrace:
> > | CPU: 2 PID: 1734 Comm: ssdd Not tainted 5.18.0-rc7+ #16
> > | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> > | Call Trace:
> > |  <TASK>
> > |  dump_stack_lvl+0x45/0x5a
> > |  unlock_parents_siglocks+0xb6/0xc0
> > |  ptrace_stop+0xb9/0x390
> > |  get_signal+0x51c/0x8d0
> > |  arch_do_signal_or_restart+0x31/0x750
> > |  exit_to_user_mode_prepare+0x157/0x220
> > |  irqentry_exit_to_user_mode+0x5/0x50
> > |  asm_sysvec_apic_timer_interrupt+0x12/0x20
> >
> > That is ptrace_parent() in unlock_parents_siglocks().
> 
> How odd.  I thought I had the appropriate lockdep config options enabled
> in my test build to catch things like this.  I guess not.
> 
> Now I am trying to think how to tell it that holding the appropriate
> iglock makes this ok.

The typical annotation is something like:

	rcu_dereference_protected(foo, lockdep_is_held(&bar))

Except in this case I think the problem is that bar depends on foo in
non-trivial ways. That is, foo is 'task->parent' and bar is
'task->parent->sighand->siglock' or something.

The other option is to use rcu_dereference_raw() in this one instance
and have a comment that explains the situation.
