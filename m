Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3543A533CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbiEYMkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243290AbiEYMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:40:28 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB0487A26
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:25 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 387DB3F803
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482422;
        bh=c10iLeMiN3rtcJh7R+kBjwZ/ioZSoIrALQhmp87Zhi4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZyeDTwEnlkwhXdFL4xbAsKsJK9r3/czeryZoTR+UTxBTDPr5/2Nq8lH+bQfdbz8d7
         pm1+5/8b1iKr3Sq26ygN3PFhi68N1/H6VpPozB0Ey4rmnhTg0xHP+vj1ZyvFaIuRWe
         b3fMw/hB2U93iv48Cal14a1+PZMcMIG1oUh37RrFubtt0wmdrQYKk8JhcC0LOceqQM
         46KTGyG0UnCVDREoX1H/rwTioIs06JpApnKlMHovMv6nbBe8G3qrmlknob86rhqyU2
         zzI1dq+ZSBKc3MqvEHtUidsVh48kdgY6FIulOlyVFsZG3qP82G77WW603rtXK3vUhr
         S6IBZ6hci2dSA==
Received: by mail-ed1-f70.google.com with SMTP id q12-20020a056402040c00b0042a84f9939dso14837753edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c10iLeMiN3rtcJh7R+kBjwZ/ioZSoIrALQhmp87Zhi4=;
        b=ErpMj8GNr28G5xmFXo8+Dky6YyeZ+vkLQ+W3FpeIyYooAUbQh2DaPA2ZBF0ZX98zyI
         FzShyu2K1axnZKxGF0Wu5bkQTEOT+biXJoNfeAzWxJ5LTBuaL5UQWASDdjRCh3lfiE2D
         g2cqCMuay6nNMIY0bXqxFIe/v1+xYRN6w1TWEm4N1RwLn9bqkWBOmsz9/524kgGwQ0r0
         bEHK97U+hHBHjEDCD1AcwMm7pEwaFOOlCDfj6S2ah0IgmAKfzl7VCzGyBGiShBjvZmfV
         aOpqZcH45B0Ti+L6IhXFVVesXd8KRUvk8HST0QEqH3YLviNj20CVvoyNMlBcWx0yOeOu
         F3JA==
X-Gm-Message-State: AOAM533ERp+UNImooW0GRdqCpphWmFi1zWD7e3UR/bvLLLAPVPoYh+Mw
        pNbKWxcpKLeSDnzKaOm1+3a9mZ1j3poHszCn6A0waajb0oC8SWzX/rZAet6QyFm8zrzslYumnZI
        eOtiwUokSPP/0YGscGgqqcks2bey5RwHOAPuEJK3V0Q==
X-Received: by 2002:a05:6402:34c2:b0:42b:66d3:7b07 with SMTP id w2-20020a05640234c200b0042b66d37b07mr16289204edc.275.1653482417422;
        Wed, 25 May 2022 05:40:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Zbt6jA3u1X6KTZoLtdjzWjbqAcTxHk4GUPkqPs5gc24VOD834mWi0LGsNzIzB5A6SMXDww==
X-Received: by 2002:a05:6402:34c2:b0:42b:66d3:7b07 with SMTP id w2-20020a05640234c200b0042b66d37b07mr16289182edc.275.1653482417204;
        Wed, 25 May 2022 05:40:17 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:16 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 3/4] sh/boards: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:40:06 +0200
Message-Id: <20220525124007.45328-4-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525124007.45328-1-juerg.haefliger@canonical.com>
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
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

While at it, remove stray tabs/spaces from a seemingly empty line.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/sh/boards/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 83bcb6d2daca..fbdb3fbfb976 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -36,7 +36,7 @@ config SH_SOLUTION_ENGINE
 	select CPU_HAS_IPR_IRQ
 	depends on CPU_SUBTYPE_SH7705 || CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7710 || \
 	  CPU_SUBTYPE_SH7712 || CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
-	  CPU_SUBTYPE_SH7750R 
+	  CPU_SUBTYPE_SH7750R
 	help
 	  Select SolutionEngine if configuring for a Hitachi SH7705, SH7709,
 	  SH7710, SH7712, SH7750, SH7750S or SH7750R evaluation board.
@@ -56,7 +56,7 @@ config SH_7619_SOLUTION_ENGINE
 	help
 	  Select 7619 SolutionEngine if configuring for a Hitachi SH7619
 	  evaluation board.
-	
+
 config SH_7721_SOLUTION_ENGINE
 	bool "SolutionEngine7721"
 	select SOLUTION_ENGINE
@@ -94,7 +94,7 @@ config SH_7751_SOLUTION_ENGINE
 	help
 	  Select 7751 SolutionEngine if configuring for a Hitachi SH7751
 	  evaluation board.
-	  
+
 config SH_7780_SOLUTION_ENGINE
 	bool "SolutionEngine7780"
 	select SOLUTION_ENGINE
@@ -167,8 +167,8 @@ config SH_RSK
 	  CPU_SUBTYPE_SH7264 || CPU_SUBTYPE_SH7269
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
-	 Select this option if configuring for any of the RSK+ MCU
-	 evaluation platforms.
+	  Select this option if configuring for any of the RSK+ MCU
+	  evaluation platforms.
 
 config SH_SDK7780
 	bool "SDK7780R3"
@@ -236,7 +236,7 @@ config SH_MIGOR
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
-          by Renesas System Solutions Asia Pte. Ltd.
+	  by Renesas System Solutions Asia Pte. Ltd.
 
 config SH_AP325RXA
 	bool "AP-325RXA"
-- 
2.32.0

