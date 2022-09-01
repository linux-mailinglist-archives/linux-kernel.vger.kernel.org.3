Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA835A9023
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiIAH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiIAHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E6E3975;
        Thu,  1 Sep 2022 00:24:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id az27so21106911wrb.6;
        Thu, 01 Sep 2022 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Gt10vt5CT1NQn1lPctepbuFvhWW8YbAlTctJQdZvPAo=;
        b=UIZXn4pvFuTzjKCfSf04Ygqa3XhrJdla1eDZ5hSqUh8vKRxt48X2V2H/der3QIPsU5
         PIPGDfjxBcGWEdfNKJTELETAgLRZCGxjnVvtWvP4LvpaNGpkLzGuXFAafspnuSssTfst
         YhF9DBLiblnVl4YAlxqVMG9Kcr1W4YsTLbh3SgZ8m5DeSLgyK9I519OClkdP9WK3h99t
         UtJMWqPndafRSqvXzPQhygN59lU8tb+FW1AcnUOKqsIYFsuWLpPlrO7B8BkqlnXTKA9N
         EYw7SK8L5eg1lbKyPgAQnpk/Bb5UazsmOAPpL5dhurA3BwBAG2LJ4ZKRdNBNWrm67+VJ
         ksvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Gt10vt5CT1NQn1lPctepbuFvhWW8YbAlTctJQdZvPAo=;
        b=hcXrrvyYbmYHAbyNAsTlX3sDl21NcjcbK4l0GAQi8B3d0vura73gTg6GnnO97+exts
         PaFwvr42gMpR9NplkUhTBQYftq2axOKaR9ZcRnk20x4Ey1amRmaJnqqeeDq5iPR/zVL2
         NLVr/ZabZFjM0muUAcNMvKgQUA12JgoTRyOa5FCM8MtoAIqDhIp68xcLqVCeV9Seh8mM
         wh/L9OnLfT14sXkolNvX2OOempiwOfKUIsq7OGgRaV0WygOJQcMgDL/NyhV40JPx0bo7
         BlltiyHjiT/unrf9vfQZiEnTrTSMu70obJpkYRTPlpkuw9EpYeGMHhrSbLrkhWBDcDqa
         3tHw==
X-Gm-Message-State: ACgBeo3gObGmEWG+xK7Ioe/H12iIzaxvzYfbMs7X6S2zy/a3O2LbsPAp
        Eq4VD59gyfUH9X4KdN2WYcQ=
X-Google-Smtp-Source: AA6agR5BwLsRQ9/7x+n9YAqW4S4hdLRQ4lbZDCQsJd8NQEsaAL62szHZm1Rw6StCHALHNYujAXY8TA==
X-Received: by 2002:a05:6000:1549:b0:225:64d0:a5c2 with SMTP id 9-20020a056000154900b0022564d0a5c2mr13015677wry.87.1662017076504;
        Thu, 01 Sep 2022 00:24:36 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003a5c75bd36fsm4644548wms.10.2022.09.01.00.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:35 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] arm64: dts: qcom: sm6115: Add apps smmu node
Date:   Thu,  1 Sep 2022 10:24:04 +0300
Message-Id: <20220901072414.1923075-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for apps smmu (one of the two smmus) present on the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index efbc81d2253b..a6be8b93a44d 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -434,6 +434,79 @@ rpm_msg_ram: memory@45f0000 {
 			reg = <0x45f0000 0x7000>;
 		};
 
+		apps_smmu: iommu@c600000 {
+			compatible = "qcom,sm6115-smmu-500", "arm,mmu-500";
+			reg = <0xc600000 0x80000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts =	<GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		apcs_glb: mailbox@f111000 {
 			compatible = "qcom,sm6115-apcs-hmss-global";
 			reg = <0xf111000 0x1000>;
-- 
2.37.2

