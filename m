Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC552C6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiERWyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiERWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:54:36 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7986224A5E;
        Wed, 18 May 2022 15:54:35 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54682)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYr-001T3j-Ut; Wed, 18 May 2022 16:54:33 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYp-002Z0O-Ef; Wed, 18 May 2022 16:54:33 -0600
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
Date:   Wed, 18 May 2022 17:53:42 -0500
Message-Id: <20220518225355.784371-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSYp-002Z0O-Ef;;;mid=<20220518225355.784371-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Nwc5NJ6zP1i47DbDDS+c6gRtGHkZGyR8=
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
X-Spam-Timing: total 1894 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (0.6%), b_tie_ro: 10 (0.6%), parse: 1.17
        (0.1%), extract_message_metadata: 24 (1.3%), get_uri_detail_list: 1.39
        (0.1%), tests_pri_-1000: 45 (2.4%), tests_pri_-950: 1.38 (0.1%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 98 (5.2%), check_bayes: 96
        (5.1%), b_tokenize: 10 (0.5%), b_tok_get_all: 8 (0.4%), b_comp_prob:
        3.0 (0.2%), b_tok_touch_all: 71 (3.8%), b_finish: 1.01 (0.1%),
        tests_pri_0: 295 (15.6%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 6 (0.3%), poll_dns_idle: 1393 (73.6%), tests_pri_10:
        2.2 (0.1%), tests_pri_500: 1410 (74.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/16] kdb: Use real_parent when displaying a list of processes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb has a bug that when using the ps command to display a list of
processes, if a process is being debugged the debugger as the parent
process.

This is silly, and I expect it never comes up in ptractice.  As there
is very little point in using gdb and kdb simultaneously.  Update the
code to use real_parent so that it is clear kdb does not want to
display a debugger as the parent of a process.

Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)"
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 0852a537dad4..db49f1026eaa 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2306,7 +2306,7 @@ void kdb_ps1(const struct task_struct *p)
 
 	cpu = kdb_process_cpu(p);
 	kdb_printf("0x%px %8d %8d  %d %4d   %c  0x%px %c%s\n",
-		   (void *)p, p->pid, p->parent->pid,
+		   (void *)p, p->pid, p->real_parent->pid,
 		   kdb_task_has_cpu(p), kdb_process_cpu(p),
 		   kdb_task_state_char(p),
 		   (void *)(&p->thread),
-- 
2.35.3

