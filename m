Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ABF5020A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbiDOCts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiDOCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF57EA76F2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649990833;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A2jDo90MdeTNOcCPPQDzuJesgdoSejoq+ceYld8MJ/c=;
        b=AV/7vugcenMUEB+MImOqBjyVdFbSCsDWfyNGxf8qJgni4ljr6YfuQIc3nLKCFrZW1ujIWE
        IM6McdY/nNp4uBppablVcCnkVUKTfAYDJ76UDdK7kO5T2jVh/b0c90FrUslyQ6dwIuaddW
        JXGagTKrqhf5tyaBlFix5RPPwit58MU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-1Ou7AM3NM3iuY1Jtzioa8w-1; Thu, 14 Apr 2022 22:47:10 -0400
X-MC-Unique: 1Ou7AM3NM3iuY1Jtzioa8w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F1B629AB3E6;
        Fri, 15 Apr 2022 02:47:10 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.8.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC4CE440ADA;
        Fri, 15 Apr 2022 02:47:09 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH 02/11] smp: cross call interface
Date:   Thu, 14 Apr 2022 22:46:52 -0400
Message-Id: <20220415024701.876364-3-dqiao@redhat.com>
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

The functions of cross CPU call interface are defined below :

int smp_xcall(int cpu, smp_call_func_t func, void *info,
		unsigned int flags)

int smp_xcall_cond(int cpu, smp_call_func_t func, void *info,
		smp_cond_func_t condf, unsigned int flags)

void smp_xcall_mask(const struct cpumask *mask, smp_call_func_t func,
		void *info, unsigned int flags)

void smp_xcall_mask_cond(const struct cpumask *mask, smp_call_func_t func,
		void *info, smp_cond_func_t condf, unsigned int flags)

int smp_xcall_private(int cpu, call_single_data_t *csd, unsigned int flags)

int smp_xcall_any(const struct cpumask *mask, smp_call_func_t func,
		void *info, unsigned int flags)

The motivation of submitting this patch set is intended to make the
existing cross CPU call mechanism become a bit more formal interface
and more friendly to the kernel developers.

Basically the minimum set of functions below can satisfy any demand
for cross CPU call from kernel consumers. For the sack of simplicity
self-explanatory and less code redundancy no ambiguity, the functions
in this interface are renamed, simplified, or eliminated. But they
are still inheriting the same semantics and parameter lists from their
previous version.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
 include/linux/smp.h |  30 +++++++++
 kernel/smp.c        | 156 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 31811da856a3..12d6efef34f7 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -161,6 +161,36 @@ do {						\
 	*(_csd) = CSD_INIT((_func), (_info));	\
 } while (0)
 
