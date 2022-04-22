Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F750C1CD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiDVWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiDVWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F18140F79C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650660242;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UjeaYgSyUiDYMobZ735OVOAwLc8xPkkl42vFpln15c=;
        b=Pb3/HfLnbDn3qbb6r4EOq9nvU3SZWoD1gzJbVCdcvDk8+ZzVcHHEFHdXQftoAWe6fkGfHM
        neI2vFb9Myaavz099fGtRIIHJhJjSDNRscUhctP0YSeizHafUDsQrLKzCl4MMDWuOyCXzL
        G5vn7V6dMfFJHY8MIycjcTMPNg83Ntc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-ofGEhA6oMF2xj5stUS2GKg-1; Fri, 22 Apr 2022 16:01:05 -0400
X-MC-Unique: ofGEhA6oMF2xj5stUS2GKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D6B13810D45;
        Fri, 22 Apr 2022 20:01:04 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.19.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25FE0C27EB4;
        Fri, 22 Apr 2022 20:01:04 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v2 09/11] smp: replace smp_call_function_single_async with smp_call_private
Date:   Fri, 22 Apr 2022 16:00:38 -0400
Message-Id: <20220422200040.93813-10-dqiao@redhat.com>
In-Reply-To: <20220422200040.93813-1-dqiao@redhat.com>
References: <20220422200040.93813-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace smp_call_function_single_async with smp_call_private
and modify all the invocations.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: removed 'x' from the function names and change XCALL to SMP_CALL from the new macros

 arch/mips/kernel/process.c                      | 2 +-
 arch/mips/kernel/smp.c                          | 2 +-
 arch/s390/pci/pci_irq.c                         | 2 +-
 arch/x86/kernel/cpuid.c                         | 2 +-
 arch/x86/lib/msr-smp.c                          | 2 +-
 block/blk-mq.c                                  | 2 +-
 drivers/clocksource/ingenic-timer.c             | 2 +-
 drivers/cpuidle/coupled.c                       | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c | 2 +-
 include/linux/smp.h                             | 3 ---
 kernel/debug/debug_core.c                       | 2 +-
 kernel/sched/core.c                             | 2 +-
 kernel/sched/fair.c                             | 2 +-
 net/core/dev.c                                  | 2 +-
 14 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c2d5f4bfe1f3..41e78c4ba2cf 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -745,7 +745,7 @@ static void raise_backtrace(cpumask_t *mask)
 		}
 
 		csd = &per_cpu(backtrace_csd, cpu);
-		smp_call_function_single_async(cpu, csd);
+		smp_call_private(cpu, csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 9a6f827d9325..04f1cec09a15 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -701,7 +701,7 @@ void tick_broadcast(const struct cpumask *mask)
 
 	for_each_cpu(cpu, mask) {
 		csd = &per_cpu(tick_broadcast_csd, cpu);
-		smp_call_function_single_async(cpu, csd);
+		smp_call_private(cpu, csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 136af9f32f23..6ce877cda632 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -212,7 +212,7 @@ static void zpci_handle_fallback_irq(void)
 			continue;
 
 		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq, &cpu_data->scheduled);
-		smp_call_function_single_async(cpu, &cpu_data->csd);
+		smp_call_private(cpu, &cpu_data->csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 6f7b8cc1bc9f..930bf45244eb 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -81,7 +81,7 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 		cmd.regs.eax = pos;
 		cmd.regs.ecx = pos >> 32;
 
-		err = smp_call_function_single_async(cpu, &csd);
+		err = smp_call_private(cpu, &csd, SMP_CALL_TYPE_ASYNC);
 		if (err)
 			break;
 		wait_for_completion(&cmd.done);
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 139ba6a2240a..71b8bf97450e 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -178,7 +178,7 @@ int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 	init_completion(&rv.done);
 	rv.msr.msr_no = msr_no;
 
-	err = smp_call_function_single_async(cpu, &csd);
+	err = smp_call_private(cpu, &csd, SMP_CALL_TYPE_ASYNC);
 	if (!err) {
 		wait_for_completion(&rv.done);
 		err = rv.msr.err;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed3ed86f7dd2..da2c86f317df 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1062,7 +1062,7 @@ static void blk_mq_complete_send_ipi(struct request *rq)
 	list = &per_cpu(blk_cpu_done, cpu);
 	if (llist_add(&rq->ipi_list, list)) {
 		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(cpu, &rq->csd);
+		smp_call_private(cpu, &rq->csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 24ed0f1f089b..d70f1c2d967b 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -121,7 +121,7 @@ static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
 		csd = &per_cpu(ingenic_cevt_csd, timer->cpu);
 		csd->info = (void *) &timer->cevt;
 		csd->func = ingenic_per_cpu_event_handler;
-		smp_call_function_single_async(timer->cpu, csd);
+		smp_call_private(timer->cpu, csd, SMP_CALL_TYPE_ASYNC);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 74068742cef3..4379dd2a363b 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -334,7 +334,7 @@ static void cpuidle_coupled_poke(int cpu)
 	call_single_data_t *csd = &per_cpu(cpuidle_coupled_poke_cb, cpu);
 
 	if (!cpumask_test_and_set_cpu(cpu, &cpuidle_coupled_poke_pending))
-		smp_call_function_single_async(cpu, csd);
+		smp_call_private(cpu, csd, SMP_CALL_TYPE_ASYNC);
 }
 
 /**
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 73cb03266549..d293e2da4aea 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -729,7 +729,7 @@ static void liquidio_napi_drv_callback(void *arg)
 		napi_schedule_irqoff(&droq->napi);
 	} else {
 		INIT_CSD(&droq->csd, napi_schedule_wrapper, &droq->napi);
-		smp_call_function_single_async(droq->cpu_id, &droq->csd);
+		smp_call_private(droq->cpu_id, &droq->csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 5e5d5a5aa730..8923a806757f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -206,9 +206,6 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
-#define	smp_call_function_single_async(cpu, csd) \
-	smp_call_private(cpu, csd, SMP_CALL_TYPE_ASYNC)
-
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
  * Architecture-dependent code may override them.
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..a6dd8f2e928a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -264,7 +264,7 @@ void __weak kgdb_roundup_cpus(void)
 			continue;
 		kgdb_info[cpu].rounding_up = true;
 
-		ret = smp_call_function_single_async(cpu, csd);
+		ret = smp_call_private(cpu, csd, SMP_CALL_TYPE_ASYNC);
 		if (ret)
 			kgdb_info[cpu].rounding_up = false;
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4fda3dfb887b..c9c5e4814742 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -836,7 +836,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	if (rq == this_rq())
 		__hrtick_restart(rq);
 	else
-		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
+		smp_call_private(cpu_of(rq), &rq->hrtick_csd, SMP_CALL_TYPE_ASYNC);
 }
 
 #else
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..367c3ce1d683 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10461,7 +10461,7 @@ static void kick_ilb(unsigned int flags)
 	 * is idle. And the softirq performing nohz idle load balance
 	 * will be run before returning from the IPI.
 	 */
-	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
+	smp_call_private(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd, SMP_CALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index 8c6c08446556..77b9f71a5259 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5788,7 +5788,7 @@ static void net_rps_send_ipi(struct softnet_data *remsd)
 		struct softnet_data *next = remsd->rps_ipi_next;
 
 		if (cpu_online(remsd->cpu))
-			smp_call_function_single_async(remsd->cpu, &remsd->csd);
+			smp_call_private(remsd->cpu, &remsd->csd, SMP_CALL_TYPE_ASYNC);
 		remsd = next;
 	}
 #endif
-- 
2.27.0

