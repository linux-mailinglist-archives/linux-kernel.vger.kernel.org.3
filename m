Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7552A9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiEQSDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244572AbiEQSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ECB5506E7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810616;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pH9ndaFUwLcCF+4STt10kq3tgUIQ5wHRs0TPJoZVpQM=;
        b=Tr1CN+YioWEnN1RMa5IetA13qgEsPeFdWZSDPTWgnJ5CALQRzq+BMVjUiY5tvY5O/LP1dq
        Z9OpPAFbx2dFHZsjJI0+p0zROmtCvCelku4z44sonEFSI5fG7SBQetWcGHDdUM9b1YDwtW
        fcyu3xufgn1syiIDVddV3+dEYL5RSKs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-92RZOzQiPjGy_JshsqWxPw-1; Tue, 17 May 2022 14:03:33 -0400
X-MC-Unique: 92RZOzQiPjGy_JshsqWxPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAE9A384F805;
        Tue, 17 May 2022 18:03:32 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5307A400DFB5;
        Tue, 17 May 2022 18:03:32 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 02/11] smp: the definitions of cross call interface
Date:   Tue, 17 May 2022 14:03:17 -0400
Message-Id: <20220517180326.997129-3-dqiao@redhat.com>
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

The functions of cross CPU call interface are defined below :

int smp_call(int cpu, smp_call_func_t func, void *info,
		unsigned int flags)

int smp_call_cond(int cpu, smp_call_func_t func, void *info,
		smp_cond_func_t condf, unsigned int flags)

void smp_call_mask(const struct cpumask *mask, smp_call_func_t func,
		void *info, unsigned int flags)

void smp_call_mask_others(const struct cpumask *mask, smp_call_func_t func,
		void *info, unsigned int flags)

void smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
		void *info, smp_cond_func_t condf, unsigned int flags)

int smp_call_csd(int cpu, call_single_data_t *csd, unsigned int flags)

Basically the set of functions above can cover the requirements for
synchronous and asynchronous type of cross calls. The target CPUs
can be specified as a unique one or all of the CPUs in a given cpumask
or all of the CPUs in cpumask except the local CPU. The CPUs in cpumask
can be as many as all the onlined CPUs or a set of selected CPUs.

Although there is a constrain that cross calls cannot be called from
context with disabled interrupts, the function smp_call_csd() is
allowed to do so, which requires the callers to provide and maintain
their own preallocated call_single_data_t structures.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to
          SMP_CALL from the new macros
v2 -> v3: In order to fix the issues that Peter pointed out previously:
	  Removed smp_call_any();
	  Changed smp_call_private to smp_call_csd;
	  Added smp_call_mask_others();
	  Modified the commit comments accordingly.
 include/linux/smp.h |  30 ++++++++
 kernel/smp.c        | 172 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 94bd901b4e4c..06a20454fd53 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -148,6 +148,36 @@ do {						\
 	*(_csd) = CSD_INIT((_func), (_info));	\
 } while (0)
 
