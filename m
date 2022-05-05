Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13451C7CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357699AbiEESiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384366AbiEEShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:37:06 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5598D5DBEE;
        Thu,  5 May 2022 11:27:37 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53624)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCO-007Bzy-6p; Thu, 05 May 2022 12:27:36 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37118 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCN-002BtP-4R; Thu, 05 May 2022 12:27:35 -0600
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
Date:   Thu,  5 May 2022 13:26:41 -0500
Message-Id: <20220505182645.497868-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmgCN-002BtP-4R;;;mid=<20220505182645.497868-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18Tux0nNErfiXQBul/5mZQkdooHVQSmtjM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 458 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.2%), parse: 1.13
        (0.2%), extract_message_metadata: 13 (2.7%), get_uri_detail_list: 1.58
        (0.3%), tests_pri_-1000: 15 (3.3%), tests_pri_-950: 1.39 (0.3%),
        tests_pri_-900: 1.17 (0.3%), tests_pri_-90: 107 (23.3%), check_bayes:
        105 (23.0%), b_tokenize: 8 (1.8%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.6 (0.6%), b_tok_touch_all: 83 (18.2%), b_finish: 0.93
        (0.2%), tests_pri_0: 291 (63.6%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.85 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 11 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 08/12] ptrace: Document that wait_task_inactive can't fail
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After ptrace_freeze_traced succeeds it is known that the the tracee
has a __state value of __TASK_TRACED and that no __ptrace_unlink will
happen because the tracer is waiting for the tracee, and the tracee is
in ptrace_stop.

The function ptrace_freeze_traced can succeed at any point after
ptrace_stop has set TASK_TRACED and dropped siglock.  The read_lock on
tasklist_lock only excludes ptrace_attach.

This means that the !current->ptrace which executes under a read_lock
of tasklist_lock will never see a ptrace_freeze_trace as the tracer
must have gone away before the tasklist_lock was taken and
ptrace_attach can not occur until the read_lock is dropped.  As
ptrace_freeze_traced depends upon ptrace_attach running before it can
run that excludes ptrace_freeze_traced until __state is set to
TASK_RUNNING.  This means that task_is_traced will fail in
ptrace_freeze_attach and ptrace_freeze_attached will fail.

On the current->ptrace branch of ptrace_stop which will be reached any
time after ptrace_freeze_traced has succeed it is known that __state
is __TASK_TRACED and schedule() will be called with that state.

Use a WARN_ON_ONCE to document that wait_task_inactive(TASK_TRACED)
should never fail.  Remove the stale comment about may_ptrace_stop.

Strictly speaking this is not true because if PREEMPT_RT is enabled
wait_task_inactive can fail because __state can be changed.  I don't
see this as a problem as the ptrace code is currently broken on
PREMPT_RT, and this is one of the issues.  Failing and warning when
the assumptions of the code are broken is good.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 7105821595bc..05953ac9f7bd 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -266,17 +266,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
-			/*
-			 * This can only happen if may_ptrace_stop() fails and
-			 * ptrace_stop() changes ->state back to TASK_RUNNING,
-			 * so we should not worry about leaking __TASK_TRACED.
-			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-			ret = -ESRCH;
-		}
-	}
+	if (!ret && !ignore_state &&
+	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+		ret = -ESRCH;
 
 	return ret;
 }
-- 
2.35.3

