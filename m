Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88794B1C10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbiBKCOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:14:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347240AbiBKCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:14:31 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B804D5FD5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:14:24 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:35186)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILS3-00BUcU-UA; Thu, 10 Feb 2022 19:14:23 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:52650 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILS1-00FMXV-SH; Thu, 10 Feb 2022 19:14:23 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        containers@lists.linux-foundation.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu, 10 Feb 2022 20:13:24 -0600
Message-Id: <20220211021324.4116773-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nILS1-00FMXV-SH;;;mid=<20220211021324.4116773-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Or+twTXTMydG/l+34jyMzeosWu6hwqIk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1400 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.7 (0.3%), b_tie_ro: 3.2 (0.2%), parse: 1.30
        (0.1%), extract_message_metadata: 11 (0.8%), get_uri_detail_list: 2.4
        (0.2%), tests_pri_-1000: 11 (0.8%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 79 (5.6%), check_bayes: 77
        (5.5%), b_tokenize: 6 (0.5%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        1.75 (0.1%), b_tok_touch_all: 59 (4.2%), b_finish: 0.77 (0.1%),
        tests_pri_0: 1278 (91.3%), check_dkim_signature: 0.41 (0.0%),
        check_dkim_adsp: 1.87 (0.1%), poll_dns_idle: 0.47 (0.0%),
        tests_pri_10: 2.6 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 8/8] ucounts: Use the same code to enforce RLIMIT_NPROC in fork and exec
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically these pieces of code have slightly diverged and caused
problems.  To avoid that in the future create a common function to see
if RLIMIT_NPROC is over a limit and the limit should be enforced.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                    |  7 ++-----
 include/linux/sched/signal.h |  2 ++
 kernel/fork.c                | 25 +++++++++++++++++++------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 01c8c7bae9b4..8913dbb9a479 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1875,14 +1875,11 @@ static int do_execveat_common(int fd, struct filename *filename,
 		return PTR_ERR(filename);
 
 	/*
-	 * After calling set*uid() is RLIMT_NPROC exceeded?
+	 * After calling set*uid() is RLIMIT_NPROC exceeded?
 	 * This can not be checked in set*uid() because too many programs don't
 	 * check the setuid() return code.
 	 */
-	if ((current->flags & PF_NPROC_CHECK) &&
-	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
-	    (current_ucounts() != &init_ucounts) &&
-	    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
+	if ((current->flags & PF_NPROC_CHECK) && is_nproc_overlimit()) {
 		retval = -EAGAIN;
 		goto out_ret;
 	}
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b6ecb9fc4cd2..b682131c52fa 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -742,4 +742,6 @@ static inline unsigned long rlimit_max(unsigned int limit)
 	return task_rlimit_max(current, limit);
 }
 
+extern bool is_nproc_overlimit(void);
+
 #endif /* _LINUX_SCHED_SIGNAL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 79661678a5bf..a18f15053e22 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1891,6 +1891,23 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
 	mutex_unlock(&oom_adj_mutex);
 }
 
+static bool is_task_nproc_overlimit(struct task_struct *task)
+{
+	struct ucounts *ucounts = task_ucounts(task);
+	/* clone does not change RLIMIT_NPROC. The parents value is safe. */
+	unsigned long limit = rlimit(RLIMIT_NPROC);
+
+	return is_ucounts_overlimit(ucounts, UCOUNT_RLIMIT_NPROC, limit) &&
+		(ucounts != &init_ucounts) &&
+		!has_capability(task, CAP_SYS_RESOURCE) &&
+		!has_capability(task, CAP_SYS_ADMIN);
+}
+
+bool is_nproc_overlimit(void)
+{
+	return is_task_nproc_overlimit(current);
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2028,12 +2045,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = -EAGAIN;
 	if (inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1) == LONG_MAX)
 		goto bad_fork_cleanup_count;
-	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
-		if ((task_ucounts(p) != &init_ucounts) &&
-		    !has_capability(p, CAP_SYS_RESOURCE) &&
-		    !has_capability(p, CAP_SYS_ADMIN))
-			goto bad_fork_cleanup_count;
-	}
+	if (is_task_nproc_overlimit(p))
+		goto bad_fork_cleanup_count;
 	current->flags &= ~PF_NPROC_CHECK;
 
 	/*
-- 
2.29.2

