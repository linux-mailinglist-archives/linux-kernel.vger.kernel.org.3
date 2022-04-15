Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5655020AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348824AbiDOCtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344111AbiDOCtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ACACA76D6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649990835;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvxIABRQwBgPVkFOQJ1JeKKDimvJbva/9785OAMrw8c=;
        b=DHOX0nwhiNaYN/TROFXm+T3JUNS/1k0gPS+M3N/GDR3/IbDigiRAHuv6b9aLogUfE2R0b/
        AY3j8h9bLsSGof3DE6YmyYM6xiq7iNWl+QeB8fI/JiPYZUT562K5qjXPQ/oWOovgJOqVyn
        YLvEdqlvsw3bjYm0hTO9GVLGKi/FL1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-q48ji5UqN56ymmG_CxYnSQ-1; Thu, 14 Apr 2022 22:47:14 -0400
X-MC-Unique: q48ji5UqN56ymmG_CxYnSQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 506FB85A5BE;
        Fri, 15 Apr 2022 02:47:13 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.8.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEA11440ADA;
        Fri, 15 Apr 2022 02:47:12 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH 04/11] smp: replace smp_call_function_single() with smp_xcall()
Date:   Thu, 14 Apr 2022 22:46:54 -0400
Message-Id: <20220415024701.876364-5-dqiao@redhat.com>
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

Eliminated the percpu global csd_data and temporarily hook up
to smp_xcall().

There is no obvious reason or evidence that the differentiation
of xcall of single recipient from that of multiple recipients
can exploit noticeable performance gaining. If something can be
optimized on this matter, it might be from the interrupt level
which has been already addressed by arch_send_call_function_single_ipi()
and arch_send_call_function_ipi_mask(). In fact, both have been
taken in to account from smp_call_function_many_cond().

So, it is appropriate to make this change as part of the cross
call interface.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
 kernel/smp.c | 74 ++++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 3f9bc5ae7180..42ecaf960963 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -399,8 +399,6 @@ static __always_inline void csd_unlock(struct __call_single_data *csd)
 	smp_store_release(&csd->node.u_flags, 0);
 }
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
-
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
@@ -634,6 +632,9 @@ void flush_smp_call_function_from_idle(void)
 }
 
 /*
+ * This is a temporarily hook up. This function will be eliminated
+ * with the last patch in this series.
+ *
  * smp_call_function_single - Run a function on a specific CPU
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
@@ -642,59 +643,21 @@ void flush_smp_call_function_from_idle(void)
  * Returns 0 on success, else a negative status code.
  */
 int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
-			     int wait)
+			int wait)
 {
-	call_single_data_t *csd;
-	call_single_data_t csd_stack = {
-		.node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
-	};
-	int this_cpu;
-	int err;
-
-	/*
-	 * prevent preemption and reschedule on another processor,
-	 * as well as CPU removal
-	 */
-	this_cpu = get_cpu();
-
-	/*
-	 * Can deadlock when called with interrupts disabled.
-	 * We allow cpu's that are not yet online though, as no one else can
-	 * send smp call function interrupt to this cpu and as such deadlocks
-	 * can't happen.
-	 */
-	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress);
-
-	/*
-	 * When @wait we can deadlock when we interrupt between llist_add() and
-	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
-	 * csd_lock() on because the interrupt context uses the same csd
-	 * storage.
-	 */
-	WARN_ON_ONCE(!in_task());
-
-	csd = &csd_stack;
-	if (!wait) {
-		csd = this_cpu_ptr(&csd_data);
-		csd_lock(csd);
-	}
-
-	csd->func = func;
-	csd->info = info;
-#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-	csd->node.src = smp_processor_id();
-	csd->node.dst = cpu;
-#endif
+	unsigned int flags = 0;
 
-	err = generic_exec_single(cpu, csd);
+	if ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu))
+		return -ENXIO;
 
 	if (wait)
-		csd_lock_wait(csd);
+		flags = XCALL_TYPE_SYNC;
+	else
+		flags = XCALL_TYPE_ASYNC;
 
-	put_cpu();
+	smp_xcall(cpu, func, info, flags);
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
@@ -1159,6 +1122,19 @@ void __smp_call_mask_cond(const struct cpumask *mask,
 		smp_cond_func_t cond_func,
 		unsigned int flags)
 {
+	bool wait = false;
+
+	if (flags == XCALL_TYPE_SYNC)
+		wait = true;
+
+	preempt_disable();
+
+	/*
+	 * This is temporarily hook. The function smp_call_function_many_cond()
+	 * will be inlined here with the last patch in this series.
+	 */
+	smp_call_function_many_cond(mask, func, info, wait, cond_func);
+	preempt_enable();
 }
 
 /*
-- 
2.27.0

