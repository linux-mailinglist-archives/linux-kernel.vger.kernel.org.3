Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D4516201
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 07:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiEAFY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 01:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiEAFYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 01:24:25 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831D13D05;
        Sat, 30 Apr 2022 22:20:59 -0700 (PDT)
From:   "Marty E. Plummer" <hanetzer@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651381846;
        bh=CJkQRIMYjHGkPOoD08ZRSBh5tWFuR3jmLS/jherWFo8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=o67qEAg5gAkd6aO3l0M/uuD6stU6h4qJ4oopGC415zc5pO2zQTW329j2QcqnSRTOh
         7zYDEcn08hRVwpsrvv/BCHLybFI0XmctjQcw5z68oRt3l+LCnQYfoIhiVv8OPYuyYv
         uu+JuDHkVz6RHZbwLfsdN1o2g/zfOHJhw9ivo2TrIr5wbT3bZrQwx3NCvkLcyrLzZh
         YIV5sOWL3oGj9lFhE7MDb4DG5wVYhKuPUbb3STmPok/1UT+dPKSNvkcvWgMzwRigbj
         86SaqawgnxBpX+SMQU/Ntv1GkZFYWA6zZXpBGnWnar6AfLxTcIzdgQjDggVBTCgeLS
         0nkd+nCCRZd1A==
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     "Marty E. Plummer" <hanetzer@startmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm: hisi: enable Hi3521a soc
Date:   Sun,  1 May 2022 00:10:20 -0500
Message-Id: <20220501051020.2432338-3-hanetzer@startmail.com>
In-Reply-To: <20220501051020.2432338-1-hanetzer@startmail.com>
References: <20220501051020.2432338-1-hanetzer@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Hisilicon Hi3521A/Hi3520DCV300 SoC. This SoC series includes
hardware mutlimedia codec cores, commonly used in consumer cctv/dvr
security systems and ipcameras. The arm core is a Cortex A7.

Add hi3521a.dtsi and hi3521a-rs-dm290e.dts for RaySharp CCTV systems,
marketed under the name Samsung SDR-B74301N.

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
 arch/arm/boot/dts/Makefile | 2 ++
 arch/arm/mach-hisi/Kconfig | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..535cef3b14ab 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -242,6 +242,8 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-ssi1328.dtb \
 	gemini-wbd111.dtb \
 	gemini-wbd222.dtb
+dtb-$(CONFIG_ARCH_HI3521A) += \
+	hi3521a-rs-dm290e.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
 	hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += \
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 2e980f834a6a..165ffb972157 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -13,6 +13,15 @@ if ARCH_HISI
 
 menu "Hisilicon platform type"
 
+config ARCH_HI3521A
+	bool "Hisilicon Hi3521a/Hi3520dcv300 family"
+	depends on ARCH_MULTI_V7
+	select CACHE_L2X0
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  Hisilicon Hi3521a/Hi3520dcv300 family
+
 config ARCH_HI3xxx
 	bool "Hisilicon Hi36xx family"
 	depends on ARCH_MULTI_V7
-- 
2.35.1

