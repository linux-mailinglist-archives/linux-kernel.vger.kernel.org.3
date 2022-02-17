Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE534BA8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiBQS5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbiBQS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7254A5C86F;
        Thu, 17 Feb 2022 10:56:48 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ek8qk0a8yItQIrPvuDv4pBp0JowKxV1QSA6uWTZltg4=;
        b=IkLU29Eo1YW3Y015KCSnDOzh/VBXeVbT9K0hClZGLf9fsCU8fga7kgin3pHuObwzrSlGd0
        S0akac4VXpv15w9Ol/+acuPaHamOsMVQirRnm/fDWh9/c4QtTp6XspzWOzVwfD984MDUs0
        4FXTofdiklBvbcx77CcGF9E4E7FpVdjmVcT/ewpvABtJ2emQzUtlrx3AqZ3kxfvDpxWTo6
        kpfOKDTWOgOTM7EfeDDi6PvvEFdwRMCsbr/z7DaPJNsvUyQ3iE4NoPc4IP2vF3MIJxuHvp
        6xps+noFHbhXre8JLIfA2sjamvpt6eMquuYqv9OdJgPV2Zc20a0tDMhCD+yo0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124207;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ek8qk0a8yItQIrPvuDv4pBp0JowKxV1QSA6uWTZltg4=;
        b=4ubnC260JGGb9pfbXCpjbdo4Y6PrnncdVkFOy9yFv0jsve6EKOs9c/HUmIz8RT/Khw+GdP
        zpDeS/pDgboUopDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Consolidate error handling
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207155910.527133-7-frederic@kernel.org>
References: <20220207155910.527133-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164512420591.16921.6984249176538271826.tip-bot2@tip-bot2>
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

Commit-ID:     0cd3e59de1f53978873669c7c8225ec13e88c3ae
Gitweb:        https://git.kernel.org/tip/0cd3e59de1f53978873669c7c8225ec13e88c3ae
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 07 Feb 2022 16:59:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:55 +01:00

sched/isolation: Consolidate error handling

Centralize the mask freeing and return value for the error path. This
makes potential leaks more visible.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220207155910.527133-7-frederic@kernel.org
---
 kernel/sched/isolation.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 23085e6..828dace 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -92,12 +92,12 @@ void __init housekeeping_init(void)
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
+	int err = 0;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
 	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
-		free_bootmem_cpumask_var(non_housekeeping_mask);
-		return 0;
+		goto free_non_housekeeping_mask;
 	}
 
 	alloc_bootmem_cpumask_var(&housekeeping_staging);
@@ -119,30 +119,29 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 	} else {
 		if (!cpumask_equal(housekeeping_staging, housekeeping_mask)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
-			free_bootmem_cpumask_var(housekeeping_staging);
-			free_bootmem_cpumask_var(non_housekeeping_mask);
-			return 0;
+			goto free_housekeeping_staging;
 		}
 	}
 
-	free_bootmem_cpumask_var(housekeeping_staging);
-
 	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
 		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 			tick_nohz_full_setup(non_housekeeping_mask);
 		} else {
 			pr_warn("Housekeeping: nohz unsupported."
 				" Build with CONFIG_NO_HZ_FULL\n");
-			free_bootmem_cpumask_var(non_housekeeping_mask);
-			return 0;
+			goto free_housekeeping_staging;
 		}
 	}
 
 	housekeeping_flags |= flags;
+	err = 1;
 
+free_housekeeping_staging:
+	free_bootmem_cpumask_var(housekeeping_staging);
+free_non_housekeeping_mask:
 	free_bootmem_cpumask_var(non_housekeeping_mask);
 
-	return 1;
+	return err;
 }
 
 static int __init housekeeping_nohz_full_setup(char *str)
