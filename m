Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238F1497D35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiAXKcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiAXKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:32:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD03C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:32:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so5461980pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elaMpABJ6ePTMvkZA2OfFeFiKBytOl2OykV9muWIvyY=;
        b=ggiLoLIe7AXZB+CBtdxcInt4cNSVMj8JD+iWER2gyyzqJtBN8xPr1NfzT+YVfqIqGE
         dRmbI60nBXEgCZN4qbBcV56qXgFxeaJ6B2lsyzfdkfc0+RMuHj40CnOwgfLRJPBEtS4V
         9fPHrcYmkIMf2jfw/899ELc+w3ZYnTju1TRi5QEN3ZrlVV/AI6eaM5x5N0QRejnR5ZVb
         PVK8EEFRbj0E5Ak7cu+9/TWEa6FVX9jwrRczTP9Ogvm7mNW4rM4umGCmn4cyonuRkON9
         fhDWow7qODcjS5xbG6DrAZ/LmnoidggV0XJ0y3Ll49Uyrx4GfMKS6C1cqzUgW/9K64Fv
         dZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elaMpABJ6ePTMvkZA2OfFeFiKBytOl2OykV9muWIvyY=;
        b=WRNwhxB6yFHVwRUyp87PLMt/kvn6sAdZy6pNZOQ9GYcDlryyI6ZmihVAOCdGxEjsBr
         5ALlfCwFFJ+oUgC4xFQwt4cQAn7K7EG2QY0DDC1WMVcgQzd8BcdL0fSBziu4dLEg2Ndk
         EpOpNZkIwqVq91c1nV74YbW+34hh5bi8wx3UG+GTyTN41YvdpFAgjKP9dhsfu7Zpy9Da
         77iOh0xoSZFFd1BM7ChZ0HrwMsvIZDT1vgfsyoR+pkZjwaQYP5/J8QeIVqj3yJcgVIkR
         MYXwRoOp3JeeJnhMr53NkhgaaF9BIKFMplWlquQbGFGZAFZSy8wIaFqdS0Q7kFW4lo1g
         YVvw==
X-Gm-Message-State: AOAM5330fO49/SA2ewvjP1IQLMZaPmwgWzzyhdtcn37KIN3MtxaVXX8E
        0OXxzhdJaGH/W/dRMrH1c18=
X-Google-Smtp-Source: ABdhPJx5IgvvoZoeazTNkiXVcubVTzVXKeEl9L+hHlo7KS2u1Si+fQ+TCaLymYL97cTAJZoI6XO13g==
X-Received: by 2002:a17:902:d503:b0:14b:10e2:f387 with SMTP id b3-20020a170902d50300b0014b10e2f387mr13896394plg.9.1643020334523;
        Mon, 24 Jan 2022 02:32:14 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id x7sm11749704pgr.87.2022.01.24.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 02:32:14 -0800 (PST)
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
To:     henrybear327@gmail.com
Cc:     bristot@redhat.com, bsegall@google.com, christian@brauner.io,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched: Simplify __sched_init runtime checks
Date:   Mon, 24 Jan 2022 18:33:02 +0800
Message-Id: <20220124103302.3124748-1-foxhoundsk.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124085332.41552-1-henrybear327@gmail.com>
References: <20220124085332.41552-1-henrybear327@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve runtime checks in __sched_init(void) by replacing if conditional
checks with preprocessor directives.

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
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
