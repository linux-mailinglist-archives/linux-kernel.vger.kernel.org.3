Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3945650E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiGDJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGDJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:31:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3391DF95
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d5so8043509plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WnlHr6IrouPH/wdi+y79keal1VSMpfo6gBqx2QqUOA=;
        b=Ifkvm7ECn8RZvQg8nAldNfFTarAyPRTePgZKiAGgjxU3ReqY6ok96bTDPAe0CwYIMt
         JvZafMLlhbWHqdw7tVHhV8MvsKRraA+NpP/NTJ0U0lteAT4j+ANPtKA6nwkQ3iKP6bs9
         I+00IMKWGw9F5416FVk5OrFWKcn2I7EYNYSd74Qfw7Qhl1lIxktOajTK3yp2ghYn6Qo3
         Vv6hIRWjTNo02XrS2afkS1kcKqqORAljlG0JlcLSfOJHAsWwYWu977LLnaeu0Gw+DLwr
         CRTQut88MUo2qef397e7NLmqUK9p9pX4XWaE+oQbOgdid4is2XNpKfPWacPmk3Kcig4/
         6d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WnlHr6IrouPH/wdi+y79keal1VSMpfo6gBqx2QqUOA=;
        b=auGki+InySwXELYiMzm5FDusEYBaIPqlBYH54j12CIBi5Yxu0+OAkN1LQD0GS2bdHc
         nS36wnre4t6haLuozf2Qz0uWypfBMXCHJDmY71r0OrzdZFG+vap9Zx73QXTAfTdkEyjy
         4fPwoUp3sZKt7+paZZNpUdekc6kIGunWTqgEPg5bQ9w0IurItKA1Al6KwKu7vE+LfVRs
         QQg7ALkm55Y1v/pY6aVya3fQgB5Ks62fdJofTxBoDe6L8jf8V1t2yJcBEj4o+IHJebgy
         2040jcQfd6/LG1aBAGGt3KRO2NnwMjo+sY0rCQCRYZoy7UCJQVMPuCxiZKnPX7PhSteI
         i0Yw==
X-Gm-Message-State: AJIora9eKQ01VJG05oEiDW3wdD0GJ8w9kh0eSe9ZAjII6emwrnxyP3i5
        xFxn9iAbOxnaULOzRfzuYJbAiQ==
X-Google-Smtp-Source: AGRyM1tSu750n4sy7LLfIPs0ul9iYMz4ChNbnddSjJNKcigFusnScVnWxTBSGvUbn9GyGLa0JntRyw==
X-Received: by 2002:a17:902:f792:b0:168:e97b:3c05 with SMTP id q18-20020a170902f79200b00168e97b3c05mr35305145pln.94.1656927044995;
        Mon, 04 Jul 2022 02:30:44 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id ms16-20020a17090b235000b001ef81bac701sm2926177pjb.42.2022.07.04.02.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:30:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 2/5] interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
Date:   Mon,  4 Jul 2022 17:30:26 +0800
Message-Id: <20220704093029.1126609-3-leo.yan@linaro.org>
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

since there have conflict between two headers icc-rpmh.h and icc-rpm.h,
the function qcom_icc_xlate_extended() is declared in icc-rpmh.h thus
it cannot be used by icc-rpm driver.

Move the function to a new common file icc-common.c so that allow it to
be called by multiple drivers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/Makefile     |  3 +++
 drivers/interconnect/qcom/icc-common.c | 34 ++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-common.h | 13 ++++++++++
 drivers/interconnect/qcom/icc-rpmh.c   | 26 +-------------------
 drivers/interconnect/qcom/icc-rpmh.h   |  1 -
 drivers/interconnect/qcom/sm8450.c     |  1 +
 6 files changed, 52 insertions(+), 26 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h

diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 120e279a7427..8e357528185d 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
+
+interconnect_qcom-y			:= icc-common.o
 icc-bcm-voter-objs			:= bcm-voter.o
 qnoc-msm8916-objs			:= msm8916.o
 qnoc-msm8939-objs			:= msm8939.o
diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
new file mode 100644
index 000000000000..0822ce207b5d
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-common.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "icc-common.h"
+
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+{
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	node = of_icc_xlate_onecell(spec, data);
+	if (IS_ERR(node))
+		return ERR_CAST(node);
+
+	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+	if (!ndata)
+		return ERR_PTR(-ENOMEM);
+
+	ndata->node = node;
+
+	if (spec->args_count == 2)
+		ndata->tag = spec->args[1];
+
+	if (spec->args_count > 2)
+		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
+
+	return ndata;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
diff --git a/drivers/interconnect/qcom/icc-common.h b/drivers/interconnect/qcom/icc-common.h
new file mode 100644
index 000000000000..33bb2c38dff3
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
+#define __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
+
+#include <linux/interconnect-provider.h>
+
+struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
+
+#endif
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 8acc8e67a332..114bb8f64573 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 
 #include "bcm-voter.h"
+#include "icc-common.h"
 #include "icc-rpmh.h"
 
 /**
@@ -100,31 +101,6 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
 
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
-{
-	struct icc_node_data *ndata;
-	struct icc_node *node;
-
-	node = of_icc_xlate_onecell(spec, data);
-	if (IS_ERR(node))
-		return ERR_CAST(node);
-
-	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
-	if (!ndata)
-		return ERR_PTR(-ENOMEM);
-
-	ndata->node = node;
-
-	if (spec->args_count == 2)
-		ndata->tag = spec->args[1];
-
-	if (spec->args_count > 2)
-		pr_warn("%pOF: Too many arguments, path tag is not parsed\n", spec->np);
-
-	return ndata;
-}
-EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
-
 /**
  * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
  * @bcm: bcm to be initialized
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index d29929461c17..04391c1ba465 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -131,7 +131,6 @@ struct qcom_icc_desc {
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
 int qcom_icc_rpmh_probe(struct platform_device *pdev);
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 7e3d372b712f..e821fd0b2f66 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -12,6 +12,7 @@
 #include <dt-bindings/interconnect/qcom,sm8450.h>
 
 #include "bcm-voter.h"
+#include "icc-common.h"
 #include "icc-rpmh.h"
 #include "sm8450.h"
 
-- 
2.25.1

