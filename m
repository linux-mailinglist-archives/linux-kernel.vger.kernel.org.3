Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2900A51B217
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356701AbiEDWpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379069AbiEDWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:45:22 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9F7506FB;
        Wed,  4 May 2022 15:41:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:54346)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgd-00EDRr-Vc; Wed, 04 May 2022 16:41:36 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37004 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgb-00GI0k-Rj; Wed, 04 May 2022 16:41:35 -0600
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
Date:   Wed,  4 May 2022 17:40:53 -0500
Message-Id: <20220504224058.476193-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmNgb-00GI0k-Rj;;;mid=<20220504224058.476193-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX191+Y3gGBLqhEu9BnhgzRytX/h5lMwm5zQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1292 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.0 (0.3%), b_tie_ro: 2.8 (0.2%), parse: 0.62
        (0.0%), extract_message_metadata: 10 (0.7%), get_uri_detail_list: 0.85
        (0.1%), tests_pri_-1000: 17 (1.4%), tests_pri_-950: 0.94 (0.1%),
        tests_pri_-900: 0.77 (0.1%), tests_pri_-90: 68 (5.2%), check_bayes: 67
        (5.2%), b_tokenize: 5 (0.4%), b_tok_get_all: 23 (1.8%), b_comp_prob:
        1.41 (0.1%), b_tok_touch_all: 34 (2.6%), b_finish: 0.69 (0.1%),
        tests_pri_0: 1179 (91.2%), check_dkim_signature: 0.34 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 1.00 (0.1%), tests_pri_10:
        2.7 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 06/11] signal: Use lockdep_assert_held instead of assert_spin_locked
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

