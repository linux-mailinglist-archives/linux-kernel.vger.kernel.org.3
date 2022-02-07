Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469134AC4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386894AbiBGQBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344207AbiBGP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:59:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC7FC0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:59:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC02614F5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC96BC340F3;
        Mon,  7 Feb 2022 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644249576;
        bh=iRj5pHdf6eWkZ1PAF3fLYv97Djo5eOJinCTnYYByUDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnCSdsPFJ5f44gKLTXUfECtabOQHR+4nOXU83UkyYaGQ5Ypy2H/dwHMu3PDyWQ6gf
         3VQ2XJ+Qi0glfn/tgzeOkMC5EnpJossH5loLqo+jtv+1+DfrxyMpfSYIgSV3qIQnja
         Kt1sS5XHziWA2NZD2D5YqQkrDElGQCzC46L+S+iNUhabzuPx857UmMVX/n7wXv6sgz
         n8hRFrFvCeE8YYPA27MPglXLLGyN0yMedDkj/m4BEEjCJ/UQRPmKI9AsxwLbO/53cy
         4hTibppB0jIJdOpYPkKCYuZNKCJNLC6hMbau8tRdh8Qid6LZhIll8Ivyx5xL2qlPNL
         SQVLzqJRqHIXw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 5/8] sched/isolation: Consolidate check for housekeeping minimum service
Date:   Mon,  7 Feb 2022 16:59:07 +0100
Message-Id: <20220207155910.527133-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207155910.527133-1-frederic@kernel.org>
References: <20220207155910.527133-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be two subsequent calls to housekeeping_setup() due to
"nohz_full=" and "isolcpus=" that can mix up.  The two passes each have
their own way to deal with an empty housekeeping set of CPUs.
Consolidate this part and remove the awful "tmp" based naming.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Paul E. McKenney  <paulmck@kernel.org>
---
 kernel/sched/isolation.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a735d9e229dd..23085e665faa 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -91,8 +91,7 @@ void __init housekeeping_init(void)
 
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
-	cpumask_var_t non_housekeeping_mask;
-	cpumask_var_t tmp;
+	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
 	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
@@ -101,32 +100,32 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		return 0;
 	}
 
-	alloc_bootmem_cpumask_var(&tmp);
-	if (!housekeeping_flags) {
-		alloc_bootmem_cpumask_var(&housekeeping_mask);
-		cpumask_andnot(housekeeping_mask,
-			       cpu_possible_mask, non_housekeeping_mask);
+	alloc_bootmem_cpumask_var(&housekeeping_staging);
+	cpumask_andnot(housekeeping_staging,
+		       cpu_possible_mask, non_housekeeping_mask);
 
-		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
-		if (cpumask_empty(tmp)) {
+	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
+		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
+		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+		if (!housekeeping_flags) {
 			pr_warn("Housekeeping: must include one present CPU, "
 				"using boot CPU:%d\n", smp_processor_id());
-			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
-			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		}
+	}
+
+	if (!housekeeping_flags) {
+		alloc_bootmem_cpumask_var(&housekeeping_mask);
+		cpumask_copy(housekeeping_mask, housekeeping_staging);
 	} else {
-		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
-		if (cpumask_empty(tmp))
-			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
-		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
-		if (!cpumask_equal(tmp, housekeeping_mask)) {
+		if (!cpumask_equal(housekeeping_staging, housekeeping_mask)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
-			free_bootmem_cpumask_var(tmp);
+			free_bootmem_cpumask_var(housekeeping_staging);
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
 		}
 	}
-	free_bootmem_cpumask_var(tmp);
+
+	free_bootmem_cpumask_var(housekeeping_staging);
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
 		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
-- 
2.25.1

