Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41635663E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiGEHYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiGEHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:24:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4029E1180D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:24:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c13so6537887pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOcKN2QE8NoS+NlXFqyzvr6uXu60h5tTF9oQlF/WJLc=;
        b=s7Q88hrh7bJzLKlFegkNpg8ZPPziy4r9+E/kiHx9wDrjOW5NWcgtVPxwtLfnWsIpZJ
         1wsJSJ05l4Nbv41ERPdxwd9NqMsLvQBaLMXmYiBgCBzJqDXJIR8g7rI9fNr8Ia/NZr2F
         jWyCSJEuLVkAghRDvZMoUDjLKFrpcevsc8DTMUlkuS2Oqz5vsQBEwTZ1j9FbcJxbPgwU
         5CORHCVkbcEmHGnDXFau/ssE9TAJ9E8JClzGlVx/ldAR4X2kIAW4fBgcdA9MJizSJOG2
         Zam/cHVCKtZe+xpxK2/dgr20uC/jdeUa28dweu8Ad8ERBRYI9XsOLZipMjOIwnZ8gcaI
         1TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOcKN2QE8NoS+NlXFqyzvr6uXu60h5tTF9oQlF/WJLc=;
        b=OzMdjbxVkWJxVhAUXo7PAkMfPYGRQNKW8BgoYpg1NhRQYwaZOgH43j8UKIubRQ8uBA
         ouzXWUvUDM3hII/tOK3mjGEuHnjp07jB9wpN+G8r3IXCzYV1EIa+lBOQpAzdEK9UN9tK
         OOT4ESinmcxp4JlE9ybgDR08tXgCYoM6z7wczaQJggLB468GZqfguRxtCPDOIWrbwodS
         hvA/6S3Qdl1zmE/FZEnZQ7jn7Jl0Er0svBjd4xgiYldxf8IJdlL5reTr1yBwkoVE6YYr
         SccIbtH5m7m00nDdiBZq9rRgu0XjJofbgVPnKDxrwogYDMs3Lrpncl0YGeXt6ccs7Fik
         qQ3A==
X-Gm-Message-State: AJIora+bEdvcAaUoUBs6AnkOpzsJ4SGYMilTqfIc9pv2VfmQ+1ENv0FO
        k0d6wSAKtUkRrEzZqCSDJQY4HQ==
X-Google-Smtp-Source: AGRyM1v/Au04ujMM00dAgBgOS4l02PNahZrcxmnKk5OipGH8+eIpVydJoO0X1cr4fZaIaHiIN5l2xg==
X-Received: by 2002:a17:90b:3e86:b0:1ec:f7e8:e4e4 with SMTP id rj6-20020a17090b3e8600b001ecf7e8e4e4mr42073633pjb.218.1657005843390;
        Tue, 05 Jul 2022 00:24:03 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b0050dc76281f0sm22148016pfb.202.2022.07.05.00.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:24:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 5/5] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
Date:   Tue,  5 Jul 2022 15:23:36 +0800
Message-Id: <20220705072336.742703-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705072336.742703-1-leo.yan@linaro.org>
References: <20220705072336.742703-1-leo.yan@linaro.org>
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

