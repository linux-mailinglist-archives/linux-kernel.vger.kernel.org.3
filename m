Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFA25020B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348942AbiDOCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348863AbiDOCt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ABF1B1A86
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649990845;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jxh3o7JLPu4/eVSTPgqOXdqshCVuUH/u4kA7lEjb85U=;
        b=P2u5B+1jsBoQFyaFkCYrB4EKyqmB/ApkN3EBduqWpchoQ8mAMFMIKSSlSr9Y+F0wzRxgdg
        k+HFJzxAq/qzjWwRITV+V3YvvkBHfpX2pImgplbHu8VZOMhrFQPtOj3EdkiSIC/vTju5Tf
        dIuB4Q3Zy4FOcJ5fN44H7cZVg668/ko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-83jz56xDNaySQCZg-O2lfQ-1; Thu, 14 Apr 2022 22:47:22 -0400
X-MC-Unique: 83jz56xDNaySQCZg-O2lfQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E659185A79C;
        Fri, 15 Apr 2022 02:47:22 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.8.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAB56440ADC;
        Fri, 15 Apr 2022 02:47:21 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH 11/11] smp: modify up.c to adopt the same format of cross CPU call.
Date:   Thu, 14 Apr 2022 22:47:01 -0400
Message-Id: <20220415024701.876364-12-dqiao@redhat.com>
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

Since smp.c has been changed to use the new interface, up.c should
be changed to use the uniprocessor version of cross call as well.

Also clean up the dead code which left out after applying the precedent
patches of this patch set.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
 include/linux/smp.h |  7 ------
 kernel/up.c         | 56 +++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index f2e6c7a1be3d..1e29527123f8 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -202,9 +202,6 @@ extern void __smp_call_single_queue(int cpu, struct llist_node *node);
 /* total number of cpus in this system (may exceed NR_CPUS) */
 extern unsigned int total_cpus;
 
-int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
-			     int wait);
-
 /*
  * Cpus stopping functions in panic. All have default weak definitions.
  * Architecture-dependent code may override them.
@@ -290,13 +287,9 @@ static inline void smp_send_stop(void) { }
 static inline void up_smp_call_function(smp_call_func_t func, void *info)
 {
 }
-#define smp_call_function(func, info, wait) \
-			(up_smp_call_function(func, info))
 
 static inline void smp_send_reschedule(int cpu) { }
 #define smp_prepare_boot_cpu()			do {} while (0)
-#define smp_call_function_many(mask, func, info, wait) \
-			(up_smp_call_function(func, info))
 static inline void call_function_init(void) { }
 
 static inline void kick_all_cpus_sync(void) {  }
diff --git a/kernel/up.c b/kernel/up.c
index a38b8b095251..92c62c677e52 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -9,8 +9,7 @@
 #include <linux/smp.h>
 #include <linux/hypervisor.h>
 
-int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
-				int wait)
+int smp_xcall(int cpu, void (*func) (void *info), void *info, unsigned int type)
 {
 	unsigned long flags;
 
@@ -23,37 +22,66 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_single);
+EXPORT_SYMBOL(smp_xcall);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_xcall_cond(int cpu, smp_call_func_t func, void *info,
+		   smp_cond_func_t cond_func, unsigned int type)
+{
+	int ret = 0;
+
+	preempt_disable();
+	if (!cond_func || cond_func(0, info))
+		ret = smp_xcall(cpu, func, info, type);
+
+	preempt_enable();
+
+	return ret;
+}
+EXPORT_SYMBOL(smp_xcall_cond);
+
+void smp_xcall_mask(const struct cpumask *mask, smp_call_func_t func, void *info, unsigned int type)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
-	csd->func(csd->info);
-	local_irq_restore(flags);
+	if (!cpumask_test_cpu(0, mask))
+		return;
+
+	preempt_disable();
+	smp_xcall(cpu, func, info, type);
+	preempt_enable();
+}
+EXPORT_SYMBOL(smp_xcall_mask);
+
+int smp_xcall_private(int cpu, struct __call_single_data *csd, unsigned int type)
+{
+	preempt_disable();
+
+	if (csd->func != NULL)
+		smp_xcall(cpu, csd->func, csd->info, type);
+
+	preempt_enable();
+
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_single_async);
+EXPORT_SYMBOL(smp_xcall_private);
 
 /*
  * Preemption is disabled here to make sure the cond_func is called under the
  * same conditions in UP and SMP.
  */
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask)
+void smp_xcall_mask_cond(const struct cpumask *mask, smp_call_func_t func,
+			 void *info, smp_cond_func_t cond_func,
+			 unsigned int type)
 {
 	unsigned long flags;
 
 	preempt_disable();
 	if ((!cond_func || cond_func(0, info)) && cpumask_test_cpu(0, mask)) {
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
+		smp_xcall(cpu, func, info, type);
 	}
 	preempt_enable();
 }
-EXPORT_SYMBOL(on_each_cpu_cond_mask);
+EXPORT_SYMBOL(smp_xcall_mask_cond);
 
 int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 {
-- 
2.27.0

