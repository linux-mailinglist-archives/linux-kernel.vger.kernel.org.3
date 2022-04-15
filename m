Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB15020B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348852AbiDOCuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346205AbiDOCto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05204A76F2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649990836;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaQc6WR24ukuwvxlivtqeU+OrGyMhQdvgNTcYOVeUVU=;
        b=QphLWqkxZ61rkpVW0cVEoBGUZWoP0lz6zebLS+dnlb63kV1Yc7ec46mvThzYy3iwGJXbtZ
        XaiM02XZfrExC/lsPp7UMI+KnGOsGeMLRg3VUj4KqfupAytn6CICoQzQcrooyYqRlekKGA
        cSx9GEtBz9vGE3zn5Fv5edjat/xXRws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-KQfow5ewOoe-aaO0srpjWQ-1; Thu, 14 Apr 2022 22:47:15 -0400
X-MC-Unique: KQfow5ewOoe-aaO0srpjWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 600493803511;
        Fri, 15 Apr 2022 02:47:14 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.8.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ADD3440ADC;
        Fri, 15 Apr 2022 02:47:14 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH 05/11] smp: replace smp_call_function_single_async() with smp_xcall_private()
Date:   Thu, 14 Apr 2022 22:46:55 -0400
Message-Id: <20220415024701.876364-6-dqiao@redhat.com>
In-Reply-To: <20220415024701.876364-1-dqiao@redhat.com>
References: <20220415024701.876364-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced smp_call_function_single_async() with smp_xcall_private()
and also extended smp_xcall_private() to support one CPU synchronous
call with preallocated csd structures.

Ideally, the new interface smp_xcall() should be able to do what
smp_call_function_single_async() does. Because the csd is provided
and maintained by the callers, it exposes the risk of corrupting
the call_single_queue[cpu] linked list if the clents menipulate
their csd inappropriately. On the other hand, there should have no
noticeable performance advantage to provide preallocated csd for
cross call kernel consumers. Thus, in the long run, the consumers
should change to not use this type of preallocated csd.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
 include/linux/smp.h |   3 +-
 kernel/smp.c        | 163 +++++++++++++++++++++-----------------------
 2 files changed, 81 insertions(+), 85 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 12d6efef34f7..8a234e707f10 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -206,7 +206,8 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
+#define	smp_call_function_single_async(cpu, csd) \
+	smp_xcall_private(cpu, csd, XCALL_TYPE_ASYNC)
 
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
diff --git a/kernel/smp.c b/kernel/smp.c
index 42ecaf960963..aef913b54f81 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -429,41 +429,6 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
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
@@ -661,52 +626,6 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
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
@@ -1251,16 +1170,92 @@ EXPORT_SYMBOL(smp_xcall_mask_cond);
  * Because the call is asynchonous with a preallocated csd structure, thus
  * it can be called from contexts with disabled interrupts.
  *
- * Parameters
+ * Ideally this functionality should be part of smp_xcall_mask_cond().
+ * Because the csd is provided and maintained by the callers, merging this
+ * functionality into smp_xcall_mask_cond() will result in some extra
+ * complications in it. Before there is better way to facilitate all
+ * kinds of xcall, let's still handle this case with a separate function.
+ *
+ * The bit CSD_FLAG_LOCK will be set to csd->node.u_flags only if the
+ * xcall is made as type CSD_TYPE_SYNC or CSD_TYPE_ASYNC.
  *
+ * Parameters:
  * cpu:   Must be a positive value less than nr_cpu_id.
  * csd:   The private csd provided by the caller.
- *
  * Others: see smp_xcall().
+ *
+ * Return: %0 on success or negative errno value on error.
+ *
+ * The following comments are from smp_call_function_single_async():
+ *
+ *    The call is asynchronous and can thus be done from contexts with
+ *    disabled interrupts. If the function is called with one csd which
+ *    has not yet been processed by previous call, the function will
+ *    return immediately with -EBUSY showing that the csd object is
+ *    still in progress.
+ *
+ *    NOTE: Be careful, there is unfortunately no current debugging
+ *    facility to validate the correctness of this serialization.
  */
 int smp_xcall_private(int cpu, call_single_data_t *csd, unsigned int flags)
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
 EXPORT_SYMBOL(smp_xcall_private);
 
-- 
2.27.0

