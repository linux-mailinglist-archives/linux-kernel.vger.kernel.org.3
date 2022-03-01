Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593054C9462
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiCATfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiCATf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:35:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65054FA2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:34:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0EC61602
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475EBC340EF;
        Tue,  1 Mar 2022 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646163286;
        bh=9B9eVbUKHgHFZe2GUw1uyhd2gTOzh/us5AsO2bpkbmw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ryZKcO5jrHX4eKN2DigtbbPXj3xKaSHVeLuNNQy9v9QAYAbm+yEm0QKZ/zHueSF5L
         iA63c20TsgCinFb+dZk1Gksc6Ea5OT4uMR7nWzo8VmrWnWduYXQIAJhzluZSJAyCHl
         KDHQl1NaRM+22bygQFS0BZwbIYnJkFjCCpbyCChBe7v4tVDDlpAxXJyNUN8aF4gfKz
         YpxqKUKt6EHmOFUwfy+UicM2ARUfs3ad6J4i8G23TtZysvdvYNYuMirpPM/LOIjwMr
         EPrRGdBJCUpWnpTWP1bo0BNrHO6ZTKabpwV7jwfduJjAKB11mdConWYC+u5vWrPw5z
         R/q5ZpD6KuTHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D928C5C0440; Tue,  1 Mar 2022 11:34:45 -0800 (PST)
Date:   Tue, 1 Mar 2022 11:34:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, jgross@suse.com, riel@surriel.com,
        urezki@gmail.com
Subject: [PATCH RFC smp] Provide boot-time timeout for CSD lock diagnostics
Message-ID: <20220301193445.GA4074635@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2ac18d36805cf..6e38727af2552 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5333,6 +5333,17 @@
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
index 01a7c1706a58b..d82439bac4016 100644
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
