Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73D5A901E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiIAH0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiIAHZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034CEEA311;
        Thu,  1 Sep 2022 00:24:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s23so8514170wmj.4;
        Thu, 01 Sep 2022 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pftcIgoM6OJkLywa4kaUHZZ9hBWiNzvtR2zUkRq+9LU=;
        b=f6wLjYA7tITjujOumV5zMtHdeRjPh+n7fuwloqWJ2U+KKobW8P+OcusT6AYQH9yhwF
         vWbe5sn5Wmr5J++mK/qQ7Pw2KUyNM5/WoxAJBvDU5YYgF2r9bCnSFKnnjoAL1cZIXfeE
         UF+4CtrTXs9EJ6T/JAaA/OXBER2KyOIyeIkU3oxWTx9QKEB//SzW3xd/H3T8RzWOblRs
         q1UU3+rGb/czSV5ijZCGrGvIk8KmnV0Fun6aHC8CIShcDQfBFKrWjfC/Z4fH5umD3Myn
         7rn3ahDNFqD7LZ8iky0rGiabgbQcKYJIQ1trSwHdndR20P2CB5a/qwR0qvhQWRNJlgmX
         FYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pftcIgoM6OJkLywa4kaUHZZ9hBWiNzvtR2zUkRq+9LU=;
        b=5H52xoaYtMjXhU1ER+SfgUAVwz2emx87zhLShy6gquwaw42OOLvobcckhSLqjH42Cc
         TOus1/87J6cSNeSqnUFHgZgJgj1OdHXlYfAVtFkOFMSzb2FAbjJj6u0i7UR2g/7qCVVB
         ekPLIhoZZbtPoj8ar3Er7tXR3yyFvWiHPXS7lW167c2Xhn9Sqd2EgNVr0KoeQT/n0cOz
         bPwUiVtZFOlQv0YnjlKpet0O9lPtrVlCdbTZlS6HWknNvW4yvYm1AZjrv5LOS5WMXCIh
         QnEWX3z5CgHFGvsdIsGnNLPZcVdUyZ7x8wcvlxw/R6t6wtjTTyHeuMyCRTRnk9WeNKP/
         g/ng==
X-Gm-Message-State: ACgBeo12CrRMPBZmQ62yxu4eoajugD8r3SS2mguG6Pzwd5VFf0qI4VRC
        DXt5D4a5dkt4+5SUIe7pTL4=
X-Google-Smtp-Source: AA6agR6y158f9uhzrI3wdo7j2IasIstv9uZU2W2pXVmPvHntbOyW6Y476Gj13kx33jgn6knrb3q+GQ==
X-Received: by 2002:a05:600c:358c:b0:3a5:dac0:dc3 with SMTP id p12-20020a05600c358c00b003a5dac00dc3mr4002936wmq.60.1662017064051;
        Thu, 01 Sep 2022 00:24:24 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b00226d1b81b45sm15570354wrr.27.2022.09.01.00.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:23 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] arm64: dts: qcom: sm6115: Add basic soc dtsi
Date:   Thu,  1 Sep 2022 10:24:00 +0300
Message-Id: <20220901072414.1923075-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
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

Add support for Qualcomm SM6115 SoC. This includes bare minimum:
- CPUs
- intc
- timer
- reserved memory

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 433 +++++++++++++++++++++++++++
 1 file changed, 433 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm6115.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
