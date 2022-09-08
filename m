Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D165B1224
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIHBhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiIHBhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:37:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DEBC6E86;
        Wed,  7 Sep 2022 18:37:04 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MNMBM0JBnzHnY1;
        Thu,  8 Sep 2022 09:35:07 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 09:37:02 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 09:37:01 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH 2/4] perf lock: Add get_key_by_aggr_mode helper
Date:   Thu, 8 Sep 2022 10:11:39 +0800
Message-ID: <20220908021141.27134-3-shangxiaojing@huawei.com>
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

Wrap repeated code in helper functions get_key_by_aggr_mode and
get_key_by_aggr_mode_simple, which assign the value to key based on
aggregation mode. Note that for the conditions not support
LOCK_AGGR_CALLER, should call get_key_by_aggr_mode_simple directly.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 tools/perf/builtin-lock.c | 129 ++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 76 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 70197c0593b1..44a47648b7fe 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -560,29 +560,50 @@ enum acquire_flags {
 	READ_LOCK = 2,
 };
 
-static int report_lock_acquire_event(struct evsel *evsel,
-				     struct perf_sample *sample)
+static int get_key_by_aggr_mode_simple(u64 *key, u64 addr, u32 tid)
 {
-	struct lock_stat *ls;
-	struct thread_stat *ts;
-	struct lock_seq_stat *seq;
-	const char *name = evsel__strval(evsel, sample, "name");
-	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
-	int flag = evsel__intval(evsel, sample, "flags");
-	u64 key;
-
 	switch (aggr_mode) {
 	case LOCK_AGGR_ADDR:
-		key = addr;
+		*key = addr;
 		break;
 	case LOCK_AGGR_TASK:
-		key = sample->tid;
+		*key = tid;
 		break;
 	case LOCK_AGGR_CALLER:
 	default:
 		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
 		return -EINVAL;
 	}
+	return 0;
+}
+
+static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample);
+
+static int get_key_by_aggr_mode(u64 *key, u64 addr, struct evsel *evsel,
+				 struct perf_sample *sample)
+{
+	if (aggr_mode == LOCK_AGGR_CALLER) {
+		*key = callchain_id(evsel, sample);
+		return 0;
+	}
+	return get_key_by_aggr_mode_simple(key, addr, sample->tid);
+}
+
+static int report_lock_acquire_event(struct evsel *evsel,
+				     struct perf_sample *sample)
+{
+	struct lock_stat *ls;
+	struct thread_stat *ts;
+	struct lock_seq_stat *seq;
+	const char *name = evsel__strval(evsel, sample, "name");
+	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
+	int flag = evsel__intval(evsel, sample, "flags");
+	u64 key;
+	int ret;
+
+	ret = get_key_by_aggr_mode_simple(&key, addr, sample->tid);
+	if (ret < 0)
+		return ret;
 
 	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
@@ -653,19 +674,11 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 	u64 key;
+	int ret;
 
-	switch (aggr_mode) {
-	case LOCK_AGGR_ADDR:
-		key = addr;
-		break;
-	case LOCK_AGGR_TASK:
-		key = sample->tid;
-		break;
-	case LOCK_AGGR_CALLER:
-	default:
-		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
-		return -EINVAL;
-	}
+	ret = get_key_by_aggr_mode_simple(&key, addr, sample->tid);
+	if (ret < 0)
+		return ret;
 
 	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
@@ -726,19 +739,11 @@ static int report_lock_contended_event(struct evsel *evsel,
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 	u64 key;
+	int ret;
 
-	switch (aggr_mode) {
-	case LOCK_AGGR_ADDR:
-		key = addr;
-		break;
-	case LOCK_AGGR_TASK:
-		key = sample->tid;
-		break;
-	case LOCK_AGGR_CALLER:
-	default:
-		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
-		return -EINVAL;
-	}
+	ret = get_key_by_aggr_mode_simple(&key, addr, sample->tid);
+	if (ret < 0)
+		return ret;
 
 	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
@@ -792,19 +797,11 @@ static int report_lock_release_event(struct evsel *evsel,
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 	u64 key;
+	int ret;
 
-	switch (aggr_mode) {
-	case LOCK_AGGR_ADDR:
-		key = addr;
-		break;
-	case LOCK_AGGR_TASK:
-		key = sample->tid;
-		break;
-	case LOCK_AGGR_CALLER:
-	default:
-		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
-		return -EINVAL;
-	}
+	ret = get_key_by_aggr_mode_simple(&key, addr, sample->tid);
+	if (ret < 0)
+		return ret;
 
 	ls = lock_stat_findnew(key, name, 0);
 	if (!ls)
@@ -1015,21 +1012,11 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	struct lock_seq_stat *seq;
 	u64 addr = evsel__intval(evsel, sample, "lock_addr");
 	u64 key;
+	int ret;
 
-	switch (aggr_mode) {
-	case LOCK_AGGR_ADDR:
-		key = addr;
-		break;
-	case LOCK_AGGR_TASK:
-		key = sample->tid;
-		break;
-	case LOCK_AGGR_CALLER:
-		key = callchain_id(evsel, sample);
-		break;
-	default:
-		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
-		return -EINVAL;
-	}
+	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
+	if (ret < 0)
+		return ret;
 
 	ls = lock_stat_find(key);
 	if (!ls) {
@@ -1098,21 +1085,11 @@ static int report_lock_contention_end_event(struct evsel *evsel,
 	u64 contended_term;
 	u64 addr = evsel__intval(evsel, sample, "lock_addr");
 	u64 key;
+	int ret;
 
-	switch (aggr_mode) {
-	case LOCK_AGGR_ADDR:
-		key = addr;
-		break;
-	case LOCK_AGGR_TASK:
-		key = sample->tid;
-		break;
-	case LOCK_AGGR_CALLER:
-		key = callchain_id(evsel, sample);
-		break;
-	default:
-		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
-		return -EINVAL;
-	}
+	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
+	if (ret < 0)
+		return ret;
 
 	ls = lock_stat_find(key);
 	if (!ls)
-- 
2.17.1

