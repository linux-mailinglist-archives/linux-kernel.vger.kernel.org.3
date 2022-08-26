Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18075A2E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbiHZSTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344557AbiHZSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:19:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1871EE3413
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:19:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so2258588pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gbwg87hG3tf6Wqw8hsoPn0QdO74QME7etMAVFms+/pw=;
        b=Jly6DP49pyKeLASqCaK5BiOAB4lrGaTYYF/8olCn3cs/vVYJxt9+JU1/zfs5QNCtwr
         df6jZMWaT53I6jX9LpiYA00yGd/tQK+mcMhSOLpTIVjMCXzyhGnZ/lEVETKa6XZUviCD
         7d4416DUgu0Yx4F80EcGrAKAJukpzYfLYqylG6cbAQixctnWo1LaWFG/lBAkYMSmjF4K
         bVP3c5KDPgQk1eNnKDGgfHEJDJLfgMdHodHISTOITHEqWJ0BIwrmVAgKN6Pylilp5Dm6
         ycReQn2zg/I+mUfZRPVQ+PQED/QsDLkAYWi7n10p9b2ik8qdDNhiiaojgaKwMIHWLirt
         9PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gbwg87hG3tf6Wqw8hsoPn0QdO74QME7etMAVFms+/pw=;
        b=jxaI58B6fzPPfFV5VvcznZ8ONIByTp9/ablElTack1XdNaOcrG7Jg8wMSJECVj7pZ1
         LdDBOx6lC+eqz8wWueNF77/beaELe692EQTSsaa4BIcIWEVP5ZW+DADSbQ6X1NB882n5
         LV2S0QuXs9nl8ji05GD3LsEOYJJhx6BqF9RGsw5k3t7reu9Xlz8G/mW2SiFSO40NKtfg
         UOj38/w8/1WxC7jVY3gjxwLaR3eFpYMjLmRuu72aZmqStKhGoLizCHJlIccs+V3DbwfW
         A8omvO+k9jOlwOu4a8bYED1XEPFfZJLsahVx6vY8J34vh5GmKIryF0mK7r0ETO5JBdmW
         wXXw==
X-Gm-Message-State: ACgBeo2WbcGPgtWcO207CG1ZQaTjRm3ALptj/hWwlAB64Hr/380oyMWn
        3G1OoG8WI6UXYTkfY6TcfgMP
X-Google-Smtp-Source: AA6agR40j8SV28Ne+ZkHO4w/7kgMZqwg4r8Ed6oPweYWQvTh4EsuC8NnuAboU7hv1QgKy9S1WBJd6Q==
X-Received: by 2002:a05:6a00:1826:b0:537:b261:3e4d with SMTP id y38-20020a056a00182600b00537b2613e4dmr5058792pfa.65.1661537979604;
        Fri, 26 Aug 2022 11:19:39 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:19:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/11] PCI: qcom-ep: Add kernel-doc for qcom_pcie_ep structure
Date:   Fri, 26 Aug 2022 23:49:13 +0530
Message-Id: <20220826181923.251564-2-manivannan.sadhasivam@linaro.org>
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

Add kernel-doc for qcom_pcie_ep structure.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 9f92d53da81a..27b7c9710b5f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -140,6 +140,23 @@ static struct clk_bulk_data qcom_pcie_ep_clks[] = {
 	{ .id = "slave_q2a" },
 };
 
+/**
+ * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
+ * @pci: Designware PCIe controller struct
+ * @parf: Qualcomm PCIe specific PARF register base
+ * @elbi: Designware PCIe specific ELBI register base
+ * @perst_map: PERST regmap
+ * @mmio_res: MMIO region resource
+ * @core_reset: PCIe Endpoint core reset
+ * @reset: PERST# GPIO
+ * @wake: WAKE# GPIO
+ * @phy: PHY controller block
+ * @perst_en: Flag for PERST enable
+ * @perst_sep_en: Flag for PERST separation enable
+ * @link_status: PCIe Link status
+ * @global_irq: Qualcomm PCIe specific Global IRQ
+ * @perst_irq: PERST# IRQ
+ */
 struct qcom_pcie_ep {
 	struct dw_pcie pci;
 
-- 
2.25.1

