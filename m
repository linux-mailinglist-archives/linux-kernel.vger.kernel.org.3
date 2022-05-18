Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B501752C722
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiERW6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiERWzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:54 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA4C22EA72;
        Wed, 18 May 2022 15:55:22 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33438)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZd-00Ckcv-Nn; Wed, 18 May 2022 16:55:21 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZc-002Z0O-KW; Wed, 18 May 2022 16:55:21 -0600
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
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 18 May 2022 17:53:54 -0500
Message-Id: <20220518225355.784371-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZc-002Z0O-KW;;;mid=<20220518225355.784371-15-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19BX42rXAmEdeldIBaC1nvKtXoRgWt4/eg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 473 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 14 (3.0%), b_tie_ro: 12 (2.5%), parse: 2.0 (0.4%),
         extract_message_metadata: 19 (4.0%), get_uri_detail_list: 2.4 (0.5%),
        tests_pri_-1000: 23 (4.8%), tests_pri_-950: 1.71 (0.4%),
        tests_pri_-900: 1.47 (0.3%), tests_pri_-90: 64 (13.5%), check_bayes:
        62 (13.1%), b_tokenize: 13 (2.7%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 3.2 (0.7%), b_tok_touch_all: 35 (7.4%), b_finish: 0.87
        (0.2%), tests_pri_0: 321 (67.8%), check_dkim_signature: 0.97 (0.2%),
        check_dkim_adsp: 3.5 (0.7%), poll_dns_idle: 0.92 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 20 (4.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 15/16] ptrace: Use siglock instead of tasklist_lock in ptrace_check_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that siglock protects tsk->parent and tsk->ptrace there is no need
to grab tasklist_lock in ptrace_check_attach.  The siglock can handle
all of the locking needs of ptrace_check_attach.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 77dfdb3d1ced..fa65841bbdbe 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -194,17 +194,14 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 {
 	bool ret = false;
 
-	/* Lockless, nobody but us can set this flag */
 	if (task->jobctl & JOBCTL_LISTENING)
 		return ret;
 
-	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
 		task->jobctl |= JOBCTL_PTRACE_FROZEN;
 		ret = true;
 	}
-	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
 }
@@ -240,32 +237,30 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
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
-		/*
-		 * child->sighand can't be NULL, release_task()
-		 * does ptrace_unlink() before __exit_signal().
-		 */
-		if (ignore_state || ptrace_freeze_traced(child))
-			ret = 0;
+	if (lock_task_sighand(child, &flags)) {
+		if (child->ptrace && child->parent == current) {
+			if (ignore_state || ptrace_freeze_traced(child))
+				ret = 0;
+		}
+		unlock_task_sighand(child, &flags);
 	}
-	read_unlock(&tasklist_lock);
 
 	if (!ret && !ignore_state &&
 	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
-- 
2.35.3

