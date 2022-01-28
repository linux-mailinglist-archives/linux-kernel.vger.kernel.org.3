Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65E449FEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350448AbiA1RH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:07:57 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:46226 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350436AbiA1RHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:07:55 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:43554)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nDUj3-00GW3C-RL; Fri, 28 Jan 2022 10:07:53 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:52512 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nDUj2-00DYw5-PQ; Fri, 28 Jan 2022 10:07:53 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     <linux-kernel@vger.kernel.org>, Alexey Gladkov <legion@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Mathias Krause <minipli@grsecurity.net>
Date:   Fri, 28 Jan 2022 11:07:45 -0600
Message-ID: <871r0rss9q.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nDUj2-00DYw5-PQ;;;mid=<871r0rss9q.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX191V4gNPonv3DqUo0r49RovzeWWyGRlyz4=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4969]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 497 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 1.29
        (0.3%), extract_message_metadata: 21 (4.3%), get_uri_detail_list: 2.9
        (0.6%), tests_pri_-1000: 25 (5.0%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 96 (19.3%), check_bayes:
        89 (17.8%), b_tokenize: 7 (1.5%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 67 (13.5%), b_finish: 1.00
        (0.2%), tests_pri_0: 325 (65.4%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 1.06 (0.2%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ucount rlimit fixes for v5.17-rc2
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ucount-rlimit-fixes-for-v5.17-rc2 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17-rc2
  HEAD: f9d87929d451d3e649699d0f1d74f71f77ad38f5 ucount:  Make get_ucount a safe get_user replacement


From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Jan 2022 12:46:50 -0600
Subject: [PATCH] ucount:  Make get_ucount a safe get_user replacement

When the ucount code was refactored to create get_ucount it was missed
that some of the contexts in which a rlimit is kept elevated can be
the only reference to the user/ucount in the system.

Ordinary ucount references exist in places that also have a reference
to the user namspace, but in POSIX message queues, the SysV shm code,
and the SIGPENDING code there is no independent user namespace
reference.

Inspection of the the user_namespace show no instance of circular
references between struct ucounts and the user_namespace.  So
hold a reference from struct ucount to it's user_namespace to
resolve this problem.

Link: https://lore.kernel.org/lkml/YZV7Z+yXbsx9p3JN@fixkernel.com/
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Reported-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Reviewed-by: Mathias Krause <minipli@grsecurity.net>
Reviewed-by: Alexey Gladkov <legion@kernel.org>
Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
Fixes: 6e52a9f0532f ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
Cc: stable@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 7b32c356ebc5..65b597431c86 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -190,6 +190,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 			kfree(new);
 		} else {
 			hlist_add_head(&new->node, hashent);
+			get_user_ns(new->ns);
 			spin_unlock_irq(&ucounts_lock);
 			return new;
 		}
@@ -210,6 +211,7 @@ void put_ucounts(struct ucounts *ucounts)
 	if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
 		hlist_del_init(&ucounts->node);
 		spin_unlock_irqrestore(&ucounts_lock, flags);
+		put_user_ns(ucounts->ns);
 		kfree(ucounts);
 	}
 }
-- 
2.29.2

Eric
