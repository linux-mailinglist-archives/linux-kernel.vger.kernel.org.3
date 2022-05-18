Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD94352C6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiERWyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiERWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:54:36 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD232265D0;
        Wed, 18 May 2022 15:54:35 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60712)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYj-00CkVI-6u; Wed, 18 May 2022 16:54:25 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYf-002Z0O-Er; Wed, 18 May 2022 16:54:24 -0600
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org
Date:   Wed, 18 May 2022 17:53:40 -0500
Message-Id: <20220518225355.784371-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSYf-002Z0O-Er;;;mid=<20220518225355.784371-1-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+VdHu+AQ1uu8lMLBODEbaBhkaz/j3E23I=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 3085 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.4%), b_tie_ro: 9 (0.3%), parse: 1.24 (0.0%),
         extract_message_metadata: 19 (0.6%), get_uri_detail_list: 1.63 (0.1%),
         tests_pri_-1000: 22 (0.7%), tests_pri_-950: 1.20 (0.0%),
        tests_pri_-900: 1.05 (0.0%), tests_pri_-90: 83 (2.7%), check_bayes: 82
        (2.7%), b_tokenize: 9 (0.3%), b_tok_get_all: 9 (0.3%), b_comp_prob:
        2.2 (0.1%), b_tok_touch_all: 58 (1.9%), b_finish: 0.86 (0.0%),
        tests_pri_0: 211 (6.8%), check_dkim_signature: 0.49 (0.0%),
        check_dkim_adsp: 3.1 (0.1%), poll_dns_idle: 2720 (88.2%),
        tests_pri_10: 1.99 (0.1%), tests_pri_500: 2730 (88.5%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH 01/16] signal/alpha: Remove unused definition of TASK_REAL_PARENT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than update this defition when I move tsk->real_parent into
signal_struct remove it now.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/asm-offsets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index 2e125e5c1508..0fca99dc5757 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -21,7 +21,6 @@ void foo(void)
 
         DEFINE(TASK_BLOCKED, offsetof(struct task_struct, blocked));
         DEFINE(TASK_CRED, offsetof(struct task_struct, cred));
-        DEFINE(TASK_REAL_PARENT, offsetof(struct task_struct, real_parent));
         DEFINE(TASK_GROUP_LEADER, offsetof(struct task_struct, group_leader));
         DEFINE(TASK_TGID, offsetof(struct task_struct, tgid));
         BLANK();
-- 
2.35.3

