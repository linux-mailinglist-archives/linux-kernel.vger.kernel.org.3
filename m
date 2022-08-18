Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002D1598FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiHRWDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345869AbiHRWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:02:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7115D11FD;
        Thu, 18 Aug 2022 15:02:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tl27so5693794ejc.1;
        Thu, 18 Aug 2022 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1sQjqIKs0PepooKpkjdm4oZlKzkE26spjqGwHASBZX4=;
        b=FfBRp8dumvJPimesUSFIFP5uIWV4TkxKeIJ4H4uOooFOev1fvbcI1pB9hZU4h8YfzZ
         UGueCs2ln8N1p/qGYU3guEzPCzRSzeDuYe/X813Lg+nE3i3Ek8EQhl5a/yDAIgtbtZDE
         R2GlVIlnvyR5kkK3fXR3DugSc+T4y+0HAkvsV8zmvGyiKm9cE4F52XGKuXZz71aprMkQ
         rFB/lYPdrNO3R7Q+yv+RSS5j8GtVf42NgEYG28OjhtgklhqBfGQurdHpgNgteeb5gNTP
         JiyWHaWQy4+qzKUIL93nMkNCnZJi9aYb8oEnauNkcoGAlr/0kQJO1eBvAa9RjCcmDLvj
         FxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1sQjqIKs0PepooKpkjdm4oZlKzkE26spjqGwHASBZX4=;
        b=rTZU0vsP05240hPESPWVIXPJNDBlFG3vtCCZ7kvUO5xNX8gSqgS86RRspFHuuhQMsr
         8h6yaUTpTPGwHB4vD0JZ8iLMkzEbTWRuM4KbR2KNNS4Z3xuPdUJ0cyjuKO4yoNoLvBtu
         6T7k7rNuv3FbCMa6RY12hte5DO3yt/ehnmMjmfNKbDlcUHBd7EuXHXBvg/JIZUJbvru0
         AtOLgd+IHz/ZfHZtZBypA2C/eIPDgcO1fAcuB7bnowvBfCAf7aVmGHrdilBeaMfLaiNK
         kUQlb5uSHVBFZ8BlBh7/PQklv1/4yH4Rb39I7Zexj+3DFaHWpgPBwYrEfaGdccjlmofC
         yJzg==
X-Gm-Message-State: ACgBeo0DJVrJq9Z7OgqAaQQmF2/wlHFjlJZGy8pZ9YdPomnBa2RlCiy1
        /WS8e+oGivV7KLjDI6Y/0Wj1L5IuMPA=
X-Google-Smtp-Source: AA6agR7LWICA29zX1BA+hAvsOg6M5ZGZDGmJ3IY2nOy5BPzAldjEqTP0mrOyWsd0aL8GvRXb7JAlfQ==
X-Received: by 2002:a17:907:87b0:b0:731:3dfd:bc8d with SMTP id qv48-20020a17090787b000b007313dfdbc8dmr2943669ejc.607.1660860174329;
        Thu, 18 Aug 2022 15:02:54 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id l7-20020a170906230700b0072fa1571c99sm1379297eja.137.2022.08.18.15.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:02:53 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 5/5] arm64: dts: ipq8074: add thermal nodes
Date:   Fri, 19 Aug 2022 00:02:45 +0200
Message-Id: <20220818220245.338396-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220245.338396-1-robimarko@gmail.com>
References: <20220818220245.338396-1-robimarko@gmail.com>
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
index 0b6b0d5153ca..1ed65cb37935 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -312,6 +312,16 @@ prng: rng@e3000 {
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
@@ -922,4 +932,90 @@ timer {
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
2.37.2

