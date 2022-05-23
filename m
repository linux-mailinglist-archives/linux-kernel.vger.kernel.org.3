Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB5530B70
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiEWIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiEWIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:04:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C61F11463
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:04:19 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07BD33F1A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653293058;
        bh=i10Qv2DK8LgAfvLl/28UAS+bU8kNjJDBm8S3mqaIAkM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kHwZOElbvNoXMadOAOnFhimbRT4YfXXw3yOlLTLTu5A4rofJEIDIZDS5gUYqiWWv4
         40cD7IICUIBVt+RLIU78tZkjNxfTRsDdOzrhfGMjxoqeG1XYatugNQRGjZcZv7jyHh
         oIkEGQ3WQIaWhovK9oRn9ESkRgfbFWOVW2GQ7B27lnFKchEdAjCNGNLEc9Tow51WUM
         0Jy8WPqq5Bx9IVF/UfTwoZ/Ob5evL3jWilh4J/g5TeHX8lwXBTewCmGkhEoCkvJn4b
         heHAa4avWgDSv9VwfaomEy92ci954nNmYVN+yILNnjgzRRMIAYIpNDLHn3O1J+/Ei3
         0TLOOFef8nxgw==
Received: by mail-ed1-f69.google.com with SMTP id g10-20020a056402180a00b0042ab515d6c5so10053830edy.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i10Qv2DK8LgAfvLl/28UAS+bU8kNjJDBm8S3mqaIAkM=;
        b=qI3RRGR6rnsI42CMmOMHvCHg5sNpE8schEre7rD9YEyN4LLAP9p2Tal96NDHnFJqOF
         H4UCZbCiiJW01ygG/vrC1r1N68M/0qaNsNfNQ3jxa/MmIPM6NfdeXwqDLxV7FASNl6vy
         +LbIFltIGsgk/XRsch8FisOsjM3T5t/XjFpdpZQlaJXoniEn+/YEQRJ4bQhb2bO4TclP
         i1m2WHrX2Ccs+fX4ngk/IiT3d8KMO3G0kwmQP9SydFw4XzaKM5T7OZOKQa4IUxSqSkpU
         Y0kNY1Tng9m7alnvRLcxGYriFUFLpmB1b8scurEUPWF5DNNzW+I76U+modHCnYYxO7ig
         mKtA==
X-Gm-Message-State: AOAM530CXrEfoP/5Q6EyDLl/vs80x0r1s60vjtCBe+/CQdtpD/p4SPcP
        Fj4++Pfd8e1psa0ainFpv444OPWKCCRS976XmaAMwvlUQJkttLLPO+w4IN0Mkp4s+xYFdINRWu6
        /p/V6ZdmXQf6auLgNDgK5k0aD9LIxFVcFUrz7yJ2lpQ==
X-Received: by 2002:a17:907:6d93:b0:6fe:cf1c:cdab with SMTP id sb19-20020a1709076d9300b006fecf1ccdabmr4919396ejc.609.1653293057757;
        Mon, 23 May 2022 01:04:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAtsAMmmZi6MDmNtECtNY2OYdpHyInL5O1rGQFD4XR9wk0qCNdrz23QVYcMm/EuyDNGL0OYQ==
X-Received: by 2002:a17:907:6d93:b0:6fe:cf1c:cdab with SMTP id sb19-20020a1709076d9300b006fecf1ccdabmr4919379ejc.609.1653293057473;
        Mon, 23 May 2022 01:04:17 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id mm24-20020a170906cc5800b006fe9ba21333sm4431045ejb.113.2022.05.23.01.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:04:17 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/3 v2] ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace some tabs
Date:   Mon, 23 May 2022 10:04:09 +0200
Message-Id: <20220523080409.14949-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <000c01d86e721c025105406f30samsung.com>
References: <000c01d86e721c025105406f30samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, replace tabs before comments with whitespaces (which seems to
be more common), add a missing trailing endif comment and squeeze multiple
empty lines.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
v2:
  Mention additional changes in the commit message.
---
 arch/arm/mach-s3c/Kconfig.s3c24xx | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig.s3c24xx b/arch/arm/mach-s3c/Kconfig.s3c24xx
index 000e3e234f71..a7625e772905 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c24xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c24xx
@@ -17,8 +17,6 @@ config PLAT_S3C24XX
 	help
 	  Base platform code for any Samsung S3C24XX device
 
-
-
 menu "Samsung S3C24XX SoCs Support"
 
 comment "S3C24XX SoCs"
@@ -268,7 +266,7 @@ config MACH_VR1000
 	help
 	  Say Y here if you are using the Thorcom VR1000 board.
 
-endif	# CPU_S3C2410
+endif # CPU_S3C2410
 
 config S3C2412_PM_SLEEP
 	bool
@@ -342,7 +340,7 @@ config MACH_VSTMS
 	help
 	  Say Y here if you are using an VSTMS board
 
-endif	# CPU_S3C2412
+endif # CPU_S3C2412
 
 if CPU_S3C2416
 
@@ -390,7 +388,7 @@ config MACH_S3C2416_DT
 	  Note: This is under development and not all peripherals can be supported
 	  with this machine file.
 
-endif	# CPU_S3C2416
+endif # CPU_S3C2416
 
 if CPU_S3C2440 || CPU_S3C2442
 
@@ -419,7 +417,7 @@ config S3C2440_PLL_16934400
 	default y if S3C24XX_PLL
 	help
 	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
-endif
+endif # CPU_S3C2440 || CPU_S3C2442
 
 if CPU_S3C2440
 
@@ -515,7 +513,7 @@ config SMDK2440_CPU2440
 	default y if ARCH_S3C2440
 	select S3C2440_XTAL_16934400
 
-endif	# CPU_S3C2440
+endif # CPU_S3C2440
 
 if CPU_S3C2442
 
@@ -535,7 +533,7 @@ config MACH_NEO1973_GTA02
 	select S3C24XX_PWM
 	select S3C_DEV_USB_HOST
 	help
-	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
+	  Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
 
 config MACH_RX1950
 	bool "HP iPAQ rx1950"
@@ -547,9 +545,9 @@ config MACH_RX1950
 	select S3C24XX_PWM
 	select S3C_DEV_NAND
 	help
-	   Say Y here if you're using HP iPAQ rx1950
+	  Say Y here if you're using HP iPAQ rx1950
 
-endif	# CPU_S3C2442
+endif # CPU_S3C2442
 
 if CPU_S3C2443 || CPU_S3C2416
 
@@ -558,7 +556,7 @@ config S3C2443_SETUP_SPI
 	help
 	  Common setup code for SPI GPIO configurations
 
-endif	# CPU_S3C2443 || CPU_S3C2416
+endif # CPU_S3C2443 || CPU_S3C2416
 
 if CPU_S3C2443
 
@@ -571,13 +569,13 @@ config MACH_SMDK2443
 	help
 	  Say Y here if you are using an SMDK2443
 
-endif	# CPU_S3C2443
+endif # CPU_S3C2443
 
 config PM_H1940
 	bool
 	help
 	  Internal node for H1940 and related PM
 
-endmenu	# Samsung S3C24XX SoCs Support
+endmenu # "Samsung S3C24XX SoCs Support"
 
-endif	# ARCH_S3C24XX
+endif # ARCH_S3C24XX
-- 
2.32.0

