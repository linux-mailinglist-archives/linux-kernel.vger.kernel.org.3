Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C94AC4BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiBGQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345316AbiBGP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:59:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277EFC0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:59:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7BF6614FD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F70C340EF;
        Mon,  7 Feb 2022 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644249580;
        bh=c6M2TbQIKTl0es8Fi4IczYM3m7IAeA0YfoCYz403STI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iv3iCqVf5oExhQyB84/vGqI9fmC9gAMadwrFhOpAfb2rp6nm0ESER7WteiLdu8QBz
         VsnlpPWIwHihAaRhrR94MZpjXRAPlTRC9AHwevtqLDcoVYeHVM/z5Vbo9jzD4K5c0w
         OjuhQ/Fd889W10c2ZTB7Eoq48WcyFWHkZyyFj5bPXJVevc5qlsNTzvktbL8Mq+pAZ3
         LekrLx9pEoSSvBPEVFjLrGizigHSemjJ1+aYtJ7rBjTaqiXkiDa26JKwsq7rm4ccYf
         trTAKYE4xV8vInIJ9uKpbsK+i3zmOXysaNup0X6oxkHqFd59oM8cojE7DYCacON62H
         yMlghHSwfUWqg==
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
Date:   Mon,  7 Feb 2022 16:59:08 +0100
Message-Id: <20220207155910.527133-7-frederic@kernel.org>
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

