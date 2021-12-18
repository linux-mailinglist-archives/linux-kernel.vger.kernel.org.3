Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15147990F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 06:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhLRF7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 00:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhLRF7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 00:59:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80872C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 21:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QjcoqbUbeZKstRrAWBvLhJ2USX/4i/+Gewx2g9VaonI=; b=R/BTjrt28RzDyjC/hs+hpe/X7s
        AsbL5FLCCzXbpSFTetnOkCK/+MJHHqpyMGlAZyg5w7c7jvcGrJEUEYhzCqfXjKuyq73ZUh5fEeG7+
        6d61bp90qn5mo8ZsxYWNSJ+A7yOUOKHw5vKjMoQRK32WM/06teyJABrAYu02ROQ9OAeS/anSD60Fm
        KuRNq/Db8TRAFj6Z4aEOYchapdO4ZfWF9u9xfj2ubnWewSUgEeIIoEGmnIYv+q7qwZHLcCJwvlOx0
        /VK0mhZnQjdzGRGgVzbHfiUUikc36DdJa/9alAKx3w1xTww6i4KZj3p2ipKzBpiACxttDEcBpuEW4
        mgokz02Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mySkH-00D3Pt-Hn; Sat, 18 Dec 2021 05:59:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: fix all kernel-doc warnings
Date:   Fri, 17 Dec 2021 21:59:00 -0800
Message-Id: <20211218055900.2704-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quieten all kernel-doc warnings in kernel/sched/fair.c:

kernel/sched/fair.c:3663: warning: No description found for return value of 'update_cfs_rq_load_avg'
kernel/sched/fair.c:8601: warning: No description found for return value of 'asym_smt_can_pull_tasks'
kernel/sched/fair.c:8673: warning: Function parameter or member 'sds' not described in 'update_sg_lb_stats'
kernel/sched/fair.c:9483: warning: contents before sections

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
v2: Tweak the Return: text of asym_smt_can_pull_tasks() [per Ricardo]

 kernel/sched/fair.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-next-20211217.orig/kernel/sched/fair.c
+++ linux-next-20211217/kernel/sched/fair.c
@@ -3652,7 +3652,7 @@ static inline void add_tg_cfs_propagate(
  *
  * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
  *
- * Returns true if the load decayed or we removed load.
+ * Return: true if the load decayed or we removed load.
  *
  * Since both these conditions indicate a changed cfs_rq->avg.load we should
  * call update_tg_load_avg() when this function returns true.
@@ -8539,6 +8539,8 @@ group_type group_classify(unsigned int i
  *
  * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
  * of @dst_cpu are idle and @sg has lower priority.
+ *
+ * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
 static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 				    struct sg_lb_stats *sgs,
@@ -8614,6 +8616,7 @@ sched_asym(struct lb_env *env, struct sd
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
+ * @sds: Load-balancing data with statistics of the local group.
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
  * @sg_status: Holds flag indicating the status of the sched_group
@@ -9421,12 +9424,11 @@ static inline void calculate_imbalance(s
 /**
  * find_busiest_group - Returns the busiest group within the sched_domain
  * if there is an imbalance.
+ * @env: The load balancing environment.
  *
  * Also calculates the amount of runnable load which should be moved
  * to restore balance.
  *
- * @env: The load balancing environment.
- *
  * Return:	- The busiest group if imbalance exists.
  */
 static struct sched_group *find_busiest_group(struct lb_env *env)
