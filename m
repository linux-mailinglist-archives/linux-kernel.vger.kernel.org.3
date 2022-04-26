Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9E50FF69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351068AbiDZNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351054AbiDZNo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:44:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D603CA77
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so25559558wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mq0VAwh5UJJ1ySY2hnGptoqpajh6aCIUVFARZ+YbYg=;
        b=qv35mZRTWy4Yq+LLwggMnPTsMMY+u2VZ9Z3bl/eMJNp9lafpx7aMAbRUxDUw/a/MvY
         KNoi+y7rF8RSxvM3fW+d8lblArckFeqPQBo/9kQ+RcmU0WsWdkqEwzsUN3yTZWuxzAPv
         NjVvlLJ3lB2yAKHHGtSMzpZV1qb+45EwL9jG6QGdCwHhjJ5rHEGiyzKX56NESjJX/FAy
         q/+VRaz+LZke0pVFwmTtYvkn/iekuRsx/T3bT+Sg6G/Ju/kUKGQ6pfW49dPrgwqHLuCb
         ZTw2mVihfsGqWc+0LtnIvffEcSkkyoKQup8K+04aTHviR9V+iMZASWEBPxIdYYIftb5A
         XVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mq0VAwh5UJJ1ySY2hnGptoqpajh6aCIUVFARZ+YbYg=;
        b=Di86+6tUE8V6ThgjSXbOzaAeLROgERUm39pDxuyRV4CPsN8HKzcpelfVnmZBcy9Vto
         20SUxPtMPGEgiUeBcvOX2rdHkoWLuXweVosujWbopF0TdPPTMFcO+A3nYWyM7OOYZeZd
         881Y3Vg7vKzViK0EWvPkvvLm0Y2sv/Q11bCD0nf/jLDCFhgo2mTxR6mgtV9Hm8HgUoSK
         yp7f5rRHs/JQWVQKcNI7HHw1F7p4GPm6sJrZ6Xa9avtm5uWXLXNTApPODw/hV+GzK4IT
         gNxnNLn+X4ABVk+iSdsSUPCci5Mvn4p133i5eQLsJOjJzExHqvYhAnqEFKEr6pV/5MyC
         9FRg==
X-Gm-Message-State: AOAM531X1hr/LNrEv/bFGxdhjmchP5mfJK370oscHi6KOuIUiSDDM4US
        mgUQUKtjtfDSWJedzs29UDbi3w==
X-Google-Smtp-Source: ABdhPJy18Pi1+TBqaTQhsPwZii6Y2cMmIKGZUbFd1DjvY0HMKv+nke8BfTjEmK9o7Hhd1yxbiQfJxw==
X-Received: by 2002:a5d:4747:0:b0:20a:c40b:1189 with SMTP id o7-20020a5d4747000000b0020ac40b1189mr17870752wrs.509.1650980509001;
        Tue, 26 Apr 2022 06:41:49 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id b6-20020adfd1c6000000b0020aac8a9946sm13628475wrd.47.2022.04.26.06.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:41:48 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] arm64: dts: mediatek: mt8195: add ssusb support
Date:   Tue, 26 Apr 2022 15:41:00 +0200
Message-Id: <20220426134106.242353-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426134106.242353-1-fparent@baylibre.com>
References: <20220426134106.242353-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SSUSB support for MT8195. In order to not break any boards, this
commit also enable SSUSB for every board that has xhci0 enabled. The
boards are configured as host-only, in order to not change the current
behavior of the interface.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts |  5 +++
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts  |  5 +++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 37 ++++++++++++++------
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 66037462263e..08cab3b3943b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -402,6 +402,11 @@ &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&ssusb {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
index db25a515e420..d49ae8605e67 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
@@ -138,6 +138,11 @@ pins {
 	};
 };
 
+&ssusb {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &u3phy0 {
 	status="okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2a525c1c74ef..aa05071a80b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -912,25 +912,40 @@ spis1: spi@1101e000 {
 			status = "disabled";
 		};
 
-		xhci0: usb@11200000 {
-			compatible = "mediatek,mt8195-xhci",
-				     "mediatek,mtk-xhci";
-			reg = <0 0x11200000 0 0x1000>,
+		ssusb: usb@11201000 {
+			compatible ="mediatek,mt8195-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2dff>,
 			      <0 0x11203e00 0 0x0100>;
 			reg-names = "mac", "ippc";
-			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
 			phys = <&u2port0 PHY_TYPE_USB2>,
 			       <&u3port0 PHY_TYPE_USB3>;
-			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
-					  <&topckgen CLK_TOP_SSUSB_XHCI>;
-			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
-						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
 			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
 				 <&topckgen CLK_TOP_SSUSB_REF>,
-				 <&apmixedsys CLK_APMIXED_USB1PLL>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck", "xhci_ck";
+			clock-names = "sys_ck", "ref_ck", "mcu_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
 			status = "disabled";
+
+			xhci0: usb@11200000 {
+				compatible = "mediatek,mt8195-xhci",
+					     "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+				assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
+						  <&topckgen CLK_TOP_SSUSB_XHCI>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+							 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+				clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
+					 <&topckgen CLK_TOP_SSUSB_REF>,
+					 <&apmixedsys CLK_APMIXED_USB1PLL>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
+				clock-names = "sys_ck", "ref_ck", "mcu_ck", "xhci_ck";
+				status = "disabled";
+			};
 		};
 
 		mmc0: mmc@11230000 {
-- 
2.36.0

