Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157535B1228
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiIHBhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiIHBhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:37:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E8C6CF5;
        Wed,  7 Sep 2022 18:37:05 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MNM8B6HHfz1P6jw;
        Thu,  8 Sep 2022 09:33:14 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 09:37:04 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 09:37:02 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 4/4] perf timechart: Add p_state_end helper
Date:   Thu, 8 Sep 2022 10:11:41 +0800
Message-ID: <20220908021141.27134-5-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908021141.27134-1-shangxiaojing@huawei.com>
References: <20220908021141.27134-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap repeated code in helper functions p_state_end, which alloc a new
power_event recording last pstate, and insert to the head of
tchart->power_events.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-timechart.c | 37 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 667a94d45493..c36296bb7637 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -376,16 +376,13 @@ static void c_state_end(struct timechart *tchart, int cpu, u64 timestamp)
 	tchart->power_events = pwr;
 }
 
-static void p_state_change(struct timechart *tchart, int cpu, u64 timestamp, u64 new_freq)
+static struct power_event *p_state_end(struct timechart *tchart, int cpu,
+					u64 timestamp)
 {
-	struct power_event *pwr;
-
-	if (new_freq > 8000000) /* detect invalid data */
-		return;
+	struct power_event *pwr = zalloc(sizeof(*pwr));
 
-	pwr = zalloc(sizeof(*pwr));
 	if (!pwr)
-		return;
+		return NULL;
 
 	pwr->state = cpus_pstate_state[cpu];
 	pwr->start_time = cpus_pstate_start_times[cpu];
@@ -393,11 +390,23 @@ static void p_state_change(struct timechart *tchart, int cpu, u64 timestamp, u64
 	pwr->cpu = cpu;
 	pwr->type = PSTATE;
 	pwr->next = tchart->power_events;
-
 	if (!pwr->start_time)
 		pwr->start_time = tchart->first_time;
 
 	tchart->power_events = pwr;
+	return pwr;
+}
+
+static void p_state_change(struct timechart *tchart, int cpu, u64 timestamp, u64 new_freq)
+{
+	struct power_event *pwr;
+
+	if (new_freq > 8000000) /* detect invalid data */
+		return;
+
+	pwr = p_state_end(tchart, cpu, timestamp);
+	if (!pwr)
+		return;
 
 	cpus_pstate_state[cpu] = new_freq;
 	cpus_pstate_start_times[cpu] = timestamp;
@@ -705,22 +714,12 @@ static void end_sample_processing(struct timechart *tchart)
 #endif
 		/* P state */
 
-		pwr = zalloc(sizeof(*pwr));
+		pwr = p_state_end(tchart, cpu, tchart->last_time);
 		if (!pwr)
 			return;
 
-		pwr->state = cpus_pstate_state[cpu];
-		pwr->start_time = cpus_pstate_start_times[cpu];
-		pwr->end_time = tchart->last_time;
-		pwr->cpu = cpu;
-		pwr->type = PSTATE;
-		pwr->next = tchart->power_events;
-
-		if (!pwr->start_time)
-			pwr->start_time = tchart->first_time;
 		if (!pwr->state)
 			pwr->state = tchart->min_freq;
-		tchart->power_events = pwr;
 	}
 }
 
-- 
2.17.1

