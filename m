Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4802550375F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiDPPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiDPPnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:43:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029D43AD0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:40:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so9287816plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pX4HjQ3ivemJ1iGijdmhH5B9H0Rvrrgm3X88jva/bN0=;
        b=ZnmRPloUsbpuCgCElVmAT2qCfPiIHMHTOHu32lcyex9OkH/tkXg8iP7dZYV3y1ridR
         bZN92FcYLJsDaqcPzOAjISj8AU1tSLlmh8hKEbPbVr9BvikAywjadWXI3ZpfLjYkTnjC
         ecr0a+1uXOkN9yP+J7So7OaGVl1DHiPgnCDrVNhtCFLjBpYqyinls2rKwQ3XDlGlYOf1
         /+bI4oDH1baZRj3SinTxatyydbjk3ICYLZYWIjopfPhbRUjORYb5w7IXjtCJgIID2a6z
         kGgfyts2apleJis6U+xSXcRdnormK/rv3aLN94aXv7zSJKXwv73B9OCsyoEh9qcOvzPI
         CFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pX4HjQ3ivemJ1iGijdmhH5B9H0Rvrrgm3X88jva/bN0=;
        b=pWdQQNmDVRplK3Tcqid+JMhNxFDU5cv/rrg+2tgd7ahL3qiCdOwZWX+XZ/8wxBpXtl
         A+ZAeA0skrk9PybgOywK2WdDaBNltX2MUtw//Hhkp9ViX+I2izambefNR9mARGBFdGST
         xXwbCua6Uc0Gk2QROMN8TbloAD0JvimqnGuAzXIejzw/HTzwjezt2cEXzeNQKPELmscT
         hJh+NIsGx48O64ZgDbYcwP0aL/s9ssmR2wVzCW8L+MsNcOgwV3GLtCxMZxJKQ2MWDwRd
         cMrJ2EJPL20X8W4n27Q1uDD5dfVFV/5R4hBy0EbMcZMI+KRXC3HVJL+iY9i1Rqp2kjVH
         V3qw==
X-Gm-Message-State: AOAM533nCR0l+Ml6p8AFCAUJvk9DhXYu7ILjGJjIXixMjQjtXtFBl5mn
        BqBZqh7tAL16TZKo1n5IGT7n6g==
X-Google-Smtp-Source: ABdhPJz0Sh63ihtTleKIFh9pi3M/2idU3a3wqfMXKb0pasbW9De65odsEA68NEdgwQvgcai+ipeJrw==
X-Received: by 2002:a17:90a:b10c:b0:1cb:9e27:5005 with SMTP id z12-20020a17090ab10c00b001cb9e275005mr4375069pjq.241.1650123644465;
        Sat, 16 Apr 2022 08:40:44 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm6358681pfh.174.2022.04.16.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 08:40:43 -0700 (PDT)
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
Subject: [PATCH v1 4/5] interconnect: qcom: icc-rpm: Support multiple buckets
Date:   Sat, 16 Apr 2022 23:40:12 +0800
Message-Id: <20220416154013.1357444-5-leo.yan@linaro.org>
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

The current interconnect rpm driver uses a single aggregate bandwidth to
calculate the clock rates for both active and sleep clocks; therefore,
it has no chance to separate bandwidth requests for these two kinds of
clocks.

This patch studies the implementation from interconnect rpmh driver to
support multiple buckets.  The rpmh driver provides three buckets for
AMC, WAKE, and SLEEP; this driver only needs to use WAKE and sleep
buckets, but we keep the same way with rpmh driver, this can allow us to
reuse the DT binding and also avoid to define duplicated data
structures.

This patch introduces two callbacks: qcom_icc_pre_bw_aggregate() is used
to clean up bucket values before aggregate bandwidth requests, and
qcom_icc_bw_aggregate() is to aggregate bandwidth for buckets.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 51 ++++++++++++++++++++++++++++-
 drivers/interconnect/qcom/icc-rpm.h |  6 ++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 2ffaf9ba08f9..41c108a96ea7 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -234,6 +234,54 @@ static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
 	return ret;
 }
 
+/**
+ * qcom_icc_rpm_pre_bw_aggregate - cleans up values before re-aggregate requests
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
@@ -395,7 +443,8 @@ int qnoc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
-	provider->aggregate = icc_std_aggregate;
+	provider->pre_aggregate = qcom_icc_pre_bw_aggregate;
+	provider->aggregate = qcom_icc_bw_aggregate;
 	provider->xlate_extended = qcom_icc_xlate_extended;
 	provider->data = data;
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index f6c4ac960102..e8ee29ea132f 100644
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

