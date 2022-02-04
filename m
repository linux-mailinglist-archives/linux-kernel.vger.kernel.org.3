Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFA4A99A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbiBDNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:05:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50418 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346961AbiBDNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:05:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1AD9ACE22C9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92778C340EF;
        Fri,  4 Feb 2022 13:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643979903;
        bh=c6M2TbQIKTl0es8Fi4IczYM3m7IAeA0YfoCYz403STI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ag87pJ2a9Wkre7e7jEHNkRb7xoZR6W5kr0Qc+Bp+6untwmxaZ82DpeJXvGhu6LBOZ
         YSDpOY6SDwrI1vFysqXYNeVXcbdn/eTqJUHPZhZ+bjfNjO3EgyJoVEOlhPUwk1TIjh
         qz3RXXVGovhfF+1VKvj90crOJUtGuqiWQBjjz2xj4hG/oDDh+TvYdddRSfGmGFD2NC
         jRm1fWpNnUnE8Hqx9H3ADQifMRDPSZYzFnkqGOOA3vAdGVmjWftaco0D0aRWERtTMN
         SylkJuHUOYBJPNGLO5QqXEYWh6INvfSpda86Jh81+jw04WSjF65cndRTDlzEHyMVDn
         RnBnCJgyMOURg==
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
Subject: [PATCH 6/8] sched/isolation: Consolidate error handling
Date:   Fri,  4 Feb 2022 14:04:31 +0100
Message-Id: <20220204130433.488085-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204130433.488085-1-frederic@kernel.org>
References: <20220204130433.488085-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Centralize the mask freeing and return value for the error path. This
makes potential leaks more visible.

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

