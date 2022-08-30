Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5124B5A690B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiH3Q7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiH3Q7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:59:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019DDB9FAA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:59:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so8143839pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=DEZxBEVQDmbO3QSre3sa73s6DhO8qX+KayjAX2fmCbRFwic8NG6XuAuDzC7zXaebzg
         WzEPgm7lq7KjDM5jCYBNaHzjSHmYLk3ChZbvejiFUfLHeaIdVvFxsDjuCB9L1y3dsP+7
         20d5vmUxRfulyomW3kyhiGKJ4lszVGk7V0pEqKOSQWiNpA3ntJ9wPuTpxNl4AEBeCTlL
         rWormvz1OEV/lItoLy8JbIsH281EPBd8+GyRmDInmwmErudiTLdJbjwhOogR4dd8972U
         KfyDoAkl2yNWkoXOsOdQZNeLf5ON6WSN3GkT05IabyBynducw9T47J6PnjPOMqIujXV7
         dmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=7zY/v8i6CVSUYy6SZsDIjyXy5pFwrw/1sbthl3QeA96GI/66ZrQfPkt+SMT4PX7U89
         DUdN14TTcnk/qm+RHpfLZdOVS9xA2dNKKfWEXMHL3/WMgJpkk8wj37aU4KPABAhUHOzk
         4iIdKkiFINNEnoeWHsAvdLzkMLJoS+MpkM4/TYw12KnrSP8zQyw2k8QzPr2ephoWBAeS
         3jWk9lkNA1kQ3Q0v8GBMdOz6mJEWFm62TvZtwFbu75ngyElbXXZk3EhkLeGubkwTfNiF
         h2fB8/L5MWYQxNJlcquznq3swM5SyPhe2+n2DcDtF+I06/Y28qcw4N730x/UuzsNDbol
         4VWg==
X-Gm-Message-State: ACgBeo1zrmHWwe5HwdbtysnjqKIrjlJYnAPRTPNJIFaF4k5mNGZOgXY/
        YoMDS2Pp1vY9kG5OruAWU12v
X-Google-Smtp-Source: AA6agR6hP1/3DL9GUw99sS8mR62251oVzQJSTfMrgO+fPtawl5EyLLcsl6sNeP8K2fT/jRRR6D9gUA==
X-Received: by 2002:a17:90a:cb14:b0:1fd:c964:f708 with SMTP id z20-20020a17090acb1400b001fdc964f708mr11522996pjt.62.1661878750176;
        Tue, 30 Aug 2022 09:59:10 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:59:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/11] PCI: qcom-ep: Disable IRQs during driver remove
Date:   Tue, 30 Aug 2022 22:28:11 +0530
Message-Id: <20220830165817.183571-6-manivannan.sadhasivam@linaro.org>
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

