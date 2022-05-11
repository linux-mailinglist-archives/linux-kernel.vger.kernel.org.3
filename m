Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A1523885
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbiEKQRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbiEKQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:17:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E72CC8C;
        Wed, 11 May 2022 09:17:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so5365847pjv.4;
        Wed, 11 May 2022 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBJKZIsVMsFKHOYwovHJla2knjXCDedlt+wjbXlZFEw=;
        b=QfFjHLv0s3dOvr2zX8dOoxKGo+oPkncDzpEXD5i/0R2k1Amvn/z/1pWMGEsJoYAQJt
         BAqC9FlB8PnmrjnzLtkhPgXjFKEY1h7dq21UmiUakxJyR3iKN+mCbRNeAxppdKwQlOrq
         EkAroyPY00i4B31fMUvhjvx5H9B54O2E50vhU79xHy/BM9qb7LVD/H9q5HifjewbW7i+
         PwR+qGAZsjVYXOME0OY0l3n1yXwbIJ/RVtHIBFMnDZ1OeGYJ5ws13n0wCxdsRIJB6Ofs
         ui9fQOfhM5FQHkgKGMKmfVyuvPCxpVbzoOmwkqwMsExDTnZmp3CBswHVEQbNDNIpVnSG
         42bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBJKZIsVMsFKHOYwovHJla2knjXCDedlt+wjbXlZFEw=;
        b=tZ08RvklxBeqLjRh0vxE9RlKVRfk3eRzr4cgmDH1GMKhv8HTVAnBB4JfX3TG1igRKY
         JWMujM+SOCY+jRaT1ticpH3dctaJCnKZo2ysKWxTHy+AO984e5aV6X4QoRGsUM9acqcS
         v86yALsc09HpDeZMWpQleiXzmQMbMoRQBYGS30i6NY86H3Q8rczYm0s1RB50l2mE+BFw
         KuTFAkTfTvPiUjnD8p60cTEiEH3HLqZsdtsOs62alfxg0pm33M000x8ZHS4p0R3dmxhl
         +1XtCotorbBDDN2ESjA4NxDM9CQRQxwisBDAw0eWV02tLbiUsskTq5K7T95K5VCrCaOB
         tb6Q==
X-Gm-Message-State: AOAM531TpSTgebKmNh8UWWN8EeRRLYuaamjOtyVTq1GKBwV5OYFFJnDO
        ei/7jny1uuOaT0VjI5BRtIR786FsgWvdyn6h
X-Google-Smtp-Source: ABdhPJwxI08p83XE/Dos9iEQkLfNw4eXNlmTKOWVJXbcZ4PNRiJ9Pm5Tdd7F7r1+vZzTyCJ4FWBIng==
X-Received: by 2002:a17:90a:c08a:b0:1d9:88de:d192 with SMTP id o10-20020a17090ac08a00b001d988ded192mr6165192pjs.8.1652285822231;
        Wed, 11 May 2022 09:17:02 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:17:01 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 9/9] arm64: dts: qcom: msm8953: Add remote processor nodes
Date:   Wed, 11 May 2022 21:46:02 +0530
Message-Id: <20220511161602.117772-10-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the modem (q6v5_mss), WiFi (wcnss-pil) and audio DSP
(q6v5_pas) remote processor nodes for the MSM8953 platform. It also adds
the coresponding SMP2P, SMSM and pinctrl nodes that are needed by these
remote processors.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 378 ++++++++++++++++++++++++++
 1 file changed, 378 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 431228faacdd..04e285e442ff 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -2,9 +2,13 @@
 /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
 
 #include <dt-bindings/clock/qcom,gcc-msm8953.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -384,6 +388,80 @@ rpmpd_opp_turbo: opp9 {
 		};
 	};
 
