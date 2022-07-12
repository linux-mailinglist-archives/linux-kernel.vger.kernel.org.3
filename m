Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4059570FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiGLCAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiGLCAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:00:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171F8C146
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:00:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c15so1161240pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsuVX4+Fk0zEwgcAXa4p8Pic6TFa+DVD5bKVK4M/r5c=;
        b=vYTRoalIhOF+nKTiZoFImZ9iTMUHU65EKw3h40WV0sfhu/d/HW+lh1rMcySSoFIX87
         /iQii+hu0HF+p3+LmLIPg960iL6Ap55/nRrqhnFUl5AZFZ5phg97Zzj8N+IG25ooXAZQ
         Tlk2Qq5YzP9CDxbZs0q2uQ/u6PY85YP4L8bmZ07o3MIwd28MrWJU79fOCXaIzOcfMrAi
         XJiF6Re8FeUSwKswx8jDITiQyh5oeDLbsCUWj9hg9xvIoM3/jg/HLMbDT5pMcS3RdwHN
         Gwrb8/jigWfkOOButJsUaknxK0ve8FXcVySFBMHmwC9sTb1b9nvfqezzXiLRX8nNsHge
         J1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsuVX4+Fk0zEwgcAXa4p8Pic6TFa+DVD5bKVK4M/r5c=;
        b=qFM159w2V/haqlYP1xL9Ule76RY/pryqWZAkReRChI5YtRu82i/R4/0ofibLJC8wUY
         abydZ6szuUxTyoOSi62VJ94FeGMtfqdyYffoMgWwo1PTR7Hf84bX3D2fTgqlceY2f7Xa
         tOOV2dzjEnj0pn/f/6Cd7J2rRSROXMvKQf6gJqeDxkgNKkkJ6l2y6kN95YPpppu4LeQ3
         a4fXdPFqf5dmcrgGg9xHwNwSr4MkrCK8QqvFiUdOb9/GsgqI9SBpifSkeS/MaodxE0gG
         3OlMpCW7u7/dETcjaS8eCsl5LwF9++Mdqq3ZvZvM/Q0RSIXdtx1et1Z7KL+wjBQCmMEC
         QA5g==
X-Gm-Message-State: AJIora9YDSxkhRKmZ9kjPh8Pq1eBOCfrYJAjvcAbjO5SKA5k4pAwja+B
        wnCBGzl0dCSpzL6z3RdYzOYG8w==
X-Google-Smtp-Source: AGRyM1sk/6vX00lbG2KXqurWWloZZq1JohhFyh20A8u3+Gaikm0W/BjEZs8fNbwXcQ8Pv4AtAiSSRw==
X-Received: by 2002:a17:902:e9d3:b0:16b:fe8c:e89b with SMTP id 19-20020a170902e9d300b0016bfe8ce89bmr21981830plk.81.1657591212581;
        Mon, 11 Jul 2022 19:00:12 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a6b4500b001ef76dbae28sm5425821pjl.36.2022.07.11.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:00:12 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 4/5] interconnect: qcom: icc-rpm: Support multiple buckets
Date:   Tue, 12 Jul 2022 09:59:28 +0800
Message-Id: <20220712015929.2789881-5-leo.yan@linaro.org>
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

The current interconnect rpm driver uses a single aggregate bandwidth to
calculate the clock rates for both active and sleep clocks; therefore,
it has no chance to separate bandwidth requests for these two kinds of
clocks.

This patch studies the implementation from interconnect rpmh driver to
support multiple buckets.  The rpmh driver provides three buckets for
AMC, WAKE, and SLEEP; this driver only needs to use WAKE and SLEEP
buckets, but we keep the same way with rpmh driver, this can allow us to
reuse the DT binding and avoid to define duplicated data structures.

This patch introduces two callbacks: qcom_icc_pre_bw_aggregate() is used
to clean up bucket values before aggregate bandwidth requests, and
qcom_icc_bw_aggregate() is to aggregate bandwidth for buckets.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 51 ++++++++++++++++++++++++++++-
 drivers/interconnect/qcom/icc-rpm.h |  6 ++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 8c9d5cc7276c..d27b1582521f 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -254,6 +254,54 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 	return 0;
 }
 
+/**
+ * qcom_icc_pre_bw_aggregate - cleans up values before re-aggregate requests
+ * @node: icc node to operate on
+ */
+static void qcom_icc_pre_bw_aggregate(struct icc_node *node)
+{
+	struct qcom_icc_node *qn;
+	size_t i;
+
+	qn = node->data;
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		qn->sum_avg[i] = 0;
+		qn->max_peak[i] = 0;
+	}
+}
+
+/**
+ * qcom_icc_bw_aggregate - aggregate bw for buckets indicated by tag
+ * @node: node to aggregate
+ * @tag: tag to indicate which buckets to aggregate
+ * @avg_bw: new bw to sum aggregate
+ * @peak_bw: new bw to max aggregate
+ * @agg_avg: existing aggregate avg bw val
+ * @agg_peak: existing aggregate peak bw val
+ */
+static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				 u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	size_t i;
+	struct qcom_icc_node *qn;
+
+	qn = node->data;
+
+	if (!tag)
+		tag = QCOM_ICC_TAG_ALWAYS;
+
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		if (tag & BIT(i)) {
+			qn->sum_avg[i] += avg_bw;
+			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
+		}
+	}
+
+	*agg_avg += avg_bw;
+	*agg_peak = max_t(u32, *agg_peak, peak_bw);
+	return 0;
+}
+
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_icc_provider *qp;
@@ -414,7 +462,8 @@ int qnoc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
-	provider->aggregate = icc_std_aggregate;
+	provider->pre_aggregate = qcom_icc_pre_bw_aggregate;
+	provider->aggregate = qcom_icc_bw_aggregate;
 	provider->xlate_extended = qcom_icc_xlate_extended;
 	provider->data = data;
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index ebee9009301e..a49af844ab13 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <dt-bindings/interconnect/qcom,icc.h>
+
 #define RPM_BUS_MASTER_REQ	0x73616d62
 #define RPM_BUS_SLAVE_REQ	0x766c7362
 
@@ -65,6 +67,8 @@ struct qcom_icc_qos {
  * @links: an array of nodes where we can go next while traversing
  * @num_links: the total number of @links
  * @buswidth: width of the interconnect between a node and the bus (bytes)
+ * @sum_avg: current sum aggregate value of all avg bw requests
+ * @max_peak: current max aggregate value of all peak bw requests
  * @mas_rpm_id:	RPM id for devices that are bus masters
  * @slv_rpm_id:	RPM id for devices that are bus slaves
  * @qos: NoC QoS setting parameters
@@ -75,6 +79,8 @@ struct qcom_icc_node {
 	const u16 *links;
 	u16 num_links;
 	u16 buswidth;
+	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
+	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
 	int mas_rpm_id;
 	int slv_rpm_id;
 	struct qcom_icc_qos qos;
-- 
2.25.1

