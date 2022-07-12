Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C266570FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiGLCAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGLCAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:00:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC255088
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:00:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j3so6268137pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrLh+9lwzn/hVK+x3i4SIxhqvOdLJGufkP7mGEFOm9c=;
        b=JyNI/FbvGc5ZUsCcMu6of1CIJXsDPu4qESFa1L5GYZGcSmZSGD8HmF22chR05DLpNR
         IwQQMOPJil0jwSX2iHcKnJ3iSxEYyRuknAPgeLLG+j2fHk9ZexDrMQ/XNY4hF7QLAtMg
         Kc3IPFq3PPIYubiXI8KZjFtz33sD55mf++AVbQPYU9y9Su/kRVTpr+H6kPLBSZ/owavj
         JmyCUWr9oqqYOK8yVHEcoI+dEgjMzxaqTnjaUCJ5/E4wvrRLMhcI1JQApHRZj7G1E7lZ
         oTLUus32jmtgFUQkaDf3Wt4+nVFSKLzuCu+y6hHUOpx24WdzxWfRYgj1d3NriUnmOJMB
         xNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrLh+9lwzn/hVK+x3i4SIxhqvOdLJGufkP7mGEFOm9c=;
        b=VdYNm6zukYbueye6dOGpsQOB75LucaYgK79oqu6ERaITTZd4OdLO5vB/AKfREnr4dS
         wVegXe3hEEnDAlTVUOLov96xczCtIsgTHm2Nae0D4NeihBLTJ6lKyE9DKfOtwJQZVSyX
         dZIoIne/o+7giWCU7eOyXhBwsJhwUChHhzQHH73vEco9oyHBWJG0ejMBIn4w6QVcSHbR
         BgTqVM7lBuEI7Sk1e6Jhd7SI7YSSQU/ZKOodtu7zd3VeL8CE4TfVdxaSx0naR1SZKhJL
         68V6Qhc4bVJus4nXjLbjtxvG5SaZ4HzIElJ6hfepL6/xJBBdUCT5ZWXkvOV19dHZ8fGj
         HIdg==
X-Gm-Message-State: AJIora/E3K1Q39aT17aAG+fplxIo3oZgac71upSzozSok406tZKfTKd4
        aOMXnAX4RCQQFUtgoPrDmwjYCA==
X-Google-Smtp-Source: AGRyM1vvGyt5VystS+i0DJ7EvZGc01AZoMkAN3JlckCOtoxswxdxThw9EmkygDkwOIo8HzjlAeHQuA==
X-Received: by 2002:a62:5bc5:0:b0:528:c346:9632 with SMTP id p188-20020a625bc5000000b00528c3469632mr21427527pfb.48.1657591216051;
        Mon, 11 Jul 2022 19:00:16 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a6b4500b001ef76dbae28sm5425821pjl.36.2022.07.11.19.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:00:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 5/5] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
Date:   Tue, 12 Jul 2022 09:59:29 +0800
Message-Id: <20220712015929.2789881-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712015929.2789881-1-leo.yan@linaro.org>
References: <20220712015929.2789881-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit uses buckets for support bandwidth and clock rates.  It
introduces a new function qcom_icc_bus_aggregate() to calculate the
aggregate average and peak bandwidths for every bucket, and also it
calculates the maximum value of aggregated average bandwidth across all
buckets.

The maximum aggregated average is used to calculate the final bandwidth
requests.  And we can set the clock rate per bucket, we use SLEEP bucket
as default bucket if a platform doesn't enable the interconnect path
tags in DT binding; otherwise, we use WAKE bucket to set active clock
and use SLEEP bucket for other clocks.  So far we don't use AMC bucket.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 75 +++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index d27b1582521f..7f6a70e0256a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -302,18 +302,57 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	return 0;
 }
 
+/**
+ * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
+ * @provider: generic interconnect provider
+ * @agg_avg: an array for aggregated average bandwidth of buckets
+ * @agg_peak: an array for aggregated peak bandwidth of buckets
+ * @max_agg_avg: pointer to max value of aggregated average bandwidth
+ */
+static void qcom_icc_bus_aggregate(struct icc_provider *provider,
+				   u64 *agg_avg, u64 *agg_peak,
+				   u64 *max_agg_avg)
+{
+	struct icc_node *node;
+	struct qcom_icc_node *qn;
+	int i;
+
+	/* Initialise aggregate values */
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		agg_avg[i] = 0;
+		agg_peak[i] = 0;
+	}
+
+	*max_agg_avg = 0;
+
+	/*
+	 * Iterate nodes on the interconnect and aggregate bandwidth
+	 * requests for every bucket.
+	 */
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		qn = node->data;
+		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+			agg_avg[i] += qn->sum_avg[i];
+			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
+		}
+	}
+
+	/* Find maximum values across all buckets */
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++)
+		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
+}
+
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
 	struct icc_provider *provider;
-	struct icc_node *n;
 	u64 sum_bw;
-	u64 max_peak_bw;
 	u64 rate;
-	u32 agg_avg = 0;
-	u32 agg_peak = 0;
+	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 max_agg_avg;
 	int ret, i;
+	int bucket;
 
 	src_qn = src->data;
 	if (dst)
@@ -321,12 +360,9 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	list_for_each_entry(n, &provider->nodes, node_list)
-		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
-				    &agg_avg, &agg_peak);
+	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
 
-	sum_bw = icc_units_to_bps(agg_avg);
-	max_peak_bw = icc_units_to_bps(agg_peak);
+	sum_bw = icc_units_to_bps(max_agg_avg);
 
 	ret = __qcom_icc_set(src, src_qn, sum_bw);
 	if (ret)
@@ -337,12 +373,23 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	rate = max(sum_bw, max_peak_bw);
-
-	do_div(rate, src_qn->buswidth);
-	rate = min_t(u64, rate, LONG_MAX);
-
 	for (i = 0; i < qp->num_clks; i++) {
+		/*
+		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
+		 * for other clocks.  If a platform doesn't set interconnect
+		 * path tags, by default use sleep bucket for all clocks.
+		 *
+		 * Note, AMC bucket is not supported yet.
+		 */
+		if (!strcmp(qp->bus_clks[i].id, "bus_a"))
+			bucket = QCOM_ICC_BUCKET_WAKE;
+		else
+			bucket = QCOM_ICC_BUCKET_SLEEP;
+
+		rate = icc_units_to_bps(max(agg_avg[bucket], agg_peak[bucket]));
+		do_div(rate, src_qn->buswidth);
+		rate = min_t(u64, rate, LONG_MAX);
+
 		if (qp->bus_clk_rate[i] == rate)
 			continue;
 
-- 
2.25.1

