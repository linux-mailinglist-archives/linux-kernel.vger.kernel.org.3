Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782C574A55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiGNKPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiGNKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:15:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC24120A5;
        Thu, 14 Jul 2022 03:15:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fy29so1417231ejc.12;
        Thu, 14 Jul 2022 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyJ4qGj8eHBHJuHHdzCBMz1BsQHdmCZcZqOIQgAVkk4=;
        b=cHZ8AriwRJyRwM6j+nXYNdxol6uzs1KKZHoYC8KX7f6/tjQjzY6YMa8WZJM/8ULjcL
         G6mYw8GAhzY500Gql1Wn4yNE2S6cbpPPBZUcS8f6WWMO7VPaEgiHbu2OzW/+6HsAk7Yj
         X3saYD7mZpXzObIICgRHUCWw3VgJtr1TCF6/EeowjOX6huIWltDLlTaQVq1VaaxEjPxk
         OaV+W2mJYumSkUjjopWL7M/zt7IzNt1YfErBNIs/laZMrkEmhX7v3isX212jO5MPIKYg
         lT/qD0fJRjojkoen/XoiqUMEuabM8iyINzZhAxH9baWTJZvYjpUbT9Jr6BelI9wbkoTe
         mYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyJ4qGj8eHBHJuHHdzCBMz1BsQHdmCZcZqOIQgAVkk4=;
        b=EtZOvTdk7VnPVm+kTpYuL0hkz3UDkRI7Zn8fMC9ifTM6bRfaKjVHM1XGUzDouYk9MJ
         zWGNhxCgr0suNNvCbu5HP+BzhsayE5hRpFXFH1J60egWxEOhRnSO/K+3wjZqH8ANGrYo
         wLa2IkMidUwcTSoQ1ZiL6roRYXNmhNhQ049hSPStN56JanHKlEgqPpr6/e0j39cqkO6Z
         zy88mEHmP8+NIVq7eRsM9edZWHZIE5nw/+QO30+H+g7t7dzehvpTIwB+9KpSczpmDB+l
         XfkUYzc6+7v4Q9/V9vlNtTXIdUO9WukgfovG3+eSRE6oVePEristRjLWAbqpWBuwfBg3
         tHsQ==
X-Gm-Message-State: AJIora880HsqSaho9wh1o0p/aIBBnqbX8rqnyCv3rNk9yz5EPVhS5HF5
        7rlRH7+5j9Dg+zvgHpHAmNQ=
X-Google-Smtp-Source: AGRyM1s68591pQ9y4rEecbAi3VFSuElDTfxlsdXA7PNvIDIud1gAERS4RRgrOotgD/ISrFNP3x+TLg==
X-Received: by 2002:a17:907:6ea4:b0:72b:8550:90db with SMTP id sh36-20020a1709076ea400b0072b855090dbmr7981114ejc.135.1657793700352;
        Thu, 14 Jul 2022 03:15:00 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-197.xnet.hr. [88.207.98.197])
        by smtp.googlemail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm535313ejb.147.2022.07.14.03.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:15:00 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 5/5] arm64: dts: ipq8074: add thermal nodes
Date:   Thu, 14 Jul 2022 12:14:51 +0200
Message-Id: <20220714101451.198211-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714101451.198211-1-robimarko@gmail.com>
References: <20220714101451.198211-1-robimarko@gmail.com>
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
Changes in v5:
* Rebase to apply on next-20220708
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 96 +++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index c1c608728d4e..64f3f0d18cf9 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -308,6 +308,16 @@ prng: rng@e3000 {
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
@@ -918,4 +928,90 @@ timer {
 			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
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
2.36.1