+
+/*
+ * smp_xcall Interface.
+ *
+ * Also see kernel/smp.c for the details.
+ */
+#define	XCALL_TYPE_SYNC		CSD_TYPE_SYNC
+#define	XCALL_TYPE_ASYNC	CSD_TYPE_ASYNC
+#define	XCALL_TYPE_IRQ_WORK	CSD_TYPE_IRQ_WORK
+#define	XCALL_TYPE_TTWU		CSD_TYPE_TTWU
+#define	XCALL_TYPE_MASK		CSD_FLAG_TYPE_MASK
+
+#define	XCALL_ALL		-1
+
+extern int smp_xcall(int cpu, smp_call_func_t func, void *info, unsigned int flags);
+
+extern int smp_xcall_cond(int cpu, smp_call_func_t func, void *info,
+		smp_cond_func_t condf, unsigned int flags);
+
+extern void smp_xcall_mask(const struct cpumask *mask, smp_call_func_t func,
+		void *info, unsigned int flags);
+
+extern void smp_xcall_mask_cond(const struct cpumask *mask, smp_call_func_t func,
+		void *info, smp_cond_func_t condf, unsigned int flags);
+
+extern int smp_xcall_private(int cpu, call_single_data_t *csd, unsigned int flags);
+
+extern int smp_xcall_any(const struct cpumask *mask, smp_call_func_t func,
+		void *info, unsigned int flags);
+
 /*
  * Enqueue a llist_node on the call_single_queue; be very careful, read
  * flush_smp_call_function_queue() in detail.
diff --git a/kernel/smp.c b/kernel/smp.c
index b2b3878f0330..6183a3586329 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1170,3 +1170,159 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 	return sscs.ret;
 }
 EXPORT_SYMBOL_GPL(smp_call_on_cpu);
+
+
+void __smp_call_mask_cond(const struct cpumask *mask,
+		smp_call_func_t func, void *info,
+		smp_cond_func_t cond_func,
+		unsigned int flags)
+{
+}
+
+/*
+ * smp_xcall Interface
+ *
+ * Consolidate the cross CPU call usage from the history below:
+ *
+ * Normally this interface cannot be used with interrupts disabled or
+ * from a hardware interrupt handler or from a bottom half handler.
+ * But there are two exceptions:
+ * 1) It can be used during early boot while early_boot_irqs_disabled
+ *    is. In this scenario, you should use local_irq_save/restore()
+ *    instead of local_irq_disable/enable()
+ * 2) Because smp_xcall_private(cpu, csd, XCALL_TYPE_ASYNC) is an asynchonous
+ *    call with a preallocated csd structure, thus it can be called from
+ *    the context where interrupts are disabled.
+ */
+
+/*
+ * Parameters:
+ *
+ * cpu: If cpu >=0 && cpu < nr_cpu_ids, the cross call is for that cpu.
+ *      If cpu == -1, the cross call is for all the online CPUs
+ *
+ * func: It is the cross function that the destination CPUs need to execute.
+ *       This function must be fast and non-blocking.
+ *
+ * info: It is the parameter to func().
+ *
+ * flags: The flags specify the manner the cross call is performaned in terms
+ *	  of synchronous or asynchronous.
+ *
+ *	  A synchronous cross call will not return immediately until all
+ *	  the destination CPUs have executed func() and responded the call.
+ *
+ *	  An asynchrouse cross call will return immediately as soon as it
+ *	  has fired all the cross calls and run func() locally if needed
+ *	  regardless the status of the target CPUs.
+ *
+ * Return: %0 on success or negative errno value on error.
+ */
+int smp_xcall(int cpu, smp_call_func_t func, void *info, unsigned int flags)
+{
+	return smp_xcall_cond(cpu, func, info, NULL, flags);
+}
+EXPORT_SYMBOL(smp_xcall);
+
+/*
+ * Parameters:
+ *
+ * cond_func: This is a condition function cond_func(cpu, info) invoked by
+ *	      the underlying cross call mechanism only. If the return value
+ *	      from cond_func(cpu, info) is true, the cross call will be sent
+ *	      to that cpu, otherwise the call will not be sent.
+ *
+ * Others: see smp_xcall().
+ *
+ * Return: %0 on success or negative errno value on error.
+ */
+int smp_xcall_cond(int cpu, smp_call_func_t func, void *info,
+		    smp_cond_func_t cond_func, unsigned int flags)
+{
+	preempt_disable();
+	if (cpu == XCALL_ALL) {
+		__smp_call_mask_cond(cpu_online_mask, func, info, cond_func, flags);
+	} else if ((unsigned int)cpu < nr_cpu_ids)
+		__smp_call_mask_cond(cpumask_of(cpu), func, info, cond_func, flags);
+	else {
+		preempt_enable();
+		pr_warn("Invalid cpu ID = %d\n", cpu);
+		return -ENXIO;
+	}
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(smp_xcall_cond);
+
+/*
+ * Parameters:
+ *
+ * mask: This is the bitmap of CPUs to which the cross call will be sent.
+ *
+ * Others: see smp_xcall().
+ */
+void smp_xcall_mask(const struct cpumask *mask, smp_call_func_t func,
+		void *info, unsigned int flags)
+{
+	preempt_disable();
+	__smp_call_mask_cond(mask, func, info, NULL, flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(smp_xcall_mask);
+
+/*
+ * The combination of smp_xcall_cond() and smp_xcall_mask()
+ */
+void smp_xcall_mask_cond(const struct cpumask *mask,
+		smp_call_func_t func, void *info,
+		smp_cond_func_t cond_func,
+		unsigned int flags)
+{
+	preempt_disable();
+	__smp_call_mask_cond(mask, func, info, cond_func, flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(smp_xcall_mask_cond);
+
+/*
+ * This function provides an alternative way of sending a xcall call to
+ * only one CPU with a private csd instead of using the csd resource of
+ * the xcall. But it is the callers' responsibity to setup and maintain
+ * its private call_single_data_t struture.
+ *
+ * Because the call is asynchonous with a preallocated csd structure, thus
+ * it can be called from contexts with disabled interrupts.
+ *
+ * Parameters
+ *
+ * cpu:   Must be a positive value less than nr_cpu_id.
+ * csd:   The private csd provided by the caller.
+ *
+ * Others: see smp_xcall().
+ */
+int smp_xcall_private(int cpu, call_single_data_t *csd, unsigned int flags)
+{
+	return 0;
+}
+EXPORT_SYMBOL(smp_xcall_private);
+
+/*
+ * Parameters:
+ *
+ * mask:  Run func() on one of the given CPUs in mask if it is oneline.
+ *        CPU selection preference (from the original comments for
+ *        smp_call_function_any()) :
+ *          1) current cpu if in @mask
+ *          2) any cpu of current node if in @mask
+ *          3) any other online cpu in @mask
+ *
+ * Others, see smp_xcall().
+ *
+ * Returns 0 on success, else a negative status code (if no cpus were online).
+ */
+int smp_xcall_any(const struct cpumask *mask, smp_call_func_t func,
+		void *info, unsigned int flags)
+{
+	return 0;
+}
+EXPORT_SYMBOL(smp_xcall_any);
-- 
2.27.0

