Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A278E52B205
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiERF6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiERF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:58:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6721E5E17C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i24so1178270pfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adiuZus1maUGP/35T5HT7LXaz99C0SKn0msg0uKYXW8=;
        b=hkIY/dOZK0sYjKIqS8J/0haYZH1qagtRLaPmrWIpy2fJC7wyaLgK9SvbIVP//+Pkrt
         uyQiwP5O+drlgWQxRJsIgMppTXmLBGWcdYa3tyRdl5vrh/2oIuMSDJm7lR2g9Vnqthrq
         y/5vSx0MMDRMxI2+qd73Sqsx7M7qVMxIrv/mDCe0j9PwLZm8yid6F8X/ASRjdp2Kf8mh
         DAxI1WHRDgdJ2tS3ITZS2YHuuAefpnf5wYAC/7iVNKWyipVqqh4hM/zrWwpzyz1rMy/8
         unyfI098K7Dc9tIFAn7JhXg/o43IA3mLFLNqScc87ILwzFR83/J4cnQ50H7FFJv0HuzI
         QEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adiuZus1maUGP/35T5HT7LXaz99C0SKn0msg0uKYXW8=;
        b=YtelBdkJa4xP/VKzgONTMV9Utg6pSTYHW9fbwXhDG9uCIRxIkSLIrZXpBFMI+pybjq
         csnJA+0FNIKgFpC2Ecyb3iuHrpCng/88dJrcFKs6gCrD4t1saCO4hNkxJgIl/L6DsVZc
         otkf8uhjH5nZHWAaedPmzxavDeHqTWev///7MdUQBZIR6AdNGbb53oyARWIhLZdiEx5e
         GNwbj+zMcyxHVohXTI+mOPwI00ivYJmKaMMvmCgybGL4o/UPXxn4k5zanFkzt5EEBnVZ
         jrUzN0lmoziihuUNa8GThVMdmdUkw9bpXovjeEgT3aVxDcuYOk7ynmQiAIM2sqQWLGjI
         KwEQ==
X-Gm-Message-State: AOAM531UuF62CZOOaQI9HARSkUDy6i2RR0aSUCIT19Ra9pfm+H8BlZnS
        kh3hMixQKaOPF5FYbcBWTkFucA==
X-Google-Smtp-Source: ABdhPJwMrXvxWHAChGlT+OPmKXc7TLoCV9WFrkwmmOwDptpvNEREN27z+7RUk6l+I3Z4RVkuTUIE6w==
X-Received: by 2002:aa7:9019:0:b0:4fa:7532:9551 with SMTP id m25-20020aa79019000000b004fa75329551mr26477696pfo.26.1652853481716;
        Tue, 17 May 2022 22:58:01 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 02/11] perf c2c: Add dimensions for 'N/A' metrics of store operation
Date:   Wed, 18 May 2022 13:57:20 +0800
Message-Id: <20220518055729.1869566-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now we have the statistics 'st_na' for store operations, add
dimensions for the 'N/A' (no available memory level) metrics and the
associated percentage calculation for the single cache line view.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 80 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index fbbed434014f..c8230c48125f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -653,6 +653,7 @@ STAT_FN(lcl_hitm)
 STAT_FN(store)
 STAT_FN(st_l1hit)
 STAT_FN(st_l1miss)
+STAT_FN(st_na)
 STAT_FN(ld_fbhit)
 STAT_FN(ld_l1hit)
 STAT_FN(ld_l2hit)
@@ -677,7 +678,8 @@ static uint64_t total_records(struct c2c_stats *stats)
 
 	total    = ldcnt +
 		   stats->st_l1hit +
-		   stats->st_l1miss;
+		   stats->st_l1miss +
+		   stats->st_na;
 
 	return total;
 }
@@ -899,6 +901,7 @@ PERCENT_FN(rmt_hitm)
 PERCENT_FN(lcl_hitm)
 PERCENT_FN(st_l1hit)
 PERCENT_FN(st_l1miss)
+PERCENT_FN(st_na)
 
 static int
 percent_rmt_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -1024,6 +1027,37 @@ percent_stores_l1miss_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static int
+percent_stores_na_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, st_na);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_stores_na_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_st_na);
+}
+
+static int64_t
+percent_stores_na_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		      struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, st_na);
+	per_right = PERCENT(right, st_na);
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
 
+static struct c2c_dimension dim_stores_na = {
+	.header		= HEADER_SPAN_LOW("N/A"),
+	.name		= "stores_na",
+	.cmp		= st_na_cmp,
+	.entry		= st_na_entry,
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
 
+static struct c2c_dimension dim_cl_stores_na = {
+	.header		= HEADER_SPAN_LOW("N/A"),
+	.name		= "cl_stores_na",
+	.cmp		= st_na_cmp,
+	.entry		= st_na_entry,
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
 
+static struct c2c_dimension dim_percent_stores_na = {
+	.header		= HEADER_SPAN_LOW("N/A"),
+	.name		= "percent_stores_na",
+	.cmp		= percent_stores_na_cmp,
+	.entry		= percent_stores_na_entry,
+	.color		= percent_stores_na_color,
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
+	&dim_stores_na,
 	&dim_cl_stores_l1hit,
 	&dim_cl_stores_l1miss,
+	&dim_cl_stores_na,
 	&dim_ld_fbhit,
 	&dim_ld_l1hit,
 	&dim_ld_l2hit,
@@ -1632,6 +1693,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_lcl_hitm,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
+	&dim_percent_stores_na,
 	&dim_dram_lcl,
 	&dim_dram_rmt,
 	&dim_pid,
@@ -2149,6 +2211,7 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Store - no mapping                : %10d\n", stats->st_noadrs);
 	fprintf(out, "  Store L1D Hit                     : %10d\n", stats->st_l1hit);
 	fprintf(out, "  Store L1D Miss                    : %10d\n", stats->st_l1miss);
+	fprintf(out, "  Store No available memory level   : %10d\n", stats->st_na);
 	fprintf(out, "  No Page Map Rejects               : %10d\n", stats->nomap);
 	fprintf(out, "  Unable to parse data source       : %10d\n", stats->noparse);
 }
@@ -2171,6 +2234,7 @@ static void print_shared_cacheline_info(FILE *out)
 	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
 	fprintf(out, "  Store HITs on shared lines        : %10d\n", stats->store);
 	fprintf(out, "  Store L1D hits on shared lines    : %10d\n", stats->st_l1hit);
+	fprintf(out, "  Store No available memory level   : %10d\n", stats->st_na);
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
+		    "cl_stores_na,"
 		    "dcacheline";
 
 	perf_hpp_list__init(&hpp_list);
@@ -2664,6 +2729,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		"percent_lcl_hitm,"
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
+		"percent_stores_na,"
 		"offset,offset_node,dcacheline_count,",
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
@@ -2850,7 +2916,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "tot_recs,"
 		     "tot_loads,"
 		     "tot_stores,"
-		     "stores_l1hit,stores_l1miss,"
+		     "stores_l1hit,stores_l1miss,stores_na,"
 		     "ld_fbhit,ld_l1hit,ld_l2hit,"
 		     "ld_lclhit,lcl_hitm,"
 		     "ld_rmthit,rmt_hitm,"
-- 
2.25.1

