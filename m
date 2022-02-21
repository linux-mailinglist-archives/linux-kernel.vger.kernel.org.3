Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D1F4BE2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381133AbiBUQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:41:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381045AbiBUQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:40:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B19127FD5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:39:21 -0800 (PST)
Date:   Mon, 21 Feb 2022 16:39:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645461558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDYoFZzzEUTriDhEdPyrCKXBps/S5usFQUe+tA2i+uo=;
        b=RrFAEqSCo3HTteCiblNftlpzEhO46oSuvL3RXLHtU1YYOOCvKWbzhgl9M08H4SyCCuaED5
        2mySAkQj4cqqTRQCwrh/aUCkBCrXqqZ/U4odDAIp6ZdMc7Uxw37UZyAV307hSlB1xqji2w
        lpZfHH5eeaoX9vFNG+tIgegBbKf4yZ3d/vqV8tbyDWf9bV/rw5KNLnPFg0TAXOfEDLaMCy
        PuXK/MSNCThw3ILGhmJXQbrqsKLnLe+SxQQXCEpM1gidohp/y4GGj9Hn0cXrBDDQAVT/OK
        C2jTWHB8BvrOIjPqj/F+5SHg96Nb0Y86qh60ak75lnt+IyTZWCsqBpObYvupsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645461558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDYoFZzzEUTriDhEdPyrCKXBps/S5usFQUe+tA2i+uo=;
        b=NzUmdXCwJIE2Qj6BV0iwiEP2dHL18qNyZN52JAelS7FjlHeCncVTs9wHSmkrRVi62jbJQI
        WlPQuu/qAzA6MPBQ==
From:   "irqchip-bot for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Use dsb(ishst) to order
 writes with ICC_SGI1R_EL1 accesses
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220220061910.6155-1-21cnbao@gmail.com>
References: <20220220061910.6155-1-21cnbao@gmail.com>
MIME-Version: 1.0
Message-ID: <164546155756.16921.7621579570018204768.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     80e4e1f472889f31a4dcaea3a4eb7a565296f1f3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/80e4e1f472889f31a4dcaea3a4eb7a565296f1f3
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Sun, 20 Feb 2022 19:19:10 +13:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Feb 2022 16:17:02 

irqchip/gic-v3: Use dsb(ishst) to order writes with ICC_SGI1R_EL1 accesses

A dsb(ishst) barrier should be enough to order previous writes with
the system register generating the SGI, as we only need to guarantee
the visibility of data to other CPUs in the inner shareable domain
before we send the SGI.

A micro-benchmark is written to verify the performance impact on
kunpeng920 machine with 2 sockets, each socket has 2 dies, and
each die has 24 CPUs, so totally the system has 2 * 2 * 24 = 96
CPUs. ~2% performance improvement can be seen by this benchmark.

The code of benchmark module:

 #include <linux/module.h>
 #include <linux/timekeeping.h>

 volatile int data0 ____cacheline_aligned;
 volatile int data1 ____cacheline_aligned;
 volatile int data2 ____cacheline_aligned;
 volatile int data3 ____cacheline_aligned;
 volatile int data4 ____cacheline_aligned;
 volatile int data5 ____cacheline_aligned;
 volatile int data6 ____cacheline_aligned;

 static void ipi_latency_func(void *val)
 {
 }

 static int __init ipi_latency_init(void)
 {
 	ktime_t stime, etime, delta;
 	int cpu, i;
 	int start = smp_processor_id();

 	stime = ktime_get();
 	for ( i = 0; i < 1000; i++)
 		for (cpu = 0; cpu < 96; cpu++) {
 			data0 = data1 = data2 = data3 = data4 = data5 = data6 = cpu;
 			smp_call_function_single(cpu, ipi_latency_func, NULL, 1);
 		}
 	etime = ktime_get();

 	delta = ktime_sub(etime, stime);

 	printk("%s ipi from cpu%d to cpu0-95 delta of 1000times:%lld\n",
 			__func__, start, delta);

 	return 0;
 }
 module_init(ipi_latency_init);

 static void ipi_latency_exit(void)
 {
 }
 module_exit(ipi_latency_exit);

 MODULE_DESCRIPTION("IPI benchmark");
 MODULE_LICENSE("GPL");

run the below commands 10 times on both Vanilla and the kernel with this
patch:
 # taskset -c 0 insmod test.ko
 # rmmod test

The result on vanilla:
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126757449
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126784249
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126177703
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127022281
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126184883
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127374585
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:125778089
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126974441
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127357625
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126228184

The result on the kernel with this patch:
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:124467401
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123474209
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123558497
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122993951
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122984223
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123323609
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:124507583
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123386963
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123340664
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123285324

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
[maz: tidied up commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220220061910.6155-1-21cnbao@gmail.com
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5e935d9..0efe1a9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	wmb();
+	dsb(ishst);
 
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
