Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DA51C7D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384324AbiEESgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385620AbiEESfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:35:25 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EABF17E1B;
        Thu,  5 May 2022 11:26:35 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:35900)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgAw-004YvQ-5P; Thu, 05 May 2022 12:26:06 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37108 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgAv-003VYC-3m; Thu, 05 May 2022 12:26:05 -0600
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
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
Date:   Thu, 05 May 2022 13:25:57 -0500
In-Reply-To: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 04 May 2022 17:39:33 -0500")
Message-ID: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmgAv-003VYC-3m;;;mid=<87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18JBIioV2PhpJQppVzrfu1tMMPl3nYOVbs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 462 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.6%), b_tie_ro: 10 (2.2%), parse: 0.85
        (0.2%), extract_message_metadata: 3.0 (0.7%), get_uri_detail_list:
        1.19 (0.3%), tests_pri_-1000: 3.7 (0.8%), tests_pri_-950: 1.39 (0.3%),
        tests_pri_-900: 1.24 (0.3%), tests_pri_-90: 97 (20.9%), check_bayes:
        95 (20.5%), b_tokenize: 8 (1.7%), b_tok_get_all: 12 (2.6%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 68 (14.6%), b_finish: 1.14
        (0.2%), tests_pri_0: 326 (70.5%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 3.2 (0.7%), poll_dns_idle: 1.30 (0.3%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

A couple of issues have been pointed but I think this parred back set of
changes is still on the right track.  The biggest change in v4 is the
split of "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs" into
two patches because the dependency I thought exited between two
different changes did not exist.  The rest of the changes are minor
tweaks to "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs";
removing an always true branch, and adding an early  test to see if the
ptracer had gone, before TASK_TRAPPING was set.

This set of changes should support Peter's freezer rewrite, and with the
addition of changing wait_task_inactive(TASK_TRACED) to be
wait_task_inactive(0) in ptrace_check_attach I don't think there are any
races or issues to be concerned about from the ptrace side.

More work is needed to support PREEMPT_RT, but these changes get things
closer.

This set of changes continues to look like it will provide a firm
foundation for solving the PREEMPT_RT and freezer challenges.

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

Eric
