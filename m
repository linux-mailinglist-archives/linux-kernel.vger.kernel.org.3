Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09575544A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiFILk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbiFILkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371EA1D4DE1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o10so30788496edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JnuoXyFQ1mcIfGUDeguV8aH22Ud7JrvDrsx4kjr7r4=;
        b=PGU4H6iTMZP3x79kZ5WZuIIIlSLQqTAVYTIvCsb1Mwnkf4YfG/6Sdora9BRlTyR/6A
         mJAinxBuAsg03ClmwZnBnVdM7k3yF8E5g1MZj4kEmypNn/TfFYqVEHP51sjwrykfElvF
         0AcmPmN9rSQSvzd+gsVLhaWqEDUZmAUsr36kSc3Rskr7YdSTq37KCZjAClfsgvLJ4qHY
         w8DQEP70VdhJaNP71LkcqxgeAqRK7tFTWfr7WCxHi3o+lp+5TmHnCYNBdREXv1RE3UAM
         81XfdS56VnQuIrNO+qrNOcNtQikSD7Mj9QxQWbsgXTyjmHAWGzgYyXKt11GCSqKTjs3m
         o2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JnuoXyFQ1mcIfGUDeguV8aH22Ud7JrvDrsx4kjr7r4=;
        b=5sdkKTdV57Jb1ofXM+SpzksxKjOgwlgJaN0CqpNWrAGxK9WQUqpDZLbjuP8p5mpEvB
         owENXiy2COVj05o6j5FTrWwW1VN6WXA1BEoR0vBoiTGGYFyBIKBpfvg1+Rq0OxNasYFr
         7WDcZ1fjnfTaBNbYMP2D0iDUdHVfKZW8Wb53jouNtfz/1T6IRg2CJujnyFSjHpaIstnb
         Zlk01KZ5VrZ1osTN4MiOjI0l2U6dc6jybSgZyct+q5XXOUXEL5R35f6fAAptZ4w8SJY2
         BsRZA5ESRhhl5lwGGcRYu6lrPXN7tInfdHprtYwrKRn8inRRfs3SqR349pR3/waS2ahH
         kOdg==
X-Gm-Message-State: AOAM530el6Ec6C9J7WrUkATKa+8jpqVLu+FqFaHWvTqWKcfrF45WDQyQ
        Blu2POHccuBKZd0g7fA+VE09ow==
X-Google-Smtp-Source: ABdhPJxYf/VijbY31dj+k3RJwewlBLxsRQ9P6vjqIemJ+NS+o5NTon5g8PndmznbS0ozJ2xm52lizQ==
X-Received: by 2002:a05:6402:f17:b0:42d:d3f3:244c with SMTP id i23-20020a0564020f1700b0042dd3f3244cmr44806846eda.52.1654774784581;
        Thu, 09 Jun 2022 04:39:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 11/48] ARM: dts: broadcom: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:30 +0200
Message-Id: <20220609113938.380466-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts          |  6 +++---
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts          |  8 ++++----
 .../boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi | 10 +++++-----
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    | 10 +++++-----
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts      |  4 ++--
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts      |  4 ++--
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts         |  2 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts         |  2 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts          |  6 +++---
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts       |  6 +++---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts        |  6 +++---
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts          |  4 ++--
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |  8 ++++----
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts    |  2 +-
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts        |  2 +-
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts        |  2 +-
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts   |  4 ++--
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts          |  4 ++--
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts    | 12 ++++++------
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts         |  4 ++--
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts          |  6 +++---
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts          |  8 ++++----
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts    |  4 ++--
 arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts         |  8 ++++----
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts        |  6 +++---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts      |  6 +++---
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts        |  2 +-
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts        |  2 +-
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts        |  2 +-
 arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts        |  2 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts        |  2 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts     |  2 +-
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts         |  8 ++++----
 arch/arm/boot/dts/bcm47094-phicomm-k3.dts            |  2 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts        |  2 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts         |  2 +-
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts             |  6 +++---
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts           |  2 +-
 arch/arm/boot/dts/bcm911360_entphn.dts               |  4 ++--
 arch/arm/boot/dts/bcm947189acdbmr.dts                |  4 ++--
 arch/arm/boot/dts/bcm953012er.dts                    |  4 ++--
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi        |  2 +-
 arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi      |  2 +-
 43 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
