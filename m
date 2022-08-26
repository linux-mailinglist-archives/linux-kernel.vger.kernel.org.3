Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C975A2E47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbiHZSUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbiHZSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:20:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580C564F9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:20:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso2584934pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=s1bHMc0t+EgY3JRHamFbe3O2W7KIQwgHUw9wruSHUsE7dwRznHeez60mroak5+DItd
         uCAE7MOSTJuyW8nVbq9I564pWBEyIa41jJusbUayQUWoDGvAWuGogzVomkMxZ1QjMIAR
         EeLE0LY0cVnfU2IJgXIewZJBTcYjZRvH1R2Rs/jQGZqkDePADEXQu7P1j0zoag7P1sXg
         Ejpna3IBKuDXXE/a3tEaiMlWGIHVJLOOM07REKrHUKuO8ZuApRFuBlC/Czw/IHlih6Mz
         qs9eVQVyNT6FcS0MnDy6vPL1emxlu/cdQKTBkdy0BfbcHodqT6B8vsoR81HQelzwjtDG
         kYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=7C2I2aebmASH+liO7A203bC1RPJpHGk3Rhs2jrh6RU3mIHE2qTEnsocgq/z6E+Zu8w
         DfR5j4hxD/CZrZAQaagK5M8tEH3/iYMhm09RC/RsadgDRpWkro8y4YtClOxh+iNtMekc
         me2py8O5PT0pJpyjDJkUbIOaGNkSgT6olB0NxD7Royu9BjE5ehZxuvmMUL1BcsQbUDYI
         2RnariF1rTKW7ITVxD17bvjSnXbrJ9/CsIb1Z4r57767wkHf5miAYxPlEjUqxAacNx0Y
         sGVcNriIL0bMhACUPaopGeHORpVDRNLEYsWu/KmJ0uGKBv/AokdMhmN9P0xoeWpZzCfb
         kcXg==
X-Gm-Message-State: ACgBeo2UbRsU+Ef5VOW3KxDYVdVUjRlxZEDtLkGWqD5Q0428hmC+EfBJ
        oBzICccWbW2GijAik/jjtJF/
X-Google-Smtp-Source: AA6agR7alkQWrE4//3h6rPpk3p0vMMc3NvIzKVWZN679umAD49dP1iV+0bBg3GO0nea//FM7CXrj5Q==
X-Received: by 2002:a17:90b:1646:b0:1fb:7b7d:e7cc with SMTP id il6-20020a17090b164600b001fb7b7de7ccmr5545692pjb.79.1661538001213;
        Fri, 26 Aug 2022 11:20:01 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/11] PCI: qcom-ep: Disable IRQs during driver remove
Date:   Fri, 26 Aug 2022 23:49:17 +0530
Message-Id: <20220826181923.251564-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the Global and PERST IRQs during driver remove to avoid getting
spurious IRQs after resource deallocation.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 54b927adf60a..98ef36e3a94d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -586,11 +586,11 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 {
 	int irq, ret;
 
-	irq = platform_get_irq_byname(pdev, "global");
-	if (irq < 0)
-		return irq;
+	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
+	if (pcie_ep->global_irq < 0)
+		return pcie_ep->global_irq;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->global_irq, NULL,
 					qcom_pcie_ep_global_irq_thread,
 					IRQF_ONESHOT,
 					"global_irq", pcie_ep);
@@ -700,6 +700,9 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 {
 	struct qcom_pcie_ep *pcie_ep = platform_get_drvdata(pdev);
 
+	disable_irq(pcie_ep->global_irq);
+	disable_irq(pcie_ep->perst_irq);
+
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return 0;
 
-- 
2.25.1

