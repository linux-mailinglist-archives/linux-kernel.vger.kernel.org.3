Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BEB473957
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbhLNAJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbhLNAJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:09:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010B6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 16:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=e7iYvqdk59yQTB+sivRttKCLwTd/sjK2UCt4QNJGOnw=; b=ps4nEtAbbflRkTVo4XZcJPVn6N
        yHOGdxIU2+dlpBNhzqAM0tnMsF3fOFPPciz/oaL/CKMHkuYDxrHn8nUTzirnZqYDE95NT4fI/2owe
        t0UrHov/bBEdHOEuHpvD+eiEQDeOA/N4UZWuf6k5r8dh3UhaJThUryRLd0vfBexpYgupbXzhab76+
        qKhIEj3t74fxH+gjsKV9Z2ONmqBfZVZbqEYNtf75EsXw5WxlKo7xE/uRSAV2XXY7mY4sFg7afIM5V
        y6I6G24G/CVlpcn/hOFLHtyhoDtwCiA7VTup1EBNnDyg7G5qlcrFP2qaxbppcJX/BwbauI+dhH6B3
        C/0uh7sg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwvNM-00C3E1-6F; Tue, 14 Dec 2021 00:09:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix all kernel-doc warnings
Date:   Mon, 13 Dec 2021 16:08:59 -0800
Message-Id: <20211214000859.24427-1-rdunlap@infradead.org>
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
 kernel/sched/fair.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- next-2021-1210.orig/kernel/sched/fair.c
+++ next-2021-1210/kernel/sched/fair.c
@@ -3653,7 +3653,7 @@ static inline void add_tg_cfs_propagate(
  *
  * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
  *
- * Returns true if the load decayed or we removed load.
+ * Return: true if the load decayed or we removed load.
  *
  * Since both these conditions indicate a changed cfs_rq->avg.load we should
  * call update_tg_load_avg() when this function returns true.
@@ -8594,6 +8594,8 @@ group_type group_classify(unsigned int i
  *
  * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
  * of @dst_cpu are idle and @sg has lower priority.
+ *
+ * Return: true if the load-balancing CPU can pull tasks, false otherwise.
  */
 static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 				    struct sg_lb_stats *sgs,
@@ -8669,6 +8671,7 @@ sched_asym(struct lb_env *env, struct sd
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
+ * @sds: Load-balancing data with statistics of the local group.
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
  * @sg_status: Holds flag indicating the status of the sched_group
@@ -9476,12 +9479,11 @@ static inline void calculate_imbalance(s
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
