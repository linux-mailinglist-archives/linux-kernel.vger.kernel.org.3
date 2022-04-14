Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC636501D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346898AbiDNVeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346616AbiDNVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:34:21 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644622E9CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:31:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k29so5853298pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLPIjSAUTJJLokAp2S9gp/hCiUMY9hC+ai2JfkC0b1o=;
        b=uSLdpLiaIGiig4Q5DmiPW0DBQzj1e6W75SKXHG58JBgSfI1RuPrTYYDfKLj+2m6k1R
         MpWxUy1tH7WusZY53nW0yk53lNTdO0IcnKeQo1MvWj5ruaBLCk9m7GU7bh3cu7zKoMzb
         qPIk8brrt48NZbXLct9NP6ya38XYAmO+FLPZ0PsRxQdf3IVzqJqAtk7EazLzvUQd7j1Q
         spKhsQz13WSaXR2p0eDKL7k5P908F0EnDtccyn8H0BnqrWuMf+MBUVKW7e73NLgDiXsn
         iycUZ4WFdU6ZHQCktlQRFQBbRbaBA1K4xsdeb5S2Wk04g85G6hPNwaeRZWvky0AHuSXV
         zYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLPIjSAUTJJLokAp2S9gp/hCiUMY9hC+ai2JfkC0b1o=;
        b=AEd+RtSJxr0hIzHRXZXqP++ixcESjfqzOqTrbScz+MymPkDEEcz6gqh+ovO+uBmCnw
         GqFTBe9RmW7Njrrfr6cOOnZLjldC66Z/Ed9ra3Uc73w2/7492lY21U2B/SCBUl3bFgFd
         KbMKntfaN8s8TbIyemE1xsAGVKR2Myxq6ZznpnP4D7o5pZv2aZQQ9XsUas/b1WFhGZvC
         NtcjLyg7Zi5kC2hhmfeJf970DQG9zPEvReOSR9mhhaRZupA8748k/12m6ZeRQC9j8sOD
         6eWHb564fXRRgx36u03PA+4qh0FIaNa3ZslYaO95eD4WF9bMDi5T8cPsAr3iCMN1uC14
         cJpw==
X-Gm-Message-State: AOAM531PnoUhS/Wt8Gvy2aOn5rdIF+ICSAvW/NNE24kO2/PC3j5TUb7I
        uSELg3QbjzH//aZfDflTJi7y3Q==
X-Google-Smtp-Source: ABdhPJzUewFZGxAuH+LgGXVv0nEasOfgkzLOPoS/66g/kZFkJ/4PxIYdIAekdhE3P4b8VJ6I0IDObg==
X-Received: by 2002:a63:b51a:0:b0:39d:ac7f:d5ba with SMTP id y26-20020a63b51a000000b0039dac7fd5bamr3802568pge.497.1649971914873;
        Thu, 14 Apr 2022 14:31:54 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id 5-20020a631045000000b0039d942d18f0sm2673706pgq.48.2022.04.14.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:31:54 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm8150: Add support for SDC2
Date:   Fri, 15 Apr 2022 03:01:38 +0530
Message-Id: <20220414213139.476240-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414213139.476240-1-bhupesh.sharma@linaro.org>
References: <20220414213139.476240-1-bhupesh.sharma@linaro.org>
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

Add support for SDC2 which can be used to interface uSD card.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 15f3bf2e7ea0..0fecebf0a473 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3270,6 +3270,51 @@ usb_2_ssphy: phy@88eb200 {
 			};
 		};
 
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sm8150-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			iommus = <&apps_smmu 0x6a0 0x0>;
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			power-domains = <&rpmhpd 0>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: sdhc2-opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmhpd_opp_min_svs>;
+				};
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		dc_noc: interconnect@9160000 {
 			compatible = "qcom,sm8150-dc-noc";
 			reg = <0 0x09160000 0 0x3200>;
-- 
2.35.1

