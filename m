Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53D5530A38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiEWHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiEWHcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:32:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F128728
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:29:50 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 21A7B3F218
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653288180;
        bh=vwrCBboBSUi71sTM6C2LN/XO07fUICSkTIXBE5um3Qk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gznVuK6wD+6u1AOsPfNtqkqoRzY38km/Wq5LVYqIUCkGSOFyzQ7mrE1VS/2ob1TGn
         GIr1ENTHT8yEoG0h0BdvH2PWaFqCmX6XyoAPGhLKJCkoDEonQLgaJoYqZGXDTJ10Xq
         JkKlXU3VOmANHr1TcTuBbDyhKYhqKGumCqQznqE+ODbLTr9IPaEiD5DuXQUNOKgnY+
         RoeZ0t7IPpPl4HmITKnSxIqLuk7VJ9v/i7Z4EUq3sO/QFfTgZttgNYAYEvQ6BwVU0A
         /3pNRaOUfDyT4moLLBshWhnJtTdNSN7avRJm6edqymOxUF5iwRnMu8ykCdlhmPUE8q
         DYf9zmF/pTYEQ==
Received: by mail-ej1-f71.google.com with SMTP id oz9-20020a1709077d8900b006f3d9488090so5462665ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwrCBboBSUi71sTM6C2LN/XO07fUICSkTIXBE5um3Qk=;
        b=j9ogFny3ArTmnXyztWkVJbP/LyqjimtqZYij0MxFCGQLLoJYvrQQ/0L8cS5Eaz0vug
         IVA+uYUgEwgshCcKLCBODtONfYWsRiGs/TILAdmoTNM7BSrLKzvvbqL9OYoaGgJaixts
         GSAQAIxX3DO5NNu6M97Tg053Th2J/JkcS82e8/fWTh5Pv10kVayNopSd61eCNoyZTf2s
         01XBWBZHuk1laVPFHooPcawFsTtWgDFxXKvap7g++uHtiT2T0rO9kREVTR7/CiE9DWR5
         Nnz1+VAqS3OLCxV9uLV7JwV+DSnyrZRmG5nxJYLNnckF+5oBi+y0siL8KwEItIgDShxo
         ZmOw==
X-Gm-Message-State: AOAM5307gxczt/Hd1Lcjnjnr97eSCiyREAhNuMgDEa2PJiOm27YteEc4
        wVlhKdW9CdrW+FFQ4fqjPbDzZK05+SL48j8SZWZ/hPtqcf6kJGaDGvA5u2mDlK3jv7I2X5weIzg
        QiGM1FDHNjJ+tgccHb7xrJO6ZusKog0XKKI2tgeTzug==
X-Received: by 2002:a05:6402:348c:b0:42a:e4e5:c63a with SMTP id v12-20020a056402348c00b0042ae4e5c63amr22121916edc.419.1653288179909;
        Sun, 22 May 2022 23:42:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysxm5gNOCFjrnP3RneZZyc/ngyLMW6c9PUSzZD7D0FANITgMZnEr+yJGihPxqDk9DL1co0uA==
X-Received: by 2002:a05:6402:348c:b0:42a:e4e5:c63a with SMTP id v12-20020a056402348c00b0042ae4e5c63amr22121904edc.419.1653288179758;
        Sun, 22 May 2022 23:42:59 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402074300b0042617ba63a5sm7792416edy.47.2022.05.22.23.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:42:59 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 3/3] ARM: s3c: Kconfig.s3c64xx: Fix indentation
Date:   Mon, 23 May 2022 08:42:52 +0200
Message-Id: <20220523064252.11938-4-juergh@canonical.com>
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

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-s3c/Kconfig.s3c64xx | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index af01675d8769..bbaa8ff3367b 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -99,7 +99,7 @@ config S3C64XX_SETUP_SDHCI_GPIO
 config S3C64XX_SETUP_SPI
 	bool
 	help
-	 Common setup code for SPI GPIO configurations
+	  Common setup code for SPI GPIO configurations
 
 config S3C64XX_SETUP_USB_PHY
 	bool
@@ -109,7 +109,7 @@ config S3C64XX_SETUP_USB_PHY
 # S36400 Macchine support
 
 config MACH_SMDK6400
-       bool "SMDK6400"
+	bool "SMDK6400"
 	depends on ATAGS
 	select CPU_S3C6400
 	select S3C64XX_SETUP_SDHCI
@@ -200,7 +200,7 @@ config SMDK6410_SD_CH0
 	bool "Use channel 0 only"
 	depends on MACH_SMDK6410
 	help
-          Select CON7 (channel 0) as the MMC/SD slot, as
+	  Select CON7 (channel 0) as the MMC/SD slot, as
 	  at least some SMDK6410 boards come with the
 	  resistors fitted so that the card detects for
 	  channels 0 and 1 are the same.
@@ -209,7 +209,7 @@ config SMDK6410_SD_CH1
 	bool "Use channel 1 only"
 	depends on MACH_SMDK6410
 	help
-          Select CON6 (channel 1) as the MMC/SD slot, as
+	  Select CON6 (channel 1) as the MMC/SD slot, as
 	  at least some SMDK6410 boards come with the
 	  resistors fitted so that the card detects for
 	  channels 0 and 1 are the same.
@@ -255,7 +255,7 @@ config MACH_NCP
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
 	help
-          Machine support for the Samsung NCP
+	  Machine support for the Samsung NCP
 
 config MACH_HMT
 	bool "Airgoo HMT"
@@ -287,21 +287,21 @@ config MACH_SMARTQ
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

