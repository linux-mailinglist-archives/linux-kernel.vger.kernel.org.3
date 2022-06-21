Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBA553229
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348907AbiFUMf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiFUMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:35:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1EB19027
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:35:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l6so4229004plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjlDmuV/uOVKT3BSmFT2nXl++EN3szZ0zzti8E6q644=;
        b=3VQV7AhNbEPddrWLGOd8BC8ju9GERSEC+GjCVKfDY9DBIs9bLhRYp56IQtNtupvHvR
         64ceScHBlOiAtQdDXzQQipdPSMZnVn2/nmHovXnkbOKdICbg2ocSBdXZ0BJ2eaPERXJQ
         wqhLg5735a5oxSmK1XYnFFJT74fh3JEOncfmiKZ7ndvZlvRFvAZ+lvbernA9KKUwLDpd
         HB5LZjcihcSITR+WCOys22YdE7q1rFUfkvIB0LVvZYegrHu8c7jxYG4riYiqjXw4G0LN
         /JyQ1d4BButexZoooYeeoeUxc/IxHY6c01RJs0VwViNEdkvTEZZpjx86+zB6dz4aN++J
         KuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjlDmuV/uOVKT3BSmFT2nXl++EN3szZ0zzti8E6q644=;
        b=JHPvK6ViEzlr6ZpyqnrgblbsUkv3u1UFYvgmYGJwqw01KgbzU8Itm0LFnb2Tizd+BF
         OAHCOrAlgInj0cOFxTqf99kU5FWa3P7rOog0qxluuWoGp9D5eKWFcpk1SkytOWuZs4NG
         istN0iJRw4d7EZmPeplmlNEF78DlGqCJbF0RAeVv+EKE4xX+zKuDGKbuZ4BCuMfJBd0x
         D4UN5y/8VZoTfNx3uTLIOsFTW3zD2vz0Z9s/MwH8w8ck8+gNC3i+8VX5KcSg239JiRGS
         +pwQp6HJTKqA3F72wcOWZRNJWQc66a/9i9MtX8/qQDeFDafWLdVcfWyctQAtC25Z0BRh
         P5Hg==
X-Gm-Message-State: AJIora+lKUzPsGNwb1qAdI19RxVAJDJiju9P9m9aXI8Ro/NGNyliRlan
        PZa0o+BrlzljNTEgdI3DP1ukEA==
X-Google-Smtp-Source: AGRyM1s92KMqIYGp268l+2CBnUMcBeQOhx/rpG4gHq3pRg7Uuy2vgBBuqnQD7+Bgvcr0COlmuTB86A==
X-Received: by 2002:a17:902:f7cb:b0:169:c7d1:2a7 with SMTP id h11-20020a170902f7cb00b00169c7d102a7mr24731850plw.141.1655814952649;
        Tue, 21 Jun 2022 05:35:52 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c11-20020a62f84b000000b0051844a64d3dsm11154791pfm.25.2022.06.21.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:35:52 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched: RT bandwidth interface for cgroup unified hierarchy
Date:   Tue, 21 Jun 2022 20:35:42 +0800
Message-Id: <20220621123542.1444-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to run RT threads in cgroup unified hierarchy, but we can't
since the default rt_bandwidth.rt_runtime of non-root task_group is 0
and we haven't interface to update it.

This patch add RT bandwidth interface "cpu.max.rt" and update the
documentation accordingly.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 13 +++++++++++
 kernel/sched/core.c                     | 31 +++++++++++++++++++++++++
 kernel/sched/rt.c                       |  2 +-
 kernel/sched/sched.h                    |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 176298f2f4de..3d2949e16e04 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1055,6 +1055,19 @@ All time durations are in microseconds.
 
 	The burst in the range [0, $MAX].
 
+  cpu.max.rt
+	A read-write two value file which exists on all cgroups when
+	CONFIG_RT_GROUP_SCHED enabled, to control CPU bandwidth for
+	RT threads in the task group.
+
+	The maximum bandwidth limit.  It's in the following format::
+
+	  $MAX $PERIOD
+
+	which indicates that RT threads in the group may consume upto
+	$MAX in each $PERIOD duration.  "max" for $MAX indicates no
+	limit.  If only one number is written, $MAX is updated.
+
   cpu.pressure
 	A read-write nested-keyed file.
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daadedc78fd9..c16f8cc5de08 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11047,6 +11047,30 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 }
 #endif
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static int cpu_max_rt_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	cpu_period_quota_print(sf, sched_group_rt_period(tg), sched_group_rt_runtime(tg));
+	return 0;
+}
+
+static ssize_t cpu_max_rt_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct task_group *tg = css_tg(of_css(of));
+	u64 period = sched_group_rt_period(tg);
+	u64 runtime;
+	int ret;
+
+	ret = cpu_period_quota_parse(buf, &period, &runtime);
+	if (!ret)
+		ret = tg_set_rt_bandwidth(tg, period, runtime);
+	return ret ?: nbytes;
+}
+#endif
+
 static struct cftype cpu_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -11082,6 +11106,13 @@ static struct cftype cpu_files[] = {
 		.write_u64 = cpu_cfs_burst_write_u64,
 	},
 #endif
+#ifdef CONFIG_RT_GROUP_SCHED
+	{
+		.name = "max.rt",
+		.seq_show = cpu_max_rt_show,
+		.write = cpu_max_rt_write,
+	},
+#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 8c9ed9664840..319ce586446f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2819,7 +2819,7 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
 	return ret;
 }
 
-static int tg_set_rt_bandwidth(struct task_group *tg,
+int tg_set_rt_bandwidth(struct task_group *tg,
 		u64 rt_period, u64 rt_runtime)
 {
 	int i, err = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7b19a72408b1..317480d535b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -486,6 +486,7 @@ extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
 		struct sched_rt_entity *parent);
+extern int tg_set_rt_bandwidth(struct task_group *tg, u64 rt_period, u64 rt_runtime);
 extern int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us);
 extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
-- 
2.36.1

