Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F665166FB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355855AbiEASZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353656AbiEASZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:25:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA352B28;
        Sun,  1 May 2022 11:22:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t5so3814111edw.11;
        Sun, 01 May 2022 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=ffLGJVCrtYMGOVbFuhVkbAI/YM3ho9JZOvR75oifjMhBEGBHXM4MrFPqSVi88fwlSg
         +tXWsTeuGgg9zPzksIkGDrp1MZmYd/DrWTeGFXh76ynyOQefGV/sdtB+eXJiuDAZhL4P
         LLdgqQaT4C+yFeBSFrR2Wo6nv/r3hvDtLaAOvYFwOYoBI6lzHN3G6YNDQd6MTxQ89dir
         yxyYyRVmKi9RFHCj1jKuXBepopt+FNulu7SEr8EZzVDq8dVPJPdNXIFcvFH/A6s/RX3A
         +INInXP9mm77uyFYkUFFvsTFieabB4YjSWNbGQ3thpesLnMEZn8D5qo1pEtwLW5D+F8t
         inSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=MK6zQ8eG9vttaW3vOjW7r5QEEqzvIBWgjlpBcTwOypG5nmOe5uMhtYLBGgavnaQ0Zc
         y+PBTYutBcDYyw70aoPd3u3ig/hVdgvhWM0F+kb/eHbWzBNdBvsjxMOHlNgXFLH1QeHa
         Y8MIeuV6MTKKJ6IE0LsAdgFsz07+ykaA+n+7FGBtu2gcM8qvxecK4n0mESlQ7htMy7Ci
         a6vs15Er64xGp4W0fOM/u7Q30ZmLGsQkID7t86SZXk0AuUEH3WL9ZSRbujerYlOa1xl2
         GyS9nF8hYCCS50rpyPVSBD9vhMqAKFxbA77cWshw6xhzj9mmBUuHGTKhIgrgJD1cbaqU
         bXyw==
X-Gm-Message-State: AOAM533HQFBiP/xWWkVWgC+pZMUjwGhPbXL2X/yutNRjGdgiXKwqm1MB
        VDIMMFznnLL1sGptcU3FOq8=
X-Google-Smtp-Source: ABdhPJy+S4ZokkQAr8L+V+PJU0ouuLgC99QeSZtg1idRU+0+6pqvq46wPkj0ntcA0m/otZQkRXaAZg==
X-Received: by 2002:a05:6402:3292:b0:427:b4c9:6522 with SMTP id f18-20020a056402329200b00427b4c96522mr5239035eda.406.1651429330230;
        Sun, 01 May 2022 11:22:10 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-225-cbl.xnet.hr. [94.253.144.225])
        by smtp.googlemail.com with ESMTPSA id gv49-20020a1709072bf100b006f3ef214e35sm2769811ejc.155.2022.05.01.11.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 11:22:09 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: ipq8074: add thermal nodes
Date:   Sun,  1 May 2022 20:22:00 +0200
Message-Id: <20220501182200.47328-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220501182200.47328-1-robimarko@gmail.com>
References: <20220501182200.47328-1-robimarko@gmail.com>
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

