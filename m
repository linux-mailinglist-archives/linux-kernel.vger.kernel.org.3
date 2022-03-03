Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4134CC391
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiCCRTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiCCRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:19:18 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B7DF495;
        Thu,  3 Mar 2022 09:18:30 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q8so6622814iod.2;
        Thu, 03 Mar 2022 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Piv/cwjRM38ctXaerZYeTWxIVh1IQ5zV9gRucqSt5Ow=;
        b=cMp0QepwF0b2BjbjvXzC51xZri/it7a7dc6vo6hmUJswJbmpu+3Jf45b1/r4+wWg1I
         AoFqnZeWVaXGz8MNSE9A9edYSC3s1ySmJpfah7zmprgz4mlvia9acs8l/lxWpQVEyQ2n
         5dAd9JC9m9kEkKfebe9oT+HPjHZOjO9Nczg2TN+U1YFbaQpfxV985vp/KTsa6W59D6Qm
         s9BGpI9yMuFlmgAP1a7A24Xg5i1QcJdggMuaulJnPWF021g23LoJVrgxp0e86jksNXgd
         Emn6tMKRyYhG1j85bZxiD9NHVYdd0MYrQTW17piCR6yiPHnce1uQWesrk7ejIvNBQhso
         kEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Piv/cwjRM38ctXaerZYeTWxIVh1IQ5zV9gRucqSt5Ow=;
        b=jAzDWFuc+Hk3KcmmE6nlsB8HwrAkF9QzCegfq9FaRCCnZd+bKkA69AXC7+861WIbEW
         zoGb+Tbuff1hZej180AA45BL4vVhWmaSz8eHUYW1qqPkHI+aJBlwkSAWZ09La74xh8EL
         kPX/Ng2YXwGEY3u/SduuOjv7eXwe+McqjLSNWmYFP1mpzeCKjhK9OtC0Pr0QSCq7pKMc
         I39wU9Sd2Ki6Hr7Rks/T+PHEzho+UbwZt15swTxvZpIb+Rr/16mNLBjzut9YshB7erlM
         LyAGgYyRri3Vv+z+5XucUc2OfjtPco7RhM5HyAxsPk256T42vftyT+F3wfTL1/OkYd4c
         jJ3g==
X-Gm-Message-State: AOAM530ZIdIEnvuhwdHCkQf4j1hNiJg2/MupRr/WfJ6Hrql8nR09frzY
        eVNZxEgsfQA3yWuvPx+fA2+uDXqSzecMcA==
X-Google-Smtp-Source: ABdhPJySCXHAFG/fVPd8LxSkhMoMH6R6svTkOcUbDAYgbbRNVTTk8ONZtwcFqggyW74gHFRY7gNjJA==
X-Received: by 2002:a6b:8e17:0:b0:60d:c43a:6992 with SMTP id q23-20020a6b8e17000000b0060dc43a6992mr28061136iod.24.1646327909291;
        Thu, 03 Mar 2022 09:18:29 -0800 (PST)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id b11-20020a92c56b000000b002c5ff65adffsm3016655ilj.31.2022.03.03.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:18:28 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: logicpd-som-lv: Fix wrong pinmuxing on OMAP35
Date:   Thu,  3 Mar 2022 11:18:17 -0600
Message-Id: <20220303171818.11060-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinout of the OMAP35 and DM37 variants of the SOM-LV are the
same, but the macros which define the pinmuxing are different
between OMAP3530 and DM3730.  The pinmuxing was correct for
for the DM3730, but wrong for the OMAP3530.  Since the boot loader
was correctly pin-muxing the pins, this was not obvious. As the
bootloader not guaranteed to pinmux all the pins any more, this
causes an issue, so the pinmux needs to be moved from a common
file to their respective board files.

Fixes: f8a2e3ff7103 ("ARM: dts: Add minimal support for LogicPD OMAP35xx SOM-LV devkit")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts b/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
index 2a0a98fe67f0..3240c67e0c39 100644
--- a/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
@@ -11,3 +11,18 @@
 	model = "LogicPD Zoom OMAP35xx SOM-LV Development Kit";
 	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3430", "ti,omap3";
 };
+
+&omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hsusb2_2_pins>;
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+			OMAP3430_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)            /* etk_d10.hsusb2_clk */
+			OMAP3430_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)            /* etk_d11.hsusb2_stp */
+			OMAP3430_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d12.hsusb2_dir */
+			OMAP3430_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d13.hsusb2_nxt */
+			OMAP3430_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d14.hsusb2_data0 */
+			OMAP3430_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d15.hsusb2_data1 */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
index a604d92221a4..c757f0d7781c 100644
--- a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
@@ -11,3 +11,18 @@
 	model = "LogicPD Zoom DM3730 SOM-LV Development Kit";
 	compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap3";
 };
+
+&omap3_pmx_core2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hsusb2_2_pins>;
+	hsusb2_2_pins: pinmux_hsusb2_2_pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)            /* etk_d10.hsusb2_clk */
+			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)            /* etk_d11.hsusb2_stp */
+			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d12.hsusb2_dir */
+			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d13.hsusb2_nxt */
+			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d14.hsusb2_data0 */
+			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d15.hsusb2_data1 */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/logicpd-som-lv.dtsi
index b56524cc7fe2..55b619c99e24 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -265,21 +265,6 @@
 	};
 };
 
-&omap3_pmx_core2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb2_2_pins>;
-	hsusb2_2_pins: pinmux_hsusb2_2_pins {
-		pinctrl-single,pins = <
-			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)            /* etk_d10.hsusb2_clk */
-			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)            /* etk_d11.hsusb2_stp */
-			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d12.hsusb2_dir */
-			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d13.hsusb2_nxt */
-			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d14.hsusb2_data0 */
-			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)    /* etk_d15.hsusb2_data1 */
-		>;
-	};
-};
-
 &uart2 {
 	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
 	pinctrl-names = "default";
-- 
2.17.1

