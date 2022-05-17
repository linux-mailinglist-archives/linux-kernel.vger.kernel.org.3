Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5520E52A101
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbiEQMAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbiEQMAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:00:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F04C431;
        Tue, 17 May 2022 05:00:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l18so34182924ejc.7;
        Tue, 17 May 2022 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1hlOjb+KKdy0/QG/BxO1k2JNdhSZM3UJOdwKv3T7/8=;
        b=BU2KTNM4aG0nn5hJWHP5ZC3Ez46/Z+TnTCi2W7zcOdcbNCX4fglgyfFxa2cHGtM8Rw
         A6/srugFXEv1nzy7qWO4TPhGJuBhSi8uUANJCqjDL4SBt8SrNla2ZST48FHpzVnIUj84
         6FRr1Mk8mjynIoFK5EKKR3fjwc2C/DXnY71Mief70mWbVoLq+7gjFKYYV8P53sIQemX8
         b/G5aVVyVJNTMUIoa+xzD2AUoQekDDd7KPsag63QKN8Gmm6Fm38xN5Yae7rAq1AoHxEz
         n5yKXyK9w5D6aAYvXW1yCMXBlVXNim7cKiw+MNvc8gi9ZzPJ2bdLJq71Zk2GLBC/Vuu/
         aSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1hlOjb+KKdy0/QG/BxO1k2JNdhSZM3UJOdwKv3T7/8=;
        b=yLidfNKebGCOao4SFSqYXnPY0EnXYPnxH+b2/+IMpWTJ8FehB2hJB+b0wuksioEuLp
         9wa1hE7KkCIm7ZUqlVKsDAf3+Za8jXBI2VQ1+X/ka8mQCXGXOtYafjpOYdE+UfUzPj7P
         gAmR5fqa/PI0GdYJsX3Ib6EtvJy5JYBqiEN7YPWctHXH3F29g+A4GlO98cYTjz2vpBW3
         xMH81Mgnt6qx++M96ZXzQCy/upT5IAdN+aDTxGv6639Rp8+jKEk3IFr4eacEyWX4qsKH
         34sA36ohnDqzu0O408V2CccFW3UDZReSfRQmkqP2tNIul7Js5DIytnNwfL/+Js/OuAuW
         IpGw==
X-Gm-Message-State: AOAM530BOaATufCZbYYQFja8p5nbKQ1P46iu/bmmBRedvM6wYLFqymAv
        7LMUPE6naLI340dvJjmKZ4VtJA/Uk4J7Yg==
X-Google-Smtp-Source: ABdhPJzS14AXLwhmzYl0Su0S93YfqX+6XOFjUdkedc6MteP8Kt4tfH+b2zdN1Nl35XOglwIUKGvmgQ==
X-Received: by 2002:a17:907:a0c8:b0:6f7:492e:e74c with SMTP id hw8-20020a170907a0c800b006f7492ee74cmr19173903ejc.670.1652788808057;
        Tue, 17 May 2022 05:00:08 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id hg16-20020a1709072cd000b006f3ef214e20sm948793ejc.134.2022.05.17.05.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:00:07 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 5/6] arm64: dts: ipq8074: add SPMI PMP8074 PMIC regulators
Date:   Tue, 17 May 2022 13:59:59 +0200
Message-Id: <20220517120000.71048-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517120000.71048-1-robimarko@gmail.com>
References: <20220517120000.71048-1-robimarko@gmail.com>
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
index 789fec7c6aa4..d1a0b77c38a4 100644
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

