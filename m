Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4184F4D8CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiCNTs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244469AbiCNTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD5D73E5E7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647287239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mETI+QLK6ZhxRbTKxuVCGJOhAl1j7UwP6UTDjwDl6o=;
        b=Ou+erTEN1WB+oktNV6WYPYTGQEbZc6eelV1padouHnr/2vF0CSo4URhjByEKumCusrWPId
        mgOGuZvp7Nkm48v6g1eFU+Hpl4ckiaoDvDayvckjcd0B14t5+feRBewNODJ49PsSrxBCx1
        TcGhAZ3pfO925rJIZ4N+C35Bg0OTNnI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-2pCTlSTPPnmRiIwsCSSdKA-1; Mon, 14 Mar 2022 15:47:09 -0400
X-MC-Unique: 2pCTlSTPPnmRiIwsCSSdKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EC0A1C0514F;
        Mon, 14 Mar 2022 19:47:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B0FD40C128B;
        Mon, 14 Mar 2022 19:47:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>,
        Jirka Hladky <jhladky@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] x86/tsc: Reduce external interference on max_warp detection
Date:   Mon, 14 Mar 2022 15:46:29 -0400
Message-Id: <20220314194630.1726542-2-longman@redhat.com>
In-Reply-To: <20220314194630.1726542-1-longman@redhat.com>
References: <20220314194630.1726542-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSC max_warp detection code in check_tsc_warp() is very timing
sensitive. Due to the possibility of false cacheline sharing,
activities done in other CPUs may have an impact on the max_warp
detection process. Put the max_wrap
detection data variables on their own cacheline to reduce that kind
of external interference.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/tsc_sync.c | 57 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 9452dc9664b5..70aeb254b62b 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -253,12 +253,15 @@ static atomic_t test_runs;
  * we want to have the fastest, inlined, non-debug version
  * of a critical section, to be able to prove TSC time-warps:
  */
-static arch_spinlock_t sync_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-
-static cycles_t last_tsc;
-static cycles_t max_warp;
-static int nr_warps;
-static int random_warps;
+static struct {
+	arch_spinlock_t lock;
+	int nr_warps;
+	int random_warps;
+	cycles_t last_tsc;
+	cycles_t max_warp;
+} sync ____cacheline_aligned_in_smp = {
+	.lock = __ARCH_SPIN_LOCK_UNLOCKED,
+};
 
 /*
  * TSC-warp measurement loop running on both CPUs.  This is not called
@@ -281,11 +284,11 @@ static cycles_t check_tsc_warp(unsigned int timeout)
 		 * previous TSC that was measured (possibly on
 		 * another CPU) and update the previous TSC timestamp.
 		 */
-		arch_spin_lock(&sync_lock);
-		prev = last_tsc;
+		arch_spin_lock(&sync.lock);
+		prev = sync.last_tsc;
 		now = rdtsc_ordered();
-		last_tsc = now;
-		arch_spin_unlock(&sync_lock);
+		sync.last_tsc = now;
+		arch_spin_unlock(&sync.lock);
 
 		/*
 		 * Be nice every now and then (and also check whether
@@ -304,18 +307,18 @@ static cycles_t check_tsc_warp(unsigned int timeout)
 		 * we saw a time-warp of the TSC going backwards:
 		 */
 		if (unlikely(prev > now)) {
-			arch_spin_lock(&sync_lock);
-			max_warp = max(max_warp, prev - now);
-			cur_max_warp = max_warp;
+			arch_spin_lock(&sync.lock);
+			sync.max_warp = max(sync.max_warp, prev - now);
+			cur_max_warp = sync.max_warp;
 			/*
 			 * Check whether this bounces back and forth. Only
 			 * one CPU should observe time going backwards.
 			 */
-			if (cur_warps != nr_warps)
-				random_warps++;
-			nr_warps++;
-			cur_warps = nr_warps;
-			arch_spin_unlock(&sync_lock);
+			if (cur_warps != sync.nr_warps)
+				sync.random_warps++;
+			sync.nr_warps++;
+			cur_warps = sync.nr_warps;
+			arch_spin_unlock(&sync.lock);
 		}
 	}
 	WARN(!(now-start),
@@ -394,21 +397,21 @@ void check_tsc_sync_source(int cpu)
 	 * stop. If not, decrement the number of runs an check if we can
 	 * retry. In case of random warps no retry is attempted.
 	 */
-	if (!nr_warps) {
+	if (!sync.nr_warps) {
 		atomic_set(&test_runs, 0);
 
 		pr_debug("TSC synchronization [CPU#%d -> CPU#%d]: passed\n",
 			smp_processor_id(), cpu);
 
-	} else if (atomic_dec_and_test(&test_runs) || random_warps) {
+	} else if (atomic_dec_and_test(&test_runs) || sync.random_warps) {
 		/* Force it to 0 if random warps brought us here */
 		atomic_set(&test_runs, 0);
 
 		pr_warn("TSC synchronization [CPU#%d -> CPU#%d]:\n",
 			smp_processor_id(), cpu);
 		pr_warn("Measured %Ld cycles TSC warp between CPUs, "
-			"turning off TSC clock.\n", max_warp);
-		if (random_warps)
+			"turning off TSC clock.\n", sync.max_warp);
+		if (sync.random_warps)
 			pr_warn("TSC warped randomly between CPUs\n");
 		mark_tsc_unstable("check_tsc_sync_source failed");
 	}
@@ -417,10 +420,10 @@ void check_tsc_sync_source(int cpu)
 	 * Reset it - just in case we boot another CPU later:
 	 */
 	atomic_set(&start_count, 0);
-	random_warps = 0;
-	nr_warps = 0;
-	max_warp = 0;
-	last_tsc = 0;
+	sync.random_warps = 0;
+	sync.nr_warps = 0;
+	sync.max_warp = 0;
+	sync.last_tsc = 0;
 
 	/*
 	 * Let the target continue with the bootup:
@@ -476,7 +479,7 @@ void check_tsc_sync_target(void)
 	/*
 	 * Store the maximum observed warp value for a potential retry:
 	 */
-	gbl_max_warp = max_warp;
+	gbl_max_warp = sync.max_warp;
 
 	/*
 	 * Ok, we are done:
-- 
2.27.0

