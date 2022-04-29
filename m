Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3215E51575B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiD2Vwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbiD2Vwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:52:30 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C5DB4B6;
        Fri, 29 Apr 2022 14:49:11 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:49840)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYUA-007OD7-DD; Fri, 29 Apr 2022 15:49:10 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36464 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYU9-007RIp-7i; Fri, 29 Apr 2022 15:49:09 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 29 Apr 2022 16:48:30 -0500
Message-Id: <20220429214837.386518-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nkYU9-007RIp-7i;;;mid=<20220429214837.386518-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/m1omujSCUx+WoYaAXDnsPr1oSU3IgaAc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 330 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (1.2%), b_tie_ro: 2.7 (0.8%), parse: 0.69
        (0.2%), extract_message_metadata: 10 (3.1%), get_uri_detail_list: 0.96
        (0.3%), tests_pri_-1000: 20 (6.0%), tests_pri_-950: 1.17 (0.4%),
        tests_pri_-900: 0.99 (0.3%), tests_pri_-90: 52 (15.9%), check_bayes:
        51 (15.4%), b_tokenize: 6 (1.7%), b_tok_get_all: 7 (2.0%),
        b_comp_prob: 1.58 (0.5%), b_tok_touch_all: 33 (10.0%), b_finish: 0.74
        (0.2%), tests_pri_0: 231 (69.9%), check_dkim_signature: 0.56 (0.2%),
        check_dkim_adsp: 2.1 (0.6%), poll_dns_idle: 0.71 (0.2%), tests_pri_10:
        1.71 (0.5%), tests_pri_500: 6 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 05/12] signal: Use lockdep_assert_held instead of assert_spin_locked
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The distinction is that assert_spin_locked() checks if the lock is
held *by*anyone* whereas lockdep_assert_held() asserts the current
context holds the lock.  Also, the check goes away if you build
without lockdep.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Ympr/+PX4XgT/UKU@hirez.programming.kicks-ass.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 72d96614effc..3fd2ce133387 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -884,7 +884,7 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
 static void ptrace_trap_notify(struct task_struct *t)
 {
 	WARN_ON_ONCE(!(t->ptrace & PT_SEIZED));
-	assert_spin_locked(&t->sighand->siglock);
+	lockdep_assert_held(&t->sighand->siglock);
 
 	task_set_jobctl_pending(t, JOBCTL_TRAP_NOTIFY);
 	ptrace_signal_wake_up(t, t->jobctl & JOBCTL_LISTENING);
@@ -1079,7 +1079,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 	int override_rlimit;
 	int ret = 0, result;
 
-	assert_spin_locked(&t->sighand->siglock);
+	lockdep_assert_held(&t->sighand->siglock);
 
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, force))
-- 
2.35.3

