Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE24CB394
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiCCAOD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 19:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCCAOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:14:02 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CED1107F2;
        Wed,  2 Mar 2022 16:13:17 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:34562)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nPZ5l-008Jz4-9e; Wed, 02 Mar 2022 17:13:13 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:60740 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nPZ5j-007x5a-5P; Wed, 02 Mar 2022 17:13:12 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Kou?= =?utf-8?Q?tn=C3=BD?= <mkoutny@suse.com>,
        <linux-api@vger.kernel.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org>
        <87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org>
Date:   Wed, 02 Mar 2022 18:12:40 -0600
In-Reply-To: <87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Fri, 18 Feb 2022 09:34:24 -0600")
Message-ID: <87o82nhp1j.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nPZ5j-007x5a-5P;;;mid=<87o82nhp1j.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19gXnmU5328L5QL/gVJuFWBeZcN6LESlxA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1544 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (0.3%), b_tie_ro: 3.2 (0.2%), parse: 1.42
        (0.1%), extract_message_metadata: 17 (1.1%), get_uri_detail_list: 2.8
        (0.2%), tests_pri_-1000: 21 (1.4%), tests_pri_-950: 1.09 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 153 (9.9%), check_bayes:
        149 (9.6%), b_tokenize: 8 (0.5%), b_tok_get_all: 10 (0.7%),
        b_comp_prob: 2.4 (0.2%), b_tok_touch_all: 125 (8.1%), b_finish: 0.70
        (0.0%), tests_pri_0: 1333 (86.3%), check_dkim_signature: 0.42 (0.0%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 0.19 (0.0%), tests_pri_10:
        1.68 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucounts: Regression fix for v5.17
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ucount-rlimit-fixes-for-v5.17 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17

  HEAD: 0ac983f512033cb7b5e210c9589768ad25b1e36b ucounts: Fix systemd LimitNPROC with private users regression

Etienne Dechamps recently found a regression caused by enforcing
RLIMIT_NPROC for root where the rlimit was not previously enforced.

Michal Koutný had previously pointed out the inconsistency in enforcing
the RLIMIT_NPROC that had been on the root owned process after the root
user creates a user namespace.

Which makes the fix for the regression simply removing the
inconsistency.


From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 24 Feb 2022 08:32:28 -0600
Subject: [PATCH] ucounts: Fix systemd LimitNPROC with private users regression

Long story short recursively enforcing RLIMIT_NPROC when it is not
enforced on the process that creates a new user namespace, causes
currently working code to fail.  There is no reason to enforce
RLIMIT_NPROC recursively when we don't enforce it normally so update
the code to detect this case.

I would like to simply use capable(CAP_SYS_RESOURCE) to detect when
RLIMIT_NPROC is not enforced upon the caller.  Unfortunately because
RLIMIT_NPROC is charged and checked for enforcement based upon the
real uid, using capable() which is euid based is inconsistent with reality.
Come as close as possible to testing for capable(CAP_SYS_RESOURCE) by
testing for when the real uid would match the conditions when
CAP_SYS_RESOURCE would be present if the real uid was the effective
uid.

Reported-by: Etienne Dechamps <etienne@edechamps.fr>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215596
Link: https://lkml.kernel.org/r/e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr
Link: https://lkml.kernel.org/r/87sfs8jmpz.fsf_-_@email.froward.int.ebiederm.org
Cc: stable@vger.kernel.org
Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/user_namespace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..5481ba44a8d6 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -58,6 +58,18 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 	cred->user_ns = user_ns;
 }
 
+static unsigned long enforced_nproc_rlimit(void)
+{
+	unsigned long limit = RLIM_INFINITY;
+
+	/* Is RLIMIT_NPROC currently enforced? */
+	if (!uid_eq(current_uid(), GLOBAL_ROOT_UID) ||
+	    (current_user_ns() != &init_user_ns))
+		limit = rlimit(RLIMIT_NPROC);
+
+	return limit;
+}
+
 /*
  * Create a new user namespace, deriving the creator from the user in the
  * passed credentials, and replacing that user with the new root user for the
@@ -122,7 +134,7 @@ int create_user_ns(struct cred *new)
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
 	}
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
+	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, enforced_nproc_rlimit());
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
-- 
2.29.2

