Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA855516E65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384661AbiEBKxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382875AbiEBKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:53:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A332661
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:49:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c14so3146665pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kB296adCBokDtwhYAZfTdKhO1gXvsxNQMsNoB2OGC7c=;
        b=OIHjaef/QU40O/tOvAAabg1Woe4yXMwUYgqjUjVUZoHiRX9SgDRhcBZfeJmVJK0Z73
         1WzItlLVhczV/OWy5ZCZWMU0SOGUaK2J5Sv3PM2hYn/UseLqmi2gn56yx4y3DNJDK1JI
         Bf/wQ2iqi3qkHmBpZ1RZiKKpUu7rOcG1K8fgjtEBMBmgI43KDzvS3Nn+vBAjTNoP2YUA
         Ji+bAIZJ8/fHrxMx1WmGtrAjmGmFVOaN0chHHlDQRBeT9fWTyXFwwlZfdUO7VZL4za9y
         tcFbP2OtAFZVUOG57s0Ypj3EGKuuF9iKtPfaR1W6ipf0TrfhhDaAFLq8nCtb4UA3leC8
         jrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kB296adCBokDtwhYAZfTdKhO1gXvsxNQMsNoB2OGC7c=;
        b=L0skl1FbJTH9qd/muwOOZilB8rb4B528QNalQ9zLANYiUM9z4sAzTCDOvIuxpqfqkE
         Rrc3RyqUvOPwDwu6M1bJ4moa7s2jb4Vl+L3gTYXLjvVsCCLmJ8npUOVfVIGd0+3aWN69
         DL0JlP4fqNYKr/OxL9XCpuvampiHC6IeRQ2W+FetrvA4qkEIjn6wtgacaVs5BgXV3y1E
         CXJbhquRG4mRjQr4lJnKv93k5dk6+9n2xTXj3FtMDkMNtxSZBUwDqfArIPW+rO7UqiEh
         Mehm8RoYDzU8mVifRScWUD+e11LgjxLX4p1Ccu9m5QdeUT24XoFFD1P+PVt2cGRqghU6
         ytgQ==
X-Gm-Message-State: AOAM533sh72wu4lsH4GPULPrjwI/2hvxN8/zVZdm0170cbXO5ZZxBbF4
        L2VK6Mv1+t55Azn3T623Rs6l
X-Google-Smtp-Source: ABdhPJwvfWoHeyH/n5sROeTB85MmcMWARDf2WBXyWL6u1OhBesg840IyZtqPsc3vz95189dY+6EfcA==
X-Received: by 2002:aa7:9109:0:b0:50a:78c8:8603 with SMTP id 9-20020aa79109000000b0050a78c88603mr10956697pfh.77.1651488586110;
        Mon, 02 May 2022 03:49:46 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id q12-20020a63f94c000000b003c14af50635sm11030090pgk.77.2022.05.02.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 03:49:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] PCI: qcom-ep: Move enable/disable resources code to common functions
Date:   Mon,  2 May 2022 16:19:38 +0530
Message-Id: <20220502104938.97033-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Remove code duplication by moving the code related to enabling/disabling
the resources (PHY, CLK, Reset) to common functions so that they can be
called from multiple places.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
[mani: renamed the functions and reworded the commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Used qcom_pcie_disable_resources() in qcom_pcie_ep_remove() as noted by
  Dmitry.

 drivers/pci/controller/dwc/pcie-qcom-ep.c | 91 ++++++++++++-----------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 6ce8eddf3a37..ec99116ad05c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -223,11 +223,8 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 	disable_irq(pcie_ep->perst_irq);
 }
 
-static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
+static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 {
-	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
-	struct device *dev = pci->dev;
-	u32 val, offset;
 	int ret;
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(qcom_pcie_ep_clks),
@@ -247,6 +244,38 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	if (ret)
 		goto err_phy_exit;
 
+	return 0;
+
+err_phy_exit:
+	phy_exit(pcie_ep->phy);
+err_disable_clk:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
+				   qcom_pcie_ep_clks);
+
+	return ret;
+}
+
+static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
+{
+	phy_power_off(pcie_ep->phy);
+	phy_exit(pcie_ep->phy);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
+				   qcom_pcie_ep_clks);
+}
+
+static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
+{
+	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
+	struct device *dev = pci->dev;
+	u32 val, offset;
+	int ret;
+
+	ret = qcom_pcie_enable_resources(pcie_ep);
+	if (ret) {
+		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		return ret;
+	}
+
 	/* Assert WAKE# to RC to indicate device is ready */
 	gpiod_set_value_cansleep(pcie_ep->wake, 1);
 	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
@@ -335,7 +364,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
-		goto err_phy_power_off;
+		goto err_disable_resources;
 	}
 
 	/*
@@ -355,13 +384,8 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 
 	return 0;
 
-err_phy_power_off:
-	phy_power_off(pcie_ep->phy);
-err_phy_exit:
-	phy_exit(pcie_ep->phy);
-err_disable_clk:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+err_disable_resources:
+	qcom_pcie_disable_resources(pcie_ep);
 
 	return ret;
 }
@@ -376,10 +400,7 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 		return;
 	}
 
-	phy_power_off(pcie_ep->phy);
-	phy_exit(pcie_ep->phy);
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+	qcom_pcie_disable_resources(pcie_ep);
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
 }
 
@@ -643,43 +664,26 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(ARRAY_SIZE(qcom_pcie_ep_clks),
-				      qcom_pcie_ep_clks);
-	if (ret)
+	ret = qcom_pcie_enable_resources(pcie_ep);
+	if (ret) {
+		dev_err(dev, "Failed to enable resources: %d\n", ret);
 		return ret;
-
-	ret = qcom_pcie_ep_core_reset(pcie_ep);
-	if (ret)
-		goto err_disable_clk;
-
-	ret = phy_init(pcie_ep->phy);
-	if (ret)
-		goto err_disable_clk;
-
-	/* PHY needs to be powered on for dw_pcie_ep_init() */
-	ret = phy_power_on(pcie_ep->phy);
-	if (ret)
-		goto err_phy_exit;
+	}
 
 	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
-		goto err_phy_power_off;
+		goto err_disable_resources;
 	}
 
 	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
 	if (ret)
-		goto err_phy_power_off;
+		goto err_disable_resources;
 
 	return 0;
 
-err_phy_power_off:
-	phy_power_off(pcie_ep->phy);
-err_phy_exit:
-	phy_exit(pcie_ep->phy);
-err_disable_clk:
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+err_disable_resources:
+	qcom_pcie_disable_resources(pcie_ep);
 
 	return ret;
 }
@@ -691,10 +695,7 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return 0;
 
-	phy_power_off(pcie_ep->phy);
-	phy_exit(pcie_ep->phy);
-	clk_bulk_disable_unprepare(ARRAY_SIZE(qcom_pcie_ep_clks),
-				   qcom_pcie_ep_clks);
+	qcom_pcie_disable_resources(pcie_ep);
 
 	return 0;
 }
-- 
2.25.1

