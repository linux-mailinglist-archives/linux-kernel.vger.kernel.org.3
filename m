Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49636518DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbiECUJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiECUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:09:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E21A81F;
        Tue,  3 May 2022 13:05:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so18050684ejk.5;
        Tue, 03 May 2022 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=Pe5LGI4BFACdp0284FSLxeZMpgqgM2fUgE66SGVSEi1UAfeWVoTIPO3yoZVP4T9T1V
         oKjbecVh+r/wwdXtuMY2ZtKR459i/rBLbT15m+pWubmtT5bV8BtQq+gt5g6cybCTQccD
         qsdne7RyOwG0TliV6yGD316wsdaPuJk6AAinLCTOEHkSyPisenzsb713Niqi/h/Tu4Ix
         QG0Fn+pnkBKntzIdJAFhybZeFatIclfXCEtTqmzgusec/CIt06UlzcwIKRJYrYfuWxxb
         8OVC+1/m0SVTVREEqD+NHtZ4koNTZqLcnwILMOHHXMHnNJNUMDhxdT2qvl2aXkyVbqtO
         6/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=Wx/m03Og2Rv1hWgNfcF+QgOR89QR4pHMJzgA2tanQzyoq6gYw273MCEX/BjJAPtkA3
         pZB0fZAZR5K4sY1cq/uRXw8fVUArGugWlU3i8YbhtRHLrs+Oy4eEVe4PZvHfEkwSZMnn
         /aZ/2DxCNUtwdRypxOB3n+Lw3eyXRrYhCNJ84k4pRG7xmtFdXw/0qVQCFjum496lamDQ
         wqJZsgPgs4bE1A5RmUBCtQNbXlVwpS87BmDAPWz+VQkqR0TYb19AiYfqf3KYea1haK/O
         pJe/ZeLMnkFbt6NA3rprABNQl5o6eMBouucByYle3M14GdtyIKAht14c83te/ZdLhKBZ
         h/AA==
X-Gm-Message-State: AOAM5312assnsMBI+Wcv7Sm2ejg7bC9cUF+/v7Cn4TCT+yaRFCjBKysB
        yxD/nApx7xMZ7zvLeDFq45Y=
X-Google-Smtp-Source: ABdhPJzvZ/B7Fl5zFKE2FPIj0VQCrTfJuai2JKU5rC5U0RRAS8CECpwZwz/oVn9LGxPLQdeUyjmzFg==
X-Received: by 2002:a17:907:97cc:b0:6da:a8fb:d1db with SMTP id js12-20020a17090797cc00b006daa8fbd1dbmr17406488ejc.267.1651608341185;
        Tue, 03 May 2022 13:05:41 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id ee47-20020a056402292f00b0041d893ed437sm8688450edb.2.2022.05.03.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:05:40 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 5/5] arm64: dts: ipq8074: add thermal nodes
Date:   Tue,  3 May 2022 22:05:30 +0200
Message-Id: <20220503200530.4019673-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200530.4019673-1-robimarko@gmail.com>
References: <20220503200530.4019673-1-robimarko@gmail.com>
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

