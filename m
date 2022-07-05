Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D656709A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiGEONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiGEOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E419031;
        Tue,  5 Jul 2022 07:06:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o25so21859873ejm.3;
        Tue, 05 Jul 2022 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWGjhMMyDD2J/KSaIxx6EOkxe1O8SSLj6I85d3AHdqM=;
        b=qT8BwhgCTMo7B27iNjgdrfJ5tnRiktq1I+h5LkxYg7iwrmlgoLxgRtSeBppKV56NcH
         DLak/zokDqL1XHwoY1Y2rMh/BoYmkiJSPIEDSUFZrr03plJWO0wNxweoNYFB6frNuSsN
         a3fRlCblTu69fEZ6pDnwVAxr9fK96HJLYiiLeE2CPgV/EPyYbkPyZzRc7ieML8am1IXj
         YSPoB0jv8Fn9VyAD8NjX9W+9QWu7zjNFCx0/VK8iMIHawjqj4vsRx/mjzPBj3hGFmcrO
         raupujfrbin8FD8iKQffa+/Ypv7SxeF6DS9lg8t3ZUGJO7rhIgzxor4d3c3cppYtncMx
         SX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWGjhMMyDD2J/KSaIxx6EOkxe1O8SSLj6I85d3AHdqM=;
        b=k6EsdF1G8a25jozJyRVLSF7xLtXemOmt+OzzgcrzM6z0kKxbkJxVXZgg1inuH+yoip
         puMofobn9aWN5yKW/lzqiK9JDC7Nk5yLEIScM/NTradl99/ykkou8V1srzTsLhK3vpc0
         0kdoZaX8x2wagZSak6DJGPBzmK2lQiSuxd4DTNVCCyqkgGU9Fe4q1BVWik/50geivkhf
         XVuM1fb2Js+AmjAyCLYnqvgjVn9QzfiUrxz++ruZxOfujBhX+IhWY6Ov7Nh2odVQ8KDe
         Qyt9oqvSYtctm2LU5HmdRZQU9qUA44wcgCicuX6vLhznGzmVWrVZqYdKRWHmFT/GkH6C
         JDNA==
X-Gm-Message-State: AJIora8kTtIM+jz5yuwJZBr/lRP1t3HS7RjTRmu2gpfxEFUAm/d9RBXD
        RUnwaOO0hU/t3maNDqnjCvk=
X-Google-Smtp-Source: AGRyM1vk72GZQ1yky3V+ahW4/9/6LVi4c/yoXtPzU4CMDl5irCeiZmStJKsU+tw11n+U5wHF7S8bOg==
X-Received: by 2002:a17:907:d19:b0:726:c8a0:c9ef with SMTP id gn25-20020a1709070d1900b00726c8a0c9efmr34432434ejc.435.1657029990216;
        Tue, 05 Jul 2022 07:06:30 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:29 -0700 (PDT)
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
Subject: [PATCH 02/13] ARM: dts: qcom: add gsbi6 missing definition for ipq8064
Date:   Tue,  5 Jul 2022 15:39:06 +0200
Message-Id: <20220705133917.8405-3-ansuelsmth@gmail.com>
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

Add gsbi6 missing definition for ipq8064.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index f06a17bd915a..1b4b72723ead 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -665,6 +665,46 @@ spi@1a280000 {
 			};
 		};
 
+		gsbi6: gsbi@16500000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <6>;
+			reg = <0x16500000 0x100>;
+			clocks = <&gcc GSBI6_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi6_i2c: i2c@16580000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gsbi6_spi: spi@16580000 {
+				compatible = "qcom,spi-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gsbi7: gsbi@16600000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.36.1

