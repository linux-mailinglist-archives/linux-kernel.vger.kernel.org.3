Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57CA5650F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiGDJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiGDJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:31:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FCDFD6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a15so8427692pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOcKN2QE8NoS+NlXFqyzvr6uXu60h5tTF9oQlF/WJLc=;
        b=KILEUB0HZOxwkq5/XBeqjn/uei8YrkNrsJVZViPmOdE2EraFxs3gPVlS9vaVFq0XsV
         xyilJcHWtyG1L6ky2NJLYlqtWCz5pz9rwz8N2XqcIN6xzN5JMbDz4j45LRocgI6xjf5Q
         xPiPdfHH1DUNY6GGxTSz6SlQLuWWdgw7Md/KsLQ0v8utLsy0q+ZMkq+BbxntG8pZ+hSa
         cd4cbVLrBZTXVniEh8tK7lRVrIPmjEqGB6bKca0jeduHPKZ/X1OTqn8CgHgtA4WWReS6
         e1pUIl2I5ma9I2/6Mjx5WNsCc0XSG+gYr4I/GyOYsEdOj4FRn9hJR7qiqRpmf2nf2Db2
         gegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOcKN2QE8NoS+NlXFqyzvr6uXu60h5tTF9oQlF/WJLc=;
        b=3VN9X9ljx1q/tuuCgklXqTsYPZ5iArzesGdvbdhL63nx0iesZk0QKqRzX58XCOFiti
         ELWoaH3XcPgGgBsbldQkJcF6Ibk2gyOI3s5XQ7Kl7YIxwYDV9Z5MPtfCMrp6pIiNib2W
         z7BXgs6TXz6arIFS9MT28fCsK5Gfpf4v4qKh3zAzOxMLZN/f41CkZPN4+F1dnMbzcckU
         iJMTPmhGyWf39A7SQNVGNLgTeP/MXEPvxD/JNM1v1Z2PPPIe2FFYDEElHAiopfIYtrmg
         PFBGOpE3dHenJSbDxQY5NBbw/SoJ9ARiWjPCinQh6IvJA9wGETnnNB6YaOkTeAawFoZJ
         DIqA==
X-Gm-Message-State: AJIora9cLjCBrMdgoRiSmmyT/21fIp4cYxcc/FBOAq+/dslbBrX5zGZO
        O1eStq4cMkUrnI92mTt4yvNoYQ==
X-Google-Smtp-Source: AGRyM1vbOAdyX1y53+MovHgyFoSWwnefAVPm2My0x0WH3rIth0QFaye33BFc8w+KNPH6F45CqTuocg==
X-Received: by 2002:a63:69c9:0:b0:411:994d:1e12 with SMTP id e192-20020a6369c9000000b00411994d1e12mr20645259pgc.383.1656927053749;
        Mon, 04 Jul 2022 02:30:53 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id ms16-20020a17090b235000b001ef81bac701sm2926177pjb.42.2022.07.04.02.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:30:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 5/5] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
Date:   Mon,  4 Jul 2022 17:30:29 +0800
Message-Id: <20220704093029.1126609-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704093029.1126609-1-leo.yan@linaro.org>
References: <20220704093029.1126609-1-leo.yan@linaro.org>
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
index b025fc6b97c9..4b932eb807c7 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -302,18 +302,62 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
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
 	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
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
 
 	src_qn = src->data;
 	if (dst)
@@ -321,12 +365,11 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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
 
 	ret = __qcom_icc_set(src, src_qn, sum_bw);
 	if (ret)
@@ -337,12 +380,23 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
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

