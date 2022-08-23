Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41FA59E1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358333AbiHWLla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357714AbiHWLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:36:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9DC6FCD;
        Tue, 23 Aug 2022 02:27:34 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3x+O8UmSs793JeulQrqXXDnvAyqXb8zmZSqEkHDA1Gg=;
        b=C1Y37yHXN8QZqt9FDef/DK8XCn/WeTFoZXq1BAQZ/HoQTjitXeqYV9+ZdGxSACYaPMK3bL
        +x2/WopLPV/SDjdjnvPDq40CprCfCSF7x7kSI+gP+cxodoI/SOy0jF7byllh6QMgcgOOXM
        bk7BRRklNnCYcY+eD136GgTmt1bDp4sp62Xzmr8JSaRvNtvM6hT51ZwO23TELCqXVMWPiA
        AFr90MYEki4APlnxeTE+AZwxLVDmIfFpORmTIw7i6eV2g3Fo6GaxpSniGBFBZBSPhPD40N
        d71nhiiAq0uysptmEDvCsJXF9C9pccwvnaL9jLHmejibU4ImKjNhdCTfh4sG7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3x+O8UmSs793JeulQrqXXDnvAyqXb8zmZSqEkHDA1Gg=;
        b=zfZXQCugaqKMypxLmzVHeobm2/t07AoAN7v315cldhm8zAUvpO6aDr4RHebLgoHC/0HkL8
        +RHovCPAG5eKR8CQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix another detach on unattached task
 corner case
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-7-zhouchengming@bytedance.com>
References: <20220818124805.601-7-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124685193.401.15399973538235063707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e2edaf61814fb6aa363989d718950c023b882d4
Gitweb:        https://git.kernel.org/tip/7e2edaf61814fb6aa363989d718950c023b882d4
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:48:02 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:19 +02:00

sched/fair: Fix another detach on unattached task corner case

commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
fixed two load tracking problems for new task, including detach on
unattached new task problem.

There still left another detach on unattached task problem for the task
which has been woken up by try_to_wake_up() and waiting for actually
being woken up by sched_ttwu_pending().

try_to_wake_up(p)
  cpu = select_task_rq(p)
  if (task_cpu(p) != cpu)
    set_task_cpu(p, cpu)
      migrate_task_rq_fair()
        remove_entity_load_avg()       --> unattached
        se->avg.last_update_time = 0;
      __set_task_cpu()
  ttwu_queue(p, cpu)
    ttwu_queue_wakelist()
      __ttwu_queue_wakelist()

task_change_group_fair()
  detach_task_cfs_rq()
    detach_entity_cfs_rq()
      detach_entity_load_avg()   --> detach on unattached task
  set_task_rq()
  attach_task_cfs_rq()
    attach_entity_cfs_rq()
      attach_entity_load_avg()

The reason of this problem is similar, we should check in detach_entity_cfs_rq()
that se->avg.last_update_time != 0, before do detach_entity_load_avg().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220818124805.601-7-zhouchengming@bytedance.com
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f52e7dc..e92bc05 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11557,6 +11557,17 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+#ifdef CONFIG_SMP
+	/*
+	 * In case the task sched_avg hasn't been attached:
+	 * - A forked task which hasn't been woken up by wake_up_new_task().
+	 * - A task which has been woken up by try_to_wake_up() but is
+	 *   waiting for actually being woken up by sched_ttwu_pending().
+	 */
+	if (!se->avg.last_update_time)
+		return;
+#endif
+
 	/* Catch up with the cfs_rq and remove our load when we leave */
 	update_load_avg(cfs_rq, se, 0);
 	detach_entity_load_avg(cfs_rq, se);
