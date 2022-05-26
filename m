Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C665354F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbiEZUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349067AbiEZUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:45:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8F13D50
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:45:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t26so3206837edt.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvEgPuZH0/TIqqUAG/GbAAeJq+KdAL3BojrVlqWVgWU=;
        b=QNn/HJC2TJeFBNRmYVeRzZjkSKQxtzpJ98EbuTBs6i5Z7ISORvwseIrTl5eTfv0rRk
         a1u0CUuYcz13vT4lJLK5XduXmmxZJPJiV7YSRGEvDS6XwxWXbm1LtSWgY78+WQE8d6Gt
         j0+haJyMSYATJHMj8QBm+N/l9lhYUBsecsk4PJzAqqTz/BXNZttKkL1T94+iiGk/6cjb
         UsbLzP6SujJGX/VdjmUZycYytVdfPdU62XqDycpFLThb4OM4mtPoSrmycEu0YNuXHcwL
         jK1CeHJsXpyCjNxg2/TLJ93rq8rhvEP6eViLTLWUx4PVZvUV6Vf4I4tIJT4VWR5+g9g/
         1L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bvEgPuZH0/TIqqUAG/GbAAeJq+KdAL3BojrVlqWVgWU=;
        b=WAkYPR3BGFu9+MlVfWPX6t/3msa7GTd+9D/sFjiB2mYIVtPWhkb01zAErKjAh/C0rv
         L68oPOMePMQAQBpSep5Aj9anuzpioCRiibE0ABjY3vcRRBKa3l5AMW6T2kCq9y6+jaGK
         ocnAVqHoU7yFI2QI9fJOUGumexbtsOnDfpwjo2plzXRPqVIf0hcBKB2rx48E/IUD0Jx8
         /08yjVEFFt+zJlh6rOx72u5ZQt6jX2QSK5970/USuRd2hpIOx0S8c9fvyUMIEcmxuS1+
         4WCrIK70hAcEpIHPNfA9/jfbrBjgPrGBzK2ugulK2m9LkDWMOt11C16fr5UjQt9b2HJS
         6TsA==
X-Gm-Message-State: AOAM531LN8ilwYeldgLFk8qCkgQ6JJOFsPbIPmTLzNwBThTxSnm+HJKR
        4pZPmFxY3vMOS9GqW+2tgRvy1A==
X-Google-Smtp-Source: ABdhPJxCy5M4S64WUb2PzZ01dJK2/2KWeckn7YeGrDFAMa680I97Bml3rWNbqOmw6hyFmdAQXaiU6g==
X-Received: by 2002:aa7:cdd7:0:b0:42a:bbb2:84e5 with SMTP id h23-20020aa7cdd7000000b0042abbb284e5mr41913291edw.91.1653597930721;
        Thu, 26 May 2022 13:45:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id rv3-20020a1709068d0300b006fec69a3978sm769550ejc.207.2022.05.26.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:45:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: marvell: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:45:24 +0200
Message-Id: <20220526204525.832847-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts    | 4 ++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi      | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts | 4 ++--
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi              | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index 39a8e5e99d79..b9ba7c452a77 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -37,7 +37,7 @@ sfp_eth0: sfp-eth0 {
 		los-gpio = <&sfp_gpio 3 GPIO_ACTIVE_HIGH>;
 		mod-def0-gpio = <&sfp_gpio 2 GPIO_ACTIVE_LOW>;
 		tx-disable-gpio = <&sfp_gpio 1 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio  = <&sfp_gpio 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&sfp_gpio 0 GPIO_ACTIVE_HIGH>;
 	};
 
 	/* SFP 1G */
@@ -47,7 +47,7 @@ sfp_eth2: sfp-eth2 {
 		los-gpio = <&sfp_gpio 7 GPIO_ACTIVE_HIGH>;
 		mod-def0-gpio = <&sfp_gpio 6 GPIO_ACTIVE_LOW>;
 		tx-disable-gpio = <&sfp_gpio 5 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio  = <&sfp_gpio 4 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&sfp_gpio 4 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 779cf167c33e..c0389dd17340 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -68,7 +68,7 @@ sfp_eth0: sfp-eth0 {
 		los-gpio = <&cp1_gpio1 28 GPIO_ACTIVE_HIGH>;
 		mod-def0-gpio = <&cp1_gpio1 27 GPIO_ACTIVE_LOW>;
 		tx-disable-gpio = <&cp1_gpio1 29 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio  = <&cp1_gpio1 26 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp1_gpio1 26 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cp1_sfpp0_pins>;
 		maximum-power-milliwatt = <2000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
index 74bed79e4f5e..cf868e0bbb9c 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
@@ -70,7 +70,7 @@ sfp_cp0_eth0: sfp-cp0-eth0 {
 		los-gpio = <&sfpplus_gpio 11 GPIO_ACTIVE_HIGH>;
 		mod-def0-gpio = <&sfpplus_gpio 10 GPIO_ACTIVE_LOW>;
 		tx-disable-gpio = <&sfpplus_gpio 9 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio  = <&sfpplus_gpio 8 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&sfpplus_gpio 8 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
 	};
 
@@ -80,7 +80,7 @@ sfp_cp1_eth0: sfp-cp1-eth0 {
 		los-gpio = <&sfpplus_gpio 3 GPIO_ACTIVE_HIGH>;
 		mod-def0-gpio = <&sfpplus_gpio 2 GPIO_ACTIVE_LOW>;
 		tx-disable-gpio = <&sfpplus_gpio 1 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio  = <&sfpplus_gpio 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&sfpplus_gpio 0 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
 	};
 
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index 7e20987253a3..f58402eb9536 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -404,7 +404,7 @@ &cp0_usb3_0 {
 &cp0_usb3_1 {
 	status = "okay";
 	usb-phy = <&cp0_usb3_0_phy1>;
-	phys =  <&cp0_utmi1>;
+	phys = <&cp0_utmi1>;
 	phy-names = "utmi";
 	dr_mode = "host";
 };
-- 
2.34.1

