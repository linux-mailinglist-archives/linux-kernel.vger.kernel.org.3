Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E624AC4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386811AbiBGQB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245674AbiBGP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:59:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C594C0401CC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:59:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED51CCE117B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E62C340F1;
        Mon,  7 Feb 2022 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644249566;
        bh=rRFnPno5dkJM7f0KqhuvvzKal926llCMJt1u2/5Gzcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht2+US44QjkwBGabQKfd+HQsGzSiDtUE6aGAel5GK5j2jPY0dxdnU+771HrqJWyp3
         yMSgogoceiO+vkImpf+gAIqt+Kb1toFH+jVnfSySGJzsBluqyGZB0tVLEOo92gPezi
         gEIF5itU/nfiYXnV1KfQIGPKbyyxJOKu9i4jd8nNjPtj1CfTA+57y1lvXSsR8PceER
         Q/r6u1kk/hblG9lo5GgTVZfXWlxWfZaedhFcdrMSmc0UW9mp77z6RihgUY88WRxKkA
         U1EYqZvd3eCfMuUr9TcnnkaxU5zk0WYSY9zTxZ8YaTgEd7+f6j+nFMVucCNYk2aqxv
         S3PRkDqHeLjXA==
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
Subject: [PATCH 2/8] workqueue: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Mon,  7 Feb 2022 16:59:04 +0100
Message-Id: <20220207155910.527133-3-frederic@kernel.org>
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

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare each of the HK_FLAG_* entries to move to their
own cpumask with enforcing to fetch them individually. The new
constraint is that multiple HK_FLAG_* entries can't be mixed together
anymore in a single call to housekeeping cpumask().

This will later allow, for example, to runtime modify the cpulist passed
through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
parameters.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
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
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..61ed310621ea 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6006,13 +6006,13 @@ static void __init wq_numa_init(void)
 void __init workqueue_init_early(void)
 {
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
-	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	int i, cpu;
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
 
 	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
-	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));
+	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_WQ));
+	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_DOMAIN));
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-- 
2.25.1

