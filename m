Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3E496CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 17:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiAVQ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 11:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiAVQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 11:27:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C98C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 08:27:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u24so2337099eds.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 08:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GufYdKD8zryiEjfbOHR6MbQFMLtxG8cX+FfA1dDcM3U=;
        b=HvbFsa5ic+Wpah73M/IiNqEgrtMQ94/PJShVp3YKCqRXN5TuayRNoKGzdwPbbnOuv0
         dMK5g8znrGaeG0RMH2tCzQkQEmnKOD93WEqVInzaf0r9ynXuQ+BTGy2NHEXwhEXfkW57
         GnhZu1+fglyFf/7v5Tkt5JNQn5TihbIC2PiRTkC+rwR+xWFnn3t9z0DcPyrYtvQunEtQ
         FnZQN/von3Y+EGquY2S10j5UyrR+m9jdeHDPgDNL53YQRsLU1lVgwQTH+Gnn452BM1PI
         mAVA4ooQarUf37BO7Ng65Uya15F/Cq4yCh5Pf84+pdPB/WxzUGbVg3l71ZcCsPGvIBwX
         TOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GufYdKD8zryiEjfbOHR6MbQFMLtxG8cX+FfA1dDcM3U=;
        b=7D8MNzO4RsnNOt92gG8Gi6BeCXrLtPgPgytOhXnlWM3mgEqNylqbSENYvxAHlNUdrY
         Rxg0vxm5/zo5vy6w8TGjZQF1uA7B++Tbm9sZzJ1f+TqSQTvXQ28YYnC8Qg+WELwASUfV
         L6tRrtlNzkj4yZ5iXKoFcqzcyXZrEjQGDrAkmBMvYaWhNg/uuZmElsUFaSG0C/ih1Y6x
         J3REPYeZ9+EetXrqZpXt2+j27nX0sQqWfNp9Y95UH0pgR82tAaaKcx5SECOVmmvFL19W
         teABZJnI7/UyfnjfnZz5yu6LmD5d64WHxBnM3P/CunnEbKJ14NZ8wbOMVfITho3ieia7
         dJRQ==
X-Gm-Message-State: AOAM533ndF5rQqrAUHl4F29uKNs6hQl4r6HppykuJAH0G2scPk9OwVrg
        yfLCad5G5qTo43Ycwu8DJbE=
X-Google-Smtp-Source: ABdhPJzbqcBhYUHjiS/U+Db6jgSti3Ll7z0d60KNDGAm3uA3QaBMcEqm+RIyyt2XFM2foltGkFSpCg==
X-Received: by 2002:a05:6402:84c:: with SMTP id b12mr8587510edz.243.1642868876212;
        Sat, 22 Jan 2022 08:27:56 -0800 (PST)
Received: from localhost.localdomain ([185.25.195.104])
        by smtp.gmail.com with ESMTPSA id h7sm2996943ejk.69.2022.01.22.08.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 08:27:55 -0800 (PST)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian@brauner.io,
        linux-kernel@vger.kernel.org
Cc:     Chun-Hung Tseng <henrybear327@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: [PATCH] sched: Simplify __sched_init runtime checks
Date:   Sat, 22 Jan 2022 17:26:18 +0100
Message-Id: <20220122162618.25432-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve runtime checks in __sched_init(void) by replacing if conditional
checks with preprocessor directives.

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
---
 kernel/sched/core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00e52d1..6de513831384 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9315,28 +9315,29 @@ void __init sched_init(void)
 #ifdef CONFIG_RT_GROUP_SCHED
 	ptr += 2 * nr_cpu_ids * sizeof(void **);
 #endif
-	if (ptr) {
-		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
+
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
+	ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.se = (struct sched_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.se = (struct sched_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.cfs_rq = (struct cfs_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
-		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
+	root_task_group.shares = ROOT_TASK_GROUP_LOAD;
+	init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
-
-		root_task_group.rt_rq = (struct rt_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
+	root_task_group.rt_rq = (struct rt_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 #endif /* CONFIG_RT_GROUP_SCHED */
-	}
+#endif /* CONFIG_FAIR_GROUP_SCHED || CONFIG_RT_GROUP_SCHED */
+
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
-- 
2.25.1

