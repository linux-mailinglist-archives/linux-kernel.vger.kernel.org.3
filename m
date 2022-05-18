Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E778852C6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiERWzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiERWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:54:46 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C52265E4;
        Wed, 18 May 2022 15:54:44 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54828)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZ1-001T58-Fx; Wed, 18 May 2022 16:54:43 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZ0-002Z0O-DQ; Wed, 18 May 2022 16:54:43 -0600
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
Date:   Wed, 18 May 2022 17:53:44 -0500
Message-Id: <20220518225355.784371-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZ0-002Z0O-DQ;;;mid=<20220518225355.784371-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19bmUj59Un5KGL2qB5b8KKLljIsiq43aWI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 409 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.3%), parse: 0.95 (0.2%),
         extract_message_metadata: 14 (3.4%), get_uri_detail_list: 1.15 (0.3%),
         tests_pri_-1000: 18 (4.3%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.31 (0.3%), tests_pri_-90: 69 (16.7%), check_bayes:
        66 (16.2%), b_tokenize: 11 (2.6%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.7 (0.6%), b_tok_touch_all: 41 (10.1%), b_finish: 1.05
        (0.3%), tests_pri_0: 282 (68.8%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 3.6 (0.9%), poll_dns_idle: 0.99 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 05/16] ptrace: Remove dead code from __ptrace_detach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since commit 28d838cc4dfe ("Fix ptrace self-attach rule") it has
been impossible to attach another thread in the same thread group.

Remove the code from __ptrace_detach that was trying to support
detaching from a thread in the same thread group.  The code is
dead and I can not make sense of what it is trying to do.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 328a34a99124..ca0e47691229 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -526,19 +526,6 @@ static int ptrace_traceme(void)
 	return ret;
 }
 
-/*
- * Called with irqs disabled, returns true if childs should reap themselves.
- */
-static int ignoring_children(struct sighand_struct *sigh)
-{
-	int ret;
-	spin_lock(&sigh->siglock);
-	ret = (sigh->action[SIGCHLD-1].sa.sa_handler == SIG_IGN) ||
-	      (sigh->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT);
-	spin_unlock(&sigh->siglock);
-	return ret;
-}
-
 /*
  * Called with tasklist_lock held for writing.
  * Unlink a traced task, and clean it up if it was a traced zombie.
@@ -565,14 +552,9 @@ static bool __ptrace_detach(struct task_struct *tracer, struct task_struct *p)
 
 	dead = !thread_group_leader(p);
 
-	if (!dead && thread_group_empty(p)) {
-		if (!same_thread_group(p->real_parent, tracer))
-			dead = do_notify_parent(p, p->exit_signal);
-		else if (ignoring_children(tracer->sighand)) {
-			__wake_up_parent(p, tracer);
-			dead = true;
-		}
-	}
+	if (!dead && thread_group_empty(p))
+		dead = do_notify_parent(p, p->exit_signal);
+
 	/* Mark it as in the process of being reaped. */
 	if (dead)
 		p->exit_state = EXIT_DEAD;
-- 
2.35.3

