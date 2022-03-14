Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00444D8CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbiCNTsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbiCNTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CE2F3DA79
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647287232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74lQ53agjdb+drBg2ZrVPEZ4Mhaf7waMbyBjjplBVKg=;
        b=bWHqTz5KLatfxVfAphRtdymnvyGQq6NR4a1m2O8QNuoN+jhDpvpkFSpvmsdw1/KBOhb73q
        1lQwTpQ92Q2Xbvk/MgOTHaMGcQMWmmTWKIeiG7Ripfcvx84CJYbIVYXNzcJ4cANk93uwfY
        UwNeNtNSfD4sLyDPrNPc31dQp1kswHw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-pGt2JrTsNNmuGNLVzlgqPQ-1; Mon, 14 Mar 2022 15:47:11 -0400
X-MC-Unique: pGt2JrTsNNmuGNLVzlgqPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80EA52999B35;
        Mon, 14 Mar 2022 19:47:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BD9C400F3EF;
        Mon, 14 Mar 2022 19:47:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>,
        Jirka Hladky <jhladky@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] x86/tsc_sync: Add synchronization overhead to tsc adjustment
Date:   Mon, 14 Mar 2022 15:46:30 -0400
Message-Id: <20220314194630.1726542-3-longman@redhat.com>
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

As stated in the comment of check_tsc_sync_target():

  The adjustment value is slightly off by the overhead of the
  sync mechanism (observed values are ~200 TSC cycles), but this
  really depends on CPU, node distance and frequency. So
  compensating for this is hard to get right.

That overhead, however, can cause the tsc adjustment to fail after 3
test runs as can be seen when booting up a hot 4-socket Intel CooperLake
system:

[    0.034090] TSC deadline timer available
[    0.008807] TSC ADJUST compensate: CPU36 observed 95626 warp. Adjust: 95626
[    0.008807] TSC ADJUST compensate: CPU36 observed 74 warp. Adjust: 95700
[    0.974281] TSC synchronization [CPU#0 -> CPU#36]:
[    0.974281] Measured 4 cycles TSC warp between CPUs, turning off TSC clock.
[    0.974281] tsc: Marking TSC unstable due to check_tsc_sync_source failed

To prevent this tsc adjustment failure, we need to estimate the sync
overhead which will be at least an unlock operation in one cpu followed
by a lock operation in another cpu.

The measurement is done in check_tsc_sync_target() after stop_count
reached 2 which is set by the source cpu after it re-initializes the sync
variables causing the lock cacheline to be remote from the target cpu.
The subsequent time measurement will then be similar to latency between
successive 2-cpu sync loop in check_tsc_warp().

Interrupt should not yet been enabled when check_tsc_sync_target() is
called. However some interference may have caused the overhead estimation
to vary a bit.  With this patch applied, the measured overhead on the
same CooperLake system on different reboot runs varies from 104 to 326.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/tsc_sync.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 70aeb254b62b..e2c43ba4e7b8 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -445,6 +445,7 @@ void check_tsc_sync_target(void)
 	struct tsc_adjust *cur = this_cpu_ptr(&tsc_adjust);
 	unsigned int cpu = smp_processor_id();
 	cycles_t cur_max_warp, gbl_max_warp;
+	cycles_t start, sync_overhead;
 	int cpus = 2;
 
 	/* Also aborts if there is no TSC. */
@@ -505,29 +506,37 @@ void check_tsc_sync_target(void)
 	if (!atomic_read(&test_runs))
 		return;
 
+	/*
+	 * Estimate the synchronization overhead by measuring the time for
+	 * a lock/unlock operation.
+	 */
+	start = rdtsc_ordered();
+	arch_spin_lock(&sync.lock);
+	arch_spin_unlock(&sync.lock);
+	sync_overhead = rdtsc_ordered() - start;
+
 	/*
 	 * If the warp value of this CPU is 0, then the other CPU
 	 * observed time going backwards so this TSC was ahead and
 	 * needs to move backwards.
 	 */
-	if (!cur_max_warp)
+	if (!cur_max_warp) {
 		cur_max_warp = -gbl_max_warp;
+		sync_overhead = -sync_overhead;
+	}
 
 	/*
 	 * Add the result to the previous adjustment value.
 	 *
 	 * The adjustment value is slightly off by the overhead of the
 	 * sync mechanism (observed values are ~200 TSC cycles), but this
-	 * really depends on CPU, node distance and frequency. So
-	 * compensating for this is hard to get right. Experiments show
-	 * that the warp is not longer detectable when the observed warp
-	 * value is used. In the worst case the adjustment needs to go
-	 * through a 3rd run for fine tuning.
+	 * really depends on CPU, node distance and frequency. Add the
+	 * estimated sync overhead to the adjustment value.
 	 */
-	cur->adjusted += cur_max_warp;
+	cur->adjusted += cur_max_warp + sync_overhead;
 
-	pr_warn("TSC ADJUST compensate: CPU%u observed %lld warp. Adjust: %lld\n",
-		cpu, cur_max_warp, cur->adjusted);
+	pr_warn("TSC ADJUST compensate: CPU%u observed %lld warp (overhead %lld). Adjust: %lld\n",
+		cpu, cur_max_warp, sync_overhead, cur->adjusted);
 
 	wrmsrl(MSR_IA32_TSC_ADJUST, cur->adjusted);
 	goto retry;
-- 
2.27.0

