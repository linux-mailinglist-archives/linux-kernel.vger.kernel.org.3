Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F72516FB8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385034AbiEBMpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384935AbiEBMpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:45:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0072813EA4
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:41:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y21so16481221edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yW6UdHo6njhH5S1r53s3segliI8gxUDt9nBcuHLQkY=;
        b=uXCBZSwt1qRzIF5T6sW64Fm0CLcSwJeNelyGVd8AVvW6fG89FXwTz/Urgs93RFzEvK
         3GeYghaFWl/YvIrao9lT9pjQMfqCUA+tPAHx2satP/wTqdRiT4zJs91ScTzTSbb1SJK9
         +GMl5qhnFeCk2AB/u1iVM5ghV1VnArWlxSkQaDqH7FUnFfGISUzleGong6MCECRdJTBo
         jbab2wNVpxF/sade3tE3dYST5xQxqoTAB41JcvAs21s3kIwTH7JZKKGg+nbMkD39iaf1
         vfH0jOfgp21aELLylWOeC/q+BYIzgK9BXRbOrdM+I+TR1WiNizY3kQy0o5tbptj2cm/P
         LUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yW6UdHo6njhH5S1r53s3segliI8gxUDt9nBcuHLQkY=;
        b=psS05C/zPlNvVNiBpzuxaudsmN0w/f6F0hVKHPGP7s42fPflMwRT9InvxqPx4rwrK7
         frvzvPN2UDcJ14Clpy7TmTpvJygeVPUBbIvPwiIAZ8Q1PKL+g6XK6JqRvZfqfbEFhsZa
         1ijq+rinC9lhTUzcMgDcvZ4oin79r8qXoLEoIzd4SkK+OGytZIB5B/YU5U6aoYHBhWl7
         15/vI5a9Ed78IQXtvyWjtzRbp2rX8F8tMBForBchqxwmQ9LKgD6LoKgesge5yNHMrMc5
         36zMzc4mvKI3YrN7GrWxYK0eINhNExeIzkzmVMTb+4c5dOPOoCCghaGkdYfj7kYRokdi
         dbdw==
X-Gm-Message-State: AOAM532kVaz6TgrjlacIlUwwVlwrUzVkjaFcBEQ/QrPoqfzHgGMn62Yg
        DE6+6CqZaorunCcSVhDsJ0OiJZF7OJelug==
X-Google-Smtp-Source: ABdhPJx6l5AUDlq7fhzKVeszwcramj2frDv3MQu1iPWyc7QiS/srlGJWi/gzSTgMUpiGn8wUKaIZDA==
X-Received: by 2002:a05:6402:3508:b0:427:b100:b825 with SMTP id b8-20020a056402350800b00427b100b825mr10097712edd.268.1651495306493;
        Mon, 02 May 2022 05:41:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w9-20020a170907270900b006f3ef214e75sm3504196ejk.219.2022.05.02.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 05:41:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: align OPP table names with DT schema
Date:   Mon,  2 May 2022 14:41:43 +0200
Message-Id: <20220502124143.160044-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects names of operating points tables to start with
"opp-table".  Use hyphens instead of underscores, fix the names to match
DT schema or remove the prefix entirely when it is not needed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 18 +++++++++---------
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 12 ++++++------
 arch/arm64/boot/dts/qcom/sdm630.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 16 ++++++++--------
 arch/arm64/boot/dts/qcom/sm6350.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi  |  8 ++++----
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 16 ++++++++--------
 arch/arm64/boot/dts/qcom/sm8350.dtsi  |  4 ++--
 arch/arm64/boot/dts/qcom/sm8450.dtsi  |  2 +-
 11 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index a4d363c187fc..a78341da0a9d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -87,7 +87,7 @@ L2_0: l2-cache {
 		};
 	};
 
-	cpu_opp_table: cpu_opp_table {
+	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 05472510e29d..ec22668e641b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -216,7 +216,7 @@ CLUSTER_PWRDN: cluster-gdhs {
 		};
 	};
 
-	cpu_opp_table: cpu-opp-table {
+	cpu_opp_table: opp-table-cpu {
 		compatible = "operating-points-v2";
 		opp-shared;
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 86175d257b1e..f434752c3e73 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -398,7 +398,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 		};
 	};
 
-	cpu0_opp_table: cpu0_opp_table {
+	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -453,7 +453,7 @@ cpu0_opp10: opp-1804800000 {
 		};
 	};
 
