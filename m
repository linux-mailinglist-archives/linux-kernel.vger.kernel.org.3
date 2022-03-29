Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83484EA8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiC2Hqc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Mar 2022 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiC2Hqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:46:30 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E719E09A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:44:47 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B84455F850;
        Tue, 29 Mar 2022 09:44:45 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched: use TASK_USER_PRIO() instead of open coding it
Date:   Tue, 29 Mar 2022 09:44:30 +0200
Message-ID: <5667632.X0gI6VCO9r@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/trace/trace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b4914925..c01c49aa4e77 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1281,7 +1281,7 @@ int tg_nop(struct task_group *tg, void *data)
 
 static void set_load_weight(struct task_struct *p, bool update_load)
 {
-	int prio = p->static_prio - MAX_RT_PRIO;
+	int prio = TASK_USER_PRIO(p);
 	struct load_weight *load = &p->se.load;
 
 	/*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..f8ab47a87fd0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1782,7 +1782,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	else
 		max_data->uid = task_uid(tsk);
 
-	max_data->nice = tsk->static_prio - 20 - MAX_RT_PRIO;
+	max_data->nice = TASK_USER_PRIO(tsk) - 20;
 	max_data->policy = tsk->policy;
 	max_data->rt_priority = tsk->rt_priority;
 
-- 
2.35.1


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


