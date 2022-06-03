Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9374253D250
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbiFCTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiFCTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:21:08 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C3749CBC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:21:06 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40554)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxCr2-00HJnH-Hh; Fri, 03 Jun 2022 13:21:04 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47998 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nxCr1-001Dcz-Am; Fri, 03 Jun 2022 13:21:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 03 Jun 2022 14:20:38 -0500
Message-ID: <87bkv97dvd.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nxCr1-001Dcz-Am;;;mid=<87bkv97dvd.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19Er4ajgHLfRA6qKXcVH31u8naeoWdWm5o=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 464 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (2.0%), b_tie_ro: 8 (1.7%), parse: 0.89 (0.2%),
        extract_message_metadata: 12 (2.6%), get_uri_detail_list: 2.7 (0.6%),
        tests_pri_-1000: 13 (2.8%), tests_pri_-950: 1.32 (0.3%),
        tests_pri_-900: 0.96 (0.2%), tests_pri_-90: 56 (12.0%), check_bayes:
        54 (11.7%), b_tokenize: 9 (1.9%), b_tok_get_all: 10 (2.3%),
        b_comp_prob: 3.1 (0.7%), b_tok_touch_all: 29 (6.2%), b_finish: 0.83
        (0.2%), tests_pri_0: 352 (75.9%), check_dkim_signature: 1.39 (0.3%),
        check_dkim_adsp: 3.7 (0.8%), poll_dns_idle: 0.66 (0.1%), tests_pri_10:
        1.86 (0.4%), tests_pri_500: 14 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] 
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ptrace_stop-cleanup-for-v5.19 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_stop-cleanup-for-v5.19
  HEAD: 31cae1eaae4fd65095ad6a3659db467bc3c2599e sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

While looking at the ptrace problems with PREEMPT_RT and the problems
of Peter Zijlstra was encountering with ptrace in his freezer rewrite
I identified some cleanups to ptrace_stop that make sense on their own
and move make resolving the other problems much simpler.

The biggest issue is the habbit of the ptrace code to change task->__state
from the tracer to suppress TASK_WAKEKILL from waking up the tracee.  No
other code in the kernel does that and it is straight forward to update
signal_wake_up and friends to make that unnecessary.

Peter's task freezer sets frozen tasks to a new state TASK_FROZEN and
then it stores them by calling "wake_up_state(t, TASK_FROZEN)" relying
on the fact that all stopped states except the special stop states can
tolerate spurious wake up and recover their state.

The state of stopped and traced tasked is changed to be stored in
task->jobctl as well as in task->__state.  This makes it possible for
the freezer to recover tasks in these special states, as well as
serving as a general cleanup.  With a little more work in that
direction I believe TASK_STOPPED can learn to tolerate spurious wake
ups and become an ordinary stop state.

The TASK_TRACED state has to remain a special state as the registers for
a process are only reliably available when the process is stopped in
the scheduler.  Fundamentally ptrace needs acess to the saved
register values of a task.

There are bunch of semi-random ptrace related cleanups that were found
while looking at these issues.

One cleanup that deserves to be called out is from commit 57b6de08b5f6
("ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs").  This
makes a change that is technically user space visible, in the handling
of what happens to a tracee when a tracer dies unexpectedly.
According to our testing and our understanding of userspace nothing
cares that spurious SIGTRAPs can be generated in that case.

The entire discussion can be found at:
  https://lkml.kernel.org/r/87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org

Eric W. Biederman (11):
      signal: Rename send_signal send_signal_locked
      signal: Replace __group_send_sig_info with send_signal_locked
      ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      ptrace: Remove arch_ptrace_attach
      signal: Use lockdep_assert_held instead of assert_spin_locked
      ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
      ptrace: Document that wait_task_inactive can't fail
      ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
      ptrace: Don't change __state
      ptrace: Always take siglock in ptrace_resume

Peter Zijlstra (1):
      sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

 arch/ia64/include/asm/ptrace.h    |   4 --
 arch/ia64/kernel/ptrace.c         |  57 ----------------
 arch/um/include/asm/thread_info.h |   2 +
 arch/um/kernel/exec.c             |   2 +-
 arch/um/kernel/process.c          |   2 +-
 arch/um/kernel/ptrace.c           |   8 +--
 arch/um/kernel/signal.c           |   4 +-
 arch/x86/kernel/step.c            |   3 +-
 arch/xtensa/kernel/ptrace.c       |   4 +-
 arch/xtensa/kernel/signal.c       |   4 +-
 drivers/tty/tty_jobctrl.c         |   4 +-
 include/linux/ptrace.h            |   7 --
 include/linux/sched.h             |  10 ++-
 include/linux/sched/jobctl.h      |   8 +++
 include/linux/sched/signal.h      |  20 ++++--
 include/linux/signal.h            |   3 +-
 kernel/ptrace.c                   |  87 ++++++++---------------
 kernel/sched/core.c               |   5 +-
 kernel/signal.c                   | 140 +++++++++++++++++---------------------
 kernel/time/posix-cpu-timers.c    |   6 +-
 20 files changed, 140 insertions(+), 240 deletions(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

p.s.  My apologies this is coming in so late, everyone in my house has
been sick.
