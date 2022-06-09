Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36512544A84
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbiFILkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiFILkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D71DC85D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g25so401924ejh.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLOgEcTi8rykVs8pllx/IciieSLBDIse4+2rVzfArXY=;
        b=evrfUU8qIoxac6Ugbi3uM5mJKY60p4YJBYqvn0mjWeqmoit6epSOjwDebGiemocatb
         sIHlNETvyjeZwJVhxFN4KmkKkoWdsi2yA7+R1G9qiP5tFlbLlt80KWLAqFRXf1qbJNkx
         4JLKz1NZEbpm/hH5DDI5yf35MwKKmQs3LK0AXdlEViBaMRKrfMu9ncCpKP0dlw4RA6CD
         8Tsix8oGxtOxRSAF0Jj3INBW14nTeZDjhtEon8nqIXVTUStXlVLhaFBNeMNYYr+5hScl
         hga8kyT7M+RF0mbro0jYogrRfScRgXGmF7LnovgsoAOrsMGnnZ/eBD7Ag0JwVEliCsXX
         8CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLOgEcTi8rykVs8pllx/IciieSLBDIse4+2rVzfArXY=;
        b=3CF1SK4bnrrDFCWqGuSdVDWZCYI4PulnxXOGlM/cWWINjtB7wM8cEF/WQ+99Al3yog
         UlEmFFLlhLQG1VIrgyEQjCP1KGtauqeiwuLcykd43jO/yuKHz9uH8YkNKvU/+HxSHblG
         dGqrfmF0b0TnwBROWG6pVm45qLETg3hzUF32d+SdS0q3a21utZ3eMj4ZAgw4x5ShvM5J
         GpxUnfGMNXPzw2oxMJLzKhWHYhXX5RPqb4rtBv1zA1Sg1jAraA7CeDaEYc4bzM/XpBwR
         LECl6ZVmjcltZMfld3qGn7octay4/Qxfa/KJ7BmlnkcZfyYFMw9ZFjcX1OS8EorWfcaJ
         j6rQ==
X-Gm-Message-State: AOAM531EAxONEmyf+fCedXkx6HcuYUF7ltW0HmbWOUSnyE6mjllPVMKU
        6+E0QdlJZuNIP6VHLbCR2mRsqQ==
X-Google-Smtp-Source: ABdhPJz0pGnYtX431VAMWvN9hF8NzcqmGoQxAtLFMtLCB50gITaiEBjsFH+kmA+yrIxtVspBhuvbcA==
X-Received: by 2002:a17:907:7fa5:b0:711:c8e2:2f4c with SMTP id qk37-20020a1709077fa500b00711c8e22f4cmr20871316ejc.49.1654774786132;
        Thu, 09 Jun 2022 04:39:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906528a00b0070a80f03a44sm9460415ejm.119.2022.06.09.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:45 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 12/48] ARM: dts: broadcom: correct gpio-keys properties
Date:   Thu,  9 Jun 2022 13:39:31 +0200
Message-Id: <20220609113938.380466-3-krzysztof.kozlowski@linaro.org>
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

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts       | 2 --
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts | 2 --
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts      | 2 --
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts       | 2 --
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts       | 2 --
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts | 2 --
 arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts     | 2 --
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts        | 2 --
 8 files changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index 14bb788a693d..f52a75c4ca09 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -47,8 +47,6 @@ wan {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-wps {
 			label = "WPS";
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index a8294c1ac11b..5ff6c588e16e 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -77,8 +77,6 @@ wireless-white {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-power {
 			label = "Power";
diff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
index 4bbd31916729..99253fd7adb3 100644
--- a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
+++ b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
@@ -29,8 +29,6 @@ nvram@1c080000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-wps {
 			label = "WPS";
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index 8783963f113b..de961fbb6200 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -72,8 +72,6 @@ usb2 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-wps {
 			label = "WPS";
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index ac2f4692fc4d..087f7f60de18 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -99,8 +99,6 @@ usb2 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-rfkill {
 			label = "WiFi";
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index 651113592598..11d1068160da 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -77,8 +77,6 @@ power {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-wps {
 			label = "WPS";
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts b/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
index 9100ff66ab86..654fcce9fded 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
@@ -34,8 +34,6 @@ status	{
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-restart {
 			label = "Reset";
diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
index 64ea6def30a4..e678bc03d816 100644
--- a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
@@ -47,8 +47,6 @@ sysled2 {
 
 	keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		button-restart {
 			label = "Reset";
-- 
2.34.1

