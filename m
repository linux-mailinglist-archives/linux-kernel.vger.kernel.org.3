Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0793E52C6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiERWzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiERWyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:54:44 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11E42265DA;
        Wed, 18 May 2022 15:54:43 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54926)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYx-003baE-OK; Wed, 18 May 2022 16:54:39 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYu-002Z0O-LI; Wed, 18 May 2022 16:54:38 -0600
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
Date:   Wed, 18 May 2022 17:53:43 -0500
Message-Id: <20220518225355.784371-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSYu-002Z0O-LI;;;mid=<20220518225355.784371-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/XPnwfZQEHyZ9WrXatAJldgaE0eiN7zxc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 2130 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.5%), b_tie_ro: 10 (0.5%), parse: 1.13
        (0.1%), extract_message_metadata: 26 (1.2%), get_uri_detail_list: 1.81
        (0.1%), tests_pri_-1000: 21 (1.0%), tests_pri_-950: 1.26 (0.1%),
        tests_pri_-900: 1.05 (0.0%), tests_pri_-90: 235 (11.0%), check_bayes:
        204 (9.6%), b_tokenize: 22 (1.0%), b_tok_get_all: 12 (0.5%),
        b_comp_prob: 7 (0.3%), b_tok_touch_all: 157 (7.4%), b_finish: 3.3
        (0.2%), tests_pri_0: 300 (14.1%), check_dkim_signature: 1.16 (0.1%),
        check_dkim_adsp: 8 (0.4%), poll_dns_idle: 1487 (69.8%), tests_pri_10:
        3.5 (0.2%), tests_pri_500: 1526 (71.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 04/16] powerpc/xmon:  Use real_parent when displaying a list of processes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xmon has a bug (copied from kdb) that when showing a list of processes
the debugger is listed as the parent, if a processes is being debugged.

This is silly, and I expect it is rare enough no has noticed in
practice.  Update the code to use real_parent so that it is clear xmon
does not want to display a debugger as the parent of a process.

Cc: Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Fixes: 6dfb54049f9a ("powerpc/xmon: Add xmon command to dump process/task similar to ps(1)")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index fd72753e8ad5..b308ef9ce604 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3282,7 +3282,7 @@ static void show_task(struct task_struct *volatile tsk)
 
 	printf("%16px %16lx %16px %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp, tsk->thread.regs,
-		tsk->pid, rcu_dereference(tsk->parent)->pid,
+		tsk->pid, rcu_dereference(tsk->real_parent)->pid,
 		state, task_cpu(tsk),
 		tsk->comm);
 }
-- 
2.35.3

