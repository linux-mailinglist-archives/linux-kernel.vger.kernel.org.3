Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D637152C6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiERWuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiERWuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:50:14 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F40149147;
        Wed, 18 May 2022 15:50:12 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:57012)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSUR-00CkAs-9I; Wed, 18 May 2022 16:49:59 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38714 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSUQ-002Y4a-2G; Wed, 18 May 2022 16:49:58 -0600
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
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
Date:   Wed, 18 May 2022 17:49:50 -0500
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 05 May 2022 13:25:57 -0500")
Message-ID: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrSUQ-002Y4a-2G;;;mid=<871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18+P8DhIXiW3QQ2kaItdAgP/dwjAcwP+HQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 589 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.11
        (0.2%), extract_message_metadata: 3.8 (0.7%), get_uri_detail_list:
        1.71 (0.3%), tests_pri_-1000: 5 (0.9%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 91 (15.4%), check_bayes:
        89 (15.1%), b_tokenize: 11 (1.9%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 61 (10.3%), b_finish: 1.04
        (0.2%), tests_pri_0: 456 (77.4%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.64 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For ptrace_stop to work on PREEMT_RT no spinlocks can be taken once
ptrace_freeze_traced has completed successfully.  Which fundamentally
means the lock dance of dropping siglock and grabbing tasklist_lock does
not work on PREEMPT_RT.  So I have worked through what is necessary so
that tasklist_lock does not need to be grabbed in ptrace_stop after
siglock is dropped.

I have explored several alternate ways of getting there and along the
way I found a lot of small bug fixes/cleanups that don't necessarily
contribute to the final result but that or worthwhile on their own.  So
I have included those changes in this set of changes just so they don't
get lost.

In addition I had a conversation with Thomas Gleixner recently that
emphasized for me the need to reduce the hold times of tasklist_lock,
and that made me realize that in principle it is possible.
https://lkml.kernel.org/r/87mtfmhap2.fsf@email.froward.int.ebiederm.org

Which is a long way of saying that not taking tasklist_lock in
ptrace_stop is good not just for PREMPT_RT but also for improving the
scalability of the kernel in general.

After this set of changes only cgroup_enter_frozen should remain a
stumbling block for PREEMPT_RT in the ptrace_stop path.

Eric W. Biederman (16):
      signal/alpha: Remove unused definition of TASK_REAL_PARENT
      signal/ia64: Remove unused definition of IA64_TASK_REAL_PARENT_OFFSET
      kdb: Use real_parent when displaying a list of processes
      powerpc/xmon:  Use real_parent when displaying a list of processes
      ptrace: Remove dead code from __ptrace_detach
      ptrace: Remove unnecessary locking in ptrace_(get|set)siginfo
      signal: Wake up the designated parent
      ptrace: Only populate last_siginfo from ptrace
      ptrace: In ptrace_setsiginfo deal with invalid si_signo
      ptrace: In ptrace_signal look at what the debugger did with siginfo
      ptrace: Use si_sino as the signal number to resume with
      ptrace: Stop protecting ptrace_set_signr with tasklist_lock
      ptrace: Document why ptrace_setoptions does not need a lock
      signal: Protect parent child relationships by childs siglock
      ptrace: Use siglock instead of tasklist_lock in ptrace_check_attach
      signal: Always call do_notify_parent_cldstop with siglock held

 arch/alpha/kernel/asm-offsets.c |   1 -
 arch/ia64/kernel/asm-offsets.c  |   1 -
 arch/powerpc/xmon/xmon.c        |   2 +-
 kernel/debug/kdb/kdb_main.c     |   2 +-
 kernel/exit.c                   |  23 +++-
 kernel/fork.c                   |  12 +-
 kernel/ptrace.c                 | 132 ++++++++----------
 kernel/signal.c                 | 296 ++++++++++++++++++++++++++--------------
 8 files changed, 279 insertions(+), 190 deletions(-)

Eric
