Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD964B10C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243178AbiBJOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:48:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbiBJOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:48:02 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D0D6A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:48:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y17so2008207plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTlhzilwZJ+GV0G2sShDk8AU6wcwqOk4GnRwj06CIc0=;
        b=Yl5VNVAN/O18uDWiOHZoyJaHv8Yj2hrpvi9Ai+sn/m8cHmMi3G/uOE7DuKDKtX/Eik
         jV7mgLokb+hr+I90QsDfmFWsrOvAsm1JZFxwN0ai68h6ekLNQ8L0NG/P3eBQBhLbaCD+
         mivFLnVauQDBJSFZIY4MGoRFJQFp6MM0ob9CMOneu/uA0OfUG4odyKXaLhcm4AjdUFXC
         woeCqSWUNhX098pO/ko1m2rnp1n9iSzZaO+gXYbJ12/21rblVvhJdWDI3aDleljLpYmB
         0OlGek5ROehPCw/ZUGRXIUs0QtTlN7AiUIEyQbDNlOxv5l3jWmYpyixt4ivSBPRBjm0g
         rMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTlhzilwZJ+GV0G2sShDk8AU6wcwqOk4GnRwj06CIc0=;
        b=TTk8KfRVAfs2iV1IfzhSRBKjlanEG76fMHriBYMBcM4j0UzwBaYJZtxQHS7kurKV87
         O4GVm0x+Zh7ygn+PhWPsHLvu8kbc45gMcjX2ohk2CfduAfQ04iQCVIwUe8lYdBSEnEfq
         n0bl7fbBiPYoz+C3jhP0bT4ZraFRNw/cLJ10lgR7KxUXU0Yd+87Lp9wW1Vq229S4LTGL
         h1rKZ7HO39YaWsUM1kDc8l/6jUiIc2ZAhMFIFDLBCh04GU5immPRDiq0iH2eE7O8rWBu
         b6q2T/1wG1hp9GEaUc4zw1Nm4ipToXdjeX0QLJeE1dKPHKX/xt6M/ZFwLVRs+zYffJs5
         NtGw==
X-Gm-Message-State: AOAM531p77mesOpqialXtzT2WU6L5F84osg0oFgk1NMAVDonXR27dgkZ
        kWtSXXbeB8EpL6WpAdsrMf+u
X-Google-Smtp-Source: ABdhPJzNPs7oJuxf+RGN9n4bAwd3UkaD8iV0GSwuukEFfop8/LTWoR3TpFFs+XL+xfJqsfA3hcVDWw==
X-Received: by 2002:a17:902:b684:: with SMTP id c4mr8126073pls.122.1644504483364;
        Thu, 10 Feb 2022 06:48:03 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.88])
        by smtp.gmail.com with ESMTPSA id p11sm15960117pff.45.2022.02.10.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 06:48:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] PCI: qcom: Add support for handling MSIs from 8 endpoints
Date:   Thu, 10 Feb 2022 20:17:45 +0530
Message-Id: <20220210144745.135721-1-manivannan.sadhasivam@linaro.org>
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

The DWC controller used in the Qcom Platforms are capable of addressing the
MSIs generated from 8 different endpoints each with 32 vectors (256 in
total). Currently the driver is using the default value of addressing the
MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
num_vectors field of pcie_port structure.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Rebased on top of v5.17-rc1

 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c19cd506ed3f..03e766f6937e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1556,6 +1556,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
+	pp->num_vectors = MAX_MSI_IRQS;
 
 	pcie->pci = pci;
 
-- 
2.25.1

