Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044E52A9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351786AbiEQSDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351742AbiEQSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3EA3F88C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810618;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUoSUmhox+3pC9/yVGV28wYCZPSi2OZsiAIPhYhjC14=;
        b=BtoQvkuNYfkvp4/tA/gyve8zTxCDRUanmsPCB7BbLOVa081y991SLe3CgbH82RDrLgQcWL
        3dn7Ema6+6A6MsiSnYJvu+8Jia5v1TixLxX47ADOjd/1vdNZwJcMGtSsFjv7TK60ltSb9H
        GdqJkk8KOh1RpW+m6ZikT/cka7QJGlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-NLdJhWFwPRWVFshJbxW6cQ-1; Tue, 17 May 2022 14:03:34 -0400
X-MC-Unique: NLdJhWFwPRWVFshJbxW6cQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC030811E76;
        Tue, 17 May 2022 18:03:33 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 557B3400F75D;
        Tue, 17 May 2022 18:03:33 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 03/11] smp: remove SCF_WAIT and SCF_RUN_LOCAL
Date:   Tue, 17 May 2022 14:03:18 -0400
Message-Id: <20220517180326.997129-4-dqiao@redhat.com>
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

Remove SCF_WAIT and SCF_RUN_LOCAL and change smp_call_function_many_cond
accordingly. In order to differentiate the cross calls that the local CPU
needs to be included from those the local CPU needs to be excluded, the
interface provides two different functions to deal with that - smp_call_mask()
and smp_call_mask_others().

As a result of these change, the set of on_each_cpu* functions will be
eliminated with a patch later on in this series.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to SMP_CALL
          from the new macros
v2 -> v3: Added a parameter 'local_cpu' to smp_call_function_many_cond
          and the changes accordingly.
 kernel/smp.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 906be125068f..101a48d1d8af 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -802,23 +802,14 @@ int smp_call_function_any(const struct cpumask *mask,
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
-/*
- * Flags to be used as scf_flags argument of smp_call_function_many_cond().
- *
- * %SCF_WAIT:		Wait until function execution is completed
- * %SCF_RUN_LOCAL:	Run also locally if local cpu is set in cpumask
- */
-#define SCF_WAIT	(1U << 0)
-#define SCF_RUN_LOCAL	(1U << 1)
-
 static void smp_call_function_many_cond(const struct cpumask *mask,
 					smp_call_func_t func, void *info,
-					unsigned int scf_flags,
+					bool local_cpu,
+					bool wait,
 					smp_cond_func_t cond_func)
 {
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
-	bool wait = scf_flags & SCF_WAIT;
 	bool run_remote = false;
 	bool run_local = false;
 	int nr_cpus = 0;
@@ -844,14 +835,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	WARN_ON_ONCE(!in_task());
 
 	/* Check if we need local execution. */
-	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
+	if (local_cpu && cpumask_test_cpu(this_cpu, mask))
 		run_local = true;
 
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
 		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (cpu < nr_cpu_ids)
+	if ((unsigned int)cpu < nr_cpu_ids)
 		run_remote = true;
 
 	if (run_remote) {
@@ -922,16 +913,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 }
 
 /**
- * smp_call_function_many(): Run a function on a set of CPUs.
+ * smp_call_function_many(): Run a function on a set of CPUs except the local CPU.
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
- *
- * If @wait is true, then returns once @func has returned.
+ * @wait: If wait is true, the call will not return until func()
+ *        has completed on other CPUs.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
@@ -940,7 +927,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
-	smp_call_function_many_cond(mask, func, info, wait * SCF_WAIT, NULL);
+	smp_call_function_many_cond(mask, func, info, false, wait, NULL);
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
@@ -1052,7 +1039,7 @@ void __init smp_init(void)
 }
 
 /*
- * on_each_cpu_cond(): Call a function on each processor for which
+ * on_each_cpu_cond(): Call a function on each processor which
  * the supplied function cond_func returns true, optionally waiting
  * for all the required CPUs to finish. This may include the local
  * processor.
@@ -1076,13 +1063,9 @@ void __init smp_init(void)
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask)
 {
-	unsigned int scf_flags = SCF_RUN_LOCAL;
-
-	if (wait)
-		scf_flags |= SCF_WAIT;
 
 	preempt_disable();
-	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
+	smp_call_function_many_cond(mask, func, info, true, wait, cond_func);
 	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
-- 
2.27.0

