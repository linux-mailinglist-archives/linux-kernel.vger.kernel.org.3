Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F05ADD97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiIFCyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiIFCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:54:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD92E6D;
        Mon,  5 Sep 2022 19:54:25 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MM8yN4CnKzkWyc;
        Tue,  6 Sep 2022 10:50:36 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 10:54:23 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 10:54:22 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2 2/3] perf c2c: Add helpers to get counts of loads or stores
Date:   Tue, 6 Sep 2022 11:29:05 +0800
Message-ID: <20220906032906.21395-3-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906032906.21395-1-shangxiaojing@huawei.com>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Wrap repeated code in helper functions get_load_llc_misses,
get_load_cache_hits. For consistence, helper function get_stores is
wraped as well.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-c2c.c | 65 +++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 653e13b5037e..12f272811487 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -673,28 +673,35 @@ STAT_FN(ld_l2hit)
 STAT_FN(ld_llchit)
 STAT_FN(rmt_hit)
 
-static uint64_t total_records(struct c2c_stats *stats)
+static uint64_t get_load_llc_misses(struct c2c_stats *stats)
 {
-	uint64_t lclmiss, ldcnt, total;
-
-	lclmiss  = stats->lcl_dram +
-		   stats->rmt_dram +
-		   stats->rmt_hitm +
-		   stats->rmt_hit;
+	return stats->lcl_dram +
+	       stats->rmt_dram +
+	       stats->rmt_hitm +
+	       stats->rmt_hit;
+}
 
-	ldcnt    = lclmiss +
-		   stats->ld_fbhit +
-		   stats->ld_l1hit +
-		   stats->ld_l2hit +
-		   stats->ld_llchit +
-		   stats->lcl_hitm;
+static uint64_t get_load_cache_hits(struct c2c_stats *stats)
+{
+	return stats->ld_fbhit +
+	       stats->ld_l1hit +
+	       stats->ld_l2hit +
+	       stats->ld_llchit +
+	       stats->lcl_hitm;
+}
 
-	total    = ldcnt +
-		   stats->st_l1hit +
-		   stats->st_l1miss +
-		   stats->st_na;
+static uint64_t get_stores(struct c2c_stats *stats)
+{
+	return stats->st_l1hit +
+	       stats->st_l1miss +
+	       stats->st_na;
+}
 
-	return total;
+static uint64_t total_records(struct c2c_stats *stats)
+{
+	return get_load_llc_misses(stats) +
+	       get_load_cache_hits(stats) +
+	       get_stores(stats);
 }
 
 static int
@@ -731,21 +738,8 @@ tot_recs_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 
 static uint64_t total_loads(struct c2c_stats *stats)
 {
-	uint64_t lclmiss, ldcnt;
-
-	lclmiss  = stats->lcl_dram +
-		   stats->rmt_dram +
-		   stats->rmt_hitm +
-		   stats->rmt_hit;
-
-	ldcnt    = lclmiss +
-		   stats->ld_fbhit +
-		   stats->ld_l1hit +
-		   stats->ld_l2hit +
-		   stats->ld_llchit +
-		   stats->lcl_hitm;
-
-	return ldcnt;
+	return get_load_llc_misses(stats) +
+	       get_load_cache_hits(stats);
 }
 
 static int
@@ -2370,10 +2364,7 @@ static void print_c2c__display_stats(FILE *out)
 	int llc_misses;
 	struct c2c_stats *stats = &c2c.hists.stats;
 
-	llc_misses = stats->lcl_dram +
-		     stats->rmt_dram +
-		     stats->rmt_hit +
-		     stats->rmt_hitm;
+	llc_misses = get_load_llc_misses(stats);
 
 	fprintf(out, "=================================================\n");
 	fprintf(out, "            Trace Event Information              \n");
-- 
2.17.1

