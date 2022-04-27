Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B4511F02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiD0Pyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbiD0PyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:54:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CB5418D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h12so1882540plf.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mp/cIkoM/PJoe1xE+vZz8Akslqiqmw4V33yfSOipkIM=;
        b=eOnyEym2vzT8TUWpZQ00UktI+qXOeIvYi456W/zTl1L1I2ia9jTNFDrGLJvKWiCg9Q
         X7Z5aq3/YA7atu+Es7loUVQiUU9MpMJZPRb1N6ajhx1RctTG/h9wr/xaBv7r0i/3UFeZ
         cyfeXSYqmeJh7zchsrpYnYUTz2+IgNsqqMv7EweUVO9rCxgAZYRfC5ALojzO42G5s23q
         llXlwLdg66VG+o78neCEousDiqUErLpi2CTiSJHP9V6QCy4VtnUeREZDAp8VqZ4kBZTs
         JZY70cwtVZqVPwPooPk0cUEaFJThlKxbee4DgYOtCq3guTp3wTQU9HrLCzdUmxw93lkM
         zJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mp/cIkoM/PJoe1xE+vZz8Akslqiqmw4V33yfSOipkIM=;
        b=kHeny1qn3aszI3k37xnTsKkYDk+u5azOobGOp18NjQvHgRMHhU9o/Y11abwO1lY3V2
         3wXSd3dyB65Gp/AVCx824VyCzBqNg/4vwf7ycyDMG/q4JYbzRGqDiKh6i7HTM6vsFA7Z
         KMBNJmQUF85cEVojYFBH7K/qMeAJcl1CDcSB/Vvj8UkBlrYo9cSM3C4IV0xx+eFKgv4G
         4PiVa8LCtB1ycga+iPZ2ZdVhIh3NazIbHFZFTzHF53818RwcZTUItEFdxaKYXtTGpAP8
         rYzOmGqh5bOzEkzXUHFio9PIQrqcpn2TjpHJWRO2Jc03W4N5P5HeF5wd9QW5qR/C4v66
         +LSA==
X-Gm-Message-State: AOAM530b81/XzncElxy2JmwIbyaOmd7SZEziVseEkjjAA/i1k2wHWt3o
        WEZhVoq4O4lTz78nTikSoDZKrA==
X-Google-Smtp-Source: ABdhPJwnZW2vM5xZ8pHW/8UiJdhMd7V/9VZpyGv2ZvJzNuhG6y1r1LDgFqBHxjp81NpGVYA/fDhCzA==
X-Received: by 2002:a17:902:b107:b0:15d:391c:5a72 with SMTP id q7-20020a170902b10700b0015d391c5a72mr8663088plr.46.1651074659116;
        Wed, 27 Apr 2022 08:50:59 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:50:58 -0700 (PDT)
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
Subject: [PATCH v1 05/11] perf c2c: Add dimensions for peer load operations
Date:   Wed, 27 Apr 2022 23:50:07 +0800
Message-Id: <20220427155013.1833222-6-leo.yan@linaro.org>
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

This patch is to add dimensions for peer load operations, include a
dimension for the total statistics for metric 'ld_peer', and also add
dimensions for the single cache line view.

Same as HTIM metrics, this patch also adds the dimension for mean value
for peer load operations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 93 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9ef439610a2b..cef6513012e2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -55,6 +55,7 @@ struct c2c_hists {
 struct compute_stats {
 	struct stats		 lcl_hitm;
 	struct stats		 rmt_hitm;
+	struct stats		 ld_peer;
 	struct stats		 load;
 };
 
@@ -154,6 +155,7 @@ static void *c2c_he_zalloc(size_t size)
 
 	init_stats(&c2c_he->cstats.lcl_hitm);
 	init_stats(&c2c_he->cstats.rmt_hitm);
+	init_stats(&c2c_he->cstats.ld_peer);
 	init_stats(&c2c_he->cstats.load);
 
 	return &c2c_he->he;
@@ -253,6 +255,8 @@ static void compute_stats(struct c2c_hist_entry *c2c_he,
 		update_stats(&cstats->rmt_hitm, weight);
 	else if (stats->lcl_hitm)
 		update_stats(&cstats->lcl_hitm, weight);
+	else if (stats->ld_peer)
+		update_stats(&cstats->ld_peer, weight);
 	else if (stats->load)
 		update_stats(&cstats->load, weight);
 }
@@ -658,6 +662,7 @@ STAT_FN(ld_fbhit)
 STAT_FN(ld_l1hit)
 STAT_FN(ld_l2hit)
 STAT_FN(ld_llchit)
+STAT_FN(ld_peer)
 STAT_FN(rmt_hit)
 
 static uint64_t total_records(struct c2c_stats *stats)
@@ -674,7 +679,8 @@ static uint64_t total_records(struct c2c_stats *stats)
 		   stats->ld_l1hit +
 		   stats->ld_l2hit +
 		   stats->ld_llchit +
-		   stats->lcl_hitm;
+		   stats->lcl_hitm +
+		   stats->ld_peer;
 
 	total    = ldcnt +
 		   stats->st_l1hit +
@@ -730,7 +736,8 @@ static uint64_t total_loads(struct c2c_stats *stats)
 		   stats->ld_l1hit +
 		   stats->ld_l2hit +
 		   stats->ld_llchit +
-		   stats->lcl_hitm;
+		   stats->lcl_hitm +
+		   stats->ld_peer;
 
 	return ldcnt;
 }
