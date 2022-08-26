Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2165A31F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbiHZWSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbiHZWR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:17:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35DE86AE;
        Fri, 26 Aug 2022 15:16:17 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=091286oT7yO5rbA4NBQR+RxD2XWprHIJeu9TMM/3rW4=;
        b=jBwIp7cR1UchZ6L9lZP6KcxZbPdoxdtIj+t2QkFPk5tx7wO7TTVUcQfvO3t8XaLr2LqJzM
        b16dCQwfgsUQNV0dJExTFCbQvYpEdyx9OhcbRRG0PLQupsRDqbuw4lPnIMDjOKhnILrVLy
        MxWY9AZWobrrpjM8A5kYCHrSnWWVw1jRog4+zvX4HyMsYxkx2QWn22Q+XYbeHJxDHoz9ST
        MdSgSRHdATxdkl17iG1rI1D8bgx7+2kzH8ewZ+s07M5vAYdTuOBBkmYi1WlU7iClwNauqU
        4UuafdCSuYtxiPJzfrzElqPrWqM99RF0mtAHXDvM/eFB51SH9dyeeqtng4o5Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=091286oT7yO5rbA4NBQR+RxD2XWprHIJeu9TMM/3rW4=;
        b=kDMsQ2eV5XQ+5txgFcyglBIAhuKB4oh6Zz1LmzLIoKZgnOdtK0YEx3YupnnI+Wf+ydKwgf
        +O70MZqxGshWGQDA==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix broken read_counter()
 for SNB IMC PMU
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220803160031.1379788-1-eranian@google.com>
References: <20220803160031.1379788-1-eranian@google.com>
MIME-Version: 1.0
Message-ID: <166155217284.401.6614839609013942092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     11745ecfe8fea4b4a4c322967a7605d2ecbd5080
Gitweb:        https://git.kernel.org/tip/11745ecfe8fea4b4a4c322967a7605d2ecbd5080
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 03 Aug 2022 09:00:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:38 +02:00

perf/x86/intel/uncore: Fix broken read_counter() for SNB IMC PMU

Existing code was generating bogus counts for the SNB IMC bandwidth counters:

$ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
     1.000327813           1,024.03 MiB  uncore_imc/data_reads/
     1.000327813              20.73 MiB  uncore_imc/data_writes/
     2.000580153         261,120.00 MiB  uncore_imc/data_reads/
     2.000580153              23.28 MiB  uncore_imc/data_writes/

The problem was introduced by commit:
  07ce734dd8ad ("perf/x86/intel/uncore: Clean up client IMC")

Where the read_counter callback was replace to point to the generic
uncore_mmio_read_counter() function.

The SNB IMC counters are freerunnig 32-bit counters laid out contiguously in
MMIO. But uncore_mmio_read_counter() is using a readq() call to read from
MMIO therefore reading 64-bit from MMIO. Although this is okay for the
uncore_perf_event_update() function because it is shifting the value based
on the actual counter width to compute a delta, it is not okay for the
uncore_pmu_event_start() which is simply reading the counter  and therefore
priming the event->prev_count with a bogus value which is responsible for
causing bogus deltas in the perf stat command above.

The fix is to reintroduce the custom callback for read_counter for the SNB
IMC PMU and use readl() instead of readq(). With the change the output of
perf stat is back to normal:
$ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
     1.000120987             296.94 MiB  uncore_imc/data_reads/
     1.000120987             138.42 MiB  uncore_imc/data_writes/
     2.000403144             175.91 MiB  uncore_imc/data_reads/
     2.000403144              68.50 MiB  uncore_imc/data_writes/

Fixes: 07ce734dd8ad ("perf/x86/intel/uncore: Clean up client IMC")
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20220803160031.1379788-1-eranian@google.com
---
 arch/x86/events/intel/uncore_snb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index ce44001..1ef4f78 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -841,6 +841,22 @@ int snb_pci2phy_map_init(int devid)
 	return 0;
 }
 
+static u64 snb_uncore_imc_read_counter(struct intel_uncore_box *box, struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * SNB IMC counters are 32-bit and are laid out back to back
+	 * in MMIO space. Therefore we must use a 32-bit accessor function
+	 * using readq() from uncore_mmio_read_counter() causes problems
+	 * because it is reading 64-bit at a time. This is okay for the
+	 * uncore_perf_event_update() function because it drops the upper
+	 * 32-bits but not okay for plain uncore_read_counter() as invoked
+	 * in uncore_pmu_event_start().
+	 */
+	return (u64)readl(box->io_addr + hwc->event_base);
+}
+
 static struct pmu snb_uncore_imc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.event_init	= snb_uncore_imc_event_init,
@@ -860,7 +876,7 @@ static struct intel_uncore_ops snb_uncore_imc_ops = {
 	.disable_event	= snb_uncore_imc_disable_event,
 	.enable_event	= snb_uncore_imc_enable_event,
 	.hw_config	= snb_uncore_imc_hw_config,
-	.read_counter	= uncore_mmio_read_counter,
+	.read_counter	= snb_uncore_imc_read_counter,
 };
 
 static struct intel_uncore_type snb_uncore_imc = {
