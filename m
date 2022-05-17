Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57E52A9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351849AbiEQSEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351830AbiEQSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06A20506F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810635;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCG2D0D+sijXYG8HRcyYEnSOhHJx5E3oR5JArHRb+NM=;
        b=Jx5ZEcnG01QPG+yRkj1Z6bScGXRsbNoACBcLzBXdxp9D/4um6sG6wksiO9USBhJMCL6XqC
        h6lP9HeMhTuKdpEUIAmdJWyJ+yYgQPbERcNXAOt6O3OEXVNw2EOfn+cGFUsRIAAmGOWneF
        VZSvMMvoFcZcdehcdSqFakiqFyh9gnQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-giNb7Z8SPZG9xnyV-NdbAQ-1; Tue, 17 May 2022 14:03:52 -0400
X-MC-Unique: giNb7Z8SPZG9xnyV-NdbAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E88B811E83;
        Tue, 17 May 2022 18:03:52 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8B8240CF8F0;
        Tue, 17 May 2022 18:03:51 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 09/11] smp: replace smp_call_function_single_async with smp_call_csd
Date:   Tue, 17 May 2022 14:03:24 -0400
Message-Id: <20220517180326.997129-10-dqiao@redhat.com>
In-Reply-To: <20220517180326.997129-1-dqiao@redhat.com>
References: <20220517180326.997129-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace smp_call_function_single_async with smp_call_csd
and modify all the invocations.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to SMP_CALL
	  from the new macros
v2 -> v3: Modifed all the invocations of smp_call_function_single_async()
	  to smp_call_csd()
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
index c2d5f4bfe1f3..8a8012af3219 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -745,7 +745,7 @@ static void raise_backtrace(cpumask_t *mask)
 		}
 
 		csd = &per_cpu(backtrace_csd, cpu);
-		smp_call_function_single_async(cpu, csd);
+		smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index ca4727862b95..02b540f668d0 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -702,7 +702,7 @@ void tick_broadcast(const struct cpumask *mask)
 
 	for_each_cpu(cpu, mask) {
 		csd = &per_cpu(tick_broadcast_csd, cpu);
-		smp_call_function_single_async(cpu, csd);
+		smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 136af9f32f23..5cfd6c98cfe3 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -212,7 +212,7 @@ static void zpci_handle_fallback_irq(void)
 			continue;
 
 		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq, &cpu_data->scheduled);
-		smp_call_function_single_async(cpu, &cpu_data->csd);
+		smp_call_csd(cpu, &cpu_data->csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 6f7b8cc1bc9f..760beece93e3 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -81,7 +81,7 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 		cmd.regs.eax = pos;
 		cmd.regs.ecx = pos >> 32;
 
-		err = smp_call_function_single_async(cpu, &csd);
+		err = smp_call_csd(cpu, &csd, SMP_CALL_TYPE_ASYNC);
 		if (err)
 			break;
 		wait_for_completion(&cmd.done);
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index cbe2874835f3..cc33097651fc 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -178,7 +178,7 @@ int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 	init_completion(&rv.done);
 	rv.msr.msr_no = msr_no;
 
-	err = smp_call_function_single_async(cpu, &csd);
+	err = smp_call_csd(cpu, &csd, SMP_CALL_TYPE_ASYNC);
 	if (!err) {
 		wait_for_completion(&rv.done);
 		err = rv.msr.err;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 84d749511f55..5c14cdffc70d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1063,7 +1063,7 @@ static void blk_mq_complete_send_ipi(struct request *rq)
 	list = &per_cpu(blk_cpu_done, cpu);
 	if (llist_add(&rq->ipi_list, list)) {
 		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(cpu, &rq->csd);
+		smp_call_csd(cpu, &rq->csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 24ed0f1f089b..722694666063 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -121,7 +121,7 @@ static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
 		csd = &per_cpu(ingenic_cevt_csd, timer->cpu);
 		csd->info = (void *) &timer->cevt;
 		csd->func = ingenic_per_cpu_event_handler;
-		smp_call_function_single_async(timer->cpu, csd);
+		smp_call_csd(timer->cpu, csd, SMP_CALL_TYPE_ASYNC);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 74068742cef3..26519f6e828a 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -334,7 +334,7 @@ static void cpuidle_coupled_poke(int cpu)
 	call_single_data_t *csd = &per_cpu(cpuidle_coupled_poke_cb, cpu);
 
 	if (!cpumask_test_and_set_cpu(cpu, &cpuidle_coupled_poke_pending))
-		smp_call_function_single_async(cpu, csd);
+		smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC);
 }
 
 /**
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 73cb03266549..489777fd3e56 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -729,7 +729,7 @@ static void liquidio_napi_drv_callback(void *arg)
 		napi_schedule_irqoff(&droq->napi);
 	} else {
 		INIT_CSD(&droq->csd, napi_schedule_wrapper, &droq->napi);
-		smp_call_function_single_async(droq->cpu_id, &droq->csd);
+		smp_call_csd(droq->cpu_id, &droq->csd, SMP_CALL_TYPE_ASYNC);
 	}
 }
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 40c46d2bea88..1086f8d5e18c 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -193,9 +193,6 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
-#define	smp_call_function_single_async(cpu, csd) \
-	smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC)
-
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
  * Architecture-dependent code may override them.
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..113229096a70 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -264,7 +264,7 @@ void __weak kgdb_roundup_cpus(void)
 			continue;
 		kgdb_info[cpu].rounding_up = true;
 
-		ret = smp_call_function_single_async(cpu, csd);
+		ret = smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC);
 		if (ret)
 			kgdb_info[cpu].rounding_up = false;
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6d1d30bd6220..09d54fb3eb4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -836,7 +836,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	if (rq == this_rq())
 		__hrtick_restart(rq);
 	else
-		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
+		smp_call_csd(cpu_of(rq), &rq->hrtick_csd, SMP_CALL_TYPE_ASYNC);
 }
 
 #else
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..1bb83d3ae9ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10461,7 +10461,7 @@ static void kick_ilb(unsigned int flags)
 	 * is idle. And the softirq performing nohz idle load balance
 	 * will be run before returning from the IPI.
 	 */
-	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
+	smp_call_csd(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd, SMP_CALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index 1461c2d9dec8..e8319f789ed1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5788,7 +5788,7 @@ static void net_rps_send_ipi(struct softnet_data *remsd)
 		struct softnet_data *next = remsd->rps_ipi_next;
 
 		if (cpu_online(remsd->cpu))
-			smp_call_function_single_async(remsd->cpu, &remsd->csd);
+			smp_call_csd(remsd->cpu, &remsd->csd, SMP_CALL_TYPE_ASYNC);
 		remsd = next;
 	}
 #endif
-- 
2.27.0