@@ -899,6 +906,7 @@ static double percent_ ## __f(struct c2c_hist_entry *c2c_he)			\
 
 PERCENT_FN(rmt_hitm)
 PERCENT_FN(lcl_hitm)
+PERCENT_FN(ld_peer)
 PERCENT_FN(st_l1hit)
 PERCENT_FN(st_l1miss)
 PERCENT_FN(st_anylvl)
@@ -965,6 +973,37 @@ percent_lcl_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static int
+percent_ld_peer_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, ld_peer);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_ld_peer_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_ld_peer);
+}
+
+static int64_t
+percent_ld_peer_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		    struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, ld_peer);
+	per_right = PERCENT(right, ld_peer);
+
+	return per_left - per_right;
+}
+
 static int
 percent_stores_l1hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			   struct hist_entry *he)
@@ -1213,6 +1252,7 @@ __func(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp, struct hist_entry *he)	\
 MEAN_ENTRY(mean_rmt_entry,  rmt_hitm);
 MEAN_ENTRY(mean_lcl_entry,  lcl_hitm);
 MEAN_ENTRY(mean_load_entry, load);
+MEAN_ENTRY(mean_peer_entry, ld_peer);
 
 static int
 cpucnt_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -1360,6 +1400,14 @@ static struct c2c_dimension dim_rmt_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_ld_peer = {
+	.header		= HEADER_BOTH("Snoop", "Peer"),
+	.name		= "ld_peer",
+	.cmp		= ld_peer_cmp,
+	.entry		= ld_peer_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_rmt_hitm = {
 	.header		= HEADER_SPAN("----- HITM -----", "Rmt", 1),
 	.name		= "cl_rmt_hitm",
@@ -1376,6 +1424,14 @@ static struct c2c_dimension dim_cl_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_cl_ld_peer = {
+	.header		= HEADER_BOTH("Snoop", "Peer"),
+	.name		= "cl_ld_peer",
+	.cmp		= ld_peer_cmp,
+	.entry		= ld_peer_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_tot_stores = {
 	.header		= HEADER_BOTH("Total", "Stores"),
 	.name		= "tot_stores",
@@ -1520,6 +1576,15 @@ static struct c2c_dimension dim_percent_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_ld_peer = {
+	.header		= HEADER_BOTH("Snoop", "Peer"),
+	.name		= "percent_ld_peer",
+	.cmp		= percent_ld_peer_cmp,
+	.entry		= percent_ld_peer_entry,
+	.color		= percent_ld_peer_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_percent_stores_l1hit = {
 	.header		= HEADER_SPAN("------- Store Refs ------", "L1 Hit", 2),
 	.name		= "percent_stores_l1hit",
@@ -1602,7 +1667,7 @@ static struct c2c_dimension dim_node = {
 };
 
 static struct c2c_dimension dim_mean_rmt = {
-	.header		= HEADER_SPAN("---------- cycles ----------", "rmt hitm", 2),
+	.header		= HEADER_SPAN("--------------- cycles ---------------", "rmt hitm", 3),
 	.name		= "mean_rmt",
 	.cmp		= empty_cmp,
 	.entry		= mean_rmt_entry,
@@ -1625,6 +1690,14 @@ static struct c2c_dimension dim_mean_load = {
 	.width		= 8,
 };
 
+static struct c2c_dimension dim_mean_peer = {
+	.header		= HEADER_SPAN_LOW("peer"),
+	.name		= "mean_peer",
+	.cmp		= empty_cmp,
+	.entry		= mean_peer_entry,
+	.width		= 8,
+};
+
 static struct c2c_dimension dim_cpucnt = {
 	.header		= HEADER_BOTH("cpu", "cnt"),
 	.name		= "cpucnt",
@@ -1672,8 +1745,10 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_tot_hitm,
 	&dim_lcl_hitm,
 	&dim_rmt_hitm,
+	&dim_ld_peer,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
+	&dim_cl_ld_peer,
 	&dim_tot_stores,
 	&dim_stores_l1hit,
 	&dim_stores_l1miss,
@@ -1691,6 +1766,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_hitm,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
+	&dim_percent_ld_peer,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
 	&dim_percent_stores_anylvl,
@@ -1704,6 +1780,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_mean_rmt,
 	&dim_mean_lcl,
 	&dim_mean_load,
+	&dim_mean_peer,
 	&dim_cpucnt,
 	&dim_srcline,
 	&dim_dcacheline_idx,
@@ -2192,6 +2269,7 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Load L1D hit                      : %10d\n", stats->ld_l1hit);
 	fprintf(out, "  Load L2D hit                      : %10d\n", stats->ld_l2hit);
 	fprintf(out, "  Load LLC hit                      : %10d\n", stats->ld_llchit + stats->lcl_hitm);
+	fprintf(out, "  Load HIT Peer                     : %10d\n", stats->ld_peer);
 	fprintf(out, "  Load Local HITM                   : %10d\n", stats->lcl_hitm);
 	fprintf(out, "  Load Remote HITM                  : %10d\n", stats->rmt_hitm);
 	fprintf(out, "  Load Remote HIT                   : %10d\n", stats->rmt_hit);
@@ -2229,6 +2307,7 @@ static void print_shared_cacheline_info(FILE *out)
 	fprintf(out, "  Fill Buffer Hits on shared lines  : %10d\n", stats->ld_fbhit);
 	fprintf(out, "  L1D hits on shared lines          : %10d\n", stats->ld_l1hit);
 	fprintf(out, "  L2D hits on shared lines          : %10d\n", stats->ld_l2hit);
+	fprintf(out, "  Load HITs on peer cache lines     : %10d\n", stats->ld_peer);
 	fprintf(out, "  LLC hits on shared lines          : %10d\n", stats->ld_llchit + stats->lcl_hitm);
 	fprintf(out, "  Locked Access on shared lines     : %10d\n", stats->locks);
 	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
@@ -2257,10 +2336,10 @@ static void print_cacheline(struct c2c_hists *c2c_hists,
 		fprintf(out, "\n");
 	}
 
-	fprintf(out, "  ----------------------------------------------------------------------\n");
+	fprintf(out, "  -------------------------------------------------------------------------------\n");
 	__hist_entry__snprintf(he_cl, &hpp, hpp_list);
 	fprintf(out, "%s\n", bf);
-	fprintf(out, "  ----------------------------------------------------------------------\n");
+	fprintf(out, "  -------------------------------------------------------------------------------\n");
 
 	hists__fprintf(&c2c_hists->hists, false, 0, 0, 0, out, false);
 }
@@ -2275,6 +2354,7 @@ static void print_pareto(FILE *out)
 	cl_output = "cl_num,"
 		    "cl_rmt_hitm,"
 		    "cl_lcl_hitm,"
+		    "cl_ld_peer,"
 		    "cl_stores_l1hit,"
 		    "cl_stores_l1miss,"
 		    "cl_stores_anylvl,"
@@ -2727,6 +2807,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		c2c.use_stdio ? "cl_num_empty," : "",
 		"percent_rmt_hitm,"
 		"percent_lcl_hitm,"
+		"percent_ld_peer,"
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
 		"percent_stores_anylvl,"
@@ -2737,6 +2818,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		"mean_rmt,"
 		"mean_lcl,"
 		"mean_load,"
+		"mean_peer,"
 		"tot_recs,"
 		"cpucnt,",
 		add_sym ? "symbol," : "",
@@ -2913,6 +2995,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "dcacheline_count,"
 		     "percent_hitm,"
 		     "tot_hitm,lcl_hitm,rmt_hitm,"
+		     "ld_peer,"
 		     "tot_recs,"
 		     "tot_loads,"
 		     "tot_stores,"
-- 
2.25.1

