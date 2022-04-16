Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2A50375C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 17:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiDPPnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDPPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:43:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213EB434B0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:40:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ll10so9746186pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgYVWdpY8CyuL5sDrlDO53qb/SZkB70TcEHgXhi98kg=;
        b=HRHo8e+OvKKl2H/ZwkgeMRfgFcUARjiWX9d58xRm8WRINkMgt4+btg9kPhRn0qp8F5
         XIamOUTabF4G2xGFvVm6uknoulkQmLxnJzLjPtYqzWjW0FLsHfy9Woq8z0W1Zfj4Qh3l
         xgCzl/wE1dM7FSdjiriNP2OBm9dO6x6fY6hM1NUDQHxWBbETIHIKgUwzyydJIkODiy0S
         zpcBB0tne1xjsJjj8ZX7b8lQbKeAsLqUBnsMIcb0mnSX5FVosdRat1hZoVc/6GIYDfRM
         8m2rR31/MMAzLnAVkkJnahb4ICwo42YfAmLW8LBe81amkWeyMSJsw4b3jvqQfm1e4h2r
         v+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tgYVWdpY8CyuL5sDrlDO53qb/SZkB70TcEHgXhi98kg=;
        b=TOyMSsM4StgaRrktBouzta3egiZ6jk5ZqvUOzWZ6jGy7mVcVj7FoGJVr65rv7Dsric
         6OfIr4LFPRFdOSGa3FD91G2daoJeq+G+eE4bEtDATdMJ7ktOzv7G5m5gF1RABAO9ZpsJ
         Nr2DoJMoOr0EebkFMJCx8upQUPAHCUu1fWsw3JvFpEEaD1A/ly+PvmEUw/LJp8Tougoa
         RuT0hc2CmRNg/kRZ+IelnSY5YFyADaN0CAx+QKii0HfgjjpHcnSLIZ8g0dhQWERWS1R0
         FZSjptpo5AOakmA4HriC77fQr3h3nPdB9viaSozurazHkgk44rjw2jX5+00KW16A9WFx
         xz6A==
X-Gm-Message-State: AOAM530zRYdisjC0MuB/e9c45BxmnE6JuYM8W47pLgiFugvYJq1ibu6v
        d+a9CRJakHaPRVpxBQAdJ0zp3A==
X-Google-Smtp-Source: ABdhPJyQ11yTE/VF6mFuaO/EuvqcXW4BsaFTSPdsJPfdrJjCldUpUDXCaaSWQVvDLELiohPIvHD0gA==
X-Received: by 2002:a17:902:c944:b0:158:de4a:6975 with SMTP id i4-20020a170902c94400b00158de4a6975mr3802627pla.131.1650123635432;
        Sat, 16 Apr 2022 08:40:35 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm6358681pfh.174.2022.04.16.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 08:40:34 -0700 (PDT)
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
Subject: [PATCH v1 2/5] interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
Date:   Sat, 16 Apr 2022 23:40:10 +0800
Message-Id: <20220416154013.1357444-3-leo.yan@linaro.org>
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

since there have conflict between two headers icc-rpmh.h and icc-rpm.h,
the function qcom_icc_xlate_extended() is declared in icc-rpmh.h thus
it cannot be used by icc-rpm driver.

Move the function to a new common file icc-common.c so that allow it to
be called by multiple drivers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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
index ceae9bb566c6..bbb3d6daaad1 100644
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
index 2c8e12549804..9a0ac85d2a84 100644
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
index 4bfc060529ba..84acc540a5f7 100644
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
index 8d99ee6421df..23045cf17e37 100644
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

