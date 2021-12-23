Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406A447E894
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbhLWT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:59:59 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50748 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbhLWT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:59:58 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:47638)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0UFp-009TeO-MD; Thu, 23 Dec 2021 12:59:57 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:58712 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0UFo-008ZE1-HM; Thu, 23 Dec 2021 12:59:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <legion@kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 23 Dec 2021 13:59:49 -0600
Message-ID: <87o857t7m2.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n0UFo-008ZE1-HM;;;mid=<87o857t7m2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+aAthlIBm9kU5qZSimccXbh7/1NOk6y0A=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 528 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.00
        (0.2%), extract_message_metadata: 18 (3.4%), get_uri_detail_list: 3.6
        (0.7%), tests_pri_-1000: 35 (6.6%), tests_pri_-950: 1.64 (0.3%),
        tests_pri_-900: 1.31 (0.2%), tests_pri_-90: 72 (13.7%), check_bayes:
        71 (13.4%), b_tokenize: 12 (2.2%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 44 (8.3%), b_finish: 1.12
        (0.2%), tests_pri_0: 368 (69.7%), check_dkim_signature: 0.82 (0.2%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.10 (0.2%), tests_pri_10:
        3.0 (0.6%), tests_pri_500: 13 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucount fix for v5.16-rc7
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ucount-rlimit-fixes-for-v5.16 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.16

  HEAD: 59ec71575ab440cd5ca0aa53b2a2985b3639fad4 ucounts: Fix rlimit max values check

This fixes a silly logic bug in the ucount rlimits code, where it was
comparing against the wrong limit.  As the fix is quite small it is
included in it's entirety below.

Resent because I left off the subject line last time.

Eric

From 59ec71575ab440cd5ca0aa53b2a2985b3639fad4 Mon Sep 17 00:00:00 2001
From: Alexey Gladkov <legion@kernel.org>
Date: Mon, 29 Nov 2021 21:37:25 +0100
Subject: [PATCH] ucounts: Fix rlimit max values check

The semantics of the rlimit max values differs from ucounts itself. When
creating a new userns, we store the current rlimit of the process in
ucount_max. Thus, the value of the limit in the parent userns is saved
in the created one.

The problem is that now we are taking the maximum value for counter from
the same userns. So for init_user_ns it will always be RLIM_INFINITY.

To fix the problem we need to check the counter value with the max value
stored in userns.

Reproducer:

su - test -c "ulimit -u 3; sleep 5 & sleep 6 & unshare -U --map-root-user sh -c 'sleep 7 & sleep 8 & date; wait'"

Before:

[1] 175
[2] 176
Fri Nov 26 13:48:20 UTC 2021
[1]-  Done                    sleep 5
[2]+  Done                    sleep 6

After:

[1] 167
[2] 168
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: retry: Resource temporarily unavailable
sh: fork: Interrupted system call
[1]-  Done                    sleep 5
[2]+  Done                    sleep 6

Fixes: c54b245d0118 ("Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
Reported-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
Link: https://lkml.kernel.org/r/024ec805f6e16896f0b23e094773790d171d2c1c.1638218242.git.legion@kernel.org
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/ucount.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4f5613dac227..7b32c356ebc5 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -264,15 +264,16 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 {
 	struct ucounts *iter;
+	long max = LONG_MAX;
 	long ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long max = READ_ONCE(iter->ns->ucount_max[type]);
 		long new = atomic_long_add_return(v, &iter->ucount[type]);
 		if (new < 0 || new > max)
 			ret = LONG_MAX;
 		else if (iter == ucounts)
 			ret = new;
+		max = READ_ONCE(iter->ns->ucount_max[type]);
 	}
 	return ret;
 }
@@ -312,15 +313,16 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 {
 	/* Caller must hold a reference to ucounts */
 	struct ucounts *iter;
+	long max = LONG_MAX;
 	long dec, ret = 0;
 
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		long max = READ_ONCE(iter->ns->ucount_max[type]);
 		long new = atomic_long_add_return(1, &iter->ucount[type]);
 		if (new < 0 || new > max)
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
+		max = READ_ONCE(iter->ns->ucount_max[type]);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
@@ -339,15 +341,16 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	return 0;
 }
 
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max)
+bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long rlimit)
 {
 	struct ucounts *iter;
-	if (get_ucounts_value(ucounts, type) > max)
-		return true;
+	long max = rlimit;
+	if (rlimit > LONG_MAX)
+		max = LONG_MAX;
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		max = READ_ONCE(iter->ns->ucount_max[type]);
 		if (get_ucounts_value(iter, type) > max)
 			return true;
+		max = READ_ONCE(iter->ns->ucount_max[type]);
 	}
 	return false;
 }
-- 
2.29.2

