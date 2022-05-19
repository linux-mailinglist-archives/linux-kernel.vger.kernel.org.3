Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAF52DEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbiESUuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbiESUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 153FE9AE51
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652993394;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdxtfUaqt+ckQV5UNvImiFwAdFM46p7Vdz5WK1RinCQ=;
        b=FlvLQD5JW8ce6g/kN5xKxUpF2PZ56qNMofEncieR9H40awhXlvjm+jeybgVlbGxzqbSCq3
        q5oagP7BTshr79apyMrpLn/4ZSG22iQtj+5RjlucFaJTO6C0Nae3ExI9nBEPA6mh5XF1Ns
        61Zs/LtqDEhKeyR2C77Uvp0jp7B2Vwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-bag73ySPPNu3X3oQiiNn6g-1; Thu, 19 May 2022 16:49:52 -0400
X-MC-Unique: bag73ySPPNu3X3oQiiNn6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A609185A79C;
        Thu, 19 May 2022 20:49:52 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.35.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B349D1121314;
        Thu, 19 May 2022 20:49:51 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v4 04/11] smp: replace smp_call_function_single() with  smp_call()
Date:   Thu, 19 May 2022 16:49:36 -0400
Message-Id: <20220519204943.1079578-5-dqiao@redhat.com>
In-Reply-To: <20220519204943.1079578-1-dqiao@redhat.com>
References: <20220519204943.1079578-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminated the percpu global csd_data and temporarily hooked up
smp_call_function_single() to smp_call().

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to
          SMP_CALL from the new macros

 kernel/smp.c | 74 ++++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 101a48d1d8af..8fdea9547502 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -414,8 +414,6 @@ static __always_inline void csd_unlock(struct __call_single_data *csd)
 	smp_store_release(&csd->node.u_flags, 0);
 }
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
-
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
@@ -649,6 +647,9 @@ void flush_smp_call_function_from_idle(void)
 }
 
 /*
+ * This is a temporarily hook up. This function will be eliminated
+ * with a later patch in this series.
+ *
  * smp_call_function_single - Run a function on a specific CPU
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
@@ -657,59 +658,21 @@ void flush_smp_call_function_from_idle(void)
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
+	unsigned int flags = 0;
 
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
-
-	err = generic_exec_single(cpu, csd);
+	if ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu))
+		return -ENXIO;
 
 	if (wait)
-		csd_lock_wait(csd);
+		flags = SMP_CALL_TYPE_SYNC;
+	else
+		flags = SMP_CALL_TYPE_ASYNC;
 
-	put_cpu();
+	smp_call(cpu, func, info, flags);
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
@@ -1175,6 +1138,19 @@ void __smp_call_mask_cond(const struct cpumask *mask,
 		smp_cond_func_t cond_func, bool local_cpu,
 		unsigned int flags)
 {
+	bool wait = false;
+
+	if (flags == SMP_CALL_TYPE_SYNC)
+		wait = true;
+
+	preempt_disable();
+
+	/*
+	 * This is temporarily hook. The function smp_call_function_many_cond()
+	 * will be inlined here with a later patch in this series.
+	 */
+	smp_call_function_many_cond(mask, func, info, local_cpu, wait, cond_func);
+	preempt_enable();
 }
 
 /*
-- 
2.27.0

