Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4D461CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbhK2Rgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:36:51 -0500
Received: from foss.arm.com ([217.140.110.172]:43872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243629AbhK2Rel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:34:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E23231063;
        Mon, 29 Nov 2021 09:31:23 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.80.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA04D3F5A1;
        Mon, 29 Nov 2021 09:31:22 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3] sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity
Date:   Mon, 29 Nov 2021 17:31:15 +0000
Message-Id: <20211129173115.4006346-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_sibling() has a special case for tasks woken up by a per-CPU
kthread where the selected CPU is the previous one. For asymmetric CPU
capacity systems, the assumption was that the wakee couldn't have a
bigger utilization during task placement than it used to have during the
last activation. That was not considering uclamp.min which can completely
change between two task activations and as a consequence mandates the
fitness criterion asym_fits_capacity(), even for the exit path described
above.

Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
V2 -> V3:
  * A more verbose commit message.
V1 -> V2:
  * Point to the correct fixed patch.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6291876a9d32..b90dc6fd86ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6410,7 +6410,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (is_per_cpu_kthread(current) &&
 	    prev == smp_processor_id() &&
-	    this_rq()->nr_running <= 1) {
+	    this_rq()->nr_running <= 1 &&
+	    asym_fits_capacity(task_util, prev)) {
 		return prev;
 	}
 
-- 
2.25.1

