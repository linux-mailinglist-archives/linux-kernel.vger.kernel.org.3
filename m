Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A80474F18
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhLOAYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbhLOAX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:23:59 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91380C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:23:59 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f125so18716913pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=16VRMFlJxS3daOX0JFWAJjx3G5Yk47/TEZJPFA/aWJM=;
        b=N2/0EuLM9AnzxVlc7PCE4rhOKTzS3+OQuEeHfXWBkc9yw2sVzvIfu3Oo929KmA/lpp
         Ma6oaV8BeV4wwIY4whVO5IS/x0FSYaeZEodSmbPgnF52OyzMb95IkvQ+RWFS3iJUlUXU
         TmaGJCBNNxA3sVmAD/lu0KV59/yC2zgWPgnKZk25/G4L7J/QWMO5dJjsHIGNxIiquvxf
         B71pq2KDsXfqr4BVhmAEkTQU8IBU6mrFVyRsD/Mfqoqkk6nTjPrCNTQ6eOKzax548NnI
         uvTFY4DIfe8JXvWRtZntmQNwVIH6kVOrmvPu0cHf5q7908M4XyiMLsGGStSnTB+vIKhk
         jinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=16VRMFlJxS3daOX0JFWAJjx3G5Yk47/TEZJPFA/aWJM=;
        b=OH4suoFMY4iPdBEHu38GJFHz377LYnkQPshuLqD21yY4gv5mr6I2gkYdOixdET76gS
         gjVGo+QLEQYIa7vFmx6dq8iWB175vm3yWA4TEAlyJ+xVx3gyGZZWMhzPp0/FD6H7JwVV
         1UHLoFx3sLkGHXd4trC9oYhH9dQ5ooOF65b9wODtARzlOFp6hWeE9/9+zp0r0EZijZ97
         +ZaiH7VH+xIqRuhOOAPsIplCGTGQJsmJ4CmoVMDTfLQyMb2JkhUOqAKp65xfKkyphbD5
         /qbF0SZQTtFERbnu+oW3SCeJ1pySXLpE0B7NuKdOtatyoTO200EwQHEBSbLHMsA+lI6l
         c4Gw==
X-Gm-Message-State: AOAM533JGZqOY/yU9KYGUiOF27tsiW6DFjrZ34U9Cv23jqAw8glICEGD
        vLJQmwTOLZhmPFVTbUDtpNJmUQ==
X-Google-Smtp-Source: ABdhPJyjJ2+NaCV3wGq65z1967WaPv0LHzTptnpGsVFNCdVSqzozysZBEAkVvmgUypv0e+B2N7arAQ==
X-Received: by 2002:a05:6a00:a18:b0:4a7:ef65:ddfb with SMTP id p24-20020a056a000a1800b004a7ef65ddfbmr6612685pfh.17.1639527839065;
        Tue, 14 Dec 2021 16:23:59 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a12sm185840pgg.28.2021.12.14.16.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:23:58 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 2/5] interconnect: icc-rpm: Add QNOC type QoS support
Date:   Wed, 15 Dec 2021 08:23:21 +0800
Message-Id: <20211215002324.1727-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215002324.1727-1-shawn.guo@linaro.org>
References: <20211215002324.1727-1-shawn.guo@linaro.org>
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

