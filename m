Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3624B1C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347243AbiBKCOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:14:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbiBKCOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:14:18 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE75FBF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:14:18 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:35092)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILRx-00BUbR-6c; Thu, 10 Feb 2022 19:14:17 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:52650 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILRu-00FMXV-RJ; Thu, 10 Feb 2022 19:14:16 -0700
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
Date:   Thu, 10 Feb 2022 20:13:22 -0600
Message-Id: <20220211021324.4116773-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nILRu-00FMXV-RJ;;;mid=<20220211021324.4116773-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX185fZu70DepgDsCFU1fZ46rdHDhwl7ZN6w=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1733 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.39
        (0.1%), extract_message_metadata: 13 (0.8%), get_uri_detail_list: 1.58
        (0.1%), tests_pri_-1000: 14 (0.8%), tests_pri_-950: 1.32 (0.1%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 433 (25.0%), check_bayes:
        432 (24.9%), b_tokenize: 6 (0.4%), b_tok_get_all: 6 (0.3%),
        b_comp_prob: 1.93 (0.1%), b_tok_touch_all: 414 (23.9%), b_finish: 0.98
        (0.1%), tests_pri_0: 1235 (71.3%), check_dkim_signature: 0.57 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.84 (0.0%), tests_pri_10:
        3.0 (0.2%), tests_pri_500: 15 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/8] ucounts: Handle inc_rlimit_ucounts wrapping in fork
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move inc_rlimit_ucounts from copy_creds into copy_process immediately
after copy_creds where it can be called exactly once.  Test for and
handle it when inc_rlimit_ucounts returns LONG_MAX indicating the
count has wrapped.

This is good hygenine and fixes a theoretical bug.  In practice
PID_MAX_LIMIT is at most 2^22 so there is not a chance the number of
processes would ever wrap even on an architecture with a 32bit long.

Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/cred.c | 2 --
 kernel/fork.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 229cff081167..96d5fd6ff26f 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -358,7 +358,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		kdebug("share_creds(%p{%d,%d})",
 		       p->cred, atomic_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
-		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 		return 0;
 	}
 
@@ -395,7 +394,6 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 #endif
 
 	p->cred = p->real_cred = get_cred(new);
-	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	alter_cred_subscribers(new, 2);
 	validate_creds(new);
 	return 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 6f62d37f3650..69333078259c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2026,6 +2026,8 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_free;
 
 	retval = -EAGAIN;
+	if (inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1) == LONG_MAX)
+		goto bad_fork_cleanup_count;
 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if ((task_ucounts(p) != &init_ucounts) &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
-- 
2.29.2

