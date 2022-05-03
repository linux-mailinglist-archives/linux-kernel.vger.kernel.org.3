Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC05518E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbiECUMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiECUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:12:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100D40A37;
        Tue,  3 May 2022 13:08:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kq17so35482515ejb.4;
        Tue, 03 May 2022 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=VcB/8mDr7B/QpyxZzzrObUbZ+95m4H+eIVF/wEma6mOfotaINcmvoWBAhG1PaSEjai
         mohNNrU2nw7CAvy+27KSzxaRXMbiOrnhRdKUysTaJ3IXDRt+e84c3VQCRUBPulxrThc5
         GwNixJ9GVCt4MGP/diptbCKM1Pd7lYH3qHuL83P3qm1xdI1+NJOqmmPZWJOU3zCenliB
         fmRDUhJ5U1cJsUaLAEcbNqxTLXkBpdHFKpLxtsY4UyIQdDWCxjJooTMDkmldF1RHaR9q
         yONE3sqt/2TeYVltjmIXBSJ75aCWT6wOMwNw638qoDJ+n+C5JxNCK7wUqp18eWZkLoHR
         OPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=g8lHItXs+/GGCp0Xp1D0d/JAlSapbNYavaAf+CuN2ts8/28PRwVjslEM1G4zAvXLK+
         31CEM/FJrYVCepl7Uo8PU/4e+uXlDWqNe2mXqeqG/t3pHIb9Mg4CN9jxgjaV1ngnjxEQ
         vcBoSRr7HplKfkziuWIT0O0ByhlzI7SwE6hMAUboBUDDR8uHxBSq9EU6SUx4g8xnwn2K
         x+x/LVJgqK9rNlmfUtxcsLyBlczgCyf0GOmlad1fWQSZSxtSdvpbmutTZ6w2IkmXGt3L
         6BatYILZ3IyTl8Eys0c1r2I8yoEq71yBqbDqNBfocRL5qQSXhjlSC/e55dkRx0+YHk1A
         4Fmw==
X-Gm-Message-State: AOAM533QZthNlyuQJfpwORSN23BHiiSLJQS3KW+nXcecR/LNY7IwkPE6
        +8LhsIc879uyCe5vVlxsr+Sv+vUFJrQVdw==
X-Google-Smtp-Source: ABdhPJw/HLcxIahYk3IaAToNtTuBPKVfrMwHL4jiawxkpG0W6d5ff3I+os9AXFjZIPLhgpVAvN9UAg==
X-Received: by 2002:a17:906:58c7:b0:6da:955b:d300 with SMTP id e7-20020a17090658c700b006da955bd300mr17111983ejs.481.1651608503681;
        Tue, 03 May 2022 13:08:23 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id ml11-20020a170906cc0b00b006f3ef214e59sm4967466ejb.191.2022.05.03.13.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:08:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 5/5] arm64: dts: ipq8074: add thermal nodes
Date:   Tue,  3 May 2022 22:08:13 +0200
Message-Id: <20220503200813.4020698-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200813.4020698-1-robimarko@gmail.com>
References: <20220503200813.4020698-1-robimarko@gmail.com>
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

IPQ8074 has a tsens v2.3.0 peripheral which monitors
temperatures around the various subsystems on the
die.

So lets add the tsens and thermal zone nodes, passive
CPU cooling will come in later patches after CPU frequency
scaling is supported.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 96 +++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index afbae86cf6d3..76e02490b968 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -332,6 +332,16 @@ prng: rng@e3000 {
 			status = "disabled";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq8074-tsens";
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "combined";
+			#qcom,sensors = <16>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		cryptobam: dma-controller@704000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x00704000 0x20000>;
@@ -1092,4 +1102,90 @@ wifi: wifi@c0000000 {
 			status = "disabled";
 		};
 	};
+
+	thermal-zones {
+		nss-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 4>;
+		};
+
+		nss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 5>;
+		};
+
+		nss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 6>;
+		};
+
+		wcss-phya0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 7>;
+		};
+
+		wcss-phya1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 8>;
+		};
+
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 9>;
+		};
+
+		cpu1_thermal: cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 10>;
+		};
+
+		cpu2_thermal: cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 11>;
+		};
+
+		cpu3_thermal: cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 12>;
+		};
+
+		cluster_thermal: cluster-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 13>;
+		};
+
+		wcss-phyb0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 14>;
+		};
+
+		wcss-phyb1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 15>;
+		};
+	};
 };
-- 
2.35.1

