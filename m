Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805464843B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiADOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiADOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:50:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B38CC06179C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:50:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17C40B81125
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B5DC36AEF;
        Tue,  4 Jan 2022 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307812;
        bh=ltlg5jlfdPZvcV9QPEZ3osCQGIe/VIdkjKzyZPSKghU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ImV2ZppcLJ6/4BTYYOxGlDKPxS20UcwhHQJRKAB/ev4JduitpfzPos6Y3+OjizkZi
         h2BbypM5+TmYhMYzZeAyeg+sAbzh/VIvCOl5Tvcj/PRe4Gyq9/yW7JCl6yIZC6qMZK
         z3QfP55HiTXI6E5AjqZVI8y8Je/BK8nh39QZb+S6T1L1U/5jUM+WNW1n1I8V0z0Thv
         I7OZXxtzB2w/ccEn0HsLUGKWLjCWEMlwZdNcUztd3SacG2UU6CL3XEdgYEDOkdKgDE
         +pNxKa6+uLMvYpa/sgcEFcv41BrLlF6K8xsBTFEHhpyDaHQWOoDBeDo9HW99aoVlWC
         khmKsi6shEpJA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 6/8] sched/isolation: Consolidate error handling
Date:   Tue,  4 Jan 2022 15:49:42 +0100
Message-Id: <20220104144944.1278663-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104144944.1278663-1-frederic@kernel.org>
References: <20220104144944.1278663-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Centralize the mask freeing and return value for the error path. This
makes potential leaks more visible.

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
---
 kernel/sched/isolation.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 23085e665faa..828dacec483e 100644
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
-- 
2.25.1

