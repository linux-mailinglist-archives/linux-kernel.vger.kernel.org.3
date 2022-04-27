Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979205120EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiD0Pz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiD0Pxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:53:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E253E15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so1933807pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aieDGF3ATgEnI82WJMWvxFqEdxYytl3KzImFfmAMmUQ=;
        b=jCr/M60V+FBlhcebtRtHMiB72UHOPoNvItJ6BMLencUYSJiLyNbcdbxCuude/Ciqz3
         fBfnBcAUFsvReSwYws2ioC50mcvED3k3Fii1BeCdIaTopdAp+jtQuATMu4XqY5qwNvtF
         bOXmmimMSnJa7C1v9JmSKzeiun1atq7WjmErsh4x2RglBe1gxEfwEkYPESfGERb7YsTa
         3tVnk1vPIv8ce/EaITGV4ajqS9beHhNJGZqhtpMzYfpGBlDvKXhcJP3qWoj5Z1Wv0x+b
         A1tq/YeIROIS80eVkOeA6vaCCwpt2OjgLvWJfgD1Xnzp2tyL/XUF5qpar10TlS8y+Bpx
         VjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aieDGF3ATgEnI82WJMWvxFqEdxYytl3KzImFfmAMmUQ=;
        b=C0FCx+1+qvv/o0QMget6kEeUTERBMSWi5mYh11XG1VS5zdI4bGgNcS/o+wlXW4GQsI
         K/AKQddo+8HUNsAA9PtFSYx0WPko60Dxti66LPTHoYDzpZJ2zd6PhHaGCo3jrsZgHyzE
         u9X5kMHxlL6I9dKLASb8JO9DCv8Gsq4y4hvcJJRSBvztBZCcyR/huUlsijyC3U9pm+tQ
         HNqJ8gqJFrnQti6eA6qgx7g2+VryN44yj1K/fLSNWVUxs7zKSBpQ918Mm4YjcPqn5Z/w
         ILmaypWUl3wWrWkiePJSz7A04jc7de6DaoEKlOBSySiLiKGs86mIcd3yj2s3M79fzI/E
         atHQ==
X-Gm-Message-State: AOAM5308kUelJmzi+znvwnh5VKScDhRpU2/0ddFpPzDKjRBAZch1Is6+
        zC/d2ht+e0TOV0OOUT6T8UA9jQ==
X-Google-Smtp-Source: ABdhPJzVOF9wzr6ywu2PPLAQ5K6M66fSocQQABsWC21Fj3LpmoozyyAXJWu0H1yYoMpwozAp6gwZGA==
X-Received: by 2002:a63:e355:0:b0:39d:7956:6d3c with SMTP id o21-20020a63e355000000b0039d79566d3cmr24649589pgj.385.1651074640263;
        Wed, 27 Apr 2022 08:50:40 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:50:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Ali Saidi <alisaidi@amazon.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 02/11] perf c2c: Add dimensions for 'anylvl' metrics of store operation
Date:   Wed, 27 Apr 2022 23:50:04 +0800
Message-Id: <20220427155013.1833222-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427155013.1833222-1-leo.yan@linaro.org>
References: <20220427155013.1833222-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now we have the statistics 'st_anylvl' for store operations, add
dimensions for the 'anylvl' metrics and also associated percentage
calculation for the single cache line view.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 80 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index fbbed434014f..9ef439610a2b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -653,6 +653,7 @@ STAT_FN(lcl_hitm)
 STAT_FN(store)
 STAT_FN(st_l1hit)
 STAT_FN(st_l1miss)
+STAT_FN(st_anylvl)
 STAT_FN(ld_fbhit)
 STAT_FN(ld_l1hit)
 STAT_FN(ld_l2hit)
@@ -677,7 +678,8 @@ static uint64_t total_records(struct c2c_stats *stats)
 
 	total    = ldcnt +
 		   stats->st_l1hit +
-		   stats->st_l1miss;
+		   stats->st_l1miss +
+		   stats->st_anylvl;
 
 	return total;
 }
@@ -899,6 +901,7 @@ PERCENT_FN(rmt_hitm)
 PERCENT_FN(lcl_hitm)
 PERCENT_FN(st_l1hit)
 PERCENT_FN(st_l1miss)
+PERCENT_FN(st_anylvl)
 
 static int
 percent_rmt_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -1024,6 +1027,37 @@ percent_stores_l1miss_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static int
+percent_stores_anylvl_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, st_anylvl);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_stores_anylvl_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			    struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_st_anylvl);
+}
+
+static int64_t
+percent_stores_anylvl_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			  struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, st_anylvl);
+	per_right = PERCENT(right, st_anylvl);
+
+	return per_left - per_right;
+}
+
 STAT_FN(lcl_dram)
 STAT_FN(rmt_dram)
 
