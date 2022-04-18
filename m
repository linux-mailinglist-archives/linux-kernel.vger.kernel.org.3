Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A456505FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiDRW5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C0F2CE2C;
        Mon, 18 Apr 2022 15:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A5F8B81136;
        Mon, 18 Apr 2022 22:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42828C385A1;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=tPyCRwdFs1UacCDWo6gPWFP2J8tgNjkdVtTI/kMjO/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcUbXgjE7VF1cqmzO0nZknf3hCOB6m2pLrkKrPBeLeT9duKCb0DbzbydFSa50sG0k
         hcRX7uV/VAEGuvQEbnPMYNOHsXJCGFJCmzNXAl+2EWzwzQ54ak8oC8qeQCpinYhuAs
         CqtBVAiJGo8D2iuyaWcHhM4USdLCm898Bq+B2NFawfme1LKeRZQKO+IQodD93TI4vR
         v5VbPp/rAodcE/QRsmIGNmkOYd7xequfoHJKHDylT4mOfQBdsqmhh6t3ICVkAlYxJB
         rjgwNxfhHMDWRwSYlruRV7piO/azxnadspi1KG+660ywzzP9uLiZmM1VuOot1pvtlW
         ugsjYlo/5TWUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E554E5C0A0D; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD lock diagnostics
Date:   Mon, 18 Apr 2022 15:53:52 -0700
Message-Id: <20220418225359.3945217-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging of problems involving insanely long-running SMI handlers
proceeds better if the CSD-lock timeout can be adjusted.  This commit
therefore provides a new smp.csd_lock_timeout kernel boot parameter
that specifies the timeout in milliseconds.  The default remains at the
previously hard-coded value of five seconds.

Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 kernel/smp.c                                    |  7 +++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..645c4c001b16 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5377,6 +5377,17 @@
 	smart2=		[HW]
 			Format: <io1>[,<io2>[,...,<io8>]]
 
+	smp.csd_lock_timeout= [KNL]
+			Specify the period of time in milliseconds
+			that smp_call_function() and friends will wait
+			for a CPU to release the CSD lock.  This is
+			useful when diagnosing bugs involving CPUs
+			disabling interrupts for extended periods
+			of time.  Defaults to 5,000 milliseconds, and
+			setting a value of zero disables this feature.
+			This feature may be more efficiently disabled
+			using the csdlock_debug- kernel parameter.
+
 	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
 	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
 	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
diff --git a/kernel/smp.c b/kernel/smp.c
index 01a7c1706a58..d82439bac401 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -183,7 +183,9 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
 static DEFINE_PER_CPU(struct cfd_seq_local, cfd_seq_local);
 
-#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
+static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
+module_param(csd_lock_timeout, ulong, 0444);
+
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
 static u64 cfd_seq;
 
@@ -329,6 +331,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 	u64 ts2, ts_delta;
 	call_single_data_t *cpu_cur_csd;
 	unsigned int flags = READ_ONCE(csd->node.u_flags);
+	unsigned long long csd_lock_timeout_ns = csd_lock_timeout * NSEC_PER_MSEC;
 
 	if (!(flags & CSD_FLAG_LOCK)) {
 		if (!unlikely(*bug_id))
@@ -341,7 +344,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 
 	ts2 = sched_clock();
 	ts_delta = ts2 - *ts1;
-	if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
+	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns <= 0))
 		return false;
 
 	firsttime = !*bug_id;
-- 
2.31.1.189.g2e36527f23

