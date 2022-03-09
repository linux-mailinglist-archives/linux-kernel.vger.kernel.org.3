Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096C54D354A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiCIQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiCIQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:17 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49B19143B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:28 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33250)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7r-00327k-UR; Wed, 09 Mar 2022 09:25:23 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7q-005hAS-Qu; Wed, 09 Mar 2022 09:25:23 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:42 -0600
Message-Id: <20220309162454.123006-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz7q-005hAS-Qu;;;mid=<20220309162454.123006-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19zLug7qOq1vqtHb4J0vYNTM2ZFZM4qWrQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (2.0%), b_tie_ro: 8 (1.8%), parse: 0.88 (0.2%),
        extract_message_metadata: 11 (2.5%), get_uri_detail_list: 1.46 (0.3%),
        tests_pri_-1000: 14 (3.0%), tests_pri_-950: 1.22 (0.3%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 98 (21.3%), check_bayes:
        96 (21.0%), b_tokenize: 7 (1.5%), b_tok_get_all: 5 (1.2%),
        b_comp_prob: 1.91 (0.4%), b_tok_touch_all: 79 (17.2%), b_finish: 0.85
        (0.2%), tests_pri_0: 310 (67.5%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 1.28 (0.3%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 01/13] ptrace: Move ptrace_report_syscall into ptrace.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ptrace_report_syscall from tracehook.h into ptrace.h where it
belongs.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h    | 27 +++++++++++++++++++++++++++
 include/linux/tracehook.h | 26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 8aee2945ff08..91b1074edb4c 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -413,4 +413,31 @@ static inline void user_single_step_report(struct pt_regs *regs)
 extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
+
+/*
+ * ptrace report for syscall entry and exit looks identical.
+ */
+static inline int ptrace_report_syscall(unsigned long message)
+{
+	int ptrace = current->ptrace;
+
+	if (!(ptrace & PT_PTRACED))
+		return 0;
+
+	current->ptrace_message = message;
+	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
+
+	/*
+	 * this isn't the same as continuing with a signal, but it will do
+	 * for normal use.  strace only continues with a signal if the
+	 * stopping signal is not SIGTRAP.  -brl
+	 */
+	if (current->exit_code) {
+		send_sig(current->exit_code, current, 1);
+		current->exit_code = 0;
+	}
+
+	current->ptrace_message = 0;
+	return fatal_signal_pending(current);
+}
 #endif
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 88c007ab5ebc..998bc3863559 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -51,32 +51,6 @@
 #include <linux/blk-cgroup.h>
 struct linux_binprm;
 
-/*
- * ptrace report for syscall entry and exit looks identical.
- */
-static inline int ptrace_report_syscall(unsigned long message)
-{
-	int ptrace = current->ptrace;
-
-	if (!(ptrace & PT_PTRACED))
-		return 0;
-
-	current->ptrace_message = message;
-	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
-
-	/*
-	 * this isn't the same as continuing with a signal, but it will do
-	 * for normal use.  strace only continues with a signal if the
-	 * stopping signal is not SIGTRAP.  -brl
-	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
-
-	current->ptrace_message = 0;
-	return fatal_signal_pending(current);
-}
 
 /**
  * tracehook_report_syscall_entry - task is about to attempt a system call
-- 
2.29.2