@@ -1351,7 +1385,7 @@ static struct c2c_dimension dim_tot_stores = {
 };
 
 static struct c2c_dimension dim_stores_l1hit = {
-	.header		= HEADER_SPAN("---- Stores ----", "L1Hit", 1),
+	.header		= HEADER_SPAN("--------- Stores --------", "L1Hit", 2),
 	.name		= "stores_l1hit",
 	.cmp		= st_l1hit_cmp,
 	.entry		= st_l1hit_entry,
@@ -1366,8 +1400,16 @@ static struct c2c_dimension dim_stores_l1miss = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_stores_anylvl = {
+	.header		= HEADER_SPAN_LOW("Anylvl"),
+	.name		= "stores_anylvl",
+	.cmp		= st_anylvl_cmp,
+	.entry		= st_anylvl_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_stores_l1hit = {
-	.header		= HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
+	.header		= HEADER_SPAN("------- Store Refs ------", "L1 Hit", 2),
 	.name		= "cl_stores_l1hit",
 	.cmp		= st_l1hit_cmp,
 	.entry		= st_l1hit_entry,
@@ -1382,6 +1424,14 @@ static struct c2c_dimension dim_cl_stores_l1miss = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_cl_stores_anylvl = {
+	.header		= HEADER_SPAN_LOW("Any Lvl"),
+	.name		= "cl_stores_anylvl",
+	.cmp		= st_anylvl_cmp,
+	.entry		= st_anylvl_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_ld_fbhit = {
 	.header		= HEADER_SPAN("----- Core Load Hit -----", "FB", 2),
 	.name		= "ld_fbhit",
@@ -1471,7 +1521,7 @@ static struct c2c_dimension dim_percent_lcl_hitm = {
 };
 
 static struct c2c_dimension dim_percent_stores_l1hit = {
-	.header		= HEADER_SPAN("-- Store Refs --", "L1 Hit", 1),
+	.header		= HEADER_SPAN("------- Store Refs ------", "L1 Hit", 2),
 	.name		= "percent_stores_l1hit",
 	.cmp		= percent_stores_l1hit_cmp,
 	.entry		= percent_stores_l1hit_entry,
@@ -1488,6 +1538,15 @@ static struct c2c_dimension dim_percent_stores_l1miss = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_stores_anylvl = {
+	.header		= HEADER_SPAN_LOW("Any Lvl"),
+	.name		= "percent_stores_anylvl",
+	.cmp		= percent_stores_anylvl_cmp,
+	.entry		= percent_stores_anylvl_entry,
+	.color		= percent_stores_anylvl_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_dram_lcl = {
 	.header		= HEADER_SPAN("--- Load Dram ----", "Lcl", 1),
 	.name		= "dram_lcl",
@@ -1618,8 +1677,10 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_tot_stores,
 	&dim_stores_l1hit,
 	&dim_stores_l1miss,
+	&dim_stores_anylvl,
 	&dim_cl_stores_l1hit,
 	&dim_cl_stores_l1miss,
+	&dim_cl_stores_anylvl,
 	&dim_ld_fbhit,
 	&dim_ld_l1hit,
 	&dim_ld_l2hit,
@@ -1632,6 +1693,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_lcl_hitm,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
+	&dim_percent_stores_anylvl,
 	&dim_dram_lcl,
 	&dim_dram_rmt,
 	&dim_pid,
@@ -2149,6 +2211,7 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Store - no mapping                : %10d\n", stats->st_noadrs);
 	fprintf(out, "  Store L1D Hit                     : %10d\n", stats->st_l1hit);
 	fprintf(out, "  Store L1D Miss                    : %10d\n", stats->st_l1miss);
+	fprintf(out, "  Store Any cache Level             : %10d\n", stats->st_anylvl);
 	fprintf(out, "  No Page Map Rejects               : %10d\n", stats->nomap);
 	fprintf(out, "  Unable to parse data source       : %10d\n", stats->noparse);
 }
@@ -2171,6 +2234,7 @@ static void print_shared_cacheline_info(FILE *out)
 	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
 	fprintf(out, "  Store HITs on shared lines        : %10d\n", stats->store);
 	fprintf(out, "  Store L1D hits on shared lines    : %10d\n", stats->st_l1hit);
+	fprintf(out, "  Store Any cache Level             : %10d\n", stats->st_anylvl);
 	fprintf(out, "  Total Merged records              : %10d\n", hitm_cnt + stats->store);
 }
 
@@ -2193,10 +2257,10 @@ static void print_cacheline(struct c2c_hists *c2c_hists,
 		fprintf(out, "\n");
 	}
 
-	fprintf(out, "  -------------------------------------------------------------\n");
+	fprintf(out, "  ----------------------------------------------------------------------\n");
 	__hist_entry__snprintf(he_cl, &hpp, hpp_list);
 	fprintf(out, "%s\n", bf);
-	fprintf(out, "  -------------------------------------------------------------\n");
+	fprintf(out, "  ----------------------------------------------------------------------\n");
 
 	hists__fprintf(&c2c_hists->hists, false, 0, 0, 0, out, false);
 }
@@ -2213,6 +2277,7 @@ static void print_pareto(FILE *out)
 		    "cl_lcl_hitm,"
 		    "cl_stores_l1hit,"
 		    "cl_stores_l1miss,"
+		    "cl_stores_anylvl,"
 		    "dcacheline";
 
 	perf_hpp_list__init(&hpp_list);
@@ -2664,6 +2729,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		"percent_lcl_hitm,"
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
+		"percent_stores_anylvl,"
 		"offset,offset_node,dcacheline_count,",
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
@@ -2850,7 +2916,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "tot_recs,"
 		     "tot_loads,"
 		     "tot_stores,"
-		     "stores_l1hit,stores_l1miss,"
+		     "stores_l1hit,stores_l1miss,stores_anylvl,"
 		     "ld_fbhit,ld_l1hit,ld_l2hit,"
 		     "ld_lclhit,lcl_hitm,"
 		     "ld_rmthit,rmt_hitm,"
-- 
2.25.1

