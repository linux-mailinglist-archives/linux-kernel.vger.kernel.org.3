Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094C44E99A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbiC1OdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243918AbiC1Ocn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580444777;
        Mon, 28 Mar 2022 07:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D77B61243;
        Mon, 28 Mar 2022 14:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7B0C34111;
        Mon, 28 Mar 2022 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477859;
        bh=OuRo2q+coWtb/ALyqpyfzlvv3DncSmX5J0Wv6DnCo6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdAnRGpsJ6xFyxaB/YI7OPLUwBkCWAtSSiNXB+HrQ+WkY68iJ3m/95U/3czpJKRc8
         ZWm+wLa9q55CE55KiLrHfabf0UflBdQ36post17Rz0rZKGWYqwgnvnWzOXCEN0F/c1
         exWVaYdel9ANnvERwEysnRHSCDaCUm3YUc6qpUk+qyp7kZY59BBvDGIQKgA22wlora
         jMxovM4jmcnhHxKSAuuZPka94WYAOk22TUBK74oLBI6YDLNtq8GvG56Rexoq29FSJI
         68QWLr8Kyo7OZXCKDPiQ4CDIOl99RtYTY9wTiAPyLzVZSWBEFyvaFQiG2bBegbcyUP
         aRW9qDeuM3vVw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: qcom: sm8250: move wcd938x node out of soc node
Date:   Mon, 28 Mar 2022 20:00:34 +0530
Message-Id: <20220328143035.519909-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328143035.519909-1-vkoul@kernel.org>
References: <20220328143035.519909-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soc node expects all the nodes to have unit addresses. The wcd codec
node does not have that which causes warnings:

arch/arm64/boot/dts/qcom/sm8250-mtp.dts:631.17-648.4:
Warning (simple_bus_reg): /soc@0/codec: missing or empty reg/ranges property

Move wcd node out of soc to fix this

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index fb99cc2827c7..3876a94b49a9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -156,6 +156,25 @@ vreg_s6c_0p88: smpc6-regulator {
 		regulator-always-on;
 		vin-supply = <&vph_pwr>;
 	};
+
+	wcd938x: codec {
+		compatible = "qcom,wcd9380-codec";
+		#sound-dai-cells = <1>;
+		reset-gpios = <&tlmm 32 0>;
+		vdd-buck-supply = <&vreg_s4a_1p8>;
+		vdd-rxtx-supply = <&vreg_s4a_1p8>;
+		vdd-io-supply = <&vreg_s4a_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+	};
 };
 
 &adsp {
@@ -627,27 +646,6 @@ &slpi {
 	firmware-name = "qcom/sm8250/slpi.mbn";
 };
 
-&soc {
-	wcd938x: codec {
-		compatible = "qcom,wcd9380-codec";
-		#sound-dai-cells = <1>;
-		reset-gpios = <&tlmm 32 0>;
-		vdd-buck-supply = <&vreg_s4a_1p8>;
-		vdd-rxtx-supply = <&vreg_s4a_1p8>;
-		vdd-io-supply = <&vreg_s4a_1p8>;
-		vdd-mic-bias-supply = <&vreg_bob>;
-		qcom,micbias1-microvolt = <1800000>;
-		qcom,micbias2-microvolt = <1800000>;
-		qcom,micbias3-microvolt = <1800000>;
-		qcom,micbias4-microvolt = <1800000>;
-		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
-		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
-		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
-		qcom,rx-device = <&wcd_rx>;
-		qcom,tx-device = <&wcd_tx>;
-	};
-};
-
 &sound {
 	compatible = "qcom,sm8250-sndcard";
 	model = "SM8250-MTP-WCD9380-WSA8810-VA-DMIC";
-- 
2.34.1

