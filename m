Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A13530A37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiEWHkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiEWHkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:40:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8401D329
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:40:17 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64B6A402E2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653288179;
        bh=0Fn1JXeiAOQvsSv4ME7qjx3lVZQDLG08r06uAlMp+Ak=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VwotHgaE7w/Amt4r89/nHIdkiB1CtGb94DcG+fWcPoyQgYpOVZc9CXuoMLCA7cdZD
         eq6RctMSBc6YQUzt3nvLa3gK4JGVmZ3VVghMHUzbbJ3gB36ABdpFVwSWJxbUYdU+PA
         3u5fErE+tOYCCzSBcKri1zzoVuAZ7xu0atpIvKvAhNzvBi04vdGACWKGQ+qUucslfF
         649nvTUS1SxKLxTZa3AtZzXQnX9RDpWlCXceMMYi/Y4xUFjxpx7n7zlFuAUVC3Y0eh
         +APF3v97Mzt5OpY0i/vbtlUPVd8h70n4w2YEAR5X6MMLX5smoguirVv3cXkFP319dm
         gG5DsvJYACV+g==
Received: by mail-ed1-f69.google.com with SMTP id w23-20020aa7da57000000b0042acd76347bso9981323eds.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Fn1JXeiAOQvsSv4ME7qjx3lVZQDLG08r06uAlMp+Ak=;
        b=kWzbohCtzFfgbyCjoic/hLsmWafvDZmeMpj5IEG+RvQadrOAVMVu2wmp0+K8TJIMy0
         zNBg+bByrWKB9IhVKffBS04uB8Pz0r1+Uf0jpRtH6d4Yg9abNqhjezwSvgrykhAXVnA/
         nvbt0iKOGeYsCxITb11yjd2qR+SkuEYwf2B7IAZXbvyLaZgjjqmPj6kpsKHEVfoGA8E+
         wZ5xjTkZZBoleJvl4xC5kj3OSVWwwT2m2FQRciPOTEgeqRzCryVnzNdT7FyUR1v7vyJy
         8V/xi5MWLcwXgYQbT/vt6m8ACWVaflF/Ju+OOjBZI520AnVtacmL0HZT1jNtiuOp17m/
         NKPA==
X-Gm-Message-State: AOAM533JMYWbjfMpp/80vatY2RO0rtmasNWzD94+89NQ0hQfmcBmeJ+D
        rb0kYdyB3sshR7E/hex7+zRUUpQZQ0imFLkHesKnhXSMQvpkWwpCfVCa38ARm3I4fqcCQFJX8bX
        BeKiZzLXe/kgweGnBzgoq5m32cjZb6g53hfhkSpeJUA==
X-Received: by 2002:a05:6402:174c:b0:42a:b4df:3aa7 with SMTP id v12-20020a056402174c00b0042ab4df3aa7mr22241465edx.263.1653288178997;
        Sun, 22 May 2022 23:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXGU3a9rNtXp1i8dxNZ2qWALsHyrukZ0RD+lIEHrPJw1VeHxe4hbjKgVr8+47QB60PgYV82Q==
X-Received: by 2002:a05:6402:174c:b0:42a:b4df:3aa7 with SMTP id v12-20020a056402174c00b0042ab4df3aa7mr22241456edx.263.1653288178851;
        Sun, 22 May 2022 23:42:58 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402074300b0042617ba63a5sm7792416edy.47.2022.05.22.23.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:42:58 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/3] ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace some tabs
Date:   Mon, 23 May 2022 08:42:51 +0200
Message-Id: <20220523064252.11938-3-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220523064252.11938-1-juergh@canonical.com>
References: <20220523064252.11938-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, replace tabs before comments with whitespaces and squeeze
multiple empty lines.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
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

