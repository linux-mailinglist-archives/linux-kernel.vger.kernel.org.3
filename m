Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308C9530B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiEWIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiEWIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:05:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390A12A8E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:05:18 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0F3A83F1EC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653285944;
        bh=Gc6m3XcjXFZK4IY7snllrwp4xXxt/PdhQGyQJtEizR4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dvcNdE11ez702Nsv4FB75AjyX1x5/RXtYrz1zQHN+PCyuaqm6Cco7a5B+4fCjTuvS
         XIaTT5wiIP1RJRR2qLZ5q4c6HImEUy2jWIX+AMTUXo7Fa04aFv6wdmduN8ZP3MACWP
         HHeRcR+uvBZcOjHujMGsEvgBnTGQHl66ZbLXolQoPWaLe4R9VZPz3RKr6ZBBCaI8d7
         t++fuzWuvi8GMpRUlbwFnuJmN9nIcdEdukYaEe4ZZ7ci7/QQVbhWkK5Bitij5C2BaE
         floF359WPem5lXAIWXhIcLwJFJKhZAOiZCC2vNBgz2l51GEhEiwNcE4Hcz8gtaLpI9
         dKZtxvGyLGUWw==
Received: by mail-ed1-f70.google.com with SMTP id n12-20020aa7c44c000000b0042ab2159b3eso9995865edr.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gc6m3XcjXFZK4IY7snllrwp4xXxt/PdhQGyQJtEizR4=;
        b=X19BMT37al/LuM8j3YyqODL6L3AP6LWlfTAUHUulIyksomBHZ5VaggV+Svs44V8hym
         VDj4rAlW0J/xuqiU0dh37e78eQv0smOgUefNyS4QE2wqRZMWmLWBen+5+KiRm+aMNYmx
         YtHtkr6/HlTqIFrD6ZL/I707hNLjVj7vd2Xe++T3FsWXwCU58HWxnkmcF4IydQe57PPg
         FSMM8hkVUiF15dLb6LFBvz27c1C8h9ive54Sfj1DG8obDVWhvU90F4rgseeD4FXsDaGN
         +dMTybuaBMLDH4SQiJhAer0a/LPQ9pH+lsZbwi5RVwtCO/YvQFqiZQBNSuB0uIqnx7JN
         1r0g==
X-Gm-Message-State: AOAM533iJC0vRM8xXqhBYrxo9Su5wWffp/OhmKuHER3CG7wuGtxM1GwG
        PrHgJbQx1326PH4K2wsqXw6DJysuJKDS8qrSTOm+IKXy3AyyL0bPcjsASciqhACGAdVkBl1qpvl
        Ns2MHXjHbbI1o8xnmHJpN7eOjeLczvSTmOecRuHjARg==
X-Received: by 2002:a05:6402:84c:b0:428:4cc4:8212 with SMTP id b12-20020a056402084c00b004284cc48212mr22595230edz.171.1653285942132;
        Sun, 22 May 2022 23:05:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkKR2r8E8Xx1iDAMXOgaBNrjjlnaFEXjGXVWac/Tu0AG+RwTJpLHCbpRGuD2/bKTDllS5fTA==
X-Received: by 2002:a05:6402:84c:b0:428:4cc4:8212 with SMTP id b12-20020a056402084c00b004284cc48212mr22595217edz.171.1653285941934;
        Sun, 22 May 2022 23:05:41 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id p23-20020a056402155700b0042617ba6389sm7777293edx.19.2022.05.22.23.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:05:41 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, joel@jms.id.au, andrew@aj.id.au,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: aspeed: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:05:32 +0200
Message-Id: <20220523060532.7864-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
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

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-aspeed/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index ea96d11b8502..e05997ec2f82 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -19,9 +19,9 @@ config MACH_ASPEED_G4
 	select PINCTRL_ASPEED_G4
 	select FTTMR010_TIMER
 	help
-	 Say yes if you intend to run on an Aspeed ast2400 or similar
-	 fourth generation BMCs, such as those used by OpenPower Power8
-	 systems.
+	  Say yes if you intend to run on an Aspeed ast2400 or similar
+	  fourth generation BMCs, such as those used by OpenPower Power8
+	  systems.
 
 config MACH_ASPEED_G5
 	bool "Aspeed SoC 5th Generation"
@@ -29,8 +29,8 @@ config MACH_ASPEED_G5
 	select PINCTRL_ASPEED_G5
 	select FTTMR010_TIMER
 	help
-	 Say yes if you intend to run on an Aspeed ast2500 or similar
-	 fifth generation Aspeed BMCs.
+	  Say yes if you intend to run on an Aspeed ast2500 or similar
+	  fifth generation Aspeed BMCs.
 
 config MACH_ASPEED_G6
 	bool "Aspeed SoC 6th Generation"
@@ -40,7 +40,7 @@ config MACH_ASPEED_G6
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	help
-	 Say yes if you intend to run on an Aspeed ast2600 or similar
-	 sixth generation Aspeed BMCs.
+	  Say yes if you intend to run on an Aspeed ast2600 or similar
+	  sixth generation Aspeed BMCs.
 
 endif
-- 
2.32.0

