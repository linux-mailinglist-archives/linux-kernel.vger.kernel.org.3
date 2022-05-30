Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6F537A15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiE3LmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiE3Llt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11C48199B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u18so3934379plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsncogAhRCuozb/yrezW79k4Hulg1xbD7mAra09AC3c=;
        b=tufe3k8H/FBkIj8fXyBbX4aKOPoIIe8c1GiInT95+5spRH9nYTk7NoLwvkdnX+z65w
         kdcsT77vp6uLJtC4cUJWmGLFMgrHeRKtFykTZWSJoy1AicljTWY7ugEfwjYfTl/U1Fv4
         zfpLxLVcH/KKjH3ZqayFF/shH2gOQGzHlltAnGvDBKRt7gqTr0WtN09shgczbXjb+UIn
         vBTcbCAxzUftF7MXb96rw0wui6awS2anzrCvMa8AHgxEeVDKZphxi6zvN7wJpdScOjyj
         od/MEzUBu/LX++asfMvEhacxiOm4Ad156srS2eJDU12oWSksct0CFDzlLbWK4LYH6E/h
         oD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsncogAhRCuozb/yrezW79k4Hulg1xbD7mAra09AC3c=;
        b=VLx4OzmP9N6okS3bAMFwpE6bqPtWeGJ6+HzAIQuTly/TQGX8fP0AGhkubtJ0Nc/IyD
         HZ1G/rrUF7lpVa6eRGRm0aA+5MPob/DzCf5hYiHjcxoKF64j4IkMf6qtwBmkhgqxgmf/
         HYGdAttMVpbwjIsscnzDnlHh/Ho95tO2v85bRD81r0WlnL9yMYIdR2T9x1/4rorr99Q+
         9Ig97898hyXnfUqmIbfxFL98PZfCAQPg27LzLZ6AXJBTq5Ar/v0ZC2QAD9TbXRmKBeQS
         KJu/F5I+VIr3CrhBx4Z0lOO8wgDxy/Osj1rbHFluLxjgfj6oXO7lZATc1cJU6Bzh5Zz3
         PLnQ==
X-Gm-Message-State: AOAM5337vYWXriRVTtoo0HBCpukXLydtKTviNCUtn0D1aoLY5AfhWaJZ
        WMdvMp5McJ7X47aYIRmMcrEzYw==
X-Google-Smtp-Source: ABdhPJxiFB7JuSdYuU8nlkgxclZNB7u2EVI0WqvYOaH3UQ0NlF5XlMPkbTfMEy3hM2gBq5LqGniFMg==
X-Received: by 2002:a17:902:bf4c:b0:15c:3d1b:8a47 with SMTP id u12-20020a170902bf4c00b0015c3d1b8a47mr58147898pls.118.1653910888699;
        Mon, 30 May 2022 04:41:28 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 06/12] perf c2c: Use explicit names for display macros
Date:   Mon, 30 May 2022 19:40:30 +0800
Message-Id: <20220530114036.3225544-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530114036.3225544-1-leo.yan@linaro.org>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
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

Perf c2c tool has an assumption that it heavily depends on HITM snoop
type to detect cache false sharing, unfortunately, HITM is not supported
on some architectures.

Essentially, perf c2c tool wants to find some very costly snooping
operations for false cache sharing, this means it's not necessarily
to stick using HITM tags and we can explore other snooping types
(e.g. SNOOPX_PEER).

