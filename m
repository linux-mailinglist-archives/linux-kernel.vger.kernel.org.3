Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59261570145
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiGKLxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiGKLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:53:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE6F25E96
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a15so4532037pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIetlnAVO8vDaATuFQD/cr++Aq+FOWz0sX+Jtq5yB3U=;
        b=KsQuIYZi3/kp8KmF/QLhj4G/JARTMoywf1iKA7RlYQ+idgFWMVkkbwX8T99Dg7PXO5
         DZ7S/+D7XMyCd4PqDVv8jF/n6mYN4FbSExA0PYMKLt0N5ZHOX6a8OmS4yVRAUNskI17G
         kMhed8/fg5vhF9yKs90RbT+z1XKSHNfdmvZQQieSbRYdnSVPqQnniZdF7SmV69rnGqAo
         GyCIm+XsyiGeyS6XoAM3ourDqIx5TAxvMqFMfRRbMy5C6nJGi0aou8ETynbpeuFRL3v0
         V4lhadyB3AJRXRInXUrecO+scOltorpmHnCH7NrqxMrFDNR8FdSAyMigAXJEiVUD+c+o
         dyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIetlnAVO8vDaATuFQD/cr++Aq+FOWz0sX+Jtq5yB3U=;
        b=cOuH8gMLpAtjLATaDYJIjTmR/uwdhQXHdI0grMesKl0GKG2REo6CO3aQxa8PxqTLKU
         fdiBNfXCg05LMt2eQ93pnJlGwNzGMuUE2GXJHPyiczgp6s5qc6QZL4EX5PPrKX+deSWt
         P7u0Jxy1xjGcsGKgi7nx8/DJPY1RkGeARZJE/JEP+fKkfBaW2g83RAQroTbsj8e1JisS
         uGTapwNeYKqTAFQY2wBe9k8tmqwPwhWsd5zUoZJ2RN8vj9AZg8yPtb1+msY129iBj8Tz
         venUudoIYVyvFxgWR9Zsxy3v8u2twC5lKa9oSeW19u1szkY58UiFhWqm/k1dmJUZ/HWa
         px4A==
X-Gm-Message-State: AJIora9CS1dFHWx8fUWHCpnmoPqGR9y4qUOOJKMvLtx8mBbD2gvXQShH
        SH2DjrJ/gfyZwAczuC7LbdvSiw==
X-Google-Smtp-Source: AGRyM1vjZY7RLJWW5h97qi6vBw9dck/pQwG1TRTSnpCMq1QXySQsT0SGBAi+JnOsa7+tVhTzOWZUYg==
X-Received: by 2002:a63:f011:0:b0:416:4b7:5ae4 with SMTP id k17-20020a63f011000000b0041604b75ae4mr3888574pgh.380.1657540379060;
        Mon, 11 Jul 2022 04:52:59 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a648e00b001eaec8cea55sm4586502pjj.57.2022.07.11.04.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:52:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 2/5] interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
Date:   Mon, 11 Jul 2022 19:52:37 +0800
Message-Id: <20220711115240.806236-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711115240.806236-1-leo.yan@linaro.org>
References: <20220711115240.806236-1-leo.yan@linaro.org>
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
index 8d1fe9d38ac3..e6451470f812 100644
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
index 3c40076eb5fb..505d53e80d96 100644
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

