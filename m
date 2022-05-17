Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07D52A9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbiEQSEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351854AbiEQSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA25B50B38
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810639;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxGCj1cP/e8qYt5WRT45mylpr4ifFluD3fScdJvLc6A=;
        b=IXKLVYZ0narU67O9b1KGbqC3W9HMESN5LYT796WSvdDJWO/kdXiwBTQoq6KpO4YEk+Sktj
        VaCMaIasubwXym4tNZs5dscsyUhgOXja8Cc7EgRw4IY1t8lkaSpR9rsbxm60Ozp4eLOkDS
        icmFYwviVfnsijfCvgq65ZBBlbIQCzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-N-obt9wAOvK86jGT5yTC4g-1; Tue, 17 May 2022 14:03:55 -0400
X-MC-Unique: N-obt9wAOvK86jGT5yTC4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5FA1101A52C;
        Tue, 17 May 2022 18:03:54 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B785400DFB5;
        Tue, 17 May 2022 18:03:54 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 11/11] smp: up.c to adopt the same format of cross CPU call.
Date:   Tue, 17 May 2022 14:03:26 -0400
Message-Id: <20220517180326.997129-12-dqiao@redhat.com>
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

Since smp.c has been changed to use the new interface, up.c should
be changed to use the uniprocessor version of cross call as well.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to
	  SMP_CALL from the new macros
v2 -> v3: Fixed the UP build errors (W=1 build) 
 kernel/up.c | 58 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/kernel/up.c b/kernel/up.c
index a38b8b095251..ebecd8602884 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -9,8 +9,7 @@
 #include <linux/smp.h>
 #include <linux/hypervisor.h>
 
-int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
-				int wait)
+int smp_call(int cpu, void (*func) (void *info), void *info, unsigned int type)
 {
 	unsigned long flags;
 
@@ -23,37 +22,62 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_single);
+EXPORT_SYMBOL(smp_call);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_cond(int cpu, smp_call_func_t func, void *info,
+		   smp_cond_func_t cond_func, unsigned int type)
 {
-	unsigned long flags;
+	int ret = 0;
+
+	preempt_disable();
+	if (!cond_func || cond_func(cpu, info))
+		ret = smp_call(cpu, func, info, type);
+
+	preempt_enable();
+
+	return ret;
+}
+EXPORT_SYMBOL(smp_call_cond);
+
+void smp_call_mask(const struct cpumask *mask, smp_call_func_t func, void *info, unsigned int type)
+{
+	if (!cpumask_test_cpu(0, mask))
+		return;
+
+	preempt_disable();
+	smp_call(0, func, info, type);
+	preempt_enable();
+}
+EXPORT_SYMBOL(smp_call_mask);
+
+int smp_call_csd(int cpu, struct __call_single_data *csd, unsigned int type)
+{
+	preempt_disable();
+
+	if (csd->func != NULL)
+		smp_call(cpu, csd->func, csd->info, type);
+
+	preempt_enable();
 
-	local_irq_save(flags);
-	csd->func(csd->info);
-	local_irq_restore(flags);
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_single_async);
+EXPORT_SYMBOL(smp_call_csd);
 
 /*
  * Preemption is disabled here to make sure the cond_func is called under the
  * same conditions in UP and SMP.
  */
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask)
+void smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
+			 void *info, smp_cond_func_t cond_func,
+			 unsigned int type)
 {
-	unsigned long flags;
-
 	preempt_disable();
 	if ((!cond_func || cond_func(0, info)) && cpumask_test_cpu(0, mask)) {
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
+		smp_call(0, func, info, type);
 	}
 	preempt_enable();
 }
-EXPORT_SYMBOL(on_each_cpu_cond_mask);
+EXPORT_SYMBOL(smp_call_mask_cond);
 
 int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 {
-- 
2.27.0

