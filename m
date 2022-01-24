Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA45497AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiAXIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbiAXIxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:53:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE31C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:53:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v13so12132787wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96kMnlFxJJvJ7SRa5XXF/kpfQ73y4IpuZ8VOnli8apo=;
        b=polSf3mP6S3oi7ybRK6wOAuDlANWEYCq3OS7i0yw1ul1bq5fCnMqJq8ApeUTILsW8N
         prUKP+gX+GYatelXtAyQczaxV5pcAP/Z9xsXMqrcafWeQmhbZ43nXsCDoDqozPP4Plbr
         8dCjIsp8P28uA/rNw4M9eb9CgBvVvuXHQwux23pk9qk55YznXKpzm3rNTk7NPUkoQGjU
         JC96L1LYoNz3/W0kVv0HjXf+7Zr1IZbGrhc45xSc4saViJMo4/2Wxu2HcVFui/3g42v5
         urNM9dhLEsDUkd0x+nxyPZDJCH0cucnWbWBG4R+1AVk6jTa8Bda5W42HC6bwFdmu9Qlt
         9lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96kMnlFxJJvJ7SRa5XXF/kpfQ73y4IpuZ8VOnli8apo=;
        b=EBdRgcvr8ae4+mpnEfqJDw5ECdGOIX1yKAYE7/2IZqm/MrZc4P3pL2tOnH/xz8VLRo
         r5xp2uLAMfsKu1ritofscutjVYp+c2n2HiCk9QdvdqEZ/rXuMiZuGath98I7qRX0IgrE
         xkucf8lsPhjY6bK+mWuanHBeQo1x8r0C37HNVSUsGq0wcRHXcpDr/CvxpeUIJqRAZwoS
         9LVQH92Od+ckB31KbLvHAaHc32pxja5OUX7YZ4xJNbuTr8kVuyY6OsiVeFQDWvI2faT7
         dGUS+4ZuEdBOr0s9juUksBGMxteYhifkGVjf0Z8B/3Q71C9uXD2RguVj3OUpRV1/PWW/
         33Ng==
X-Gm-Message-State: AOAM532Gs1AGQL6g0erM43gsVMnrnN8Q3mZAX3VCXxGxsrHt9hNq0WND
        AkM/4JHhYvJagOHZGiG2Ktw=
X-Google-Smtp-Source: ABdhPJyj5YPxS3yuvox1B7UPNEPDrQvMA5sAfgLkylj9oXR4+IQO84+Z7xcXdk30gS1XcENDy6a10w==
X-Received: by 2002:adf:dfcb:: with SMTP id q11mr13253128wrn.181.1643014421323;
        Mon, 24 Jan 2022 00:53:41 -0800 (PST)
Received: from localhost.localdomain (mob-194-230-158-138.cgn.sunrise.net. [194.230.158.138])
        by smtp.gmail.com with ESMTPSA id 10sm18407348wmc.44.2022.01.24.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:53:41 -0800 (PST)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian@brauner.io,
        linux-kernel@vger.kernel.org
Cc:     Chun-Hung Tseng <henrybear327@gmail.com>
Subject: [PATCH v2] sched: Simplify __sched_init runtime checks
Date:   Mon, 24 Jan 2022 09:53:32 +0100
Message-Id: <20220124085332.41552-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve runtime checks in __sched_init(void) by replacing if conditional
checks with preprocessor directives.

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 kernel/sched/core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 848eaa0efe0e..1b27ca7f485a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9308,28 +9308,29 @@ void __init sched_init(void)
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
2.34.1

