Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A9052B76F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiERKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiERKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:08:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8EE158955
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:08:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i17so1308504pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AISLwiGo1fKv8O+f+qFCUVpBkv1G8j+nuhHa4bKM0U=;
        b=aTiOlVUCRysQ6EdAlT9QX6NXLbQEKSGApC3rgjFEq+XFsAq6wS/O2fVE9q9NMxMKr0
         QE2HvhyR7/FO79cbjpDtKOy1BYGyexxL0f2gvyarNMFm5UWsVZN4a6UcpKPyKSkKsIkL
         voCRvzaLvb/Awv67C4wdPdaaG6mRmoptoysiYK16RYeibn2lptOCHtq1noYUGn/BJhrh
         JMMg1u0bthT56FRxhY3njMEPQ77u8s5e1/UKv2XfAvEU1zh95oZbyiLKTVe+C0WjLW+E
         zmzfQyCFhYVLa4pjkfGF7PT3SkjgaaOlvQSs/7OXL2SoJEH5nR4tI5QBXtIhiixoB5V0
         N6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AISLwiGo1fKv8O+f+qFCUVpBkv1G8j+nuhHa4bKM0U=;
        b=ddEUYYdLPevQSQxNYvqcdgWMZ+txllbhD9UP+CNuJEgCuWY2QfWAIY19YYWk205UUg
         tKTWgzpq7D6ytlc8C12divMgOJOm1+Ls95QdzrGGDRWarGRcGxCiygfsAJOPcYiNVJ4U
         tP9h5/Si2/M7CrGBRD6b10VrVS/zAJ1oVgYPlDsPIyYO+oASSfFFHmska9l0+FnaKc93
         NXs3OsLfX3uAqKv2FAv1B8m3qT+TlEkGzruAI74eWSSIvUdG1XiCv4Qc8U/jGCmisCvB
         NDx/IkKiB0bPqchL9dJqB3sTjA6BMGo2FZU5mFub2CEZvBoT/8DubY/sUPMdU8zzFU+Z
         YOzw==
X-Gm-Message-State: AOAM533agkZkViNG2bfH8cy15w47J0Tt/QdqgpD/ytTob6AaElRpdn/M
        NIQcF/WBjtY6CzMDQUG84U+JaW6kXTO8tw==
X-Google-Smtp-Source: ABdhPJyOLr9ENpyofj8YiB675pWCS82np9F+62WZI0ucmAv+ZHeP4s9OW16B1+jOlqhOCReNk04Dxg==
X-Received: by 2002:a17:902:ecd0:b0:161:9ccf:f3f4 with SMTP id a16-20020a170902ecd000b001619ccff3f4mr9557830plh.19.1652868526734;
        Wed, 18 May 2022 03:08:46 -0700 (PDT)
Received: from localhost (153.185.242.35.bc.googleusercontent.com. [35.242.185.153])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902dcca00b001619fbb0e6dsm1232907pll.40.2022.05.18.03.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 03:08:46 -0700 (PDT)
From:   Fam Zheng <fam.zheng@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        zhouchengming@bytedance.com,
        Vincent Guittot <vincent.guittot@linaro.org>, fam@euphon.net,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        songmuchun@bytedance.com, Juri Lelli <juri.lelli@redhat.com>,
        Fam Zheng <fam.zheng@bytedance.com>
Subject: [RFC PATCH] sched: Enable root level cgroup bandwidth control
Date:   Wed, 18 May 2022 11:08:41 +0100
Message-Id: <20220518100841.1497391-1-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the data center there sometimes comes a need to throttle down a
server, cgroup is a natural choice to reduce cpu quota for running task
but there is no interface for the root group.

Alternative solution such as cpufreq controlling exists, with the help
of e.g. intel-pstate or acpi-cpufreq; but that is not always available,
depending on the hardware and BIOS.

This patch allows capping the global cpu utilization.

Currently, writing a positive integer to the v1 root cgroup:

        /sys/fs/cgroup/cpu/cpu.cfs_quota_ns

will be rejected by kernel (-EINVAL). And there is no such entries in v2
either because of CFTYPE_NOT_ON_ROOT flags.

Remove this limitation by checking the root node's throttled state.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>
---
 kernel/sched/core.c | 13 ++++---------
 kernel/sched/fair.c |  2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d58c0389eb23..c30c8a4d006a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10402,9 +10402,6 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
 
-	if (tg == &root_task_group)
-		return -EINVAL;
-
 	/*
 	 * Ensure we have at some amount of bandwidth every period.  This is
 	 * to prevent reaching a state of large arrears when throttled via
@@ -10632,12 +10629,10 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
 	s64 quota = 0, parent_quota = -1;
 
-	if (!tg->parent) {
-		quota = RUNTIME_INF;
-	} else {
+	quota = normalize_cfs_quota(tg, d);
+	if (tg->parent) {
 		struct cfs_bandwidth *parent_b = &tg->parent->cfs_bandwidth;
 
-		quota = normalize_cfs_quota(tg, d);
 		parent_quota = parent_b->hierarchical_quota;
 
 		/*
@@ -10983,13 +10978,13 @@ static struct cftype cpu_files[] = {
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "max",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.flags = 0,
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
 	{
 		.name = "max.burst",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.flags = 0,
 		.read_u64 = cpu_cfs_burst_read_u64,
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..dd8c7eb9b648 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7310,7 +7310,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
 				cfs_rq = &rq->cfs;
 
-				if (!cfs_rq->nr_running)
+				if (!cfs_rq->nr_running || cfs_rq_throttled(cfs_rq))
 					goto idle;
 
 				goto simple;
-- 
2.25.1