new file mode 100644
index 000000000000..69d9de540478
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
+ */
+
+#include <dt-bindings/clock/qcom,gcc-sm6115.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+			#clock-cells = <0>;
+			clock-output-names = "xo_board";
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32764>;
+			#clock-cells = <0>;
+			clock-output-names = "sleep_clk";
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x1>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x2>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x3>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU4: cpu@100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1638>;
+			dynamic-power-coefficient = <282>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+			};
+		};
+
+		CPU5: cpu@101 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x101>;
+			capacity-dmips-mhz = <1638>;
+			dynamic-power-coefficient = <282>;
+			enable-method = "psci";
+			next-level-cache = <&L2_1>;
+		};
+
+		CPU6: cpu@102 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x102>;
+			capacity-dmips-mhz = <1638>;
+			dynamic-power-coefficient = <282>;
+			enable-method = "psci";
+			next-level-cache = <&L2_1>;
+		};
+
+		CPU7: cpu@103 {
+			device_type = "cpu";
+			compatible = "qcom,kryo260";
+			reg = <0x0 0x103>;
+			capacity-dmips-mhz = <1638>;
+			dynamic-power-coefficient = <282>;
+			enable-method = "psci";
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+
+				core2 {
+					cpu = <&CPU2>;
+				};
+
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+
+				core1 {
+					cpu = <&CPU5>;
+				};
+
+				core2 {
+					cpu = <&CPU6>;
+				};
+
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-sm6115", "qcom,scm";
+			#reset-cells = <1>;
+		};
+	};
+
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: memory@45700000 {
+			reg = <0x0 0x45700000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_aop_mem: memory@45e00000 {
+			reg = <0x0 0x45e00000 0x0 0x140000>;
+			no-map;
+		};
+
+		sec_apps_mem: memory@45fff000 {
+			reg = <0x0 0x45fff000 0x0 0x1000>;
+			no-map;
+		};
+
+		smem_mem: memory@46000000 {
+			reg = <0x0 0x46000000 0x0 0x200000>;
+			no-map;
+		};
+
+		cdsp_sec_mem: memory@46200000 {
+			reg = <0x0 0x46200000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		pil_modem_mem: memory@4ab00000 {
+			reg = <0x0 0x4ab00000 0x0 0x6900000>;
+			no-map;
+		};
+
+		pil_video_mem: memory@51400000 {
+			reg = <0x0 0x51400000 0x0 0x500000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@51900000 {
+			reg = <0x0 0x51900000 0x0 0x100000>;
+			no-map;
+		};
+
+		pil_cdsp_mem: memory@51a00000 {
+			reg = <0x0 0x51a00000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		pil_adsp_mem: memory@53800000 {
+			reg = <0x0 0x53800000 0x0 0x2800000>;
+			no-map;
+		};
+
+		pil_ipa_fw_mem: memory@56100000 {
+			reg = <0x0 0x56100000 0x0 0x10000>;
+			no-map;
+		};
+
+		pil_ipa_gsi_mem: memory@56110000 {
+			reg = <0x0 0x56110000 0x0 0x5000>;
+			no-map;
+		};
+
+		pil_gpu_mem: memory@56115000 {
+			reg = <0x0 0x56115000 0x0 0x2000>;
+			no-map;
+		};
+
+		cont_splash_memory: memory@5c000000 {
+			reg = <0x0 0x5c000000 0x0 0x00f00000>;
+			no-map;
+		};
+
+		dfps_data_memory: memory@5cf00000 {
+			reg = <0x0 0x5cf00000 0x0 0x0100000>;
+			no-map;
+		};
+
+		removed_mem: memory@60000000 {
+			reg = <0x0 0x60000000 0x0 0x3900000>;
+			no-map;
+		};
+
+		secure_display_memory: memory@f3c00000 {
+			reg = <0x0 0xf3c00000 0x0 0x5c00000>;
+			no-map;
+		};
+
+		dump_mem: memory@f9800000 {
+			reg = <0x0 0xf9800000 0x0 0x800000>;
+			no-map;
+		};
+
+		adsp_mem: memory@fa000000 {
+			reg = <0x0 0xfa000000 0x0 0x800000>;
+			no-map;
+		};
+
+		qseecom_mem: memory@fa800000 {
+			reg = <0x0 0xfa800000 0x0 0x1400000>;
+			no-map;
+		};
+
+		user_contig_mem: memory@fbc00000 {
+			reg = <0x0 0xfbc00000 0x0 0x1000000>;
+			no-map;
+		};
+
+		qseecom_ta_mem: memory@fcc00000 {
+			reg = <0x0 0xfcc00000 0x0 0x1000000>;
+			no-map;
+		};
+
+		linux_cma_mem: memory@fdc00000 {
+			reg = <0x0 0xfdc00000 0x0 0x2000000>;
+			no-map;
+		};
+
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+
+		qfprom@1b40000 {
+			compatible = "qcom,qfprom";
+			reg = <0x1b40000 0x7000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qusb2_hstx_trim: hstx_trim@25b {
+				reg = <0x25b 0x1>;
+				bits = <1 4>;
+			};
+		};
+
+		tcsr_mutex_regs: syscon@1f40000 {
+			compatible = "syscon";
+			reg = <0x340000 0x20000>;
+		};
+
+		rpm_msg_ram: memory@45f0000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x45f0000 0x7000>;
+		};
+
+		timer@f120000 {
+			compatible = "arm,armv7-timer-mem";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0xf120000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame@f121000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf121000 0x1000>,
+				      <0xf122000 0x1000>;
+			};
+
+			frame@f123000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf123000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f124000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf124000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f125000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf125000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f126000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf126000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f127000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf127000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@f128000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xf128000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		intc: interrupt-controller@f200000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupt-parent = <&intc>;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+			reg = <0xf200000 0x10000>,
+			      <0xf300000 0x100000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 1 0xf08>,
+			     <GIC_PPI 2 0xf08>,
+			     <GIC_PPI 3 0xf08>,
+			     <GIC_PPI 0 0xf08>;
+		clock-frequency = <19200000>;
+	};
+};
-- 
2.37.2

