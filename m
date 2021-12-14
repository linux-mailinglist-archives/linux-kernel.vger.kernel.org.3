Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B269B473F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhLNJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhLNJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:30:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3C3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:30:28 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 200so8039944pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=16VRMFlJxS3daOX0JFWAJjx3G5Yk47/TEZJPFA/aWJM=;
        b=SyfFyx8MT4n1J5ol1EnOZmW1sZBrovqjEj+JSWZCKoqSGD0kR9iXw5TRqD9ddyBwBJ
         tT1BakJMKyhq89Lij1q1vsUXOVQvKz48mTVSrJoypoXHTVcIwR4stDfS+p5Mb3Fk5s2B
         JZSGsPmX7rdmp+faSgg0fcjHOYkDOC0dIWVzN/TdoArLTK9ep0lOBo8bRJkCb5y/cHar
         wXfvH45X0st5qiuHTX5FtQmfyhw0hEjOWJ94GOQmcEL0pOsxuedsvkhBpfgv5V4PYtCc
         Uu+qx7Ra/BycBR6MshvlPyzAgauolNu4lj+zQ8LCGytyj1qTiDlKBIGOY+gOjzeAh0Rn
         3Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=16VRMFlJxS3daOX0JFWAJjx3G5Yk47/TEZJPFA/aWJM=;
        b=RABpVLfvQ+GSI2iVHNrRH/Jv+pdaSQR6XporqSOlhFBRu4iGOD6JVTscIEGiAquoJS
         ro+JlvPaGeyoCVBbyYBMGIHhiNM9ugZ4bnsuVzOvjo+upP5b8ndjGCgGLiiwjEVYEwVX
         Sg3aHtXn5RE17Urc1AwTR/ELRc2CoNWtHPs/wvgF09aRccTRBknihYmw/htI+iMTq5t7
         L7v+KfnqByhudXZ1C5ZS633a7QM/YlkV3T4AoSN5hXNcPshXTHARVPkdJUo6jOKfJ/j+
         dvYXIGl3Py5PeNk3RyUZZz3OVeuNyeB8yLU/Rb7OCB+pATyjnhMe7ldOvGJqDs3FJlcf
         /d2A==
X-Gm-Message-State: AOAM530R89cy+EsF44ySY92KW0/3SjsukYEYEl8plwvKpuOExXhivo75
        bKzL7dSwlnHmb4o3o+20oR8I9g==
X-Google-Smtp-Source: ABdhPJxl+abRHBP0auJl7PPCmBEZuoU7+wqEdUtpvDA7sESkomzhF2mpULQQXdwrRlxjnCWbn06rLg==
X-Received: by 2002:a63:c045:: with SMTP id z5mr2926837pgi.441.1639474227840;
        Tue, 14 Dec 2021 01:30:27 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c21sm15143184pfl.138.2021.12.14.01.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 01:30:27 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 RESEND 2/5] interconnect: icc-rpm: Add QNOC type QoS support
Date:   Tue, 14 Dec 2021 17:30:08 +0800
Message-Id: <20211214093011.19775-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214093011.19775-1-shawn.guo@linaro.org>
References: <20211214093011.19775-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds QoS support for QNOC type device which can be found on QCM2290
platform.  The downstream driver[1] includes support for priority,
limiter, regulator and forwarding setup.  As QCM2290 support only
requires priority and forwarding configuration, limiter and regulator
support are omitted for this initial submission.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.19/tree/drivers/soc/qcom/msm_bus/msm_bus_qnoc_adhoc.c?h=kernel.lnx.4.19.r22-rel

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 38 ++++++++++++++++++++++++++---
 drivers/interconnect/qcom/icc-rpm.h |  3 +++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 429c377231e6..d8ea9bb479b1 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -18,6 +18,13 @@
 #include "smd-rpm.h"
 #include "icc-rpm.h"
 
+/* QNOC QoS */
+#define QNOC_QOS_MCTL_LOWn_ADDR(n)	(0x8 + (n * 0x1000))
+#define QNOC_QOS_MCTL_DFLT_PRIO_MASK	0x70
+#define QNOC_QOS_MCTL_DFLT_PRIO_SHIFT	4
+#define QNOC_QOS_MCTL_URGFWD_EN_MASK	0x8
+#define QNOC_QOS_MCTL_URGFWD_EN_SHIFT	3
+
 /* BIMC QoS */
 #define M_BKE_REG_BASE(n)		(0x300 + (0x4000 * n))
 #define M_BKE_EN_ADDR(n)		(M_BKE_REG_BASE(n))
@@ -40,6 +47,27 @@
 #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
 #define NOC_QOS_MODEn_MASK		0x3
 
+static int qcom_icc_set_qnoc_qos(struct icc_node *src, u64 max_bw)
+{
+	struct icc_provider *provider = src->provider;
+	struct qcom_icc_provider *qp = to_qcom_provider(provider);
+	struct qcom_icc_node *qn = src->data;
+	struct qcom_icc_qos *qos = &qn->qos;
+	int rc;
+
+	rc = regmap_update_bits(qp->regmap,
+			qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+			QNOC_QOS_MCTL_DFLT_PRIO_MASK,
+			qos->areq_prio << QNOC_QOS_MCTL_DFLT_PRIO_SHIFT);
+	if (rc)
+		return rc;
+
+	return regmap_update_bits(qp->regmap,
+			qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+			QNOC_QOS_MCTL_URGFWD_EN_MASK,
+			!!qos->urg_fwd_en << QNOC_QOS_MCTL_URGFWD_EN_SHIFT);
+}
+
 static int qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
 					struct qcom_icc_qos *qos,
 					int regnum)
@@ -164,10 +192,14 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
 
 	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
 
-	if (qp->type == QCOM_ICC_BIMC)
+	switch (qp->type) {
+	case QCOM_ICC_BIMC:
 		return qcom_icc_set_bimc_qos(node, sum_bw);
-
-	return qcom_icc_set_noc_qos(node, sum_bw);
+	case QCOM_ICC_QNOC:
+		return qcom_icc_set_qnoc_qos(node, sum_bw);
+	default:
+		return qcom_icc_set_noc_qos(node, sum_bw);
+	}
 }
 
 static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 2268777348cb..26dad006034f 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -15,6 +15,7 @@
 enum qcom_icc_type {
 	QCOM_ICC_NOC,
 	QCOM_ICC_BIMC,
+	QCOM_ICC_QNOC,
 };
 
 /**
@@ -43,6 +44,7 @@ struct qcom_icc_provider {
  * @ap_owned: indicates if the node is owned by the AP or by the RPM
  * @qos_mode: default qos mode for this node
  * @qos_port: qos port number for finding qos registers of this node
+ * @urg_fwd_en: enable urgent forwarding
  */
 struct qcom_icc_qos {
 	u32 areq_prio;
@@ -51,6 +53,7 @@ struct qcom_icc_qos {
 	bool ap_owned;
 	int qos_mode;
 	int qos_port;
+	bool urg_fwd_en;
 };
 
 /**
-- 
2.17.1

