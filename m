Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557EF565390
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiGDLcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiGDLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:32:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68CE087;
        Mon,  4 Jul 2022 04:32:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c13so11292383eds.10;
        Mon, 04 Jul 2022 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uISEbHJkHg+LEqbPo3bae9ouqkQHAUMU2B39TEtx3IM=;
        b=YVS3/CLBf4sWzij1YFNtJ3WqNO0Ezk0DxMzOE0UXGMiPUVJq8rj/aNZQSbtKM45i0l
         Z9RPuEGdpJAPlq7iBGvJw8bIvEEVL8i9wMIKZUYT0Grtak5VmpkNmA/GYtYA/SDUuG7e
         AQV2ZT1jovFHo4/ndWUEHXo+Rl8EzAI6nvRErmdsnHEw1Kg1cs+xBooHm6buQVapp+Kc
         5F86P3Af6WN24ISMSGUuyB5rek0aDdpeeHElmujOyimBzmWpa7fTh2kxvMv+h8SA0CsA
         Z848nfLycb3XU/uKOLfQVFwCovdI9+LFDPQfS4ybPO2Sb6ZjciewOMHlIfEVxzZ+trmu
         mu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uISEbHJkHg+LEqbPo3bae9ouqkQHAUMU2B39TEtx3IM=;
        b=NXbifHUR4ZD4qBvjTYaY9qOaMpmSFt/s9olP79YJkIA7d5b0OXKGbSzFDKHCe/X+0u
         j8LjLg9UOstMso1ZESqpcCMs+2CVByVpXAnpz4NiP/KonU0VbrgUaNp+r6A3M6b3i8lF
         HEj9Rgx7/RVmcqevLahPz1XoFASUhUFLmLUI6rsImlQ+/FBq0wil5XvjM+6j18hwC8Bn
         BlFs00KIeAdLLGZaayft++eKZglEEmk36+G0GV8FAuy2G+faJYU7NdrADODahxi1KPBM
         q8l11GJIwZTRXmOSDAeLYptQkkF2/xyp8Bwg3vyxryC+5MpMI2Qk3Y9gFnjni2B2w4Zn
         tm6Q==
X-Gm-Message-State: AJIora+0RhffYPUmfAV0q2RVmkYfn0ynaskkBm2Ah8YimXUULreD/1bT
        6KDswn99tEdKpXkcwwlrik8=
X-Google-Smtp-Source: AGRyM1uj1exLYEgzw2Sc3V24Q5wM/1WKZlyPagwLIaIkQyM7uLbWM7Ihj0QJER2NpHZ9CJiPZ9SN3Q==
X-Received: by 2002:a05:6402:27c6:b0:435:d24a:d061 with SMTP id c6-20020a05640227c600b00435d24ad061mr38796181ede.427.1656934369556;
        Mon, 04 Jul 2022 04:32:49 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402148a00b0043a1255bc68sm3685852edv.94.2022.07.04.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:32:49 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: ipq8074: move ARMv8 timer out of SoC node
Date:   Mon,  4 Jul 2022 13:32:46 +0200
Message-Id: <20220704113246.622917-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The ARM timer is usually considered not part of SoC node, just like
other ARM designed blocks (PMU, PSCI).  This fixes dtbs_check warning:

arch/arm64/boot/dts/qcom/ipq8072-ax9000.dtb: soc: timer: {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 2, 3848], [1, 3, 3848], [1, 4, 3848], [1, 1, 3848]]} should not be valid under {'type': 'object'}
	From schema: dtschema/schemas/simple-bus.yaml

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index e0bd202e4eae..9f5798f4825d 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -143,6 +143,14 @@ m3_dump_region: m3_dump@51000000 {
 		};
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq8074", "qcom,scm";
@@ -852,14 +860,6 @@ gic_v2m0: v2m@0 {
 			};
 		};
 
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		watchdog: watchdog@b017000 {
 			compatible = "qcom,kpss-wdt";
 			reg = <0xb017000 0x1000>;
-- 
2.36.1

