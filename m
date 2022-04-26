Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458D510C47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiDZW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355935AbiDZW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:56:13 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A04473B2;
        Tue, 26 Apr 2022 15:53:05 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60022)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3M-007FwD-9j; Tue, 26 Apr 2022 16:53:04 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35772 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3L-006ASW-Aa; Tue, 26 Apr 2022 16:53:03 -0600
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
Date:   Tue, 26 Apr 2022 17:52:09 -0500
Message-Id: <20220426225211.308418-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1njU3L-006ASW-Aa;;;mid=<20220426225211.308418-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX196mjsOCd0SEDESfdGedhN7wA/hLrR7neg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 317 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.7%), b_tie_ro: 10 (3.3%), parse: 1.15
        (0.4%), extract_message_metadata: 13 (4.0%), get_uri_detail_list: 1.25
        (0.4%), tests_pri_-1000: 14 (4.5%), tests_pri_-950: 1.23 (0.4%),
        tests_pri_-900: 1.04 (0.3%), tests_pri_-90: 56 (17.6%), check_bayes:
        55 (17.2%), b_tokenize: 6 (2.0%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 2.2 (0.7%), b_tok_touch_all: 37 (11.7%), b_finish: 0.81
        (0.3%), tests_pri_0: 203 (64.0%), check_dkim_signature: 0.51 (0.2%),
        check_dkim_adsp: 3.3 (1.0%), poll_dns_idle: 1.32 (0.4%), tests_pri_10:
        3.1 (1.0%), tests_pri_500: 10 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in ptrace_check_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asking wait_task_inactive to verify that tsk->__state == __TASK_TRACED
was needed to detect the when ptrace_stop would decide not to stop
after calling "set_special_state(TASK_TRACED)".  With the recent
cleanups ptrace_stop will always stop after calling set_special_state.

Take advatnage of this by no longer asking wait_task_inactive to
verify the state.  If a bug is hit and wait_task_inactive does not
succeed warn and return -ESRCH.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 16d1a84a2cae..0634da7ac685 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -265,17 +265,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
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
+	    WARN_ON_ONCE(!wait_task_inactive(child, 0)))
+		ret = -ESRCH;
 
 	return ret;
 }
-- 
2.35.3

