Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE00150C1C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiDVWBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiDVWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D453214E49
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650660241;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNsTmPytqbyVMuI1jCNlM1MxlCERYC1WJFd11A8MCUo=;
        b=GgNy5nDkg2Y3Z9f1Yu3hvUbUo4mKUlHH21OfRKq8qIc3HqwO0dsj+g/tDI+3lBrMCHpLuk
        V601Cz5/mP63dwfaFU4J+c/CDnuJsQ6QU50Zsyygntze8O1PYofSZamHOx2hFvDxMgPIaa
        IvKCD8NPpgumgtZPa062W9RprtHXpjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511--Si6D8kxNMeAWNcW2D3XOg-1; Fri, 22 Apr 2022 16:01:09 -0400
X-MC-Unique: -Si6D8kxNMeAWNcW2D3XOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF5D5811E9B;
        Fri, 22 Apr 2022 20:01:08 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.19.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78DA9C28108;
        Fri, 22 Apr 2022 20:01:08 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v2 11/11] smp: modify up.c to adopt the same format of cross CPU call.
Date:   Fri, 22 Apr 2022 16:00:40 -0400
Message-Id: <20220422200040.93813-12-dqiao@redhat.com>
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

Since smp.c has been changed to use the new interface, up.c should
be changed to use the uniprocessor version of cross call as well.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: removed 'x' from the function names and change XCALL to SMP_CALL from the new macros

 kernel/up.c | 56 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/kernel/up.c b/kernel/up.c
index a38b8b095251..b442e011a059 100644
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
 
@@ -23,37 +22,66 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_single);
+EXPORT_SYMBOL(smp_call);
 
-int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
+int smp_call_cond(int cpu, smp_call_func_t func, void *info,
+		   smp_cond_func_t cond_func, unsigned int type)
+{
+	int ret = 0;
+
+	preempt_disable();
+	if (!cond_func || cond_func(0, info))
+		ret = smp_call(cpu, func, info, type);
+
+	preempt_enable();
+
+	return ret;
+}
+EXPORT_SYMBOL(smp_call_cond);
+
+void smp_call_mask(const struct cpumask *mask, smp_call_func_t func, void *info, unsigned int type)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
-	csd->func(csd->info);
-	local_irq_restore(flags);
+	if (!cpumask_test_cpu(0, mask))
+		return;
+
+	preempt_disable();
+	smp_call(cpu, func, info, type);
+	preempt_enable();
+}
+EXPORT_SYMBOL(smp_call_mask);
+
+int smp_call_private(int cpu, struct __call_single_data *csd, unsigned int type)
+{
+	preempt_disable();
+
+	if (csd->func != NULL)
+		smp_call(cpu, csd->func, csd->info, type);
+
+	preempt_enable();
+
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_single_async);
+EXPORT_SYMBOL(smp_call_private);
 
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
 	unsigned long flags;
 
 	preempt_disable();
 	if ((!cond_func || cond_func(0, info)) && cpumask_test_cpu(0, mask)) {
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
+		smp_call(cpu, func, info, type);
 	}
 	preempt_enable();
 }
-EXPORT_SYMBOL(on_each_cpu_cond_mask);
+EXPORT_SYMBOL(smp_call_mask_cond);
 
 int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 {
-- 
2.27.0

