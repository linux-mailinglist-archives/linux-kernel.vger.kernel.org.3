Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBB52A47E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348576AbiEQOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiEQOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:14:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E94F446
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:38 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 04E8F3F32C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652796877;
        bh=A4tif2oeOiGZ9imun85v7GxeMQf4jXcTSTh0npKa1q8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=NDR5necBD82xdjupd4XX8/56kxM7joDrst9u6Ei02eB/eLoScFg22d8tBCDuwjffQ
         jidxdOAtpla1gh8vIuS9LQrN9BUF17P7ysnNA9eZUX/rqmKmc3VntVSZYuFdfP9bE/
         vrqMaMq8MxZ2ltRSspOQO3aFOlNegBeNaUnnWYkXDJmKSG8DX0oaCPOw0GGcMOBDvD
         AMf8S1xdxS2+dFh8TMNjJ9x4VnIMs3f1E5TqYU3/St249xrSZ8ZYWuywxLIeNKjZUG
         0xS2RS+SgPwZL49YY/ydG1HGO8oEB8bslXsNT3ICfKN4+z8BXzRKwDfV+GrFZIgt+L
         XvwUJJyv9YA8Q==
Received: by mail-ej1-f70.google.com with SMTP id jx8-20020a170906ca4800b006f88b28f2f6so7444865ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4tif2oeOiGZ9imun85v7GxeMQf4jXcTSTh0npKa1q8=;
        b=637VuI8oqJArVaA2nXutnKz7xHS8OTL+Kod3OEn7C8Uuo6UkKLDOTu6nIqlYSsoQMe
         ltRjIu06QNGKiVsOtgLnZtyU/sHS/XcENYwf/Bj5fuaKfsO1y5xkWBLe/J6i1jNTbaRX
         FvtAFRCWZ0VOCM9a5JpPO3D5Wt3DKNu4pVLy8ZnxwpSjaAsc00gUzSpKzfOhaZJ9xgAK
         r7/dykJnSGxsRTxAMB+FjCy2a4RnwAZjLfIpyUve7N+WKvJnT21aE0kjVv2e+ZU5kMgQ
         2RBjntGtv/aJ8qTTzppeMQk3lbo5YCBJ+h6ExHr0EsAeZalNUeGQfhSY6iDZ56wa1vmr
         IFSg==
X-Gm-Message-State: AOAM531zWyNaPLUlksbBlHvw5Ic12q8qz2JTEonoaRWztzoVCW4hy857
        8QSHPnMe2RmGLwYfI+7SvCidGXCUuRB7z66li0Si8m8FF+TbElpz0MCGaeFTYh974PExRLyl08I
        TiechsOY6UAK6HVyE8XzDffHsa1Qy3V1JM4i/YAyfDA==
X-Received: by 2002:aa7:c3d2:0:b0:42a:b39d:b30c with SMTP id l18-20020aa7c3d2000000b0042ab39db30cmr10650517edr.368.1652796876712;
        Tue, 17 May 2022 07:14:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcFmT2bwAJvi5wGkShAFw0mg0nOBEWTIrotAppzC53+6Xd62jlbuqdJpzMa+vDlkhQ/CdUNw==
X-Received: by 2002:aa7:c3d2:0:b0:42a:b39d:b30c with SMTP id l18-20020aa7c3d2000000b0042ab39db30cmr10650488edr.368.1652796876505;
        Tue, 17 May 2022 07:14:36 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id em9-20020a170907288900b006f3ef214e4fsm1079265ejc.181.2022.05.17.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:14:36 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/3] ARM: Kconfig: Fix indentation and add comments
Date:   Tue, 17 May 2022 16:14:22 +0200
Message-Id: <20220517141424.331759-2-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517141424.331759-1-juergh@canonical.com>
References: <20220517141424.331759-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/arm/Kconfig | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e2d8a8..912716c99c82 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -181,7 +181,7 @@ config ARM_DMA_IOMMU_ALIGNMENT
 	  specified order. The order is expressed as a power of two multiplied
 	  by the PAGE_SIZE.
 
-endif
+endif # ARM_DMA_USE_IOMMU
 
 config SYS_SUPPORTS_APM_EMULATION
 	bool
@@ -549,7 +549,7 @@ config ARCH_MULTI_CPU_AUTO
 	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
 	select ARCH_MULTI_V5
 
-endmenu
+endmenu # "Multiple platform selection"
 
 config ARCH_VIRT
 	bool "Dummy Virtual Machine"
@@ -771,7 +771,7 @@ config IWMMXT
 
 if !MMU
 source "arch/arm/Kconfig-nommu"
-endif
+endif # !MMU
 
 config PJ4B_ERRATA_4742
 	bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
@@ -973,14 +973,14 @@ config ARM_ERRATA_764369
 	  in the diagnostic control register of the SCU.
 
 config ARM_ERRATA_775420
-       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
-       depends on CPU_V7
-       help
-	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
-	 r2p6,r2p8,r2p10,r3p0) erratum. In case a data cache maintenance
-	 operation aborts with MMU exception, it might cause the processor
-	 to deadlock. This workaround puts DSB before executing ISB if
-	 an abort may occur on cache maintenance.
+	bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 775420 Cortex-A9 (r2p2,
+	  r2p6,r2p8,r2p10,r3p0) erratum. In case a data cache maintenance
+	  operation aborts with MMU exception, it might cause the processor
+	  to deadlock. This workaround puts DSB before executing ISB if
+	  an abort may occur on cache maintenance.
 
 config ARM_ERRATA_798181
 	bool "ARM errata: TLBI/DSB failure on Cortex-A15"
@@ -1073,7 +1073,7 @@ config ARM_ERRATA_857272
 	  config option from the A12 erratum due to the way errata are checked
 	  for and handled.
 
-endmenu
+endmenu # "System Type"
 
 source "arch/arm/common/Kconfig"
 
@@ -1115,7 +1115,7 @@ config ARM_ERRATA_814220
 	  This ERRATA only affected the Cortex-A7 and present in r0p2, r0p3,
 	  r0p4, r0p5.
 
-endmenu
+endmenu # "Bus support"
 
 menu "Kernel Features"
 
@@ -1631,7 +1631,7 @@ config STACKPROTECTOR_PER_TASK
 	  Enable this option to switch to a different method that uses a
 	  different canary value for each task.
 
-endmenu
+endmenu # "Kernel Features"
 
 menu "Boot options"
 
@@ -1903,7 +1903,7 @@ config DMI
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
 
-endmenu
+endmenu # "Boot options"
 
 menu "CPU Power Management"
 
@@ -1911,7 +1911,7 @@ source "drivers/cpufreq/Kconfig"
 
 source "drivers/cpuidle/Kconfig"
 
-endmenu
+endmenu # "CPU Power Management"
 
 menu "Floating point emulation"
 
@@ -1985,7 +1985,7 @@ config KERNEL_MODE_NEON
 	help
 	  Say Y to include support for NEON in kernel mode.
 
-endmenu
+endmenu # "Floating point emulation"
 
 menu "Power management options"
 
@@ -2005,10 +2005,10 @@ config ARCH_HIBERNATION_POSSIBLE
 	depends on MMU
 	default y if ARCH_SUSPEND_POSSIBLE
 
-endmenu
+endmenu # "Power management options"
 
 if CRYPTO
 source "arch/arm/crypto/Kconfig"
-endif
+endif # CRYPTO
 
 source "arch/arm/Kconfig.assembler"
-- 
2.32.0

