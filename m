Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4294AC4BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386916AbiBGQBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350663AbiBGP7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:59:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03BC0401D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:59:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD6461515
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C42C340F3;
        Mon,  7 Feb 2022 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644249583;
        bh=TPKKeEGOrqR+X2YLdEaXENJC6749BoVZ0uCtQo07pYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1g69Va2WuBl3UIzqBDK08oUzBc7Q3fC1wysIdXxK6sSWxZP4T13KrQN8jaCiEqj3
         OX2yKEwcC6isxpzkcB95u/b/0iox6kgC8sQlJxagjVOt9WlaGJcvxTzVLwcoKp6Z6M
         Y24+fEbb6ciNol/8HVyOoFdMU/arSk7U+5g2bUlABaSsqW+U1c3UypuToO2YwXQ/Vc
         xDmdvtjGvZ8SX1q9BIu+W7B0U33wVNVsIgVdEx5JrLK+eC3tCJdNSF4nzjjb5tJ7Fl
         BBywy0/piEIswQRWFwsBw7ApcImf+XD38cfGPQnPsJbcuRQYh21qtCoAashnWgCnoW
         cSlBXD+huhFCg==
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
Subject: [PATCH 7/8] sched/isolation: Fix housekeeping_mask memory leak
Date:   Mon,  7 Feb 2022 16:59:09 +0100
Message-Id: <20220207155910.527133-8-frederic@kernel.org>
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

If "nohz_full=" or "isolcpus=nohz" are called with CONFIG_NO_HZ_FULL=n,
housekeeping_mask doesn't get freed despite it being unused if
housekeeping_setup() is called for the first time.

Check this scenario first to fix this, so that no useless allocation
is performed.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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

