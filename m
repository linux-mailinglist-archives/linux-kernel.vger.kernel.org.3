Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B958F795
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiHKG0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiHKGZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:25:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD874CDE
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w14so16157783plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KnWKrrjawRTLOiYleRgV3PDi8JFvvBPnPLiWcsRBXJA=;
        b=Wck12WVdi/621N01A1wNtWUHy9F3EGU+P2AYXxv9xTLE50qIp6cX/e4fAhp7jBf1DF
         Uybcqy/Y7rwExBEBriginoAgd9hnvxC90/yENYjIZBCWW0Z3uxDNcjOnnxcB0nMPAFmA
         BQ5l3sfrksJin8TRci2uKzxzhJRiVykPITguk42FB8quNB91WqFtV6GwsYW4ohsnqx4u
         Nms/RIomji7n8YE47i4gsG1pR4uT1QJyUESKdb82lHF/Lr8CymO2rqGVn3GB3+sXqymk
         jgwmP+BWbQcYtYu4vybY6o6ExhnQiFLOZPjDIxuKMb14bPYYrGadajne3NcuDB95Rbu8
         HlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KnWKrrjawRTLOiYleRgV3PDi8JFvvBPnPLiWcsRBXJA=;
        b=7+T0Q1FrkoCr4xScSZ/mRLqfA4eKet/XLJ4FnYhPcH6QqDbSggyIK6LbhEZYK7uMez
         RH7yXVSavigirGiRO/SSKeKLxQgLQODOBGqEFrgW1H6rQwJsmsvtPif7hnqt+NCj0VuE
         A3o0g0cP7MES61a2rIHJ0P+lrcm1GRRLzL+XamppFTP6AxmGnj6d1PN/5dfwowlQC+iO
         /o8S5pepSfqdzqElBhoNi+T6NZTbDVSBXYVgIuxGMmh2pjqSeafubLBX3TfO5lseCenC
         ucGC0k+nXyIk6xD8c+sqdhtUzqV+pj4SmqVo1GQr9ISTiW0ZVxWhaEkkxhIkAWROGphR
         rt+g==
X-Gm-Message-State: ACgBeo2n1FYG3Njx5q5Kxy3IGoDytsdPEd0QQedpkV3CerKkJSMewSnc
        pLDnME2c6esYXTVfK5WiK26K36M9Akqa3qVUOXc=
X-Google-Smtp-Source: AA6agR7Ppt2+A2Pqs9k402jJcp3AHfjonp0bbtJHBieXzKmidSVkjOxrwHydskVNPI2YlzxKyhDxUw==
X-Received: by 2002:a17:903:2646:b0:16f:1d75:3101 with SMTP id je6-20020a170903264600b0016f1d753101mr30681593plb.111.1660199149210;
        Wed, 10 Aug 2022 23:25:49 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 08/15] perf c2c: Add mean dimensions for peer operations
Date:   Thu, 11 Aug 2022 14:24:44 +0800
Message-Id: <20220811062451.435810-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
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

This patch adds two dimensions for the mean value of peer operations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index dd47f068b8da..8dd9218a052f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -55,6 +55,8 @@ struct c2c_hists {
 struct compute_stats {
 	struct stats		 lcl_hitm;
 	struct stats		 rmt_hitm;
+	struct stats		 lcl_peer;
+	struct stats		 rmt_peer;
 	struct stats		 load;
 };
 
@@ -154,6 +156,8 @@ static void *c2c_he_zalloc(size_t size)
 
 	init_stats(&c2c_he->cstats.lcl_hitm);
 	init_stats(&c2c_he->cstats.rmt_hitm);
+	init_stats(&c2c_he->cstats.lcl_peer);
+	init_stats(&c2c_he->cstats.rmt_peer);
 	init_stats(&c2c_he->cstats.load);
 
 	return &c2c_he->he;
@@ -253,6 +257,10 @@ static void compute_stats(struct c2c_hist_entry *c2c_he,
 		update_stats(&cstats->rmt_hitm, weight);
 	else if (stats->lcl_hitm)
 		update_stats(&cstats->lcl_hitm, weight);
+	else if (stats->rmt_peer)
+		update_stats(&cstats->rmt_peer, weight);
+	else if (stats->lcl_peer)
+		update_stats(&cstats->lcl_peer, weight);
 	else if (stats->load)
 		update_stats(&cstats->load, weight);
 }
@@ -1280,6 +1288,8 @@ __func(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp, struct hist_entry *he)	\
 MEAN_ENTRY(mean_rmt_entry,  rmt_hitm);
 MEAN_ENTRY(mean_lcl_entry,  lcl_hitm);
 MEAN_ENTRY(mean_load_entry, load);
+MEAN_ENTRY(mean_rmt_peer_entry, rmt_peer);
+MEAN_ENTRY(mean_lcl_peer_entry, lcl_peer);
 
 static int
 cpucnt_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -1750,6 +1760,22 @@ static struct c2c_dimension dim_mean_load = {
 	.width		= 8,
 };
 
+static struct c2c_dimension dim_mean_rmt_peer = {
+	.header		= HEADER_SPAN("---------- cycles ----------", "rmt peer", 2),
+	.name		= "mean_rmt_peer",
+	.cmp		= empty_cmp,
+	.entry		= mean_rmt_peer_entry,
+	.width		= 8,
+};
+
+static struct c2c_dimension dim_mean_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("lcl peer"),
+	.name		= "mean_lcl_peer",
+	.cmp		= empty_cmp,
+	.entry		= mean_lcl_peer_entry,
+	.width		= 8,
+};
+
 static struct c2c_dimension dim_cpucnt = {
 	.header		= HEADER_BOTH("cpu", "cnt"),
 	.name		= "cpucnt",
@@ -1835,6 +1861,8 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_node,
 	&dim_mean_rmt,
 	&dim_mean_lcl,
+	&dim_mean_rmt_peer,
+	&dim_mean_lcl_peer,
 	&dim_mean_load,
 	&dim_cpucnt,
 	&dim_srcline,
-- 
2.34.1

