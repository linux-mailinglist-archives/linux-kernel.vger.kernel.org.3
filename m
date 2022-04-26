Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4ED510C37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355694AbiDZWyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiDZWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:54:17 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B4043AF6;
        Tue, 26 Apr 2022 15:51:08 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60786)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU1Q-00Fjdd-J7; Tue, 26 Apr 2022 16:51:04 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35762 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU1P-0069qu-F8; Tue, 26 Apr 2022 16:51:04 -0600
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
        Kees Cook <keescook@chromium.org>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
Date:   Tue, 26 Apr 2022 17:50:21 -0500
In-Reply-To: <87czhap9dy.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 21 Apr 2022 13:40:57 -0500")
Message-ID: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njU1P-0069qu-F8;;;mid=<878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+owb0c0Gz7E4NISzDrmUFadshStTe596o=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 519 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 17 (3.4%), b_tie_ro: 12 (2.2%), parse: 2.4 (0.5%),
         extract_message_metadata: 6 (1.1%), get_uri_detail_list: 2.0 (0.4%),
        tests_pri_-1000: 6 (1.1%), tests_pri_-950: 1.52 (0.3%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 107 (20.5%), check_bayes:
        105 (20.2%), b_tokenize: 10 (2.0%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 3.3 (0.6%), b_tok_touch_all: 79 (15.2%), b_finish: 0.96
        (0.2%), tests_pri_0: 334 (64.4%), check_dkim_signature: 0.72 (0.1%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 1.26 (0.2%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 29 (5.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/9] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While looking at how ptrace is broken on PREEMPT_RT I realized
that ptrace_stop would be much simpler and more maintainable
if tsk->ptrace, tsk->parent, and tsk->real_parent were protected
by siglock.  Most of the changes are general cleanups in support
of this locking change.

While making the necessary changes to protect tsk->ptrace with
siglock I discovered we have two architectures xtensa and um
that were using tsk->ptrace for what most other architectures
use TIF_SIGPENDING for and not protecting tsk->ptrace with any lock.

By the end of this series ptrace should work on PREEMPT_RT with the
CONFIG_FREEZER and CONFIG_CGROUPS disabled, by the simple fact that the
ptrace_stop code becomes less special.  The function cgroup_enter_frozen
because it takes a lock which is a sleeping lock on PREEMPT_RT with
preemption disabled definitely remains a problem.  Peter Zijlstra has
been rewriting the classic freezer and in earlier parts of this
discussion so I presume it is also a problem for PREEMPT_RT.

Peter's series rewriting the freezer[1] should work on top of this
series with minimal changes and patch 2/5 removed.

Eric W. Biederman (9):
      signal: Rename send_signal send_signal_locked
      signal: Replace __group_send_sig_info with send_signal_locked
      ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      signal: Protect parent child relationships by childs siglock
      signal: Always call do_notify_parent_cldstop with siglock held
      ptrace: Simplify the wait_task_inactive call in ptrace_check_attach
      ptrace: Use siglock instead of tasklist_lock in ptrace_check_attach
      ptrace: Don't change __state

 arch/um/include/asm/thread_info.h |   2 +
 arch/um/kernel/exec.c             |   2 +-
 arch/um/kernel/process.c          |   2 +-
 arch/um/kernel/ptrace.c           |   8 +-
 arch/um/kernel/signal.c           |   4 +-
 arch/xtensa/kernel/ptrace.c       |   4 +-
 arch/xtensa/kernel/signal.c       |   4 +-
 drivers/tty/tty_jobctrl.c         |   4 +-
 include/linux/ptrace.h            |   7 --
 include/linux/sched/jobctl.h      |   2 +
 include/linux/sched/signal.h      |   3 +-
 include/linux/signal.h            |   3 +-
 kernel/exit.c                     |   4 +
 kernel/fork.c                     |  12 +--
 kernel/ptrace.c                   |  61 ++++++-------
 kernel/signal.c                   | 187 ++++++++++++++------------------------
 kernel/time/posix-cpu-timers.c    |   6 +-
 17 files changed, 131 insertions(+), 184 deletions(-)

[1] https://lkml.kernel.org/r/20220421150248.667412396@infradead.org

Eric
