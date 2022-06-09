Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA45445A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbiFIIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiFIIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:24:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4164D111BA0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:24:34 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C9B83F1EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654763072;
        bh=SFJ97el+kYEC87Qtf60Q+pyhpNssxYYRxUciLiN5a3M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Zjw/vPxXdpQjfu/7U1ZvBLDR7ZTIYj2plvu1r0N+DfrzuUHmhwSwQOmJlyFAbOHLp
         nXJCY9lgqKQ9chbbnz0CvmCdprjsQjzhZnuh24LQ23jdLWtuNi7DaMxgq0n7A031HX
         YQ1s7Jy0sm1zDW51GZx/O0Q8P4y+g76B0nsQGHQ/VW/Exp62hMgntJBviiwd88KyAV
         ddfSaaa4ZdjWlcTkgPs4dM2ReTvLdQk7uVhZSfp4UzVGBMq1ft3RnhfblrcCp1uATB
         ZgRYJYLlohGZ9+wgAwLAMtdYqCug6htQyDg5VARyQNMF6Y611jKjCZhUXjfuXrmnWq
         1vTVbV5uVNekA==
Received: by mail-ej1-f72.google.com with SMTP id t15-20020a1709066bcf00b0070dedeacb2cso7701628ejs.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFJ97el+kYEC87Qtf60Q+pyhpNssxYYRxUciLiN5a3M=;
        b=avhzshKK/t2siOjM098ZrIutFz+Bfrdjz/enyMQphpLuYA7xxZCOp15ZsrhIljIrse
         4Se+BufV43mgtW4mUegLLZoCAXflZspx+aAG1eS2pMuyYlvU4VBiUBkYvLjJEDIK77uB
         2RvlFPT0Jw/H45VcAwDkavwSz3s6GXsCMO/GN0raiot4QuhlhZLe4xdA0diTtSySTW/b
         4fxHPGmwcaAmAVo0L3m1m+GTGwCO+tflb905e5TxD5xyOgH7u/ep0m+4evE+JBg1z5Y/
         l/BNG+kq3ciDb06xZDcBV02ytHRqFoZjrZp0Zp2WY+eXcttV9RvUQpjXQ4gS3vjaXkTQ
         ac0A==
X-Gm-Message-State: AOAM531h2Y/iO95WV/Rz/bUXBIuZzBrqc+zjgHzAURPk6zxE/09FcOxc
        IgsgJHsPAOw+ezsDOk/AnK4rUNWDdCjQ8o0Zr/TDsQU68bVcHoUXquLuAi46NIQacYe11bEiAP/
        Xc+yVmjYPRdQ8jHYxFXsj9l6prGTNcJrwsOaNwiaNpw==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr34017561ejc.568.1654763072459;
        Thu, 09 Jun 2022 01:24:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/io4UIarrO6pbgqaHyxPgZ4V1VbyhRGpi8ULkQkP44WTBqh4iY5Er0cx64gIopQmMFamZVg==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr34017543ejc.568.1654763072210;
        Thu, 09 Jun 2022 01:24:32 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b00711d546f8a8sm4664834ejc.139.2022.06.09.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:24:31 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     krzysztof.kozlowski@linaro.org, linux@armlinux.org.uk,
        alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/3 v3] ARM: s3c: Kconfig: Fix indentation
Date:   Thu,  9 Jun 2022 10:21:52 +0200
Message-Id: <20220609082154.115301-2-juerg.haefliger@canonical.com>
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
 arch/arm/mach-s3c/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
index 54548c051402..a64143574546 100644
--- a/arch/arm/mach-s3c/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -43,12 +43,12 @@ config SAMSUNG_ATAGS
 	def_bool n
 	depends on ATAGS
 	help
-	   This option enables ATAGS based boot support code for
-	   Samsung platforms, including static platform devices, legacy
-	   clock, timer and interrupt initialization, etc.
+	  This option enables ATAGS based boot support code for
+	  Samsung platforms, including static platform devices, legacy
+	  clock, timer and interrupt initialization, etc.
 
-	   Platforms that support only DT based boot need not to select
-	   this option.
+	  Platforms that support only DT based boot need not to select
+	  this option.
 
 if SAMSUNG_ATAGS
 
@@ -102,7 +102,7 @@ config S3C_DEV_HSMMC3
 config S3C_DEV_HWMON
 	bool
 	help
-	    Compile in platform device definitions for HWMON
+	  Compile in platform device definitions for HWMON
 
 config S3C_DEV_I2C1
 	bool
@@ -194,7 +194,7 @@ config S3C64XX_DEV_SPI0
 config SAMSUNG_DEV_TS
 	bool
 	help
-	    Common in platform device definitions for touchscreen device
+	  Common in platform device definitions for touchscreen device
 
 config SAMSUNG_DEV_KEYPAD
 	bool
-- 
2.32.0

