Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640F552EBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbiETMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiETMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:12:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A04B15EA62
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:11:59 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 887F73F1F3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653048717;
        bh=BbZQ2v7/O1XNxv2l6ZiEn/Rj5+K5y5FEa7M1oafefgw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=La3gNyCoGQlRcMD2Jl3/gCT9tGNrHI5p33DAXDh4JVw7sL0wL3dcb+CW/eC2weNur
         5ZFDM0PuQkoUW4oflGEMVcRELyD41ODy16qiTOtMr/PCSctPPAllJbEtEGqlZzBiNX
         xWvs2VvbiQQ2QBqFlbnqlj3PaZ3ko5BEBanFvuPBKzGU8XWxTob/REoSevG1krFLa2
         rOZnhwYlEsVI4WbbtJbFI3wGYQ/3UTAZqY9BNoupiIfoGVtQxZJhb9BwaoDCJGGENb
         yO3V2MeRabZLub+LCZ8d61YOto5OkK8uNeMUU/EVRarY6oMijUsQUs866rFeO9v06l
         UuiUW0KCEUi/Q==
Received: by mail-ej1-f70.google.com with SMTP id gh15-20020a170906e08f00b006fea2a22319so1466511ejb.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbZQ2v7/O1XNxv2l6ZiEn/Rj5+K5y5FEa7M1oafefgw=;
        b=xZyXEqqEGI1ik/0RBHJRs2pfe4HnG2F7eFevLKOcKRGXsgv3qEYHNxxDkJ4JNRtt6l
         61EqFsHCFYj626qvL07vVYwmWvkPLgxBi8eXuhUPTrW94zrB4AcUjIQIBAernq9+6t97
         FMdK++cT3CF9yBIkuN1w0P45LIuY+U/6l4agjxg/DBzeBBre8sI2UqgwNAztl2gpf5BP
         iLswt2UvzZhUbx1nMiQbWrapCMIeDknHb0MsLNaT1QETEji793m0i9Mkr3dD9bvwws83
         FeVDwHCRuohfubXmcYeyptDfG8YxB7tZ9HtPi/wkZjZfiP7MopASK8xzub3aks1wwv0Q
         Vd4Q==
X-Gm-Message-State: AOAM533shpxMLGnbZbGkAe30YSJJYNtKqfmwic3Q3aOVQvOVrkCIQaZI
        8ZbuNezkmQ5OKqnsOcwAxM6MukqAZommfX5ydV4T+zlpuYIx28KTABqXYJ1SRAe9y8yyFaNQjlX
        f5A4xaEBQSCjm2NtGGRhi0ScJFYNNW/SCeUiEH8QZ8Q==
X-Received: by 2002:a17:907:3e07:b0:6f0:270c:1121 with SMTP id hp7-20020a1709073e0700b006f0270c1121mr8481906ejc.137.1653048717229;
        Fri, 20 May 2022 05:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys+rXcRkBah3y4A8Ivr51zp1KXUkCKOzJC77NGpxzecgku3TDy2b6vWrZwTWYFUrWMpOX1dg==
X-Received: by 2002:a17:907:3e07:b0:6f0:270c:1121 with SMTP id hp7-20020a1709073e0700b006f0270c1121mr8481891ejc.137.1653048717052;
        Fri, 20 May 2022 05:11:57 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ml13-20020a170906cc0d00b006fe90a8459dsm2432866ejb.166.2022.05.20.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:11:56 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     davem@davemloft.net, sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] sparc: Kconfig: Fix indentation and add comments
Date:   Fri, 20 May 2022 14:11:53 +0200
Message-Id: <20220520121153.148573-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

While add it, add trailing comments to endif and endmenu statements for
better readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/sparc/Kconfig | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9200bc04701c..3c97725fe75c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -227,7 +227,7 @@ config HOTPLUG_CPU
 
 if SPARC64
 source "drivers/cpufreq/Kconfig"
-endif
+endif # SPARC64
 
 config US3_MC
 	tristate "UltraSPARC-III Memory Controller driver"
@@ -283,7 +283,7 @@ config FORCE_MAX_ZONEORDER
 
 if SPARC64
 source "kernel/power/Kconfig"
-endif
+endif # SPARC64
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
@@ -382,33 +382,33 @@ config UBOOT_LOAD_ADDR
 	hex "uImage Load Address"
 	default 0x40004000
 	help
-	 U-Boot kernel load address, the address in physical address space
-	 where u-boot will place the Linux kernel before booting it.
-	 This address is normally the base address of main memory + 0x4000.
+	  U-Boot kernel load address, the address in physical address space
+	  where u-boot will place the Linux kernel before booting it.
+	  This address is normally the base address of main memory + 0x4000.
 
 config UBOOT_FLASH_ADDR
 	hex "uImage.o Load Address"
 	default 0x00080000
 	help
-	 Optional setting only affecting the uImage.o ELF-image used to
-	 download the uImage file to the target using a ELF-loader other than
-	 U-Boot. It may for example be used to download an uImage to FLASH with
-	 the GRMON utility before even starting u-boot.
+	  Optional setting only affecting the uImage.o ELF-image used to
+	  download the uImage file to the target using a ELF-loader other than
+	  U-Boot. It may for example be used to download an uImage to FLASH with
+	  the GRMON utility before even starting u-boot.
 
 config UBOOT_ENTRY_ADDR
 	hex "uImage Entry Address"
 	default 0xf0004000
 	help
-	 Do not change this unless you know what you're doing. This is
-	 hardcoded by the SPARC32 and LEON port.
+	  Do not change this unless you know what you're doing. This is
+	  hardcoded by the SPARC32 and LEON port.
 
-	 This is the virtual address u-boot jumps to when booting the Linux
-	 Kernel.
+	  This is the virtual address u-boot jumps to when booting the Linux
+	  Kernel.
 
-endmenu
-endif
+endmenu # "U-Boot options"
+endif # SPARC_LEON
 
-endmenu
+endmenu # "Processor type and features"
 
 menu "Bus options (PCI etc.)"
 config SBUS
@@ -478,7 +478,7 @@ config SPARC64_PCI_MSI
 	default y
 	depends on SPARC64_PCI && PCI_MSI
 
-endmenu
+endmenu # "Bus options (PCI etc.)"
 
 config COMPAT
 	bool
-- 
2.32.0

