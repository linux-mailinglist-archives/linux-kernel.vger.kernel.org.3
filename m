Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFE51EC7C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiEHJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiEHJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:29:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCBDE018
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:25:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id bo5so9861444pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUGLoaJd3B+TtNu4b8kB3fkRxS/7EQl4VGMpMCSV3Jc=;
        b=WcsX1Z9JcIs+2mCuBtKVYji34LP/dT9i3R1idr1sUXRNJ9K+X++C8Sjl9mL8UbnUii
         CigGlzLmEtYk/4yFMQjo3mccYBhlj76aqiP8tdbgYtPb7RPT/PIrwMu22q48fqrOL80j
         dbnP/S11EPibLBVpJym5ahAFCbwh7f4PVb43L+8Ekl6gg7F7SBCLbJVVgO6fnP/T8Cid
         H0AiB1Ri3I0nC1izG1lGgjeG+OnaLUJF+cPAz0iit5YbVVMuNKBSnHlSxc4NOmsEme2Q
         fUO0qDUX9ANXfiF975UZx1LukOByflPmNNRhShEENC71z74qyezRrrj5XNKs+vLXMcEY
         lXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUGLoaJd3B+TtNu4b8kB3fkRxS/7EQl4VGMpMCSV3Jc=;
        b=Hdr2QK7dsO9LSNMqHNh7/FRHtDRzMITFvSpZro9DNow7moS+QQsNYH+Wu/V7aSqe4Q
         G/jun2Pi8523CKQdadgbTlZO31UJxU5zPI2nYiiOMjlrNzXriLhUaFFNn4zcq8kaAaK6
         FaDu9/wvigZnJRI3sXAXPoLKIZ6vMNm6WL7BqBxt8yeNdjpYrCdlt6NrGTGDGLd594Cw
         4/rYHHvsnySbgA1VVuOqno4Zl4ASst9gTLk4d4bcX2t519ad8lD2TllMOWaG6h2SYfkD
         LsBclYYdZscFhmrVApJ4Ur90QjkInWIPMbJw3Zog4gE1WuQ9Q7eabSFeV6Sd3a9A8fTS
         06kw==
X-Gm-Message-State: AOAM533OkjK7S7k22B746YJlsA2al6ZF86VbV1gOjNs4wxBxzJs+bhA/
        QLjszB1Hn6uYkG+1eCmORhWFuQ==
X-Google-Smtp-Source: ABdhPJwCPH/k/zt3g/jrNWG8ycYHnRc7fh3h5PiX/79iqwYBimO1ycFpR5t4XPtcqlzjeLUPvYHjjQ==
X-Received: by 2002:a05:6a00:4385:b0:510:4422:aa3a with SMTP id bt5-20020a056a00438500b005104422aa3amr11139190pfb.16.1652001922968;
        Sun, 08 May 2022 02:25:22 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:25:22 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 07/11] perf c2c: Rename dimension from 'percent_hitm' to 'percent_costly_snoop'
Date:   Sun,  8 May 2022 17:23:42 +0800
Message-Id: <20220508092346.255826-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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

Use more general naming for the main sort dimension, this can allow us
not to sort only on HITM snoop type, so it can be extended to support
other costly snooping operations.  So rename the dimension to the prefix
'percent_costly_".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 180208a4085f..1e1565e5d396 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -794,7 +794,7 @@ percent_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, per);
 }
 
-static double percent_hitm(struct c2c_hist_entry *c2c_he)
+static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *hists;
 	struct c2c_stats *stats;
@@ -834,8 +834,8 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 })
 
 static int
-percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		   struct hist_entry *he)
+percent_costly_snoop_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
 	int width = c2c_width(fmt, hpp, he->hists);
@@ -843,20 +843,20 @@ percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	double per;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
-	per = percent_hitm(c2c_he);
+	per = percent_costly_snoop(c2c_he);
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
 }
 
 static int
-percent_hitm_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		   struct hist_entry *he)
+percent_costly_snoop_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
 {
-	return percent_color(fmt, hpp, he, percent_hitm);
+	return percent_color(fmt, hpp, he, percent_costly_snoop);
 }
 
 static int64_t
-percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
-		 struct hist_entry *left, struct hist_entry *right)
+percent_costly_snoop_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			 struct hist_entry *left, struct hist_entry *right)
 {
 	struct c2c_hist_entry *c2c_left;
 	struct c2c_hist_entry *c2c_right;
@@ -866,8 +866,8 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	c2c_left  = container_of(left, struct c2c_hist_entry, he);
 	c2c_right = container_of(right, struct c2c_hist_entry, he);
 
-	per_left  = percent_hitm(c2c_left);
-	per_right = percent_hitm(c2c_right);
+	per_left  = percent_costly_snoop(c2c_left);
+	per_right = percent_costly_snoop(c2c_right);
 
 	return per_left - per_right;
 }
@@ -1544,17 +1544,17 @@ static struct c2c_dimension dim_tot_loads = {
 	.width		= 7,
 };
 
-static struct c2c_header percent_hitm_header[] = {
+static struct c2c_header percent_costly_snoop_header[] = {
 	[DISPLAY_LCL_HITM] = HEADER_BOTH("Lcl", "Hitm"),
 	[DISPLAY_RMT_HITM] = HEADER_BOTH("Rmt", "Hitm"),
 	[DISPLAY_TOT_HITM] = HEADER_BOTH("Tot", "Hitm"),
 };
 
-static struct c2c_dimension dim_percent_hitm = {
-	.name		= "percent_hitm",
-	.cmp		= percent_hitm_cmp,
-	.entry		= percent_hitm_entry,
-	.color		= percent_hitm_color,
+static struct c2c_dimension dim_percent_costly_snoop = {
+	.name		= "percent_costly_snoop",
+	.cmp		= percent_costly_snoop_cmp,
+	.entry		= percent_costly_snoop_entry,
+	.color		= percent_costly_snoop_color,
 	.width		= 7,
 };
 
@@ -1763,7 +1763,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_rmthit,
 	&dim_tot_recs,
 	&dim_tot_loads,
-	&dim_percent_hitm,
+	&dim_percent_costly_snoop,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
 	&dim_percent_ld_peer,
@@ -2665,7 +2665,7 @@ static int ui_quirks(void)
 		nodestr = "CL";
 	}
 
-	dim_percent_hitm.header = percent_hitm_header[c2c.display];
+	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line("Cacheline", dim_dcacheline.width +
@@ -2993,7 +2993,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "dcacheline,"
 		     "dcacheline_node,"
 		     "dcacheline_count,"
-		     "percent_hitm,"
+		     "percent_costly_snoop,"
 		     "tot_hitm,lcl_hitm,rmt_hitm,"
 		     "ld_peer,"
 		     "tot_recs,"
-- 
2.25.1

