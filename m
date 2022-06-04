Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77253D582
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350547AbiFDEaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350583AbiFDE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E95737014
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b5so8121743plx.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6VEWmY6DuHMkOh6HqTlb6jLvc+Emj76rtex2ionhAY=;
        b=f2KYLDGltwHeJcv7Zm+Il4ZHmv7MLryeW2B4gKu14lozsW5bteKRF+9Q/XgmN4T9Qf
         SfvYUM9Ek4exDdBF6uRzm/ZCc9EgserRezFPKlys+JJ9QZHvCi7FshynIiR4aca/M2nt
         9Qf5B98O8ywujjvoxxxoQwajjwLyJYuPHxuZNekJjj8cEcNfW4iJPT+K2vAuwJRi6rO9
         M+qfAFOXruK+eHu3Q5LDVfKNRTsJGkGTTzhi3Tfy5ysp5FLS5y9qJ07DRqALhT6CC5Nu
         g4ww5WsNRPG//rrvR6JwIveXrBYLT0RtrFO+EaTdi7KZC5cVW7RauHkEvHKGc697575T
         RhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6VEWmY6DuHMkOh6HqTlb6jLvc+Emj76rtex2ionhAY=;
        b=xCRe9L03msytuwYZZD6yzBFVpWupacQV4QeWZLp1e6zniwjESRpiXSR04aMez9Abu1
         F5XNLIDuU0ZO0p/GYk/L6swaWMDq065L0xVIKXnFLHnC8FcObNWZcFE0aH8eQYSseFvE
         zaQQT3AsJIksFxOQT6IEVCcvSO///yaTlYq7lvYozgoEufRB6KgkoAZf+dLhboD9zkIa
         V9FpZsJSiOkevCwVSPVicWX6qs0fTrfXmzPniVFm3WPo33y71bSpyhlojYyumWV8qt3h
         w7DGp5bnL94jiyXGnCkv6cXaTI7UYd8chwpCBDWnhPzw9JLDLLbb0VJoDGdLstkdZDMn
         v9OQ==
X-Gm-Message-State: AOAM530vGw6WXbq0gSpVcGpdfiPwKRrg+8G+7D1LQh+KF/tKCPyMw+4/
        RsitrEfn5LPwey+xHdGo6wGyGw==
X-Google-Smtp-Source: ABdhPJzyROiuTA/MxC5iDVkugqNxze3C4usCrRKy9Ot7D/f91eyyzkrPRNj14MuM6oxZn16V8gd3bA==
X-Received: by 2002:a17:902:e5cc:b0:167:5526:ea68 with SMTP id u12-20020a170902e5cc00b001675526ea68mr3799065plf.133.1654316991098;
        Fri, 03 Jun 2022 21:29:51 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:50 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 12/17] perf c2c: Rename dimension from 'percent_hitm' to 'percent_costly_snoop'
Date:   Sat,  4 Jun 2022 12:28:15 +0800
Message-Id: <20220604042820.2270916-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
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
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index cbeb1878a71c..66ff834516a2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -798,7 +798,7 @@ percent_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, per);
 }
 
-static double percent_hitm(struct c2c_hist_entry *c2c_he)
+static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *hists;
 	struct c2c_stats *stats;
@@ -838,8 +838,8 @@ static double percent_hitm(struct c2c_hist_entry *c2c_he)
 })
 
 static int
-percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-		   struct hist_entry *he)
+percent_costly_snoop_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
 	int width = c2c_width(fmt, hpp, he->hists);
@@ -847,20 +847,20 @@ percent_hitm_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
@@ -870,8 +870,8 @@ percent_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	c2c_left  = container_of(left, struct c2c_hist_entry, he);
 	c2c_right = container_of(right, struct c2c_hist_entry, he);
 
-	per_left  = percent_hitm(c2c_left);
-	per_right = percent_hitm(c2c_right);
+	per_left  = percent_costly_snoop(c2c_left);
+	per_right = percent_costly_snoop(c2c_right);
 
 	return per_left - per_right;
 }
@@ -1605,17 +1605,17 @@ static struct c2c_dimension dim_tot_loads = {
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
 
@@ -1844,7 +1844,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_ld_rmthit,
 	&dim_tot_recs,
 	&dim_tot_loads,
-	&dim_percent_hitm,
+	&dim_percent_costly_snoop,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
 	&dim_percent_rmt_peer,
@@ -2748,7 +2748,7 @@ static int ui_quirks(void)
 		nodestr = "CL";
 	}
 
-	dim_percent_hitm.header = percent_hitm_header[c2c.display];
+	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
 
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line("Cacheline", dim_dcacheline.width +
@@ -3076,7 +3076,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		     "dcacheline,"
 		     "dcacheline_node,"
 		     "dcacheline_count,"
-		     "percent_hitm,"
+		     "percent_costly_snoop,"
 		     "tot_hitm,lcl_hitm,rmt_hitm,"
 		     "tot_recs,"
 		     "tot_loads,"
-- 
2.25.1

