Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D01544599
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiFIIYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiFIIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:24:48 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D314C740
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:24:46 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 08A203F1EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654763085;
        bh=asv2YFG4JzXJVjsA4weMFWBvIhm3Q2lDEdHn5tZpyZ8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=F8NOqxRO/vCga2m+i4GFJdUwWFv1qz0j0GCyztdeaXycpYZrZuK7mRGRmeoexoH78
         EkJQ7JZV8/RrTLoPpYO6o8JcHwLGPS4EAGF8RN92shcQrCQk0sEkrxnur0OLuNgO/R
         wsUdbauqkhYpIsnuJ0gyhNFQzvETqlIbciFr3dIcpARsn5KG00Ul4smGBHjJhQER25
         SOLSY0j6YlqGxkwM9i5G00FJtlzS+UpGfYvQ/7AIxkKgMRFC7Oaoc8JV/j3aqpbJ1h
         LY8lDBDCLWI553c028hhV65fg7U6GNn18FkjTOz2j5Y4m7MhELSNAlg2KHTGEVys4L
         u17PijrVnCjpQ==
Received: by mail-ej1-f69.google.com with SMTP id gr1-20020a170906e2c100b006fefea3ec0aso10566411ejb.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asv2YFG4JzXJVjsA4weMFWBvIhm3Q2lDEdHn5tZpyZ8=;
        b=fQhV435gzqwFnQ2SOtppj3ZZirVYpHF9niFMlJCKCatDq2fuetdAnoVFOAM/WF5fNl
         xW2mkFGbNC3e/XiLTQ/u4Vzm1usQNPnrNZtYgq2JQeTZDC49sOZxOBYF0SxtbsotVo2F
         ky0tUQvFbW433AqaN2vOHpbG7GwiG62cklbhVwvIBD1hTnmZFG4jsStcAqqK1nc9VNUn
         JLlrL1o5kebuStDhGR4TVF0VSEhR3pu+hwc6ksjCwgZw8c3I77On+uzvZbG5KeEdp1Sy
         2WxOeUrMHwph/GdisnK9CI+MUS3FTNwvnKq6AoCXx9V4QC4UaMB+YxmwF/R0DC7pKa72
         mswQ==
X-Gm-Message-State: AOAM5333MZLtzbIyc6fWtxBWr5eyzX0peVpludlHJSy9gctItdYuPfJR
        5Jl15YZvyDHef32WAM2qmaHULxUKbbf6qMXqzRfNR7Ae3sFokdrnZT3oBls78eDKC83fmVUZ0Al
        Z4Q/lFGYzeRZloH2De9ZEdkhYXEGohvak06/JaCVxpw==
X-Received: by 2002:a05:6402:3310:b0:42d:e77b:fef0 with SMTP id e16-20020a056402331000b0042de77bfef0mr43331361eda.193.1654763084874;
        Thu, 09 Jun 2022 01:24:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdf/ZiDCo7jz5yiaIvSvUiLLxW+qOu8aQuET2ULpFUAjVrfmXVy+zucpZkygq1yMZeZQuarQ==
X-Received: by 2002:a05:6402:3310:b0:42d:e77b:fef0 with SMTP id e16-20020a056402331000b0042de77bfef0mr43331347eda.193.1654763084688;
        Thu, 09 Jun 2022 01:24:44 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b00711d546f8a8sm4664834ejc.139.2022.06.09.01.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:24:44 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     krzysztof.kozlowski@linaro.org, linux@armlinux.org.uk,
        alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 3/3 v3] ARM: s3c: Kconfig.s3c64xx: Fix indentation
Date:   Thu,  9 Jun 2022 10:21:54 +0200
Message-Id: <20220609082154.115301-4-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220609082154.115301-1-juerg.haefliger@canonical.com>
References: <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org>
 <20220609082154.115301-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
arch/arm/mach-s3c/Kconfig.s3c64xx | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index 2b27bff4d928..bfc222f5bcd9 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -104,7 +104,7 @@ config S3C64XX_SETUP_SDHCI_GPIO
 config S3C64XX_SETUP_SPI
 	bool
 	help
-	 Common setup code for SPI GPIO configurations
+	  Common setup code for SPI GPIO configurations
 
 config S3C64XX_SETUP_USB_PHY
 	bool
@@ -114,7 +114,7 @@ config S3C64XX_SETUP_USB_PHY
 # S36400 Macchine support
 
 config MACH_SMDK6400
-       bool "SMDK6400"
+	bool "SMDK6400"
 	depends on ATAGS
 	select CPU_S3C6400
 	select S3C64XX_SETUP_SDHCI
@@ -205,7 +205,7 @@ config SMDK6410_SD_CH0
 	bool "Use channel 0 only"
 	depends on MACH_SMDK6410
 	help
-          Select CON7 (channel 0) as the MMC/SD slot, as
+	  Select CON7 (channel 0) as the MMC/SD slot, as
 	  at least some SMDK6410 boards come with the
 	  resistors fitted so that the card detects for
 	  channels 0 and 1 are the same.
@@ -214,7 +214,7 @@ config SMDK6410_SD_CH1
 	bool "Use channel 1 only"
 	depends on MACH_SMDK6410
 	help
-          Select CON6 (channel 1) as the MMC/SD slot, as
+	  Select CON6 (channel 1) as the MMC/SD slot, as
 	  at least some SMDK6410 boards come with the
 	  resistors fitted so that the card detects for
 	  channels 0 and 1 are the same.
@@ -260,7 +260,7 @@ config MACH_NCP
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
 	help
-          Machine support for the Samsung NCP
+	  Machine support for the Samsung NCP
 
 config MACH_HMT
 	bool "Airgoo HMT"
@@ -292,21 +292,21 @@ config MACH_SMARTQ
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	help
-	    Shared machine support for SmartQ 5/7
+	  Shared machine support for SmartQ 5/7
 
 config MACH_SMARTQ5
 	bool "SmartQ 5"
 	depends on ATAGS
 	select MACH_SMARTQ
 	help
-	    Machine support for the SmartQ 5
+	  Machine support for the SmartQ 5
 
 config MACH_SMARTQ7
 	bool "SmartQ 7"
 	depends on ATAGS
 	select MACH_SMARTQ
 	help
-	    Machine support for the SmartQ 7
+	  Machine support for the SmartQ 7
 
 config MACH_WLF_CRAGG_6410
 	bool "Wolfson Cragganmore 6410"
-- 
2.32.0

