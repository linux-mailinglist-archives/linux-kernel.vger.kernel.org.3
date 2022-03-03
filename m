Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08C4CB69E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 06:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiCCF7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 00:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiCCF7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 00:59:14 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7603119F19
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 21:58:28 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id b5so553581ilj.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 21:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mV84UzvwgcTzHrS1PWSpDhxSyXTiMnXaQ2zCTd8Q558=;
        b=UZ/tqQYZi+ogQesV46CHakDd32m+0wL6DfJVcLrOka/3rU3gfGo4gJcNSOvA2BGs9B
         OjPxDa0sbiH/7Q67uGyy54+fs1hLf6x24XjzTf5qk3BdXOVix3Ah59En3zhwepPXpyDX
         BcyMJBi3fyv3OAbfWuNsXLeIXCE7z7cJl0xw+VWDNO9eOrmFw+jLaJuIy6S2xgaYT+Zm
         /+k9Uh3uG2WGfouxTefJ7Usjojy9IGA3sM1Y/lBxIu4TVXi5llZIeZ1EJZ0J4n1tGHl+
         /aLcTPNNLM53heiRJusvi7ezyfcF+xc+1EOzcgXNa09Guik6iY1rG7eLqrGnum0J3OxT
         GTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mV84UzvwgcTzHrS1PWSpDhxSyXTiMnXaQ2zCTd8Q558=;
        b=T94fZKg75/pPojqHhLI+sSS0NZM+1sHVneyQXxj1nOdc5kaxnIYNLeinUKQXqwiqGn
         nsG5AgVTt+3ulDMDpJ3agI1ReY2JbP7dHXtg/OBVAcNY7+6fbZXnjPGI2Z+QTy5XqHrh
         0l101zkuMu8Wp+yVd+6tmNBAkwqaBVv4BUCSnja2CuUVZcQHZBQu0r7ZrDBPQ1wN++pN
         CPxAGx/kKCZHRgX2HenOHkTu3UAMIZ8Ylph1N73FFw6kDsNU4dzSTfAxusNynoJlL6ui
         bKEd8RRTjHTEosibDCPFm7Rq83B2Ocdwazc75N5S3yFehv7cTiX6G5ebYwpr+mHgi+8d
         rDRg==
X-Gm-Message-State: AOAM530yi3XigOEBBgO1D+OSQ2izwPYc6fNQ/CTmyw0HBTDo/mx3BqpQ
        6ubXikh1PWWTU44esy45KtZxC0GBuRWWDg==
X-Google-Smtp-Source: ABdhPJzu54Dx+if56oJLM2VL7QdcrZOD0qKkts4F8jiuqloHdxsuPwtqUxPKmc7COOV/y7BltcJ/WQ==
X-Received: by 2002:a05:6e02:b4d:b0:2c2:2786:5215 with SMTP id f13-20020a056e020b4d00b002c227865215mr31467464ilu.4.1646287108186;
        Wed, 02 Mar 2022 21:58:28 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s13-20020a056e0218cd00b002c5f74a97d6sm1023018ilu.39.2022.03.02.21.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 21:58:27 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     corbet@lwn.net, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, surenb@google.com, ebiggers@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
Subject: [PATCH] psi: remove CPU full metric at system level
Date:   Thu,  3 Mar 2022 13:58:14 +0800
Message-Id: <20220303055814.93057-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin find it confusing when look at the /proc/pressure/cpu output,
and found no hint about that CPU "full" line in psi Documentation.

% cat /proc/pressure/cpu
some avg10=0.92 avg60=0.91 avg300=0.73 total=933490489
full avg10=0.22 avg60=0.23 avg300=0.16 total=358783277

The PSI_CPU_FULL state is introduced by commit e7fcd7622823
("psi: Add PSI_CPU_FULL state"), which mainly for cgroup level,
but also counted at the system level as a side effect.

Naturally, the FULL state doesn't exist for the CPU resource at
the system level. These "full" numbers can come from CPU idle
schedule latency. For example, t1 is the time when task wakeup
on an idle CPU, t2 is the time when CPU pick and switch to it.
The delta of (t2 - t1) will be in CPU_FULL state.

Another case all processes can be stalled is when all cgroups
have been throttled at the same time, which unlikely to happen.

Anyway, CPU_FULL metric is meaningless and confusing at the
system level. So this patch removed CPU full metric at the
system level, and removed it's monitor function too. The psi
Documentation has also been updated accordingly.

Fixes: e7fcd7622823 ("psi: Add PSI_CPU_FULL state")
Reported-by: Martin Steigerwald <Martin.Steigerwald@proact.de>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/accounting/psi.rst | 18 +++++++++++++++---
 kernel/sched/psi.c               | 10 +++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 860fe651d645..519652c06d7d 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -178,8 +178,20 @@ Cgroup2 interface
 In a system with a CONFIG_CGROUP=y kernel and the cgroup2 filesystem
 mounted, pressure stall information is also tracked for tasks grouped
 into cgroups. Each subdirectory in the cgroupfs mountpoint contains
-cpu.pressure, memory.pressure, and io.pressure files; the format is
-the same as the /proc/pressure/ files.
+cpu.pressure, memory.pressure, and io.pressure files; the format of
+memory.pressure and io.pressure is the same as the /proc/pressure/ files.
+
+But the format of cpu.pressure is as such::
+	some avg10=0.00 avg60=0.00 avg300=0.00 total=0
+	full avg10=0.00 avg60=0.00 avg300=0.00 total=0
+
+The "some" line indicates the share of time in which at least some tasks
+in the cgroup are stalled on CPU resource.
+
+The "full" line indicates the share of time in which all non-idle tasks
+in the cgroup are stalled on CPU resource, which is being used by others
+outside of the cgroup or throttled by the cgroup cpu.max configuration.
 
 Per-cgroup psi monitors can be specified and used the same way as
-system-wide ones.
+system-wide ones, except that users can also monitor full pressure on
+CPU resource at the cgroup level.
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e14358178849..d1baeb07d08c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1047,6 +1047,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
+	int full_max = 2;
 	int full;
 	u64 now;
 
@@ -1061,7 +1062,11 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2; full++) {
+	/* CPU_FULL state doesn't exist at system level */
+	if (res == PSI_CPU && group == &psi_system)
+		full_max = 1;
+
+	for (full = 0; full < full_max; full++) {
 		unsigned long avg[3];
 		u64 total;
 		int w;
@@ -1103,6 +1108,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	if (state >= PSI_NONIDLE)
 		return ERR_PTR(-EINVAL);
 
+	if (state == PSI_CPU_FULL && group == &psi_system)
+		return ERR_PTR(-EINVAL);
+
 	if (window_us < WINDOW_MIN_US ||
 		window_us > WINDOW_MAX_US)
 		return ERR_PTR(-EINVAL);
-- 
2.20.1

