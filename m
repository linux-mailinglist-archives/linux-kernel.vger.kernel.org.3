Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1F5670AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiGEONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiGEOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEFFC56;
        Tue,  5 Jul 2022 07:07:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z19so15395884edb.11;
        Tue, 05 Jul 2022 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPe6ZT7qToz7oy62Ap1sHdRiXhnpHBlrej3RJOUEXl4=;
        b=cgZTxP3I0MP9sE6cOtTi718x5FDH28XnPFRT3JDPLGP9o+ix6lW6KHkrUALYcp24ku
         GGtgSfa2nOmkfAvmwBh1VgyF0uqPxrtzrk/SC3+0wjo+SVJMSo4tiKDhVYKThB2tgBUn
         UgisdAzM7S8pVV9HErfx2/TuDKUOfKFk6Ys6VpGrJes/fZ0agiWN43rqzvnU9NkhWSFq
         +DP/ldLDgMjbmEafjdU12QcREwLXRV6OzJGDt7S5CfT3RnMYsiR8QxS1AECRR9hCeYoM
         B2oo3mJpeTC3KkHOne4FPMYN1RRpIP8lB/aWcsZ0GQZHkPdyPos6f9GoWDQOqXU0VLBK
         kq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPe6ZT7qToz7oy62Ap1sHdRiXhnpHBlrej3RJOUEXl4=;
        b=8D6x8V45fgz/ihJZLCZu3t2I3tV+Kq7vZfjtfo1VP2/3rYms6Z2hSQaT8d3rPNLCrh
         J/DqZKczZcZ3VKAbRafJwZmRxpFTn0l8V9DADJD7p+rz7I3ocn5sBK2BbeKCHdwbhMVs
         VJKknz5EyNrLyh1dBGEtfaL33vLUuzNKRRJBWrfcjpi+3ADfRqCLr+o7up/oWc0BD9ar
         ntogzWGYqTkZ4ix/sYD/qO7M8UHUAtPmVPN/y1wKL/ZThDf6BuHNPvN9WyxYfpCG35ru
         GffhVOOpn9k5G8PkmEuPUw9acO7EcitPeAJ3LKvv+dHMtu9xwPJh5Zez3MvrpHe59piI
         MKTg==
X-Gm-Message-State: AJIora/V+NJjuIZ/SWOxWqs8mTk2wQAnxqm8jLIdekA6LJ3HodrgBnYQ
        UrPpyzl4i8GieImsJwuMHbcdVLsN2YE=
X-Google-Smtp-Source: AGRyM1swQG9fMazVqk90G7pkKzG+/2L16Pn+23dPoPAcjPtP9/808+mOwgeWEyr1FpDUqOcNGc09nA==
X-Received: by 2002:a05:6402:2816:b0:434:ed38:16f3 with SMTP id h22-20020a056402281600b00434ed3816f3mr47212140ede.116.1657029993822;
        Tue, 05 Jul 2022 07:06:33 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:33 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 05/13] ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
Date:   Tue,  5 Jul 2022 15:39:09 +0200
Message-Id: <20220705133917.8405-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing snps,dwmac compatible for gmac ipq8064 dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index c0b05d2a2d6d..b2faa4a067e9 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1077,7 +1077,7 @@ stmmac_axi_setup: stmmac-axi-config {
 
 		gmac0: ethernet@37000000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37000000 0x200000>;
 			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1101,7 +1101,7 @@ gmac0: ethernet@37000000 {
 
 		gmac1: ethernet@37200000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37200000 0x200000>;
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1125,7 +1125,7 @@ gmac1: ethernet@37200000 {
 
 		gmac2: ethernet@37400000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37400000 0x200000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1149,7 +1149,7 @@ gmac2: ethernet@37400000 {
 
 		gmac3: ethernet@37600000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37600000 0x200000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.36.1

