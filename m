Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431854EA3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiC1XzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiC1XzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:55:06 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC5134
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:53:22 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:48432)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYzAm-00FuPV-4Y; Mon, 28 Mar 2022 17:53:20 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41522 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYzAk-000IZk-5q; Mon, 28 Mar 2022 17:53:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <legion@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>
References: <20220322080918.59861-1-linmiaohe@huawei.com>
Date:   Mon, 28 Mar 2022 18:52:43 -0500
In-Reply-To: <20220322080918.59861-1-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Tue, 22 Mar 2022 16:09:18 +0800")
Message-ID: <87ilrxprck.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nYzAk-000IZk-5q;;;mid=<87ilrxprck.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Nb6UePjBpVKyMHCsWjDtNwSqTFKHXX5Q=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1416 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (1.1%), b_tie_ro: 13 (0.9%), parse: 1.10
        (0.1%), extract_message_metadata: 18 (1.3%), get_uri_detail_list: 2.9
        (0.2%), tests_pri_-1000: 15 (1.0%), tests_pri_-950: 1.36 (0.1%),
        tests_pri_-900: 1.21 (0.1%), tests_pri_-90: 96 (6.8%), check_bayes: 93
        (6.5%), b_tokenize: 6 (0.4%), b_tok_get_all: 9 (0.7%), b_comp_prob:
        2.6 (0.2%), b_tok_touch_all: 69 (4.9%), b_finish: 1.39 (0.1%),
        tests_pri_0: 1254 (88.6%), check_dkim_signature: 0.47 (0.0%),
        check_dkim_adsp: 3.7 (0.3%), poll_dns_idle: 1.82 (0.1%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucounts: Fix shm ucounts for v5.18
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ucount-rlimit-for-v5.18 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-for-v5.18

  HEAD: e97824ff663ce3509fe040431c713182c2f058b1 mm/mlock: fix two bugs in user_shm_lock()

From: Miaohe Lin <linmiaohe@huawei.com>
Date: Tue, 22 Mar 2022 16:09:18 +0800
Subject: [PATCH] mm/mlock: fix two bugs in user_shm_lock()

user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So the
later user_shm_unlock might do the extra dec_rlimit_ucounts. Also in the
RLIM_INFINITY case, user_shm_lock will success regardless of the value of
memlock where memblock == LONG_MAX && !capable(CAP_IPC_LOCK) should fail.
Fix all of these by changing the code to leave lock_limit at ULONG_MAX aka
RLIM_INFINITY, leave "allowed" initialized to 0 and remove the special case
of RLIM_INFINITY as nothing can be greater than ULONG_MAX.

Credit goes to Eric W. Biederman for proposing simplifying the code and
thus catching the later bug.

Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org
v1: https://lkml.kernel.org/r/20220310132417.41189-1-linmiaohe@huawei.com
v2: https://lkml.kernel.org/r/20220314064039.62972-1-linmiaohe@huawei.com
Link: https://lkml.kernel.org/r/20220322080918.59861-1-linmiaohe@huawei.com
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 mm/mlock.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 25934e7db3e1..37f969ec68fa 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -827,13 +827,12 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 
 	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
-	if (lock_limit == RLIM_INFINITY)
-		allowed = 1;
-	lock_limit >>= PAGE_SHIFT;
+	if (lock_limit != RLIM_INFINITY)
+		lock_limit >>= PAGE_SHIFT;
 	spin_lock(&shmlock_user_lock);
 	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 
-	if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
+	if ((memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
 	}
-- 
2.29.2

