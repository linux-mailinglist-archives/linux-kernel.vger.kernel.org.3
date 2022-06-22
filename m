Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846F455517F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376623AbiFVQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376724AbiFVQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:46:05 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABBE40906
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:45:31 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:51690)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43Tu-004y2t-75; Wed, 22 Jun 2022 10:45:30 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57370 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o43Tq-001XnL-UP; Wed, 22 Jun 2022 10:45:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Robert O'Callahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Keno Fischer <keno@juliacomputing.com>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org>
Date:   Wed, 22 Jun 2022 11:45:20 -0500
In-Reply-To: <87r13gd4xy.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 22 Jun 2022 11:43:37 -0500")
Message-ID: <87letod4v3.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o43Tq-001XnL-UP;;;mid=<87letod4v3.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19c3wZsaos70YdODfLJcA9aZoPCblOi9kQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=2 Fuz1=2 Fuz2=2 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2538 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (0.4%), b_tie_ro: 9 (0.3%), parse: 0.81 (0.0%),
         extract_message_metadata: 11 (0.4%), get_uri_detail_list: 0.85 (0.0%),
         tests_pri_-1000: 14 (0.5%), tests_pri_-950: 1.23 (0.0%),
        tests_pri_-900: 0.97 (0.0%), tests_pri_-90: 48 (1.9%), check_bayes: 46
        (1.8%), b_tokenize: 5 (0.2%), b_tok_get_all: 5 (0.2%), b_comp_prob:
        1.80 (0.1%), b_tok_touch_all: 31 (1.2%), b_finish: 0.78 (0.0%),
        tests_pri_0: 2441 (96.2%), check_dkim_signature: 0.49 (0.0%),
        check_dkim_adsp: 2.8 (0.1%), poll_dns_idle: 0.99 (0.0%), tests_pri_10:
        2.2 (0.1%), tests_pri_500: 7 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/3] signal: Ensure SIGNAL_GROUP_EXIT gets set in do_group_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The function do_group_exit has an optimization that avoids taking
siglock and doing the work to find other threads in the signal group
and shutting them down.

It is very desirable for SIGNAL_GROUP_EXIT to always been set whenever
it is decided for the process to exit.  That ensures only a single
place needs to be tested, and a single bit of state needs to be looked
at.  This makes the optimization in do_group_exit counter productive.

Make the code and maintenance simpler by removing this unnecessary
option.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f072959fcab7..96e4b12edea8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -905,7 +905,7 @@ do_group_exit(int exit_code)
 		exit_code = sig->group_exit_code;
 	else if (sig->group_exec_task)
 		exit_code = 0;
-	else if (!thread_group_empty(current)) {
+	else {
 		struct sighand_struct *const sighand = current->sighand;
 
 		spin_lock_irq(&sighand->siglock);
-- 
2.35.3

