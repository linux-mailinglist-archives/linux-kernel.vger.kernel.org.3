Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7FF5279E8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiEOUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiEOUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:31:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E482BE5;
        Sun, 15 May 2022 13:31:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so25145258eja.11;
        Sun, 15 May 2022 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6l0wEsNTNKfaV6zwlBqgwcxJ/BycnrD93GoqTYwraw4=;
        b=eJQDMuXDs0P8Yd1vlhcMTfVvKQf+3HUD8ARLmrREpOaNRrsVbevUByGuT0/nc+vyTd
         FY3MN0Rh9BMLLUUHhxlHGHTLJhYJ9aIerY7jMuO2YGXDlIREAuOMb7o4CCO7hvDTqGOe
         YNFTZx/I6HkK41yeZUWSD2OKOznbPRjN/A13mJ3dZKgyWO1YWBdCZxr2ituTqf8yo0Dj
         7/5zZl3okvwaJU8tv+6NX55ySC44Ebxf+w+S71gZgCYCnivsSJmCW4FRfnf+Fdba8/qK
         IwAgtb6ImbIWKpInr8WC3vjL/0sAjBOB+ZCCF1mOlh04gaDFtBhgGe9RX2Nr0M+Ssxfa
         QnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6l0wEsNTNKfaV6zwlBqgwcxJ/BycnrD93GoqTYwraw4=;
        b=zJIGuKM+3DveMOzaRJlkrKJjnoQEnybMWEKULYgEyL3iRIg+qIf4lOCFp667oqsa6Z
         iyCcMd1kTUBn0M1fI/nVDqz8gPyrpdmZPJPOs4IfsvYGShllMR24BOap/sZvi8AArWgj
         Q9sGfnGcG0OnGZHE1MhB8X6qrtqKzkwAKi2nQDqzUnWgULifQ12HrSYeDiJJdDj6ML0E
         f6oWeou7L9LGzuK+azOlyEw9DdKSzpp2mm14+7dUf/T0YzOnJjTumvYflzbMuThrtcu2
         i1/k1TkQcZVDiG2/Ry0pLyuIa/seGz/+K4KSn1r0Q2nmc30UhX9VmmTpc2un30iUPiyI
         R6SQ==
X-Gm-Message-State: AOAM531+8D1H3FKyMqTjETvqxiHuptPyrCUNB79b9DIqKhrs2IzZqpTT
        W+9lpLc4ittCq0smUAnJ7cA=
X-Google-Smtp-Source: ABdhPJwqo5T+h7bMBIp9nWmIFVLUI0DqUBugAbUWghlzPMtBIdV+nRGVJXTgci94XSuBWxjYfZ6aKA==
X-Received: by 2002:a17:907:3faa:b0:6f4:da62:6729 with SMTP id hr42-20020a1709073faa00b006f4da626729mr12199093ejc.747.1652646686931;
        Sun, 15 May 2022 13:31:26 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e4esm2944884ejb.180.2022.05.15.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:31:26 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 5/6] arm64: dts: ipq8074: add SPMI PMP8074 PMIC regulators
Date:   Sun, 15 May 2022 22:31:17 +0200
Message-Id: <20220515203118.474684-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515203118.474684-1-robimarko@gmail.com>
References: <20220515203118.474684-1-robimarko@gmail.com>
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

PMP8074 is used in IPQ8074 and provides S3 for cores,
S4 for UBI core and LDO11 for SDIO/eMMC.

So, lets add the nodes in preparation for DVFS later.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index dbe23793e4d9..906468ee990e 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-ipq8074.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ8074";
@@ -421,6 +422,39 @@ spmi_bus: spmi@200f000 {
 			interrupt-controller;
 			#interrupt-cells = <4>;
 			cell-index = <0>;
+
+			pmic@1 {
+				compatible ="qcom,spmi-pmic";
+				reg = <0x1 SPMI_USID>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				regulators {
+					compatible = "qcom,pmp8074-regulators";
+
+					s3: s3 {
+						regulator-name = "vdd_s3";
+						regulator-min-microvolt = <592000>;
+						regulator-max-microvolt = <1064000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					s4: s4 {
+						regulator-name = "vdd_s4";
+						regulator-min-microvolt = <712000>;
+						regulator-max-microvolt = <992000>;
+						regulator-always-on;
+						regulator-boot-on;
+					};
+
+					l11: l11 {
+						regulator-name = "l11";
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3300000>;
+					};
+				};
+			};
 		};
 
 		sdhc_1: sdhci@7824900 {
-- 
2.36.1

