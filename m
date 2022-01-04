Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D6E4843B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiADOuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:50:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42064 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiADOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:50:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F0761488
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E561C36AED;
        Tue,  4 Jan 2022 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307816;
        bh=jPTZQrqO8CoTMJAUHYLOdsNJt5UYV2szJE+ZXdnYbJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sA/iL8kDN433Yv7ZY33MaiDyGA3Sj739XEXsQFOnRFZFZo3PGdovVSQ1lcV+oAll8
         688ir/ey47It/8ZL8u4ALNWC91RAMCOgsBTQ2qO3TEChUSsVc2ssIgI79iD+Mmzfof
         v58sk8z9RXPDT4LlBXXq9gQxOlTyVRBkv9eqxs8Il1k+crr8urg98LCVvf+R0f3xny
         cBeyl8/DsVgYZl2+viqNPVa9E+EunVzUjLOhgbQfb8CiqWC2CDX4N9fmnvNtemidtT
         WAEVc7EDukoSSUAcTNPhO5hVv5A5DO3Pu9Lt2N00njqv1NBXNufut40q5bz23WdGsv
         clUz+zOrfG/qg==
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
Subject: [PATCH 7/8] sched/isolation: Fix housekeeping_mask memory leak
Date:   Tue,  4 Jan 2022 15:49:43 +0100
Message-Id: <20220104144944.1278663-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104144944.1278663-1-frederic@kernel.org>
References: <20220104144944.1278663-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "nohz_full=" or "isolcpus=nohz" are called with CONFIG_NO_HZ_FULL=n,
housekeeping_mask doesn't get freed despite it being unused if
housekeeping_setup() is called for the first time.

Check this scenario first to fix this, so that no useless allocation
is performed.

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
 kernel/sched/isolation.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 828dacec483e..883eee9fae22 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -94,6 +94,14 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
 	int err = 0;
 
+	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
+		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
+			pr_warn("Housekeeping: nohz unsupported."
+				" Build with CONFIG_NO_HZ_FULL\n");
+			return 0;
+		}
+	}
+
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
 	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
@@ -123,15 +131,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		}
 	}
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
-		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
-			tick_nohz_full_setup(non_housekeeping_mask);
-		} else {
-			pr_warn("Housekeeping: nohz unsupported."
-				" Build with CONFIG_NO_HZ_FULL\n");
-			goto free_housekeeping_staging;
-		}
-	}
+	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK))
+		tick_nohz_full_setup(non_housekeeping_mask);
 
 	housekeeping_flags |= flags;
 	err = 1;
-- 
2.25.1

