Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA964BB53C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiBRJRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:17:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiBRJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:17:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF810FE5;
        Fri, 18 Feb 2022 01:16:48 -0800 (PST)
X-UUID: dce69bfac27c49e7b5243bfa4ba95afc-20220218
X-UUID: dce69bfac27c49e7b5243bfa4ba95afc-20220218
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1732226255; Fri, 18 Feb 2022 17:16:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Feb 2022 17:16:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Feb 2022 17:16:44 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 08/23] arm64: dts: mt8192: Add audio-related nodes
Date:   Fri, 18 Feb 2022 17:16:18 +0800
Message-ID: <20220218091633.9368-9-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio-related nodes in audsys for mt8192 SoC.
Move audsys node in ascending order.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 135 ++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 08c7c1c772f5..f93fe3779161 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -743,6 +743,135 @@
 			#size-cells = <2>;
 		};
 
+		audsys: syscon@11210000 {
+			compatible = "mediatek,mt8192-audsys", "syscon";
+			reg = <0 0x11210000 0 0x2000>;
+			#clock-cells = <1>;
+
+			afe: mt8192-afe-pcm {
+				compatible = "mediatek,mt8192-audio";
+				interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH 0>;
+				resets = <&watchdog 17>;
+				reset-names = "audiosys";
+				mediatek,apmixedsys = <&apmixedsys>;
+				mediatek,infracfg = <&infracfg>;
+				mediatek,topckgen = <&topckgen>;
+				power-domains = <&spm MT8192_POWER_DOMAIN_AUDIO>;
+				clocks = <&audsys CLK_AUD_AFE>,
+					 <&audsys CLK_AUD_DAC>,
+					 <&audsys CLK_AUD_DAC_PREDIS>,
+					 <&audsys CLK_AUD_ADC>,
+					 <&audsys CLK_AUD_ADDA6_ADC>,
+					 <&audsys CLK_AUD_22M>,
+					 <&audsys CLK_AUD_24M>,
+					 <&audsys CLK_AUD_APLL_TUNER>,
+					 <&audsys CLK_AUD_APLL2_TUNER>,
+					 <&audsys CLK_AUD_TDM>,
+					 <&audsys CLK_AUD_TML>,
+					 <&audsys CLK_AUD_NLE>,
+					 <&audsys CLK_AUD_DAC_HIRES>,
+					 <&audsys CLK_AUD_ADC_HIRES>,
+					 <&audsys CLK_AUD_ADC_HIRES_TML>,
+					 <&audsys CLK_AUD_ADDA6_ADC_HIRES>,
+					 <&audsys CLK_AUD_3RD_DAC>,
+					 <&audsys CLK_AUD_3RD_DAC_PREDIS>,
+					 <&audsys CLK_AUD_3RD_DAC_TML>,
+					 <&audsys CLK_AUD_3RD_DAC_HIRES>,
+					 <&infracfg CLK_INFRA_AUDIO>,
+					 <&infracfg CLK_INFRA_AUDIO_26M_B>,
+					 <&topckgen CLK_TOP_AUDIO_SEL>,
+					 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+					 <&topckgen CLK_TOP_MAINPLL_D4_D4>,
+					 <&topckgen CLK_TOP_AUD_1_SEL>,
+					 <&topckgen CLK_TOP_APLL1>,
+					 <&topckgen CLK_TOP_AUD_2_SEL>,
+					 <&topckgen CLK_TOP_APLL2>,
+					 <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
+					 <&topckgen CLK_TOP_APLL1_D4>,
+					 <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
+					 <&topckgen CLK_TOP_APLL2_D4>,
+					 <&topckgen CLK_TOP_APLL_I2S0_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S1_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S2_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S3_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S4_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S5_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S6_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S7_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S8_M_SEL>,
+					 <&topckgen CLK_TOP_APLL_I2S9_M_SEL>,
+					 <&topckgen CLK_TOP_APLL12_DIV0>,
+					 <&topckgen CLK_TOP_APLL12_DIV1>,
+					 <&topckgen CLK_TOP_APLL12_DIV2>,
+					 <&topckgen CLK_TOP_APLL12_DIV3>,
+					 <&topckgen CLK_TOP_APLL12_DIV4>,
+					 <&topckgen CLK_TOP_APLL12_DIVB>,
+					 <&topckgen CLK_TOP_APLL12_DIV5>,
+					 <&topckgen CLK_TOP_APLL12_DIV6>,
+					 <&topckgen CLK_TOP_APLL12_DIV7>,
+					 <&topckgen CLK_TOP_APLL12_DIV8>,
+					 <&topckgen CLK_TOP_APLL12_DIV9>,
+					 <&topckgen CLK_TOP_AUDIO_H_SEL>,
+					 <&clk26m>;
+				clock-names = "aud_afe_clk",
+					      "aud_dac_clk",
+					      "aud_dac_predis_clk",
+					      "aud_adc_clk",
+					      "aud_adda6_adc_clk",
+					      "aud_apll22m_clk",
+					      "aud_apll24m_clk",
+					      "aud_apll1_tuner_clk",
+					      "aud_apll2_tuner_clk",
+					      "aud_tdm_clk",
+					      "aud_tml_clk",
+					      "aud_nle",
+					      "aud_dac_hires_clk",
+					      "aud_adc_hires_clk",
+					      "aud_adc_hires_tml",
+					      "aud_adda6_adc_hires_clk",
+					      "aud_3rd_dac_clk",
+					      "aud_3rd_dac_predis_clk",
+					      "aud_3rd_dac_tml",
+					      "aud_3rd_dac_hires_clk",
+					      "aud_infra_clk",
+					      "aud_infra_26m_clk",
+					      "top_mux_audio",
+					      "top_mux_audio_int",
+					      "top_mainpll_d4_d4",
+					      "top_mux_aud_1",
+					      "top_apll1_ck",
+					      "top_mux_aud_2",
+					      "top_apll2_ck",
+					      "top_mux_aud_eng1",
+					      "top_apll1_d4",
+					      "top_mux_aud_eng2",
+					      "top_apll2_d4",
+					      "top_i2s0_m_sel",
+					      "top_i2s1_m_sel",
+					      "top_i2s2_m_sel",
+					      "top_i2s3_m_sel",
+					      "top_i2s4_m_sel",
+					      "top_i2s5_m_sel",
+					      "top_i2s6_m_sel",
+					      "top_i2s7_m_sel",
+					      "top_i2s8_m_sel",
+					      "top_i2s9_m_sel",
+					      "top_apll12_div0",
+					      "top_apll12_div1",
+					      "top_apll12_div2",
+					      "top_apll12_div3",
+					      "top_apll12_div4",
+					      "top_apll12_divb",
+					      "top_apll12_div5",
+					      "top_apll12_div6",
+					      "top_apll12_div7",
+					      "top_apll12_div8",
+					      "top_apll12_div9",
+					      "top_mux_audio_h",
+					      "top_clk26m_clk";
+			};
+		};
+
 		nor_flash: spi@11234000 {
 			compatible = "mediatek,mt8192-nor";
 			reg = <0 0x11234000 0 0xe0>;
@@ -758,12 +887,6 @@
 			status = "disable";
 		};
 
-		audsys: clock-controller@11210000 {
-			compatible = "mediatek,mt8192-audsys", "syscon";
-			reg = <0 0x11210000 0 0x1000>;
-			#clock-cells = <1>;
-		};
-
 		i2c3: i2c@11cb0000 {
 			compatible = "mediatek,mt8192-i2c";
 			reg = <0 0x11cb0000 0 0x1000>,
-- 
2.18.0

