Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A677570151
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiGKLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGKLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:53:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0886825EBF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:53:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q82so4522233pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9C4b2eXgqDOnaISTWY3hd8BHivbis4FswsOZcWe/jU=;
        b=vUebZIGKNacxF3KqZp8W0o7xTR8bwMilpI1OMr+YKfjbmxpHzCKq8DfP+s/d7BrbKk
         vqUfx0AJTq+tlRaVvaCvg6+cewoJZY4++sqiwpgU2wMvnnoA1cKwdpZU+9+yLTwHCU6R
         ygRvVQDUiggbMbr07B0VtyBk1eXhHVVZbCanUv6uOoiFaATgLNuRSfXyUZ5yjp0qfrrs
         Ouogbe02NP7BFzX25uiWgLFH5XvVG2A3A52pHpdjNt9Pnfh1dnIyt9IvKh8HtAssLccG
         /rDbXdNYAeGCVDYP0CLq/+dnumAW/bT17c+SyoL4AaSEg6jtLvgWHwKAjEkIqAPXuj/u
         yYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9C4b2eXgqDOnaISTWY3hd8BHivbis4FswsOZcWe/jU=;
        b=7xbej/VhvQQEWlufkNz0zx/kL9wqdzjv1uLE+Nj51w6CIzhpQxsqKRFX6MveWY+Fh9
         uMXFWEvdFpBSh4ZyzIiEolucO6n4Hcc9cBkV5HDROL/MyrQzjXbBMPo5vlJbbvgDPoDI
         VWNFOxWwEX55CRN1GcNOcyJl0CDho7Dp1v9HSx3dar6Rhx2P/hoWDv19vMWXmDMTS/mk
         BWaelKoKr4zeNsWsP82plzOvnOUgVNdv3M8iWMScyleCoZYwP5MhFkQPRCuR6+wHi7Z5
         OiAoeif/kEBxCJBLkhEZpW6WRBczZ97AJ2K/RivHSKghK/9PuVP5OoIcbL6M8mSWgd46
         QJfw==
X-Gm-Message-State: AJIora/0zifFtzCsj3EwZjCBzM9L7QJiRc+z7nZbgwGc7swjPJUyNzxR
        9Q4FOHgyBcLX1Y2Nw1LDf6p/TA==
X-Google-Smtp-Source: AGRyM1vpZXo8S0A+cw9lPocExuKZFE4v5svlvg3jjLPozwoQPPVwu6Nf4Qtp7bhf5TPqR8+tyxmQXw==
X-Received: by 2002:a63:9701:0:b0:40c:a588:b488 with SMTP id n1-20020a639701000000b0040ca588b488mr15689995pge.303.1657540389089;
        Mon, 11 Jul 2022 04:53:09 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a648e00b001eaec8cea55sm4586502pjj.57.2022.07.11.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:53:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 5/5] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
Date:   Mon, 11 Jul 2022 19:52:40 +0800
Message-Id: <20220711115240.806236-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711115240.806236-1-leo.yan@linaro.org>
References: <20220711115240.806236-1-leo.yan@linaro.org>
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
index d27b1582521f..f15f5deee6ef 100644
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
+	u64 max_agg_avg, max_agg_peak;
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