For this reason, this patch renames HITM related display macros with
suffix '_HITM', so it can be distinct if later add more display types
for on other snooping type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 01a0656537f6..b50b23ea28ec 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -115,16 +115,16 @@ struct perf_c2c {
 };
 
 enum {
-	DISPLAY_LCL,
-	DISPLAY_RMT,
-	DISPLAY_TOT,
+	DISPLAY_LCL_HITM,
+	DISPLAY_RMT_HITM,
+	DISPLAY_TOT_HITM,
 	DISPLAY_MAX,
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL] = "Local",
-	[DISPLAY_RMT] = "Remote",
-	[DISPLAY_TOT] = "Total",
+	[DISPLAY_LCL_HITM] = "Local",
+	[DISPLAY_RMT_HITM] = "Remote",
+	[DISPLAY_TOT_HITM] = "Total",
 };
 
 static const struct option c2c_options[] = {
@@ -811,15 +811,15 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 	total = &hists->stats;
 
 	switch (c2c.display) {
-	case DISPLAY_RMT:
+	case DISPLAY_RMT_HITM:
 		st  = stats->rmt_hitm;
 		tot = total->rmt_hitm;
 		break;
-	case DISPLAY_LCL:
+	case DISPLAY_LCL_HITM:
 		st  = stats->lcl_hitm;
 		tot = total->lcl_hitm;
 		break;
-	case DISPLAY_TOT:
+	case DISPLAY_TOT_HITM:
 		st  = stats->tot_hitm;
 		tot = total->tot_hitm;
 	default:
@@ -1217,15 +1217,15 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			advance_hpp(hpp, ret);
 
 			switch (c2c.display) {
-			case DISPLAY_RMT:
+			case DISPLAY_RMT_HITM:
 				ret = display_metrics(hpp, stats->rmt_hitm,
 						      c2c_he->stats.rmt_hitm);
 				break;
-			case DISPLAY_LCL:
+			case DISPLAY_LCL_HITM:
 				ret = display_metrics(hpp, stats->lcl_hitm,
 						      c2c_he->stats.lcl_hitm);
 				break;
-			case DISPLAY_TOT:
+			case DISPLAY_TOT_HITM:
 				ret = display_metrics(hpp, stats->tot_hitm,
 						      c2c_he->stats.tot_hitm);
 				break;
@@ -1606,9 +1606,9 @@ static struct c2c_dimension dim_tot_loads = {
 };
 
 static struct c2c_header percent_hitm_header[] = {
-	[DISPLAY_LCL] = HEADER_BOTH("Lcl", "Hitm"),
-	[DISPLAY_RMT] = HEADER_BOTH("Rmt", "Hitm"),
-	[DISPLAY_TOT] = HEADER_BOTH("Tot", "Hitm"),
+	[DISPLAY_LCL_HITM] = HEADER_BOTH("Lcl", "Hitm"),
+	[DISPLAY_RMT_HITM] = HEADER_BOTH("Rmt", "Hitm"),
+	[DISPLAY_TOT_HITM] = HEADER_BOTH("Tot", "Hitm"),
 };
 
 static struct c2c_dimension dim_percent_hitm = {
@@ -2101,15 +2101,15 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
 	switch (c2c.display) {
-	case DISPLAY_LCL:
+	case DISPLAY_LCL_HITM:
 		he->filtered = filter_display(c2c_he->stats.lcl_hitm,
 					      stats->lcl_hitm);
 		break;
-	case DISPLAY_RMT:
+	case DISPLAY_RMT_HITM:
 		he->filtered = filter_display(c2c_he->stats.rmt_hitm,
 					      stats->rmt_hitm);
 		break;
-	case DISPLAY_TOT:
+	case DISPLAY_TOT_HITM:
 		he->filtered = filter_display(c2c_he->stats.tot_hitm,
 					      stats->tot_hitm);
 		break;
@@ -2132,13 +2132,13 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 		return true;
 
 	switch (c2c.display) {
-	case DISPLAY_LCL:
+	case DISPLAY_LCL_HITM:
 		has_record = !!c2c_he->stats.lcl_hitm;
 		break;
-	case DISPLAY_RMT:
+	case DISPLAY_RMT_HITM:
 		has_record = !!c2c_he->stats.rmt_hitm;
 		break;
-	case DISPLAY_TOT:
+	case DISPLAY_TOT_HITM:
 		has_record = !!c2c_he->stats.tot_hitm;
 		break;
 	default:
@@ -2835,11 +2835,11 @@ static int setup_display(const char *str)
 	const char *display = str ?: "tot";
 
 	if (!strcmp(display, "tot"))
-		c2c.display = DISPLAY_TOT;
+		c2c.display = DISPLAY_TOT_HITM;
 	else if (!strcmp(display, "rmt"))
-		c2c.display = DISPLAY_RMT;
+		c2c.display = DISPLAY_RMT_HITM;
 	else if (!strcmp(display, "lcl"))
-		c2c.display = DISPLAY_LCL;
+		c2c.display = DISPLAY_LCL_HITM;
 	else {
 		pr_err("failed: unknown display type: %s\n", str);
 		return -1;
@@ -2927,9 +2927,9 @@ static int setup_coalesce(const char *coalesce, bool no_source)
 		return -1;
 
 	if (asprintf(&c2c.cl_resort, "offset,%s",
-		     c2c.display == DISPLAY_TOT ?
+		     c2c.display == DISPLAY_TOT_HITM ?
 		     "tot_hitm" :
-		     c2c.display == DISPLAY_RMT ?
+		     c2c.display == DISPLAY_RMT_HITM ?
 		     "rmt_hitm,lcl_hitm" :
 		     "lcl_hitm,rmt_hitm") < 0)
 		return -ENOMEM;
@@ -3085,11 +3085,11 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "ld_rmthit,rmt_hitm,"
 		     "dram_lcl,dram_rmt";
 
-	if (c2c.display == DISPLAY_TOT)
+	if (c2c.display == DISPLAY_TOT_HITM)
 		sort_str = "tot_hitm";
-	else if (c2c.display == DISPLAY_RMT)
+	else if (c2c.display == DISPLAY_RMT_HITM)
 		sort_str = "rmt_hitm";
-	else if (c2c.display == DISPLAY_LCL)
+	else if (c2c.display == DISPLAY_LCL_HITM)
 		sort_str = "lcl_hitm";
 
 	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
-- 
2.25.1

