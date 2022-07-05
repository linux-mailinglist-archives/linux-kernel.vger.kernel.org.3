Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA515677C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiGET1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiGET1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:27:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49B13E95;
        Tue,  5 Jul 2022 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bOtM5/WaJKnB51txW+Mekm3Yh3BM4No3H1nhe/iwwbU=; b=Sbee/UubzckJGeJJDe5/awhnlx
        qDM5x116uwooPagEgTzZ861yxSaQARQyCKVoxKm5+/HVR2GgJMfJe1ruRFGz/SH9Ib2A1VN/1lruY
        +AXMdzJ2h9rJGQKGX+oGzxkt57Gz4fY4NNUIwlwLmlV2u/fLm9JPSC4aBhKvC3BIAMtDNKsjRRrYk
        KffZV8AvtQjYM+tkPjHDVzhqcrj3gG1cSQcuLsow5qaHau1iEXQ9V6xrja5yENZwfuYQVvBftxQBg
        LGW5grqT7UuKvoXx1JRHJ1T8Y6iwtYI+yRNUjER/Nd9DEJR4lcPRAGV8AMnCLn+MEhqJ2tneyQyUL
        R3Ot3O9w==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8oBM-0006tA-GY; Tue, 05 Jul 2022 19:26:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37AB398005E; Tue,  5 Jul 2022 21:25:58 +0200 (CEST)
Date:   Tue, 5 Jul 2022 21:25:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <YsSQRmCZSIQ1ewzo@worktop.programming.kicks-ass.net>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-12-ebiederm@xmission.com>
 <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <877d5ajesi.fsf@email.froward.int.ebiederm.org>
 <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <20220628191541.34a073fc@gandalf.local.home>
 <yt9d5ykbekn3.fsf@linux.ibm.com>
 <yt9dpmijcvu6.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dpmijcvu6.fsf@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 07:28:49PM +0200, Sven Schnelle wrote:
> Sven Schnelle <svens@linux.ibm.com> writes:

> I think there's a race in ptrace_check_attach(). It first calls
> ptrace_freeze_task(), which checks whether JOBCTL_TRACED is set.
> If it is (and a few other conditions match) it will set ret = 0.
> 
> Later outside of siglock and tasklist_lock it will call
> wait_task_inactive, assuming the target is in TASK_TRACED, but it isn't.
> 
> ptrace_stop(), which runs on another CPU, does:
> 
> set_special_state(TASK_TRACED);
> current->jobctl |= JOBCTL_TRACED;
> 
> which looks ok on first sight, but in this case JOBCTL is already set,
> so the reading CPU will immediately move on to wait_task_inactive(),
> before JOBCTL_TRACED is set. I don't know whether this is a valid
> combination. I never looked into JOBCTL_* semantics, but i guess now
> is a good time to do so. I added some debugging statements, and that
> gives:
> 
> [   86.218488] kill_chi-300545    2d.... 79990135us : ptrace_stop: state 8
> [   86.218492] kill_chi-300545    2d.... 79990136us : signal_generate: sig=17 errno=0 code=4 comm=strace pid=300542 grp=1 res=1
> [   86.218496] kill_chi-300545    2d.... 79990136us : sched_stat_runtime: comm=kill_child pid=300545 runtime=3058 [ns] vruntime=606165713178 [ns]
> [   86.218500] kill_chi-300545    2d.... 79990136us : sched_switch: prev_comm=kill_child prev_pid=300545 prev_prio=120 prev_state=t ==> next_comm=swapper/2 next_pid=0 next_prio=120
> [   86.218504]   strace-300542    7..... 79990139us : sys_ptrace -> 0x50
> [   86.218508]   strace-300542    7..... 79990139us : sys_write(fd: 2, buf: 2aa198f7ad0, count: 12)
> [   86.218512]   strace-300542    7..... 79990140us : sys_write -> 0x12
> [   86.218515]   <idle>-0         6dNh.. 79990140us : sched_wakeup: comm=kill_child pid=343805 prio=120 target_cpu=006
> [   86.218519]   <idle>-0         6d.... 79990140us : sched_switch: prev_comm=swapper/6 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kill_child next_pid=343805 next_prio=120
> [   86.218524]   strace-300542    7..... 79990140us : sys_write(fd: 2, buf: 2aa198f7ad0, count: 19)
> [   86.218527]   strace-300542    7..... 79990141us : sys_write -> 0x19
> [   86.218531] kill_chi-343805    6..... 79990141us : sys_sched_yield -> 0xffffffffffffffda
> [   86.218535]   strace-300542    7..... 79990141us : sys_ptrace(request: 18, pid: 53efd, addr: 0, data: 0)
> [   86.218539] kill_chi-343805    6d.... 79990141us : signal_deliver: sig=9 errno=0 code=0 sa_handler=0 sa_flags=0
> [   86.218543]   strace-300542    7d.... 79990141us : ptrace_check_attach: task_is_traced: 1, fatal signal pending: 0
> [   86.218547]   strace-300542    7..... 79990141us : ptrace_check_attach: child->pid = 343805, child->__flags=0
> [   86.218551] kill_chi-343805    6d.... 79990141us : ptrace_stop: JOBCTL_TRACED already set, state=0 <------ valid combination of flags?

Yeah, that's not supposed to be so. JOBCTL_TRACED is supposed to follow
__TASK_TRACED for now. Set when __TASK_TRACED, cleared when
TASK_RUNNING.

Specifically {ptrace_,}signal_wake_up() in signal.h clear JOBCTL_TRACED
when they would wake a __TASK_TRACED task.

> [   86.218554] kill_chi-343805    6d.... 79990141us : ptrace_stop: state 8
> [   86.218558] kill_chi-343805    6d.... 79990142us : signal_generate: sig=17 errno=0 code=4 comm=strace pid=300542 grp=1 res=1
> [   86.218562] kill_chi-343805    6d.... 79990142us : sched_stat_runtime: comm=kill_child pid=343805 runtime=2135 [ns] vruntime=556109013931 [ns]
> [   86.218566]   strace-300542    7..... 79990142us : wait_task_inactive: NO MATCH: state 0, match_state 8, pid 343805
> [   86.218570] kill_chi-343805    6d.... 79990142us : sched_switch: prev_comm=kill_child prev_pid=343805 prev_prio=120 prev_state=t ==>next_comm=swapper/6 next_pid=0 next_prio=120
> 
