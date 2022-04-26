Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB0510C49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355983AbiDZW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355949AbiDZW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:56:16 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D13D4CD43;
        Tue, 26 Apr 2022 15:53:08 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:57512)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3P-00CcWA-H2; Tue, 26 Apr 2022 16:53:07 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35772 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3O-006ASW-76; Tue, 26 Apr 2022 16:53:06 -0600
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
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 26 Apr 2022 17:52:10 -0500
Message-Id: <20220426225211.308418-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1njU3O-006ASW-76;;;mid=<20220426225211.308418-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19vCMILBL9SRVw0QkC5/xHZqHpvkZOM2VA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 523 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.4%), b_tie_ro: 11 (2.1%), parse: 1.42
        (0.3%), extract_message_metadata: 16 (3.0%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 19 (3.6%), tests_pri_-950: 1.51 (0.3%),
        tests_pri_-900: 1.26 (0.2%), tests_pri_-90: 57 (11.0%), check_bayes:
        56 (10.7%), b_tokenize: 10 (1.9%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 31 (6.0%), b_finish: 0.92
        (0.2%), tests_pri_0: 393 (75.2%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.68 (0.1%), tests_pri_10:
        3.7 (0.7%), tests_pri_500: 13 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 8/9] ptrace: Use siglock instead of tasklist_lock in ptrace_check_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that siglock protects tsk->parent and tsk->ptrace there is no need
to grab tasklist_lock in ptrace_check_attach.  The siglock can handle
all of the locking needs of ptrace_check_attach.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 0634da7ac685..842511ee9a9f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -189,17 +189,14 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 {
 	bool ret = false;
 
-	/* Lockless, nobody but us can set this flag */
 	if (task->jobctl & JOBCTL_LISTENING)
 		return ret;
 
-	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
 		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
-	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
 }
@@ -237,33 +234,35 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
  * state.
  *
  * CONTEXT:
- * Grabs and releases tasklist_lock and @child->sighand->siglock.
+ * Grabs and releases @child->sighand->siglock.
  *
  * RETURNS:
  * 0 on success, -ESRCH if %child is not ready.
  */
 static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
+	unsigned long flags;
 	int ret = -ESRCH;
 
 	/*
-	 * We take the read lock around doing both checks to close a
+	 * We take the siglock around doing both checks to close a
 	 * possible race where someone else was tracing our child and
 	 * detached between these two checks.  After this locked check,
 	 * we are sure that this is our traced child and that can only
 	 * be changed by us so it's not changing right after this.
 	 */
-	read_lock(&tasklist_lock);
-	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-		/*
-		 * child->sighand can't be NULL, release_task()
-		 * does ptrace_unlink() before __exit_signal().
-		 */
-		if (ignore_state || ptrace_freeze_traced(child))
-			ret = 0;
+	if (lock_task_sighand(child, &flags)) {
+		if (child->ptrace && child->parent == current) {
+			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+			/*
+			 * child->sighand can't be NULL, release_task()
+			 * does ptrace_unlink() before __exit_signal().
+			 */
+			if (ignore_state || ptrace_freeze_traced(child))
+				ret = 0;
+		}
+		unlock_task_sighand(child, &flags);
 	}
-	read_unlock(&tasklist_lock);
 
 	if (!ret && !ignore_state &&
 	    WARN_ON_ONCE(!wait_task_inactive(child, 0)))
-- 
2.35.3

