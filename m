Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283B5A68FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiH3Q7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiH3Q7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:59:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410EB9FB6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:59:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa2so4027025pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cXVSIoAXy4k6GvjO7JA/nhvOJMAK8QRnMR9+cTCkOGs=;
        b=F4+Mue9z8/NIh0/+GyY0e1oPUlENhniRHuhgypYQDNG726pVNN9PqSm0K9SII7gpmW
         CnTBN3cXEHt8anqhFTIaybBZcnVpabrwDqr6mStCTpsoGan5/mUAgYkNRAdib1/sb9Pe
         sT7yBAPlpoZFu+hXmRCqH7FrOlfCObGN7G8+d/zSHgHuAbV9LSZSn6trx0qiiKE+CQyJ
         NrkBTa+dhvfcQk0Mw68TxLWCSSSkcRegu3a+VZ89gLktL/mRNc2P4d4lT8PU+u6bbaOJ
         yyDFWju7dO7pJrfmFpNSs1VWvLZYplYUnkY9ZoidMR0YRK+Z3LbNl2mg5hUpwV3VA4Di
         dAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cXVSIoAXy4k6GvjO7JA/nhvOJMAK8QRnMR9+cTCkOGs=;
        b=TwND0zcNXCflmL1slSZ5axAo5/RHEhNOC5SPwC4HsYhm9RbfB9vu4pL68WrSPKsgVG
         PPwaXN7v9xVwrWkb5X65Or83q3Ky+VMudH7bH8sBwdxKxY+U35c7pDZrYgdHmMkIkqph
         SPekMBJlb8zCSQPqCQ1z69PFnjvxKWmSdDDnXfC/aoYXs+Wobfa+qsPO1wH45vb66Q9s
         k325HLAJ5Ob/cDgJVGX+VNOU4GIDGTyQmcel6HEUUkTkhFH/Vc+jXRl6lSGBVf+63VXe
         r+2EbVa9dDsu74Q1uYzHrAoh4hGRsegpOvqFoI1TzU7D4h1FOZxOd2JXrVoqgIT8eKAC
         oKMg==
X-Gm-Message-State: ACgBeo1QE2mVXHyyi8B1vTQvc4vpJtG4howOssI5YUENL50uew003VW3
        tgk0rCMnaOK219Jxrlj2qOXI
X-Google-Smtp-Source: AA6agR6OpJc0TAmDAvBCfMYtPNFVC1gjNXQxUiq1H+/Y8Gzp6uHO29zaPd5s51mVRE7Jt2R0MdqJ1Q==
X-Received: by 2002:a17:90a:318f:b0:1fa:a374:f565 with SMTP id j15-20020a17090a318f00b001faa374f565mr24569940pjb.146.1661878739057;
        Tue, 30 Aug 2022 09:58:59 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:58:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 03/11] PCI: qcom-ep: Make use of the cached dev pointer
Date:   Tue, 30 Aug 2022 22:28:09 +0530
Message-Id: <20220830165817.183571-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
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

In the qcom_pcie_ep_get_resources() function, dev pointer is already
cached in a local variable. So let's make use of it instead of getting
the dev pointer again from pdev struct.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 34c498d581de..1e09eca5b3b2 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -483,7 +483,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 
 	ret = qcom_pcie_ep_get_io_resources(pdev, pcie_ep);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to get io resources %d\n", ret);
+		dev_err(dev, "Failed to get io resources %d\n", ret);
 		return ret;
 	}
 
@@ -505,7 +505,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->wake))
 		return PTR_ERR(pcie_ep->wake);
 
-	pcie_ep->phy = devm_phy_optional_get(&pdev->dev, "pciephy");
+	pcie_ep->phy = devm_phy_optional_get(dev, "pciephy");
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
-- 
2.25.1

