Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049C52C741
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiERWz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiERWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:04 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693A82265E6;
        Wed, 18 May 2022 15:55:03 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55170)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZK-001T8Y-Fv; Wed, 18 May 2022 16:55:02 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZJ-002Z0O-E4; Wed, 18 May 2022 16:55:02 -0600
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
Date:   Wed, 18 May 2022 17:53:49 -0500
Message-Id: <20220518225355.784371-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZJ-002Z0O-E4;;;mid=<20220518225355.784371-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+msBsnMWwqD43ol0tBZ0Atn/7Xdy2Pjbs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 358 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (1.3%), b_tie_ro: 3.1 (0.9%), parse: 1.20
        (0.3%), extract_message_metadata: 11 (3.0%), get_uri_detail_list: 1.09
        (0.3%), tests_pri_-1000: 12 (3.3%), tests_pri_-950: 1.08 (0.3%),
        tests_pri_-900: 0.86 (0.2%), tests_pri_-90: 67 (18.8%), check_bayes:
        66 (18.4%), b_tokenize: 6 (1.8%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 1.98 (0.6%), b_tok_touch_all: 47 (13.1%), b_finish: 0.78
        (0.2%), tests_pri_0: 247 (68.9%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.6 (0.7%), poll_dns_idle: 1.27 (0.4%), tests_pri_10:
        2.8 (0.8%), tests_pri_500: 8 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/16] ptrace: In ptrace_signal look at what the debugger did with siginfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that siginfo is only modified by the tracer and that siginfo is
cleared with the signal is canceled have ptrace_signal directly examine
siginfo.

This makes the code a little simpler and handles the case when
the tracer exits without calling ptrace_detach.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ff4a52352390..3d955c23b13d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2556,9 +2556,10 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	signr = ptrace_stop(signr, CLD_TRAPPED, 0, info);
+	ptrace_stop(signr, CLD_TRAPPED, 0, info);
 
 	/* We're back.  Did the debugger cancel the sig?  */
+	signr = info->si_signo;
 	if (signr == 0)
 		return signr;
 
-- 
2.35.3