+
+/*
+ * smp_call Interface.
+ *
+ * Also see kernel/smp.c for the details.
+ */
+#define	SMP_CALL_TYPE_SYNC		CSD_TYPE_SYNC
+#define	SMP_CALL_TYPE_ASYNC		CSD_TYPE_ASYNC
+#define	SMP_CALL_TYPE_IRQ_WORK		CSD_TYPE_IRQ_WORK
+#define	SMP_CALL_TYPE_TTWU		CSD_TYPE_TTWU
+#define	SMP_CALL_TYPE_MASK		CSD_FLAG_TYPE_MASK
+
+#define	SMP_CALL_ALL	-1
+
+extern int smp_call(int cpu, smp_call_func_t func, void *info, unsigned int flags);
+
+extern int smp_call_cond(int cpu, smp_call_func_t func, void *info,
+		smp_cond_func_t condf, unsigned int flags);
+
+extern void smp_call_mask(const struct cpumask *mask, smp_call_func_t func,
+		void *info, unsigned int flags);
+
+void smp_call_mask_others(const struct cpumask *mask, smp_call_func_t func,
+                void *info, unsigned int flags);
+
+extern void smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
+		void *info, smp_cond_func_t condf, unsigned int flags);
+
+extern int smp_call_csd(int cpu, call_single_data_t *csd, unsigned int flags);
+
 /*
  * Enqueue a llist_node on the call_single_queue; be very careful, read
  * flush_smp_call_function_queue() in detail.
diff --git a/kernel/smp.c b/kernel/smp.c
index 4d192ac85a91..906be125068f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1185,3 +1185,175 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 	return sscs.ret;
 }
 EXPORT_SYMBOL_GPL(smp_call_on_cpu);
+
+
+void __smp_call_mask_cond(const struct cpumask *mask,
+		smp_call_func_t func, void *info,
+		smp_cond_func_t cond_func, bool local_cpu,
+		unsigned int flags)
+{
+}
+
+/*
+ * smp_call Interface
+ *
+ * Consolidate the cross CPU call usage from the history below:
+ *
+ * Normally this interface cannot be used with interrupts disabled or
+ * from a hardware interrupt handler or from a bottom half handler.
+ * But there are two exceptions:
+ * 1) It can be used during early boot while early_boot_irqs_disabled
+ *    is. In this scenario, you should use local_irq_save/restore()
+ *    instead of local_irq_disable/enable()
+ * 2) Because smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC) is an asynchonous
+ *    call with a preallocated csd structure, thus it can be called from
+ *    the context where interrupts are disabled.
+ */
+
+/*
+ * Parameters:
+ *
+ * cpu: If cpu == SMP_CALL_ALL, the cross call is for all the online CPUs
+ *      Otherwise, if 0 <= cpu < nr_cpu_ids, the cross call is for that cpu.
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
+int smp_call(int cpu, smp_call_func_t func, void *info, unsigned int flags)
+{
+	return smp_call_cond(cpu, func, info, NULL, flags);
+}
+EXPORT_SYMBOL(smp_call);
+
+/*
+ * Parameters:
+ *
+ * cond_func: This is a condition function cond_func(cpu, info) invoked by
+ *	      the underlying cross call mechanism only. If the return value
+ *	      from cond_func(cpu, info) is true, the cross call will be sent
+ *	      to that cpu, otherwise not.
+ *
+ * Others: see smp_call().
+ *
+ * Return: %0 on success or negative errno value on error.
+ */
+int smp_call_cond(int cpu, smp_call_func_t func, void *info,
+		    smp_cond_func_t cond_func, unsigned int flags)
+{
+	preempt_disable();
+	if (cpu == SMP_CALL_ALL) {
+		__smp_call_mask_cond(cpu_online_mask, func, info, cond_func, true, flags);
+	} else if ((unsigned int)cpu < nr_cpu_ids) {
+		__smp_call_mask_cond(cpumask_of(cpu), func, info, cond_func, true, flags);
+	} else {
+		preempt_enable();
+		pr_warn("Invalid cpu ID = %d\n", cpu);
+		return -ENXIO;
+	}
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(smp_call_cond);
+
+/*
+ * Parameters:
+ *
+ * mask: The cross call will be sent to all the CPUs in mask.
+ *
+ * Others: see smp_call().
+ */
+void smp_call_mask(const struct cpumask *mask, smp_call_func_t func,
+		void *info, unsigned int flags)
+{
+	if (mask == NULL) {
+		pr_warn("mask must not be NULL\n");
+		return;
+	}
+
+	preempt_disable();
+	__smp_call_mask_cond(mask, func, info, NULL, true, flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(smp_call_mask);
+
+/*
+ * Parameters:
+ *
+ * mask: The cross call will be sent to all the CPUs in mask except
+ *       the local CPU.
+ *
+ * Others: see smp_call().
+ *
+ * Besides, its the callers' discrimination as to whether preemption
+ * needs to be disabled or not during the call.
+ */
+void smp_call_mask_others(const struct cpumask *mask, smp_call_func_t func,
+		void *info, unsigned int flags)
+{
+	if (mask == NULL) {
+		pr_warn("mask must not be NULL\n");
+		return;
+	}
+
+	__smp_call_mask_cond(mask, func, info, NULL, false, flags);
+}
+EXPORT_SYMBOL(smp_call_mask_others);
+
+/*
+ * The combination of smp_call_cond() and smp_call_mask()
+ */
+void smp_call_mask_cond(const struct cpumask *mask,
+		smp_call_func_t func, void *info,
+		smp_cond_func_t cond_func,
+		unsigned int flags)
+{
+	if (!mask) {
+		/*
+		 * If mask is NULL meaning for all CPUs,
+		 * then cond_func must be provided.
+		 */
+		WARN_ON_ONCE(!cond_func);
+		mask = cpu_online_mask;
+	}
+
+	preempt_disable();
+	__smp_call_mask_cond(mask, func, info, cond_func, true, flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(smp_call_mask_cond);
+
+/*
+ * This function provides an alternative way of sending a cross call to
+ * only one destination CPU with a caller pre-allocated private csd instead
+ * of using the csd resource in the cross call mechanism. Thus it is the
+ * callers' responsibity to setup and maintain its own private csd.
+ *
+ * Because of that, this function can be used from the contexts with disabled
+ * interrupts.
+ *
+ * Parameters
+ *
+ * cpu:   Must be a positive value less than nr_cpu_id.
+ * csd:   The private csd provided by the callers.
+ *
+ * Others: see smp_call().
+ */
+int smp_call_csd(int cpu, call_single_data_t *csd, unsigned int flags)
+{
+	return 0;
+}
+EXPORT_SYMBOL(smp_call_csd);
-- 
2.27.0

