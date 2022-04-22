Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062550C1F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiDVWAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiDVWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C93781DB2EA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650660181;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HiNB6iLIf8FsYqufDVUIiSknSL5xFdrV7f9Mrot/NEI=;
        b=RtV2dqHHfAA8lqHzyEU+z4rnHrqEzFMqpfCibA3G2W84Kfmx0d/LxDJ1L4UqOjSn57fxij
        14BoLIYlA/teWZQEImMs0JEZau3+xxtL07rEoNc+knx6RVO7JZgFdPtijorNm+Uxn/tqqg
        T5kYbhGkViRD+BXcdWX6io/MpeNftnI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-In9Z-SzxPrCriq2YgYhQ6A-1; Fri, 22 Apr 2022 16:00:58 -0400
X-MC-Unique: In9Z-SzxPrCriq2YgYhQ6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0C7B8339B7;
        Fri, 22 Apr 2022 20:00:51 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.19.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8573FC44B0B;
        Fri, 22 Apr 2022 20:00:51 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v2 03/11] smp: eliminate SCF_WAIT and SCF_RUN_LOCAL
Date:   Fri, 22 Apr 2022 16:00:32 -0400
Message-Id: <20220422200040.93813-4-dqiao@redhat.com>
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

The commit a32a4d8a815c ("smp: Run functions concurrently in
smp_call_function_many_cond()") was to improve the concurrent
of the cross call execution between local and remote. The change
in smp_call_function_many_cond() did what was intended, but the
new macro SCF_WAIT and SCF_RUN_LOCAL and the code around them
to handle local call were not unnecessary because the modified
function smp_call_function_many() was able to handle the local
cross call. So these two macros can be eliminated and the code
implemented around that can be removed as well.

Also this patch fixed a issue of a comparison between an integer
and a unsigned integer in smp_call_function_many_cond().

The changes with this patch and the changes made in subsequent
patches will eventually help eliminate the set of on_each_cpu*
functions.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: removed 'x' from the function names and change XCALL to SMP_CALL from the new macros

 kernel/smp.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index b1e6a8f77a9e..22e8f2bd770b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -787,23 +787,13 @@ int smp_call_function_any(const struct cpumask *mask,
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
+					bool wait,
 					smp_cond_func_t cond_func)
 {
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
-	bool wait = scf_flags & SCF_WAIT;
 	bool run_remote = false;
 	bool run_local = false;
 	int nr_cpus = 0;
@@ -829,14 +819,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	WARN_ON_ONCE(!in_task());
 
 	/* Check if we need local execution. */
-	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
+	if (cpumask_test_cpu(this_cpu, mask))
 		run_local = true;
 
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
 		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (cpu < nr_cpu_ids)
+	if ((unsigned int)cpu < nr_cpu_ids)
 		run_remote = true;
 
 	if (run_remote) {
@@ -911,12 +901,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
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
@@ -925,7 +911,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
-	smp_call_function_many_cond(mask, func, info, wait * SCF_WAIT, NULL);
+	smp_call_function_many_cond(mask, func, info, wait, NULL);
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
@@ -1061,13 +1047,9 @@ void __init smp_init(void)
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask)
 {
-	unsigned int scf_flags = SCF_RUN_LOCAL;
-
-	if (wait)
-		scf_flags |= SCF_WAIT;
 
 	preempt_disable();
-	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
+	smp_call_function_many_cond(mask, func, info, wait, cond_func);
 	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
-- 
2.27.0

