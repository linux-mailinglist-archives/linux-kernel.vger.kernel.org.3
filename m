Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B096537641
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiE3IJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiE3IJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:09:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0536575226
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:08:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f21so9944184pfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQMU+Azb2CyYnqiOkLdOJDhSu2qq9ydEFPtWmStOAJU=;
        b=SlvC9E3B+AvqQXTMHJ0kieTj61nPGO22GeH9i1A1SCxW2FY2zkeyWFRd2YJ98qDO+E
         Qo7SmR5I0Jt240JSU7C0Nd3oZA3Ty2CYQFBDJaXkKX3a+wfTqyC8uZqUS3SiOV+BeoZr
         tYxTjqGshIxdp7DwMxZYdUwpTCgerftKNLobxZr/DsKZ9wC+kv11OZ3UvfbaGS+JE095
         cZCg01epBYWi2rrsmdK9X+h6k5DZCre5jqlsYoqB2d4k5+vW9lGt1pYk7XW458aukJee
         YVEtZaxFdl1V6cowCbbYo9Z2NPdvMkzenMawcSjI7hedb1XijNaCtEU/in9Q53z+5w7K
         EDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQMU+Azb2CyYnqiOkLdOJDhSu2qq9ydEFPtWmStOAJU=;
        b=6F8D8l47KQeMOSgYE4Pd+PsaMljcRxMJBbd+Khk6WfCmmPTer5ggOnl8ZG5pAnWr4j
         SytCXerQ0NMa2mNnAos5d7lzOPumwNp+chHPPTS2Emat4YETyhnafPOvDdXZNlxwRpzs
         tQmfT2GU7+d8aeIbQvsrA25Z1aCc2xVzUo/Dr9LHEUvF3U4cPp1MFDuLyjYwBRjLmVWD
         AoOYoP4Kn7YhpQ5nrZFcfZIQcwfO4ADjwLUabwSeJAezvmci9GEFVTD9Ro/jB6+RaGB0
         U3Ec7qd6e/tL4vNpujaDX1Chr1XuWfEmJgESxEvxhKU5GU2q8quyz2E7xHppNYttomcd
         0s4A==
X-Gm-Message-State: AOAM531WtVNmqFZ9W+HHppxsZjzSvz7Lo+vYQwkybFyqlunJDW09CSu5
        k4gYzDQKAUrwcIY+FmujcjVD
X-Google-Smtp-Source: ABdhPJzHqkdC2S2wPLL9VZ3aRN3aCQgHi+x0s3Sal6yisEAAh4WGC/R6dRPSXyxbgctC0yNLYK8IrQ==
X-Received: by 2002:a65:62d0:0:b0:3fa:c6aa:6901 with SMTP id m16-20020a6562d0000000b003fac6aa6901mr23157011pgv.314.1653898139145;
        Mon, 30 May 2022 01:08:59 -0700 (PDT)
Received: from localhost.localdomain ([220.158.159.114])
        by smtp.gmail.com with ESMTPSA id io17-20020a17090312d100b0015e8d4eb285sm8450345plb.207.2022.05.30.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:08:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     tglx@linutronix.de, maz@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sm8450: Fix the IRQ trigger type for remoteproc nodes
Date:   Mon, 30 May 2022 13:38:41 +0530
Message-Id: <20220530080842.37024-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
References: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
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

The watchdog IRQ trigger type should be EDGE_RISING. So fix all remoteproc
nodes.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 934e29b9e153..7c511901e52f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -854,7 +854,7 @@ remoteproc_slpi: remoteproc@2400000 {
 			compatible = "qcom,sm8450-slpi-pas";
 			reg = <0 0x02400000 0 0x4000>;
 
-			interrupts-extended = <&pdc 9 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 9 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_slpi_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -894,7 +894,7 @@ remoteproc_adsp: remoteproc@30000000 {
 			compatible = "qcom,sm8450-adsp-pas";
 			reg = <0 0x030000000 0 0x100>;
 
-			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -934,7 +934,7 @@ remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8450-cdsp-pas";
 			reg = <0 0x032300000 0 0x1400000>;
 
-			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -974,7 +974,7 @@ remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8450-mpss-pas";
 			reg = <0x0 0x04080000 0x0 0x4040>;
 
-			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
-- 
2.25.1

