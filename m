Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F234BA906
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbiBQS5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244691AbiBQS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B15D184;
        Thu, 17 Feb 2022 10:56:49 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nUF53BsGHL+u33dBoU9ttT7k66xxkdNEHsP1HfU69c=;
        b=bsliCJ24Hlg7P1oeGl8rySXZtM/rLcD6JZ3y2VBILQACKZAUYd6hj9U8PD7KP44Wp1e8D8
        5BaWizVEIGyLPP9pmBpG4XBMuJFQmHHUd4prpz2n2MMPPMuzrlmD5LCF0zMCwNAawzZL+e
        fQpDrE7vYQLo1woHyeZUgh9QPqSGWMZd4iJnBXe9KRX/qSbEEirmw4qe8yNl5bg60HwDpB
        cltxxaEKUlsOATATMVXzpI3j/7FHg3AGSJAsmef8sMgk7iCetQ9Z1suWdXFCjzyFQ5Dhqv
        UwdASno31YrdW50XMYqlkyctcm7ra1/B0M3X9bG+njul0uCZCFkoDbDXqF8LOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nUF53BsGHL+u33dBoU9ttT7k66xxkdNEHsP1HfU69c=;
        b=a+Rni78vV6QhndPk0BCYn6fiuj5iQnQ6F4VNYGVAfH/8mFkwFDof5LMalQbo4A2oH30YSS
        1Lj+g7x27YcIDEBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Consolidate check for housekeeping
 minimum service
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207155910.527133-6-frederic@kernel.org>
References: <20220207155910.527133-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164512420688.16921.9890491331015314578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6367b600e31c6b211eadee7bf7f4ed8c755e9176
Gitweb:        https://git.kernel.org/tip/6367b600e31c6b211eadee7bf7f4ed8c755e9176
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 07 Feb 2022 16:59:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:55 +01:00

sched/isolation: Consolidate check for housekeeping minimum service

There can be two subsequent calls to housekeeping_setup() due to
"nohz_full=" and "isolcpus=" that can mix up.  The two passes each have
their own way to deal with an empty housekeeping set of CPUs.
Consolidate this part and remove the awful "tmp" based naming.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220207155910.527133-6-frederic@kernel.org
---
 kernel/sched/isolation.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a735d9e..23085e6 100644
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
