Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65CC50BEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiDVRtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiDVRsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:48:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FB2B270;
        Fri, 22 Apr 2022 10:45:18 -0700 (PDT)
Date:   Fri, 22 Apr 2022 19:43:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650649400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r35IzhDbN3FW/BuR5UEyJUUkP1Dog8UZeCh3xRNziMg=;
        b=o7hPQh1ekabXuESidnVM7vcbehFyiWRLFfN4L9HXX6h7DshXLvAfWCCeACLXfpeWcjuuYV
        haAr6oP01wZcB63goOW2UE3Sup5+qV9YHlu+jX4cvh+MCRSTSmasbLP1l9Xl/yFb29Ptnz
        d7o3gRtW+svZf+m8ehZghlfIgUHnrUNe7RT8dNJIOCiBHVFeYs+RlP6lGAyiBowVsHLh3a
        ZTuuLhrFFrKTV/hCSs0NQRvJ8gMm0Wzb0qN+U5QTm/J0RRdla7GyS4AGL6pXFm1Fqcx1YN
        6Zn17Bfx7k8kNlGYiQNKrUTI37Zcv6o0rfp+SaXh0B+AKWoxPDqOrmoEcJdeMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650649400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r35IzhDbN3FW/BuR5UEyJUUkP1Dog8UZeCh3xRNziMg=;
        b=HnnVKkPms88wJwa/dhy+NNgkI7KZgDrhI59dCGrQ+kdQdKtLIaKSlNQxkMaIpL1Coh3TuO
        8FQ7v37KOyfh30Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] ptrace-vs-PREEMPT_RT and freezer rewrite
Message-ID: <YmLpNhXD8+EzF9/D@linutronix.de>
References: <20220421150248.667412396@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421150248.667412396@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-21 17:02:48 [+0200], Peter Zijlstra wrote:
> Find here a new posting of the ptrace and freezer patches :-)
> 
> The majority of the changes are in patch 2, which with much feedback from Oleg
> and Eric has changed lots.
> 
> I'm hoping we're converging on something agreeable.

I tested this under RT (had to remove the preempt-disable section in
ptrace_stop()) with ssdd [0]. It forks a few tasks and then
PTRACE_SINGLESTEPs them for a few iterations.

The following failures were reported by that tool:
| forktest#27/3790: EXITING, ERROR: wait on PTRACE_ATTACH saw a SIGCHLD count of 0, should be 1
| forktest#225/40029: EXITING, ERROR: wait on PTRACE_SINGLESTEP #22241: no SIGCHLD seen (signal count == 0), signo 5

very rarely. Then I managed to figure out that the latter error triggers
if I compile something large with a RT priority. Sadly it also happens
with my old ptrace hack (but I just noticed it). It didn't happen with
without RT (just the 5 patches applied).

I also managed to trigger this backtrace with RT:
|WARNING: CPU: 1 PID: 3748 at kernel/signal.c:2237 ptrace_stop+0x356/0x370
|Modules linked in:
|CPU: 1 PID: 3748 Comm: ssdd Not tainted 5.18.0-rc3-rt1+ #1
|Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.03.0003.041920141333 04/19/2014
|RIP: 0010:ptrace_stop+0x356/0x370
|RSP: 0000:ffffc9000d277d98 EFLAGS: 00010246
|RAX: ffff888116d1e100 RBX: ffff888116d1e100 RCX: 0000000000000001
|RDX: 0000000000000001 RSI: 000000000000002e RDI: ffffffff822bdcc3
|RBP: ffff888116d1e100 R08: ffff88811ca99870 R09: 0000000000000001
|R10: ffff88811ca99910 R11: ffff88852ade2680 R12: ffffc9000d277e90
|R13: 0000000000000004 R14: ffff888116d1ed48 R15: 0000000000000000
|FS:  00007f0afdad4580(0000) GS:ffff88852aa40000(0000) knlGS:0000000000000000
|CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
|CR2: 00007f0afdad4508 CR3: 0000000558198006 CR4: 00000000000606e0
|Call Trace:
| <TASK>
| get_signal+0x553/0x870
| arch_do_signal_or_restart+0x31/0x7b0
| exit_to_user_mode_prepare+0xe4/0x110
| irqentry_exit_to_user_mode+0x5/0x20
| noist_exc_debug+0xe0/0x120
| asm_exc_debug+0x2b/0x30
|RSP: 002b:00007fffae964b70 EFLAGS: 00000346
|RAX: 0000000000000000 RBX: 00000000000000fc RCX: 00007f0afd9c0d35
|RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
|RBP: 00007fffae964e38 R08: 0000000000000000 R09: 00007fffae962a82
|R10: 00007f0afdad4850 R11: 0000000000000246 R12: 0000000000000000
|R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
| </TASK>

which is the WARN_ON_ONCE() in clear_traced_quiesce().

[0] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/ssdd/ssdd.c

Sebastian
