Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0D52C6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiERWzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiERWzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:00 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F68B2265DF;
        Wed, 18 May 2022 15:54:59 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33018)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZG-00CkZV-Mj; Wed, 18 May 2022 16:54:58 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZF-002Z0O-HE; Wed, 18 May 2022 16:54:58 -0600
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
Date:   Wed, 18 May 2022 17:53:48 -0500
Message-Id: <20220518225355.784371-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZF-002Z0O-HE;;;mid=<20220518225355.784371-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19tbqiOJHWnZVuKgNQ7Jp3oXCI1nNuPXUo=
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
X-Spam-Timing: total 362 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.3%), b_tie_ro: 10 (2.9%), parse: 1.08
        (0.3%), extract_message_metadata: 12 (3.3%), get_uri_detail_list: 1.12
        (0.3%), tests_pri_-1000: 15 (4.3%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 1.06 (0.3%), tests_pri_-90: 80 (22.0%), check_bayes:
        78 (21.5%), b_tokenize: 8 (2.3%), b_tok_get_all: 8 (2.3%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 55 (15.3%), b_finish: 0.98
        (0.3%), tests_pri_0: 227 (62.7%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 4.3 (1.2%), poll_dns_idle: 2.6 (0.7%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 09/16] ptrace: In ptrace_setsiginfo deal with invalid si_signo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tracer calls PTRACE_SETSIGINFO it only has an effect if the
tracee is stopped in ptrace_signal.

When one of PTRACE_DETACH, PTRACE_SINGLESTEP, PTRACE_SINGLEBLOCK,
PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP, PTRACE_SYSCALL, or
PTRACE_CONT pass in a signel number to continue with the kernel
validates that signal number and the ptrace_signal verifies the signal
number matches the si_signo, before the siginfo is used.

As the signal number to continue with is verified to be a valid signal
number the signal number in si_signo must be a valid signal number.

Make this obvious and avoid needing checks later by immediately
clearing siginfo if si_signo is not valid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a24eed725cec..a0a07d140751 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -716,7 +716,9 @@ static int ptrace_setsiginfo(struct task_struct *child, const kernel_siginfo_t *
 	if (unlikely(!child->last_siginfo))
 		return -EINVAL;
 
-	copy_siginfo(child->last_siginfo, info);
+	clear_siginfo(child->last_siginfo);
+	if (valid_signal(info->si_signo))
+		copy_siginfo(child->last_siginfo, info);
 	return 0;
 }
 
-- 
2.35.3

