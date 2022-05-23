Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320E5530A28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiEWHzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiEWHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:55:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2180266B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:55:17 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0789F402DE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653287294;
        bh=mhLady9xJOsYFKdyyp5cJp4wqz+mfmHOLOYqLp7Vdvc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Y/GQluuTelR9yUAumOjQcJs/zirOtE+t4bnpBwKc5Djn3z9nFZB/u74CmFb5NETaR
         k3y027yTH8AF7KwzpdNoVpl/X2N6qRl6n5A8s6KYaTEMsS6VfvnvPZBw8DE5WolgHE
         6n71BoqWtYs4klryCZRc/wmy2CPxpwdFeiUIjBdacBs88ARMfpzJznfaFajcD1IH5F
         ujqNarceRDAPjazpEFd1mNhEmWiXvnptfn6R0+hAmpXBTkDWLoM8XFI+cmkg/4FvQG
         /UDV3eV+8XY5BstXF2nMKsDif/s7IPVMUhqys4eBLQDmkHSrECcNW6HL8NXqzlPpJ1
         IXZkiHMD7wgBQ==
Received: by mail-ed1-f72.google.com with SMTP id u1-20020aa7d981000000b0042acd1f2253so9961510eds.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhLady9xJOsYFKdyyp5cJp4wqz+mfmHOLOYqLp7Vdvc=;
        b=1q0hO/PTOjk3Qowv+QndJeG37qn+TCWjyECB/thhnAirbg3t4L0UbHBXb1v2mNPPrD
         Gi7Av09/qOeZbSKEVIevvQ9YEJ6sSfRprH8x9c8UTDZaNWJ6b9qy15DQjRL54Y+6bM4Y
         AGZfhWMlgj/FljwAILdslF5BAb1FT2eb7pkSNzDzdOIuK1Emh26s8nM6Bzny3Xkukks0
         QeSRRFG0qi+ktJFykKQueSEoflAbuwPskyPYQin7Tp7b8wIbnc2d9HJjrusZKU080HZI
         d4OtJdDCiGX3nEdI90MgULW+Hqd0ttvQa5fq2Lj7R18HlughfJywkKQVLamw6NmenyDM
         9Msg==
X-Gm-Message-State: AOAM532mKQI8M6iBLqrqTXB9cV8QHaM/wV9MqtulUiaIAIdw7EUziu3o
        E893aGYvdrB4RFlZWWT1GuK3DOhjAnMjZaP1lHtjn+TmYfFePx6uuwyknGUPqnr8nKnOK8kMRSo
        71JtXgj8JFBfLsPAnkpDHzganZD/0OEPNnwmkce4geQ==
X-Received: by 2002:a17:907:7242:b0:6f5:2904:5354 with SMTP id ds2-20020a170907724200b006f529045354mr18968654ejc.452.1653287289985;
        Sun, 22 May 2022 23:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCe9Yjq1im7YJA39o3/MAHjexYIKNJaEWJo31J3DrHB1x7uDcNtM3+yNSeKZzO3xMwortHbg==
X-Received: by 2002:a17:907:7242:b0:6f5:2904:5354 with SMTP id ds2-20020a170907724200b006f529045354mr18968639ejc.452.1653287289739;
        Sun, 22 May 2022 23:28:09 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090602cb00b006f3ef214e59sm5785652ejk.191.2022.05.22.23.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:28:09 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     aaro.koskinen@iki.fi, tony@atomide.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: omap1: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:28:07 +0200
Message-Id: <20220523062807.10544-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
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
 arch/arm/mach-omap1/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 208c700c2455..f7088beec7ef 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -59,8 +59,8 @@ config MACH_OMAP_INNOVATOR
 	bool "TI Innovator"
 	depends on ARCH_OMAP15XX || ARCH_OMAP16XX
 	help
-          TI OMAP 1510 or 1610 Innovator board support. Say Y here if you
-          have such a board.
+	  TI OMAP 1510 or 1610 Innovator board support. Say Y here if you
+	  have such a board.
 
 config MACH_OMAP_H2
 	bool "TI H2 Support"
@@ -87,7 +87,7 @@ config MACH_OMAP_OSK
 	depends on ARCH_OMAP16XX
 	help
 	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
-          if you have such a board.
+	  if you have such a board.
 
 config OMAP_OSK_MISTRAL
 	bool "Mistral QVGA board Support"
@@ -124,10 +124,10 @@ config MACH_OMAP_PALMZ71
 	bool "Palm Zire71"
 	depends on ARCH_OMAP15XX
 	help
-	 Support for the Palm Zire71 PDA. To boot the kernel,
-	 you'll need a PalmOS compatible bootloader; check out
-	 http://hackndev.com/palm/z71 for more information.
-	 Say Y here if you have such a PDA, say N otherwise.
+	  Support for the Palm Zire71 PDA. To boot the kernel,
+	  you'll need a PalmOS compatible bootloader; check out
+	  http://hackndev.com/palm/z71 for more information.
+	  Say Y here if you have such a PDA, say N otherwise.
 
 config MACH_OMAP_PALMTT
 	bool "Palm Tungsten|T"
@@ -173,10 +173,10 @@ config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP15XX || ARCH_OMAP16XX
 	help
-          Support for generic OMAP-1510, 1610 or 1710 board with
-          no FPGA. Can be used as template for porting Linux to
-          custom OMAP boards. Say Y here if you have a custom
-          board.
+	  Support for generic OMAP-1510, 1610 or 1710 board with
+	  no FPGA. Can be used as template for porting Linux to
+	  custom OMAP boards. Say Y here if you have a custom
+	  board.
 
 endmenu
 
-- 
2.32.0

