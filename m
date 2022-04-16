Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E79503764
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiDPPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiDPPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:43:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782C43AED
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:40:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bg9so11241115pgb.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5d0zYZ5+/Tkvm61fQS6okbc7Mh/5Bl30pRUEHW+V10=;
        b=oSFmSrkpPKvO9fbkYCk3UdWDdX/mtlRloZeotCBLoIWSWfHiAKegibFwinUMtfz1qB
         shDnTy0WmJClr2IOacTGrFkl022+olnKdy18nMYZlMalZLe3Oc8l8pk/f9uAzbjvNTRO
         53ZMPSQ/efIO3yZ+V4WJjzFpZZOymdo2Ysx5IydbOC5xMTGVamcpVsWK2uZEtyBz8DEQ
         GOP7ukqmu93EdT2IHOKwXF+vgB5Hlgboy4sHZuzXiKnNEE666nd6ny/pUhh4bgDxior0
         QDGhSUhrQrxl41zX0OtLomtHsQD5n0wS9SC9EtL/P1Zcv7UfNBcwfPhVcH5MQflsa6no
         VWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5d0zYZ5+/Tkvm61fQS6okbc7Mh/5Bl30pRUEHW+V10=;
        b=STYxQMAHDJVQX4DPEN1PHX2IjrRegzjhpCequOL9C/jZ9zLtV6PjDP5JBKy/K300OI
         hLSkVu24LThUMHvAFeCJlYmMvcrYrUFTu3xkMmADbhRfomkVdt6wBIlxFrPLiPwC53yL
         vaVkQuYORZ7fn1yWeLgdLqhaW+IEHCfq2+tZTz9qA6Qv/UHPv7/VMp2dX7bo8UHl8vIG
         sIsj0E5ZQF6EcBS3pLRsJh598Lv1qqPNHOVP2g1zr2BcTPS7xgZiYEKzfpriy9vxdN3k
         c8GIbK/8JPK8dMRT6UA/WVYPE/H6r/m+E+Yx/5Rkf9ZiTOZOXoAnDdmPAUsSltbv7cbH
         d8zg==
X-Gm-Message-State: AOAM531SXNpqsqCPGrbE1J29zMiZPHGZiMA5MAA24S4I96oWW5VYA7d+
        QqH+Aqp4G2dayfM5d+i0BUISiw==
X-Google-Smtp-Source: ABdhPJwD7nKEqOCPfjWoGBGIhtOXB1UHAVlIYGzQsWeQMBVdVCX96tWC47BU4QdMtgGQ8SsoCLDI4Q==
X-Received: by 2002:aa7:9afc:0:b0:50a:4b33:a1d6 with SMTP id y28-20020aa79afc000000b0050a4b33a1d6mr3895374pfp.30.1650123649231;
        Sat, 16 Apr 2022 08:40:49 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm6358681pfh.174.2022.04.16.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 08:40:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/5] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
Date:   Sat, 16 Apr 2022 23:40:13 +0800
Message-Id: <20220416154013.1357444-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416154013.1357444-1-leo.yan@linaro.org>
References: <20220416154013.1357444-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes to use bucket value to set bandwidth and clock rates.

This patch introduces function qcom_icc_bus_aggregate() to calculate the
aggregate average and peak bandwidths for every bucket, and also it
calculates the maximum aggregate values across all buckets.

The maximum aggregate values are used to calculate the final bandwidth
requests.  And we can set the clock rate per bucket, we use SLEEP bucket
as default bucket if a platform doesn't enable the interconnect path
tags in DT binding; otherwise, we use WAKE bucket to set active clock
and use SLEEP bucket for other clocks.  So far we don't use AMC bucket.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 80 ++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 13 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 41c108a96ea7..c1705b6a6b15 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -282,29 +282,72 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	return 0;
 }
 
+/**
+ * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
+ * @provider: generic interconnect provider
+ * @agg_avg: an array for aggregated average bandwidth of buckets
+ * @agg_peak: an array for aggregated peak bandwidth of buckets
+ * @max_agg_avg: pointer to max value of aggregated average bandwidth
+ * @max_agg_peak: pointer to max value of aggregated peak bandwidth
+ */
+static void qcom_icc_bus_aggregate(struct icc_provider *provider,
+				   u64 *agg_avg, u64 *agg_peak,
+				   u64 *max_agg_avg, u64 *max_agg_peak)
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
+	*max_agg_peak = 0;
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
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
+		*max_agg_peak = max_t(u64, *max_agg_peak, agg_peak[i]);
+	}
+}
+
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
 	struct icc_provider *provider;
-	struct icc_node *n;
 	u64 sum_bw;
 	u64 max_peak_bw;
 	u64 rate;
-	u32 agg_avg = 0;
-	u32 agg_peak = 0;
+	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 max_agg_avg, max_agg_peak;
 	int ret, i;
+	int bucket;
 
 	qn = src->data;
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	list_for_each_entry(n, &provider->nodes, node_list)
-		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
-				    &agg_avg, &agg_peak);
+	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg,
+			       &max_agg_peak);
 
-	sum_bw = icc_units_to_bps(agg_avg);
-	max_peak_bw = icc_units_to_bps(agg_peak);
+	sum_bw = icc_units_to_bps(max_agg_avg);
+	max_peak_bw = icc_units_to_bps(max_agg_peak);
 
 	if (!qn->qos.ap_owned) {
 		/* send bandwidth request message to the RPM processor */
@@ -318,12 +361,23 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	rate = max(sum_bw, max_peak_bw);
-
-	do_div(rate, qn->buswidth);
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
+		do_div(rate, qn->buswidth);
+		rate = min_t(u64, rate, LONG_MAX);
+
 		if (qp->bus_clk_rate[i] == rate)
 			continue;
 
-- 
2.25.1