index 8ed403767540..09ee3e46c0cc 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
@@ -70,19 +70,19 @@ usb2 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
index 667b118ba4ee..32619c6045d3 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
@@ -54,25 +54,25 @@ usb3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		brightness {
+		button-brightness {
 			label = "Backlight";
 			linux,code = <KEY_BRIGHTNESS_ZERO>;
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi
index d659e409a17e..a658b9b7bcec 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi
@@ -104,33 +104,33 @@ wireless1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
 
-		aoss {
+		button-aoss {
 			label = "AOSS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Commit mode set by switch? */
-		mode {
+		button-mode {
 			label = "Mode";
 			linux,code = <KEY_SETUP>;
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Switch: AP mode */
-		sw_ap {
+		button-sw-ap {
 			label = "AP";
 			linux,code = <BTN_0>;
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
 
-		eject {
+		button-eject {
 			label = "USB eject";
 			linux,code = <KEY_EJECTCD>;
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index ff31ce45831a..f8f53457dd43 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -100,33 +100,33 @@ wireless1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
 
-		aoss {
+		button-aoss {
 			label = "AOSS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Commit mode set by switch? */
-		mode {
+		button-mode {
 			label = "Mode";
 			linux,code = <KEY_SETUP>;
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Switch: AP mode */
-		sw_ap {
+		button-sw-ap {
 			label = "AP";
 			linux,code = <BTN_0>;
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
 
-		eject {
+		button-eject {
 			label = "USB eject";
 			linux,code = <KEY_EJECTCD>;
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
index 5bac1e15775a..0ed25bf71f0d 100644
--- a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
@@ -29,13 +29,13 @@ nvram@1c080000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
index cd797b4202ad..f1412ba83def 100644
--- a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
@@ -25,13 +25,13 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
index 5b4a481be4f4..14ee410183af 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
@@ -45,7 +45,7 @@ status {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index c81944cd6d0b..600ab087f5e5 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -52,7 +52,7 @@ status {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 43a5d675dd67..fd6d8d2a4456 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -63,19 +63,19 @@ wireless {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 		};
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index 4c60eda296d9..76fc1099d47d 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -59,19 +59,19 @@ wireless {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 		};
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 9ca6d1b2590d..6bcdfb73cb9e 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -94,19 +94,19 @@ wan-red {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 0e273c598732..ca47cc4f2ba1 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -60,13 +60,13 @@ usb3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index d00495a8b6fc..0edc2543e568 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -91,26 +91,26 @@ wireless1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		aoss {
+		button-aoss {
 			label = "AOSS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 9 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Switch device mode? */
-		mode {
+		button-mode {
 			label = "Mode";
 			linux,code = <KEY_SETUP>;
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
 
-		eject {
+		button-eject {
 			label = "USB eject";
 			linux,code = <KEY_EJECTCD>;
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index 8b1a05a0f1a1..1f0998f34afd 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -96,7 +96,7 @@ wireless1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
index 68aaf0af3945..c8c02377543b 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
@@ -45,7 +45,7 @@ status {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
index 9316a36434f7..3b35a7af4b1c 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
@@ -94,7 +94,7 @@ lan1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
index 12e34a0439b4..19a7971b5a00 100644
--- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
+++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
@@ -77,13 +77,13 @@ usb2-port2 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index 7546c8d07bcd..14bb788a693d 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -50,13 +50,13 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index beae9eab9cb8..a8294c1ac11b 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -80,39 +80,39 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power {
+		button-power {
 			label = "Power";
 			linux,code = <KEY_POWER>;
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
 		};
 
-		aoss {
+		button-aoss {
 			label = "AOSS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Commit mode set by switch? */
-		mode {
+		button-mode {
 			label = "Mode";
 			linux,code = <KEY_SETUP>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Switch: AP mode */
-		sw_ap {
+		button-sw-ap {
 			label = "AP";
 			linux,code = <BTN_0>;
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 		};
 
-		eject {
+		button-eject {
 			label = "USB eject";
 			linux,code = <KEY_EJECTCD>;
 			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
index 7879f7d7d9c3..4bbd31916729 100644
--- a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
+++ b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
@@ -32,13 +32,13 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index 56d309dbc6b0..8783963f113b 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -75,19 +75,19 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 		};
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index 89f992af61d1..ac2f4692fc4d 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -102,25 +102,25 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
 		};
 
-		brightness {
+		button-brightness {
 			label = "Backlight";
 			linux,code = <KEY_BRIGHTNESS_ZERO>;
 			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index c2a266a439d0..651113592598 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -80,13 +80,13 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts b/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
index d8503758342b..a5fec56d11c0 100644
--- a/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
+++ b/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
@@ -72,25 +72,25 @@ wps {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
 		};
 
-		reset {
+		button-reset {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
 
-		wifi {
+		button-wifi {
 			label = "Wi-Fi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 		};
 
-		led {
+		button-led {
 			label = "Backlight";
 			linux,code = <KEY_BRIGHTNESS_ZERO>;
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 60bfd52ee677..2c38b642a8b8 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -86,20 +86,20 @@ usb3-white {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Switch: router / extender */
-		extender {
+		button-extender {
 			label = "Extender";
 			linux,code = <BTN_0>;
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 9bef6b9bfa8d..86c7cc0fa70e 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -30,19 +30,19 @@ nvram@1c080000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		rfkill {
+		button-rfkill {
 				label = "WiFi";
 				linux,code = <KEY_RFKILL>;
 				gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
 		};
 
-		reset {
+		button-reset {
 				label = "Reset";
 				linux,code = <KEY_RESTART>;
 				gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
index b51a0ee7e584..9ad15bcae1ca 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
@@ -49,7 +49,7 @@ usb3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts b/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
index 6fa101f0a90d..ee24d3768536 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
@@ -43,7 +43,7 @@ status	{
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
index b959a9504eea..6549d07b9887 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
@@ -49,7 +49,7 @@ usb3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts b/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
index b0d8a688141d..9100ff66ab86 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
@@ -37,7 +37,7 @@ gpio-keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index cbe8c8e4a301..bf053a2fcc7c 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -89,7 +89,7 @@ status	{
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
index 9efcb2424228..78a90dd57a4e 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
@@ -67,7 +67,7 @@ status	{
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index 42097a4c2659..f850dce37b20 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -65,25 +65,25 @@ usb3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		brightness {
+		button-brightness {
 			label = "Backlight";
 			linux,code = <KEY_BRIGHTNESS_ZERO>;
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47094-phicomm-k3.dts b/arch/arm/boot/dts/bcm47094-phicomm-k3.dts
index a2566ad4619c..3bf6e24978ac 100644
--- a/arch/arm/boot/dts/bcm47094-phicomm-k3.dts
+++ b/arch/arm/boot/dts/bcm47094-phicomm-k3.dts
@@ -22,7 +22,7 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 57ca1cfaecd8..e20b6d2eb274 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -39,7 +39,7 @@ system {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 2e1a7e382cb7..9d863570fcf3 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -49,7 +49,7 @@ pcie0_leds {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 07eb3a8287d6..55b92645b0f1 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -59,19 +59,19 @@ pcie0_leds {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		rfkill {
+		button-rfkill {
 			label = "WiFi";
 			linux,code = <KEY_RFKILL>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 9 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
index daca63f25134..64ea6def30a4 100644
--- a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
@@ -50,7 +50,7 @@ keys {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 21 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index a76c74b44bba..363009e747b3 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -47,10 +47,10 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 
-		hook {
+		button-hook {
 			label = "HOOK";
 			linux,code = <KEY_O>;
 			gpios = <&gpio_asiu 48 0>;
diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/bcm947189acdbmr.dts
index b0b8c774a37f..16e70a264faf 100644
--- a/arch/arm/boot/dts/bcm947189acdbmr.dts
+++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
@@ -44,13 +44,13 @@ wps {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
 		};
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 9 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm953012er.dts b/arch/arm/boot/dts/bcm953012er.dts
index dd63a148a16b..4fe3b3653376 100644
--- a/arch/arm/boot/dts/bcm953012er.dts
+++ b/arch/arm/boot/dts/bcm953012er.dts
@@ -47,13 +47,13 @@ memory@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wps {
+		button-wps {
 			label = "WPS";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
 		};
 
-		restart {
+		button-restart {
 			label = "Reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
index 58b7d9fc7574..c54451dde6dd 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -13,7 +13,7 @@ keys {
 		autorepeat;
 		poll-interval = <20>;
 
-		reset {
+		button-reset {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpioa 8 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
index 576cfc52567b..1830844c8404 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
@@ -14,7 +14,7 @@ keys {
 		autorepeat;
 		poll-interval = <20>;
 
-		reset {
+		button-reset {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpioa 6 GPIO_ACTIVE_LOW>;
-- 
2.34.1