-	cpu6_opp_table: cpu6_opp_table {
+	cpu6_opp_table: opp-table-cpu6 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -725,7 +725,7 @@ sdhc_1: sdhci@7c4000 {
 
 			status = "disabled";
 
-			sdhc1_opp_table: sdhc1-opp-table {
+			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
@@ -744,7 +744,7 @@ opp-384000000 {
 			};
 		};
 
-		qup_opp_table: qup-opp-table {
+		qup_opp_table: opp-table-qup {
 			compatible = "operating-points-v2";
 
 			opp-75000000 {
@@ -2609,7 +2609,7 @@ sdhc_2: sdhci@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
@@ -2628,7 +2628,7 @@ opp-202000000 {
 			};
 		};
 
-		qspi_opp_table: qspi-opp-table {
+		qspi_opp_table: opp-table-qspi {
 			compatible = "operating-points-v2";
 
 			opp-75000000 {
@@ -2829,7 +2829,7 @@ video-encoder {
 				compatible = "venus-encoder";
 			};
 
-			venus_opp_table: venus-opp-table {
+			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-150000000 {
@@ -2967,7 +2967,7 @@ dpu_intf0_out: endpoint {
 					};
 				};
 
-				mdp_opp_table: mdp-opp-table {
+				mdp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
 					opp-200000000 {
@@ -3046,7 +3046,7 @@ dsi0_out: endpoint {
 					};
 				};
 
-				dsi_opp_table: dsi-opp-table {
+				dsi_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
 					opp-187500000 {
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ccf5e95071f9..4674ef7a1562 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -417,7 +417,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 		};
 	};
 
-	cpu0_opp_table: cpu0-opp-table {
+	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -477,7 +477,7 @@ cpu0_opp_2016mhz: opp-2016000000 {
 		};
 	};
 
-	cpu4_opp_table: cpu4-opp-table {
+	cpu4_opp_table: opp-table-cpu4 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -547,7 +547,7 @@ cpu4_opp_2611mhz: opp-2611200000 {
 		};
 	};
 
-	cpu7_opp_table: cpu7-opp-table {
+	cpu7_opp_table: opp-table-cpu7 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -763,7 +763,7 @@ psci {
 		method = "smc";
 	};
 
-	qspi_opp_table: qspi-opp-table {
+	qspi_opp_table: opp-table-qspi {
 		compatible = "operating-points-v2";
 
 		opp-75000000 {
@@ -787,7 +787,7 @@ opp-300000000 {
 		};
 	};
 
-	qup_opp_table: qup-opp-table {
+	qup_opp_table: opp-table-qup {
 		compatible = "operating-points-v2";
 
 		opp-75000000 {
@@ -3326,7 +3326,7 @@ video-firmware {
 				iommus = <&apps_smmu 0x21a2 0x0>;
 			};
 
-			venus_opp_table: venus-opp-table {
+			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-133330000 {
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 7f875bf9390a..8d51d266950a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1401,7 +1401,7 @@ mmcc: clock-controller@c8c0000 {
 					<0>;
 		};
 
-		dsi_opp_table: dsi-opp-table {
+		dsi_opp_table: opp-table-dsi {
 			compatible = "operating-points-v2";
 
 			opp-131250000 {
@@ -1490,7 +1490,7 @@ mdp5_intf1_out: endpoint {
 					};
 				};
 
-				mdp_opp_table: mdp-opp {
+				mdp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
 					opp-150000000 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 692cf4be4eef..3c94719f013e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -462,7 +462,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 		};
 	};
 
-	cpu0_opp_table: cpu0_opp_table {
+	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -557,7 +557,7 @@ cpu0_opp18: opp-1766400000 {
 		};
 	};
 
-	cpu4_opp_table: cpu4_opp_table {
+	cpu4_opp_table: opp-table-cpu4 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -1104,7 +1104,7 @@ rng: rng@793000 {
 			clock-names = "core";
 		};
 
-		qup_opp_table: qup-opp-table {
+		qup_opp_table: opp-table-qup {
 			compatible = "operating-points-v2";
 
 			opp-50000000 {
@@ -3569,7 +3569,7 @@ sdhc_2: sdhci@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-9600000 {
@@ -3594,7 +3594,7 @@ opp-201500000 {
 			};
 		};
 
-		qspi_opp_table: qspi-opp-table {
+		qspi_opp_table: opp-table-qspi {
 			compatible = "operating-points-v2";
 
 			opp-19200000 {
@@ -3965,7 +3965,7 @@ video-core1 {
 				compatible = "venus-encoder";
 			};
 
-			venus_opp_table: venus-opp-table {
+			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
@@ -4202,7 +4202,7 @@ clock_camcc: clock-controller@ad00000 {
 			clock-names = "bi_tcxo";
 		};
 
-		dsi_opp_table: dsi-opp-table {
+		dsi_opp_table: opp-table-dsi {
 			compatible = "operating-points-v2";
 
 			opp-19200000 {
@@ -4304,7 +4304,7 @@ dpu_intf2_out: endpoint {
 					};
 				};
 
-				mdp_opp_table: mdp-opp-table {
+				mdp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
 					opp-19200000 {
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index fb1a0f662575..9fda9be2f2f7 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -497,7 +497,7 @@ sdhc_1: sdhci@7c4000 {
 
 			status = "disabled";
 
-			sdhc1_opp_table: sdhc1-opp-table {
+			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-19200000 {
@@ -941,7 +941,7 @@ sdhc_2: sdhci@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 2700a8145cb9..0ca10684a748 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -288,7 +288,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 		};
 	};
 
-	cpu0_opp_table: cpu0_opp_table {
+	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -383,7 +383,7 @@ cpu0_opp18: opp-1785600000 {
 		};
 	};
 
-	cpu4_opp_table: cpu4_opp_table {
+	cpu4_opp_table: opp-table-cpu4 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -473,7 +473,7 @@ cpu4_opp17: opp-2419200000 {
 		};
 	};
 
-	cpu7_opp_table: cpu7_opp_table {
+	cpu7_opp_table: opp-table-cpu7 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -3563,7 +3563,7 @@ sdhc_2: sdhci@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-19200000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dc2562070336..c5034b7f9add 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -336,7 +336,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 		};
 	};
 
-	cpu0_opp_table: cpu0_opp_table {
+	cpu0_opp_table: opp-table-cpu0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -426,7 +426,7 @@ cpu0_opp17: opp-1804800000 {
 		};
 	};
 
-	cpu4_opp_table: cpu4_opp_table {
+	cpu4_opp_table: opp-table-cpu4 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -521,7 +521,7 @@ cpu4_opp18: opp-2419200000 {
 		};
 	};
 
-	cpu7_opp_table: cpu7_opp_table {
+	cpu7_opp_table: opp-table-cpu7 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -914,7 +914,7 @@ rng: rng@793000 {
 			clock-names = "core";
 		};
 
-		qup_opp_table: qup-opp-table {
+		qup_opp_table: opp-table-qup {
 			compatible = "operating-points-v2";
 
 			opp-50000000 {
@@ -2937,7 +2937,7 @@ sdhc_2: sdhci@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-19200000 {
@@ -3115,7 +3115,7 @@ video-encoder {
 				compatible = "venus-encoder";
 			};
 
-			venus_opp_table: venus-opp-table {
+			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-720000000 {
@@ -3478,7 +3478,7 @@ dpu_intf2_out: endpoint {
 					};
 				};
 
-				mdp_opp_table: mdp-opp-table {
+				mdp_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
 					opp-200000000 {
@@ -3648,7 +3648,7 @@ dsi1_phy: dsi-phy@ae96400 {
 
 				status = "disabled";
 
-				dsi_opp_table: dsi-opp-table {
+				dsi_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
 					opp-187500000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c0137bdcf94b..ccfa84dda3d7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -638,7 +638,7 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
-		qup_opp_table_100mhz: qup-100mhz-opp-table {
+		qup_opp_table_100mhz: opp-table-qup100mhz {
 			compatible = "operating-points-v2";
 
 			opp-50000000 {
@@ -657,7 +657,7 @@ opp-100000000 {
 			};
 		};
 
-		qup_opp_table_120mhz: qup-120mhz-opp-table {
+		qup_opp_table_120mhz: opp-table-qup120mhz {
 			compatible = "operating-points-v2";
 
 			opp-50000000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7f52c3cfdfb7..7a4e989e14e0 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -343,7 +343,7 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
-	qup_opp_table_100mhz: qup-100mhz-opp-table {
+	qup_opp_table_100mhz: opp-table-qup {
 		compatible = "operating-points-v2";
 
 		opp-50000000 {
-- 
2.32.0

