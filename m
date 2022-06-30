Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2556121D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiF3F6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiF3F6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:58:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD611038
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 22:58:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 128so17115691pfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZw35i4tD7dQYkHhZWLzGB0BrtXzLncPfNzT7OZ+gHQ=;
        b=MnrkkkQngsd882Zalre1QkUMe2ArvPJYExWnuAXbTuXsuU2qRxNOE5BVO1bfkeE1Re
         puXMlzWxtZ35+ltaHCe+oT8MWh8sKhbBMn8NR6K4m8xfG90bn0nlzaTglNagAg3JEE+J
         UTr/DVFQix0Z5NVe3RO+R8qPtVmQwR7RWW4TBe5IHR+QiUJR4ga6QZLCqR3aVFcqlSWu
         giLINCkQ8dMjmoqg1R0Ayj7DSzy9TODnxJzSNE767uqfRvp1zjHgtMLXzRiRKH44Sbpp
         9v0Psj1iendUbddbUSqzWmcmtr6qg3K8euV3dZi3F7cVY05hPVukCNBooEOKPgCY8pFC
         SPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZw35i4tD7dQYkHhZWLzGB0BrtXzLncPfNzT7OZ+gHQ=;
        b=xOdZEbg5OtNUhdcTPBBaB1NlP3l8xTexslF1I+1p99poM3E43z2uphSQCiFrX88Tvg
         D5CiWA7FwA1aNQ9nuWW6eGb8A53KvqInGrLoOezAVw27xbZJvU7YFh91LfEx0Xi/95yt
         M/0hL8TUmZRbig9xH0YEhQjgadIJeoXE/E2YJq9zrNtE9ALwxljGLZ3hldorrRH3RScQ
         m/Dbl7BW0YVSyZvc5rLt0oZIpF3uo6DGII7zxM4wirQPRp9h4jQbRpewjcQ62Vl5P3e0
         P6LBAvPeycZUCCAoWPvtUzrG/NNhHc9KrI8XzMgh0T1wWR/QzBSGf3KXo6HRS8fVqsVq
         FN+g==
X-Gm-Message-State: AJIora9nUS8cckOzsOIy23+RxMA6X4PVC8s3337FWFrg80/U/8n722tX
        PEL6hPQ57DwVmUpuWoLQaYnpCQ==
X-Google-Smtp-Source: AGRyM1s0pbVgYymjRA/AoQmD/YyxHMpMN4XE9vLP38BnWLV3SpmI5t3mWSuoR8Dl1JLjDFosnOFnlg==
X-Received: by 2002:a63:8949:0:b0:40d:44d6:423e with SMTP id v70-20020a638949000000b0040d44d6423emr6141673pgd.525.1656568700955;
        Wed, 29 Jun 2022 22:58:20 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090a550e00b001e31f4cc977sm3309288pji.56.2022.06.29.22.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 22:58:20 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/5] interconnect: qcom: icc-rpm: Support multiple buckets
Date:   Thu, 30 Jun 2022 13:57:21 +0800
Message-Id: <20220630055723.704605-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630055723.704605-1-leo.yan@linaro.org>
References: <20220630055723.704605-1-leo.yan@linaro.org>
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
index 8c9d5cc7276c..b025fc6b97c9 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -254,6 +254,54 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 	return 0;
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

