Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE152A9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351807AbiEQSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351755AbiEQSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A3243FD82
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810620;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYMVqMFm1U/Csh/eNKPFnJ0fYLpXDdjO8eETCSzIUiY=;
        b=WDxOgIsFQ9Q4pniRNsz52B8zCNYNzDNTnifl4mqK0sbQShnU7iVetUoZWpKwwD96767Q5M
        Wj0i59QeCiIaHU+RzVio7gbVY2kUURXjP9Efgw9HzVOjyumJ51fytcAg3jX6IzcrIt+fSk
        ZlduFSmnTP9MF2j3NWm1KJPL39d3Zug=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-H_9N_WmiO9GqAi7YwU1VNA-1; Tue, 17 May 2022 14:03:36 -0400
X-MC-Unique: H_9N_WmiO9GqAi7YwU1VNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A40573C16199;
        Tue, 17 May 2022 18:03:35 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF0D400DFB5;
        Tue, 17 May 2022 18:03:35 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 05/11] smp: replace smp_call_function_single_async with smp_call_csd
Date:   Tue, 17 May 2022 14:03:20 -0400
Message-Id: <20220517180326.997129-6-dqiao@redhat.com>
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

Replaced smp_call_function_single_async with smp_call_csd and extended
it to support one CPU synchronous call with preallocated csd structure.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: removed 'x' from the function names and change XCALL to
	  SMP_CALL from the new macros
v2 -> v3: Changed the call of smp_call_private() to smp_call_csd()
 include/linux/smp.h |   3 +-
 kernel/smp.c        | 157 ++++++++++++++++++++------------------------
 2 files changed, 75 insertions(+), 85 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 06a20454fd53..b4885e45690b 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -193,7 +193,8 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
+#define	smp_call_function_single_async(cpu, csd) \
+	smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC)
 
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/kernel/smp.c b/kernel/smp.c
index 8fdea9547502..f08135ad70e3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -444,41 +444,6 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		send_call_function_single_ipi(cpu);
 }
 
-/*
- * Insert a previously allocated call_single_data_t element
- * for execution on the given CPU. data must already have
- * ->func, ->info, and ->flags set.
- */
-static int generic_exec_single(int cpu, struct __call_single_data *csd)
-{
-	if (cpu == smp_processor_id()) {
-		smp_call_func_t func = csd->func;
-		void *info = csd->info;
-		unsigned long flags;
-
-		/*
-		 * We can unlock early even for the synchronous on-stack case,
-		 * since we're doing this from the same CPU..
-		 */
-		csd_lock_record(csd);
-		csd_unlock(csd);
-		local_irq_save(flags);
-		func(info);
-		csd_lock_record(NULL);
-		local_irq_restore(flags);
-		return 0;
-	}
-
-	if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu)) {
-		csd_unlock(csd);
-		return -ENXIO;
-	}
-
-	__smp_call_single_queue(cpu, &csd->node.llist);
-
-	return 0;
-}
-
 /**
  * generic_smp_call_function_single_interrupt - Execute SMP IPI callbacks
  *
@@ -676,52 +641,6 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-/**
- * smp_call_function_single_async() - Run an asynchronous function on a
- * 			         specific CPU.
- * @cpu: The CPU to run on.
- * @csd: Pre-allocated and setup data structure
- *
- * Like smp_call_function_single(), but the call is asynchonous and
- * can thus be done from contexts with disabled interrupts.
- *
- * The caller passes his own pre-allocated data structure
- * (ie: embedded in an object) and is responsible for synchronizing it
- * such that the IPIs performed on the @csd are strictly serialized.
- *
- * If the function is called with one csd which has not yet been
- * processed by previous call to smp_call_function_single_async(), the
- * function will return immediately with -EBUSY showing that the csd
- * object is still in progress.
- *
- * NOTE: Be careful, there is unfortunately no current debugging facility to
- * validate the correctness of this serialization.
- *
- * Return: %0 on success or negative errno value on error
- */
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
-{
-	int err = 0;
-
-	preempt_disable();
-
-	if (csd->node.u_flags & CSD_FLAG_LOCK) {
-		err = -EBUSY;
-		goto out;
-	}
-
-	csd->node.u_flags = CSD_FLAG_LOCK;
-	smp_wmb();
-
-	err = generic_exec_single(cpu, csd);
-
-out:
-	preempt_enable();
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(smp_call_function_single_async);
-
 /*
  * smp_call_function_any - Run a function on any of the given cpus
  * @mask: The mask of cpus it can run on.
@@ -1304,15 +1223,85 @@ EXPORT_SYMBOL(smp_call_mask_cond);
  * Because of that, this function can be used from the contexts with disabled
  * interrupts.
  *
- * Parameters
+ * The bit CSD_FLAG_LOCK will be set to csd->node.u_flags only if the call
+ * is made as type CSD_TYPE_SYNC or CSD_TYPE_ASYNC.
  *
+ * Parameters
  * cpu:   Must be a positive value less than nr_cpu_id.
  * csd:   The private csd provided by the callers.
- *
  * Others: see smp_call().
+ *
+ * Return: %0 on success or negative errno value on error.
+ *
+ * The following comments are from smp_call_function_single_async():
+ *
+ *   The call is asynchronous and can thus be done from contexts with
+ *   disabled interrupts. If the function is called with one csd which
+ *   has not yet been processed by previous call, the function will
+ *   return immediately with -EBUSY showing that the csd object is
+ *   still in progress.
+ *
+ *   NOTE: Be careful, there is unfortunately no current debugging
+ *   facility to validate the correctness of this serialization.
  */
 int smp_call_csd(int cpu, call_single_data_t *csd, unsigned int flags)
 {
-	return 0;
+	int err = 0;
+
+	if ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu)) {
+		pr_warn("cpu ID must be a positive number < nr_cpu_ids and must be currently online\n");
+		return -EINVAL;
+	}
+
+	if (csd == NULL) {
+		pr_warn("csd must not be NULL\n");
+		return -EINVAL;
+	}
+
+	preempt_disable();
+	if (csd->node.u_flags & CSD_FLAG_LOCK) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * CSD_FLAG_LOCK is set for CSD_TYPE_SYNC or CSD_TYPE_ASYNC only.
+	 */
+	if ((flags & ~(CSD_TYPE_SYNC | CSD_TYPE_ASYNC)) == 0)
+		csd->node.u_flags = CSD_FLAG_LOCK | flags;
+	else
+		csd->node.u_flags = flags;
+
+	if (cpu == smp_processor_id()) {
+		smp_call_func_t func = csd->func;
+		void *info = csd->info;
+		unsigned long flags;
+
+		/*
+		 * We can unlock early even for the synchronous on-stack case,
+		 * since we're doing this from the same CPU..
+		 */
+		csd_lock_record(csd);
+		csd_unlock(csd);
+		local_irq_save(flags);
+		func(info);
+		csd_lock_record(NULL);
+		local_irq_restore(flags);
+		goto out;
+	}
+
+	/*
+	 * Ensure the flags are visible before the csd
+	 * goes to the queue.
+	 */
+	smp_wmb();
+
+	__smp_call_single_queue(cpu, &csd->node.llist);
+
+	if (flags & CSD_TYPE_SYNC)
+		csd_lock_wait(csd);
+out:
+	preempt_enable();
+	return err;
 }
 EXPORT_SYMBOL(smp_call_csd);
-- 
2.27.0