+	modem-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	adsp-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	wcnss-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <451>, <431>;
+
+		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 18>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <4>;
+
+		wcnss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		wcnss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smsm {
 		compatible = "qcom,smsm";
 
@@ -398,6 +476,22 @@ apps_smsm: apps@0 {
 
 			#qcom,smem-state-cells = <1>;
 		};
+
+		hexagon_smsm: hexagon@1 {
+			reg = <1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		wcnss_smsm: wcnss@6 {
+			reg = <6>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	soc: soc@0 {
@@ -688,6 +782,59 @@ i2c_8_sleep: i2c-8-sleep-pins {
 				drive-strength = <2>;
 				bias-disable;
 			};
+
+			wcnss_default: wcnss-default-pins {
+				wcss_wlan2 {
+					pins = "gpio76";
+					function = "wcss_wlan2";
+				};
+				wcss_wlan1 {
+					pins = "gpio77";
+					function = "wcss_wlan1";
+				};
+				wcss_wlan0 {
+					pins = "gpio78";
+					function = "wcss_wlan0";
+				};
+				wcss_wlan {
+					pins = "gpio79", "gpio80";
+					function = "wcss_wlan";
+				};
+
+				pinconf {
+					pins = "gpio76", "gpio77", "gpio78",
+					     "gpio79", "gpio80";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+			};
+
+			wcnss_sleep: wcnss-sleep-pins {
+				wcss_wlan2 {
+					pins = "gpio76";
+					function = "wcss_wlan2";
+				};
+				wcss_wlan1 {
+					pins = "gpio77";
+					function = "wcss_wlan1";
+				};
+				wcss_wlan0 {
+					pins = "gpio78";
+					function = "wcss_wlan0";
+				};
+				wcss_wlan {
+					pins = "gpio79", "gpio80";
+					function = "wcss_wlan";
+				};
+
+				pinconf {
+					pins = "gpio76", "gpio77",
+					     "gpio78", "gpio79",
+					     "gpio80";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -745,6 +892,59 @@ spmi_bus: spmi@200f000 {
 			#size-cells = <0>;
 		};
 
+		modem: remoteproc@4080000 {
+			compatible = "qcom,msm8953-mss-pil";
+			reg = <0x4080000 0x100>,
+			    <0x4020000 0x040>;
+
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc 0 24 1>,
+					      <&modem_smp2p_in 0 0>,
+					      <&modem_smp2p_in 1 0>,
+					      <&modem_smp2p_in 2 0>,
+					      <&modem_smp2p_in 3 0>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "bus", "mem", "xo";
+
+			power-domains = <&rpmpd MSM8953_VDDCX>, <&rpmpd MSM8953_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&gcc GCC_MSS_BCR>;
+			reset-names = "mss_restart";
+
+			qcom,halt-regs = <&tcsr 0x18000 0x19000 0x1a000>;
+
+			status = "okay";
+
+			mba {
+				memory-region = <&mba_mem>;
+			};
+
+			mpss {
+				memory-region = <&mpss_mem>;
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,smd-edge = <0>;
+				qcom,ipc = <&apcs 8 12>;
+				qcom,remote-pid = <1>;
+
+				label = "modem";
+			};
+		};
+
 		usb3: usb@70f8800 {
 			compatible = "qcom,msm8953-dwc3", "qcom,dwc3";
 			reg = <0x70f8800 0x400>;
@@ -1057,6 +1257,74 @@ i2c_8: i2c@7af8000 {
 			status = "disabled";
 		};
 
+		pronto: remoteproc@a21b000 {
+			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
+			reg = <0xa204000 0x2000>,
+			      <0xa202000 0x1000>,
+			      <0xa21b000 0x3000>;
+			reg-names = "ccu", "dxe", "pmu";
+
+			memory-region = <&wcnss_fw_mem>;
+
+			interrupts-extended = <&intc 0 149 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			power-domains = <&rpmpd MSM8953_VDDCX>, <&rpmpd MSM8953_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			qcom,state = <&wcnss_smp2p_out 0>;
+			qcom,state-names = "stop";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&wcnss_default>;
+			pinctrl-1 = <&wcnss_sleep>;
+
+			status = "okay";
+
+			iris: iris {
+				compatible = "qcom,wcn3660b";
+
+				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
+				clock-names = "xo";
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&apcs 8 17>;
+				qcom,smd-edge = <6>;
+				qcom,remote-pid = <4>;
+
+				label = "pronto";
+
+				wcnss {
+					compatible = "qcom,wcnss";
+					qcom,smd-channels = "WCNSS_CTRL";
+
+					qcom,mmio = <&pronto>;
+
+					bt {
+						compatible = "qcom,wcnss-bt";
+					};
+
+					wifi {
+						compatible = "qcom,wcnss-wlan";
+
+						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+						interrupt-names = "tx", "rx";
+
+						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
+						qcom,smem-state-names = "tx-enable", "tx-rings-empty";
+					};
+				};
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
@@ -1070,6 +1338,116 @@ apcs: mailbox@b011000 {
 			#mbox-cells = <1>;
 		};
 
+		lpass: remoteproc@c200000 {
+			compatible = "qcom,msm8953-adsp-pil";
+			reg = <0xc200000 0x100>;
+
+			interrupts-extended = <&intc 0 293 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd MSM8953_VDDCX>;
+			power-domain-names = "cx";
+
+			memory-region = <&adsp_fw_mem>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			smd-edge {
+				interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+
+				label = "lpass";
+				mboxes = <&apcs 8>;
+				qcom,smd-edge = <1>;
+				qcom,remote-pid = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,smd-channels = "apr_audio_svc";
+					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6core {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+					};
+
+					q6afe: q6afe {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+
+							dai@16 {
+								reg = <PRIMARY_MI2S_RX>;
+								qcom,sd-lines = <0 1>;
+							};
+
+							dai@21 {
+								reg = <TERTIARY_MI2S_TX>;
+								qcom,sd-lines = <0 1>;
+							};
+						};
+						q6afecc: clock-controller {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: q6asm {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+
+							dai@0 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA1>;
+							};
+
+							dai@1 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA2>;
+							};
+
+							dai@2 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA3>;
+							};
+
+							dai@3 {
+								reg = <MSM_FRONTEND_DAI_MULTIMEDIA4>;
+								is-compress-dai;
+							};
+						};
+					};
+
+					q6adm: q6adm {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+			};
+
+		};
+
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0xb120000 0x1000>;
-- 
2.36.0

