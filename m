Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E9152C714
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiERW6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiERWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:35 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2922DA2A;
        Wed, 18 May 2022 15:55:14 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55520)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZV-003bfZ-Um; Wed, 18 May 2022 16:55:13 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZU-002Z0O-Ps; Wed, 18 May 2022 16:55:13 -0600
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
Date:   Wed, 18 May 2022 17:53:52 -0500
Message-Id: <20220518225355.784371-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZU-002Z0O-Ps;;;mid=<20220518225355.784371-13-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18zEH9NpD628NHFl0dZMZNqY3TpzcDYfhc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 481 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 14 (2.9%), b_tie_ro: 12 (2.5%), parse: 1.81
        (0.4%), extract_message_metadata: 19 (3.9%), get_uri_detail_list: 1.71
        (0.4%), tests_pri_-1000: 23 (4.8%), tests_pri_-950: 1.74 (0.4%),
        tests_pri_-900: 1.47 (0.3%), tests_pri_-90: 69 (14.3%), check_bayes:
        66 (13.8%), b_tokenize: 11 (2.4%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 39 (8.1%), b_finish: 1.09
        (0.2%), tests_pri_0: 337 (70.2%), check_dkim_signature: 0.86 (0.2%),
        check_dkim_adsp: 3.6 (0.7%), poll_dns_idle: 1.01 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 13/16] ptrace: Document why ptrace_setoptions does not need a lock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions that change ->ptrace are: ptrace_attach, ptrace_traceme,
ptrace_init_task, __ptrace_unlink, ptrace_setoptions.

Except for ptrace_setoptions all of the places where ->ptrace is
modified hold tasklist_lock for write, and either the tracee or the
tracer is modifies ->ptrace.

When ptrace_setoptions is called the tracee has been frozen with
ptrace_freeze_traced, and most be explicitly unfrozen by the tracer
before it can do anything.  As ptrace_setoption is run in the tracer
there can be no contention by the simple fact that the tracee can't
run.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d0527b6e2b29..fbadd2f21f09 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -689,7 +689,10 @@ static int ptrace_setoptions(struct task_struct *child, unsigned long data)
 	if (ret)
 		return ret;
 
-	/* Avoid intermediate state when all opts are cleared */
+	/*
+	 * With a frozen tracee, only the tracer modifies ->ptrace.
+	 * Avoid intermediate state when all opts are cleared.
+	 */
 	flags = child->ptrace;
 	flags &= ~(PTRACE_O_MASK << PT_OPT_FLAG_SHIFT);
 	flags |= (data << PT_OPT_FLAG_SHIFT);
-- 
2.35.3

