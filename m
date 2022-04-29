Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86951583E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381445AbiD2WP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381448AbiD2WPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:15:49 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9FDCE06;
        Fri, 29 Apr 2022 15:12:24 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38182)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYSx-00AIAD-EI; Fri, 29 Apr 2022 15:47:55 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36454 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYSv-005dKg-DP; Fri, 29 Apr 2022 15:47:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
Date:   Fri, 29 Apr 2022 16:46:59 -0500
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 26 Apr 2022 17:50:21 -0500")
Message-ID: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nkYSv-005dKg-DP;;;mid=<87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+ZIVHGWhwXaAZQuMgvUvy1NsqcM6xYpoc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1441 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (0.9%), b_tie_ro: 11 (0.8%), parse: 1.53
        (0.1%), extract_message_metadata: 5 (0.4%), get_uri_detail_list: 2.1
        (0.1%), tests_pri_-1000: 6 (0.4%), tests_pri_-950: 1.76 (0.1%),
        tests_pri_-900: 1.50 (0.1%), tests_pri_-90: 116 (8.0%), check_bayes:
        113 (7.9%), b_tokenize: 13 (0.9%), b_tok_get_all: 10 (0.7%),
        b_comp_prob: 3.4 (0.2%), b_tok_touch_all: 82 (5.7%), b_finish: 1.17
        (0.1%), tests_pri_0: 1274 (88.4%), check_dkim_signature: 0.88 (0.1%),
        check_dkim_adsp: 2.9 (0.2%), poll_dns_idle: 0.88 (0.1%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The states TASK_STOPPED and TASK_TRACE are special in they can not
handle spurious wake-ups.  This plus actively depending upon and
changing the value of tsk->__state causes problems for PREEMPT_RT and
Peter's freezer rewrite.

There are a lot of details we have to get right to sort out the
technical challenges and this is my parred back version of the changes
that contains just those problems I see good solutions to that I believe
are ready.

In particular I don't have a solution that is ready for the challenges
presented by wait_task_inactive.

I hope we can review these changes and then have a firm foundation
for the rest of the challenges.

There are cleanups to the ptrace support for xtensa, um, and
ia64.

I have sucked in the first patch of Peter's freezer change as
with minor modifications I believe it is ready to go.

Eric W. Biederman (12):
      signal: Rename send_signal send_signal_locked
      signal: Replace __group_send_sig_info with send_signal_locked
      ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      signal: Use lockdep_assert_held instead of assert_spin_locked
      ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
      ptrace: Don't change __state
      ptrace: Remove arch_ptrace_attach
      ptrace: Always take siglock in ptrace_resume
      ptrace: Only return signr from ptrace_stop if it was provided
      ptrace: Always call schedule in ptrace_stop
      sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

 arch/ia64/include/asm/ptrace.h    |   4 --
 arch/ia64/kernel/ptrace.c         |  57 ----------------
 arch/um/include/asm/thread_info.h |   2 +
 arch/um/kernel/exec.c             |   2 +-
 arch/um/kernel/process.c          |   2 +-
 arch/um/kernel/ptrace.c           |   8 +--
 arch/um/kernel/signal.c           |   4 +-
 arch/xtensa/kernel/ptrace.c       |   4 +-
 arch/xtensa/kernel/signal.c       |   4 +-
 drivers/tty/tty_jobctrl.c         |   4 +-
 include/linux/ptrace.h            |   7 --
 include/linux/sched.h             |  10 ++-
 include/linux/sched/jobctl.h      |  10 +++
 include/linux/sched/signal.h      |  23 ++++++-
 include/linux/signal.h            |   3 +-
 kernel/ptrace.c                   |  88 +++++++++----------------
 kernel/signal.c                   | 135 +++++++++++++++++---------------------
 kernel/time/posix-cpu-timers.c    |   6 +-
 18 files changed, 145 insertions(+), 228 deletions(-)

Eric
