Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680BF57CECC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiGUPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiGUPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:23:12 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A251FCE3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:23:10 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEXWv-001VEJ-1v;
        Thu, 21 Jul 2022 15:51:57 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] sched: fix undefined rt.c declarations
Date:   Thu, 21 Jul 2022 15:51:55 +0100
Message-Id: <20220721145155.358366-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several symbols defined in sched.h but get wrapped in the
CONFIG_CGROUP_SCHED even though dummy versions get built in rt.c and
therefore trigger the sparse warnings below. Fix this by moving them
outside the CONFIG_CGROUP_SCHED block.

kernel/sched/rt.c:309:6: warning: symbol 'unregister_rt_sched_group' was not declared. Should it be static?
kernel/sched/rt.c:311:6: warning: symbol 'free_rt_sched_group' was not declared. Should it be static?
kernel/sched/rt.c:313:5: warning: symbol 'alloc_rt_sched_group' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 kernel/sched/sched.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47b89a0fc6e5..8f97f342c560 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -480,9 +480,6 @@ extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 
-extern void unregister_rt_sched_group(struct task_group *tg);
-extern void free_rt_sched_group(struct task_group *tg);
-extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
 		struct sched_rt_entity *parent);
@@ -520,6 +517,10 @@ struct cfs_bandwidth { };
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+extern void unregister_rt_sched_group(struct task_group *tg);
+extern void free_rt_sched_group(struct task_group *tg);
+extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
-- 
2.35.1

