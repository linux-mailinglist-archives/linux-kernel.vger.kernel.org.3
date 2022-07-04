Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84320565396
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiGDLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiGDLdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:33:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F9E88;
        Mon,  4 Jul 2022 04:33:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r18so11301342edb.9;
        Mon, 04 Jul 2022 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uISEbHJkHg+LEqbPo3bae9ouqkQHAUMU2B39TEtx3IM=;
        b=dzmj2xWm6eSskZQBMCsfD48QgA7TdfhmhaOVbRJ2tfU6HQHxuDV/dUl2WUcjhUxvrC
         gr6yLEcqCxUN5UYBsH1YRtYj9HGJJmGEoqyD5O3tgUtTnNRirlzw4jFRmVX7sMu3T6aa
         wKCcWkWJrefr9dFaJx4FZwGZh0wZ/kghKazaPv/ox/+P/6UGBX69ybkrgk+TZVpOCBXD
         2foxv9e+zqVyMPCG38J0dpw2lrAW7h1BGvUBp7Ro5Wq4M3hDMXhT930wExbYZCTRoJNc
         IczFduVUPZ+Akl3mTYUHDYSyw65k+8y6DNbJlEJvPO+0SBaN7JLo5D2WPWQJ+JVk0e8k
         No1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uISEbHJkHg+LEqbPo3bae9ouqkQHAUMU2B39TEtx3IM=;
        b=qVIutjStFs26khSW6kFloYSBdgEjrU34WNGzraFR3lC8v9LPJI147R61nHspspWtCd
         ARyZMK59NEz8DnG8ko2+2hD+tYTT1RX3wzbz+HVsO0nMwmt7NX+XlHPTgVAKTHrTufbO
         oW1iKC63ZoDSQXIeWA8KQ/dIeeBZzRVzTu9m/D3dVRgJHQufW66vV78vE/B0QVBAxZN9
         SsRYuzSowkILcL537yzd+OeQ9LpNzx+BeBunhrRGC+FanyoyCfDuGuddPFZdNqWynPuD
         E6p2Y6QyrLTsMBtDoi4Bm6vUwbVbNJfHkhFt/FZvLGOiR1aZ5oWUisAE5mBI4MmMNzmF
         bXzg==
X-Gm-Message-State: AJIora9fSOYIPSS3bcKPQPjABfYoTpR6UPD8SXL80zf+HfrU7uTAiN1G
        0HbTv4xOvv/ojW91ZDfkAgw=
X-Google-Smtp-Source: AGRyM1t+ayVebEnERBQsS76YfAYD0xB3AMp9xItFk+buPPIwHLF0IGQtmV0R6+WVPDpM3l6Pyd2vPw==
X-Received: by 2002:a50:fc15:0:b0:435:7897:e8ab with SMTP id i21-20020a50fc15000000b004357897e8abmr38380577edr.17.1656934400109;
        Mon, 04 Jul 2022 04:33:20 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id x21-20020aa7dad5000000b0043a2338ca10sm3065443eds.92.2022.07.04.04.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:33:19 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: ipq8074: move ARMv8 timer out of SoC node
Date:   Mon,  4 Jul 2022 13:33:18 +0200
Message-Id: <20220704113318.623102-1-robimarko@gmail.com>
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

