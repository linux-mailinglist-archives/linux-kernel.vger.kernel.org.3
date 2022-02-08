Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF304ADFE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353027AbiBHRwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiBHRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:52:31 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BAFC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:52:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d187so20159470pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jol+dETTGtIFDcZ0LJDX3mcnE3qDxeQxYuYPKzLtM34=;
        b=uVxOhFl3E2w5uygsEEVOYcV9lvC3YEdBrz1J8A6DRi43hwukU559+L1rfzX8g6P3ov
         NA45kkbyzqaLqgLn2oCZN1wj/2bCWF3CNiPl/6PWDFjRM9Go56Tmy5I2ZvjVyF3cNWaS
         dVjqyscrm8IccUnSsyMqBCiLHW+NpeVuO0A6KUDHx/LZJpgPBEyRn/GNCzzJtNWSxr6G
         joRLs7vbZDfcfHT5AijGSRNJPxEvOFvdKGVwigL2L51eXfelhyGWMoq4xR586YQHeJRM
         5nw+hoBoGzk/d0q7MvczA3CHglnDCcL7si0Yd5TAsfrvhzSn3PnkU85tdEeG9jwvgkKd
         cb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jol+dETTGtIFDcZ0LJDX3mcnE3qDxeQxYuYPKzLtM34=;
        b=cNB8S+YcAFqdhOYVnH+/Q3v07iFy3avs153hRyZKdPujnOW7hJTFPhAE7usl8O3qyZ
         4uHr8W4vh2AuUNklP2nrNF/xp4wqHQrJQn41eGQbm4rLgse0KrYABOanNteL94nmHfeF
         csE/ZWoAM/WCEx/9pqeyPtqRBgnWRx4JCzB6uqdYcSnsqXNMTV5eD5nHKeiEgHcRWiRy
         Amhe5npSGZZFRT8YhFmxQraTuGfik+Dq2CELCEZh8JTkY+eCh6MouzW58qeVdPn29YUv
         8ya8oLbpKkDHXVKXQaEvO0rihctgVi5OcVf4/N3fegXFMmHDz+aiSBdBTuYMzk3Qh12q
         uiDQ==
X-Gm-Message-State: AOAM5329LR5GIgM+oqckkCMD0SyVdVPVpvLO7Zvq11SVcz7nkptbRKZV
        cmUFIP81hzel12q+m+H3yE1j8+pXC7FElWw=
X-Google-Smtp-Source: ABdhPJznRykqSscOw2Q7+AcZ0+rPbkaqlvRPjTV7z383WaT1cnQelg6lrxmlkaH9+qE3TW+p+TcM/A==
X-Received: by 2002:a05:6a00:130a:: with SMTP id j10mr5450281pfu.32.1644342750066;
        Tue, 08 Feb 2022 09:52:30 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id nu15sm3807706pjb.5.2022.02.08.09.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:52:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] ARM: dts: qcom: sdx55: Fix the address used for PCIe EP local addr space
Date:   Tue,  8 Feb 2022 23:22:21 +0530
Message-Id: <20220208175222.415762-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Fix the address range used for mapping the PCIe host memory in the DDR.

Fixes: ac0e2878cbb0 ("ARM: dts: qcom: sdx55: Add support for PCIe EP")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 8ac0492c7659..40f11159f061 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -413,7 +413,7 @@ pcie_ep: pcie-ep@40000000 {
 			      <0x40000000 0xf1d>,
 			      <0x40000f20 0xc8>,
 			      <0x40001000 0x1000>,
-			      <0x40002000 0x10000>,
+			      <0x40200000 0x100000>,
 			      <0x01c03000 0x3000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
 				    "mmio";
-- 
2.25.1

