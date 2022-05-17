Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0552A490
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348689AbiEQORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348698AbiEQOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:16:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE175275FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:16:55 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3173B3FFC8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652797014;
        bh=DJeT9IyGMKuIxu/NYXP6jKmFYzxZ1VoA48dGzoOnvhY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QoBOrcRK5IXkGDbZkg42tC5BgP82UrPKj6T3BBTEMXh+BoLmjMBmhGjRv8YI/PBli
         HkfcYp66hh6OSmXb0P4i3uGBLR/KiWXDyMZ9DjQSiTJhBy+BqfiBgtq9ZV4c+Nl1Ox
         xLWmnCsdmGN2yAYw8Kh0ZSO7iGZwkYWbSgNljZDZqYxga1rFmsNR3YlCUK1Lyr3YZH
         dl1aI+5dZPoQU4mJsLeeZeNsfcBuHV5gjdSsR2M+M0NMQuUoN2MovT0OqHUDeL3IPt
         2IO1kqolbbEzFsygRvVG5tpWqniVyhh5xvT5lo3Wn/88skEiSMvPeFfHvO4G4pw1dX
         XGaxMOusQH2hw==
Received: by mail-ed1-f69.google.com with SMTP id n7-20020a05640206c700b0042aaeb9d702so4379659edy.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJeT9IyGMKuIxu/NYXP6jKmFYzxZ1VoA48dGzoOnvhY=;
        b=Eptk6vrMatSZ88A/PCdZIepW18m/+GVr1OI9Rifw3FqLcI0Fqi/2eNNNsq2wyQomxy
         hE7Mn34LmFMjfqgBakbmzHq9G0j1eR2KkIhyJ+qFWvYFDaU2piesTDD2CkjGE2AVsjWs
         X+iKicoxzrIwj0DM8KEIJ9QSBnWlKrGEV0GjcXNoQXAh/0Yp7TlUdqAxuwnFpPkW7ajf
         c1rlNDLeInarGd6y1yNBWDFKWFEYrnebcqiKfNz0RhCm6Hj4K7flHk1TJ60KWYuMKSAF
         +PLfVErDiP47Qkx5LURVYbM6DX2IXNEfrTJU5qVQAMhhr/Ii+DmK97mQLJG6cfu09udQ
         7KRA==
X-Gm-Message-State: AOAM533ruKhmjIlvkTLYklObZ8bcQysv90TzF5nZFtfUw0zc0EPOgsxb
        VMOllW7ASbBtQ0PJRufBMc7zjgcgEf6NY3buY70Y7OvYWZk0s1cMFTUQ0o9q1lg532i/LH2e+cP
        HWs8mC6UZRqQ1cScXXVP3OsVIY/00v34FYYLYKXIxVw==
X-Received: by 2002:aa7:cdd7:0:b0:42a:bbb2:84e5 with SMTP id h23-20020aa7cdd7000000b0042abbb284e5mr7834231edw.91.1652797013404;
        Tue, 17 May 2022 07:16:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUqApBfnAdMdEFlriYn5A5ZDLCsI42m2I9XvRdzhQFLTaTYaIMZc3iVYXrq0tJV5WXgGvsRw==
X-Received: by 2002:aa7:cdd7:0:b0:42a:bbb2:84e5 with SMTP id h23-20020aa7cdd7000000b0042abbb284e5mr7834213edw.91.1652797013187;
        Tue, 17 May 2022 07:16:53 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bo3-20020a170906d04300b006f3ef214dcesm1065035ejb.52.2022.05.17.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:16:52 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/2] arm64: Kconfig: Fix indentation and add comments
Date:   Tue, 17 May 2022 16:16:47 +0200
Message-Id: <20220517141648.331976-2-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517141648.331976-1-juergh@canonical.com>
References: <20220517141648.331976-1-juergh@canonical.com>
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
 arch/arm64/Kconfig | 95 +++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20ea89d9ac2f..e0ed1629199a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -262,31 +262,31 @@ config ARM64_CONT_PMD_SHIFT
 	default 4
 
 config ARCH_MMAP_RND_BITS_MIN
-       default 14 if ARM64_64K_PAGES
-       default 16 if ARM64_16K_PAGES
-       default 18
+	default 14 if ARM64_64K_PAGES
+	default 16 if ARM64_16K_PAGES
+	default 18
 
 # max bits determined by the following formula:
 #  VA_BITS - PAGE_SHIFT - 3
 config ARCH_MMAP_RND_BITS_MAX
-       default 19 if ARM64_VA_BITS=36
-       default 24 if ARM64_VA_BITS=39
-       default 27 if ARM64_VA_BITS=42
-       default 30 if ARM64_VA_BITS=47
-       default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
-       default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
-       default 33 if ARM64_VA_BITS=48
-       default 14 if ARM64_64K_PAGES
-       default 16 if ARM64_16K_PAGES
-       default 18
+	default 19 if ARM64_VA_BITS=36
+	default 24 if ARM64_VA_BITS=39
+	default 27 if ARM64_VA_BITS=42
+	default 30 if ARM64_VA_BITS=47
+	default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
+	default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
+	default 33 if ARM64_VA_BITS=48
+	default 14 if ARM64_64K_PAGES
+	default 16 if ARM64_16K_PAGES
+	default 18
 
 config ARCH_MMAP_RND_COMPAT_BITS_MIN
-       default 7 if ARM64_64K_PAGES
-       default 9 if ARM64_16K_PAGES
-       default 11
+	default 7 if ARM64_64K_PAGES
+	default 9 if ARM64_16K_PAGES
+	default 11
 
 config ARCH_MMAP_RND_COMPAT_BITS_MAX
-       default 16
+	default 16
 
 config NO_IOPORT_MAP
 	def_bool y if !PCI
@@ -313,7 +313,7 @@ config GENERIC_HWEIGHT
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
@@ -1046,8 +1046,7 @@ config SOCIONEXT_SYNQUACER_PREITS
 
 	  If unsure, say Y.
 
-endmenu
-
+endmenu # "ARM errata workarounds via the alternatives framework"
 
 choice
 	prompt "Page size"
@@ -1575,9 +1574,9 @@ config SETEND_EMULATION
 	  be unexpected results in the applications.
 
 	  If unsure, say Y
-endif
+endif # ARMV8_DEPRECATED
 
-endif
+endif # COMPAT
 
 menu "ARMv8.1 architectural features"
 
@@ -1602,15 +1601,15 @@ config ARM64_PAN
 	bool "Enable support for Privileged Access Never (PAN)"
 	default y
 	help
-	 Privileged Access Never (PAN; part of the ARMv8.1 Extensions)
-	 prevents the kernel or hypervisor from accessing user-space (EL0)
-	 memory directly.
+	  Privileged Access Never (PAN; part of the ARMv8.1 Extensions)
+	  prevents the kernel or hypervisor from accessing user-space (EL0)
+	  memory directly.
 
-	 Choosing this option will cause any unprotected (not using
-	 copy_to_user et al) memory access to fail with a permission fault.
+	  Choosing this option will cause any unprotected (not using
+	  copy_to_user et al) memory access to fail with a permission fault.
 
-	 The feature is detected at runtime, and will remain as a 'nop'
-	 instruction if the cpu does not implement the feature.
+	  The feature is detected at runtime, and will remain as a 'nop'
+	  instruction if the cpu does not implement the feature.
 
 config AS_HAS_LDAPR
 	def_bool $(as-instr,.arch_extension rcpc)
@@ -1638,15 +1637,15 @@ config ARM64_USE_LSE_ATOMICS
 	  built with binutils >= 2.25 in order for the new instructions
 	  to be used.
 
-endmenu
+endmenu # "ARMv8.1 architectural features"
 
 menu "ARMv8.2 architectural features"
 
 config AS_HAS_ARMV8_2
-       def_bool $(cc-option,-Wa$(comma)-march=armv8.2-a)
+	def_bool $(cc-option,-Wa$(comma)-march=armv8.2-a)
 
 config AS_HAS_SHA3
-       def_bool $(as-instr,.arch armv8.2-a+sha3)
+	def_bool $(as-instr,.arch armv8.2-a+sha3)
 
 config ARM64_PMEM
 	bool "Enable support for persistent memory"
@@ -1690,7 +1689,7 @@ config ARM64_CNP
 	  at runtime, and does not affect PEs that do not implement
 	  this feature.
 
-endmenu
+endmenu # "ARMv8.2 architectural features"
 
 menu "ARMv8.3 architectural features"
 
@@ -1753,7 +1752,7 @@ config AS_HAS_PAC
 config AS_HAS_CFI_NEGATE_RA_STATE
 	def_bool $(as-instr,.cfi_startproc\n.cfi_negate_ra_state\n.cfi_endproc\n)
 
-endmenu
+endmenu # "ARMv8.3 architectural features"
 
 menu "ARMv8.4 architectural features"
 
@@ -1794,7 +1793,7 @@ config ARM64_TLB_RANGE
 	  The feature introduces new assembly instructions, and they were
 	  support when binutils >= 2.30.
 
-endmenu
+endmenu # "ARMv8.4 architectural features"
 
 menu "ARMv8.5 architectural features"
 
@@ -1901,7 +1900,7 @@ config ARM64_MTE
 
 	  Documentation/arm64/memory-tagging-extension.rst.
 
-endmenu
+endmenu # "ARMv8.5 architectural features"
 
 menu "ARMv8.7 architectural features"
 
@@ -1910,12 +1909,12 @@ config ARM64_EPAN
 	default y
 	depends on ARM64_PAN
 	help
-	 Enhanced Privileged Access Never (EPAN) allows Privileged
-	 Access Never to be used with Execute-only mappings.
+	  Enhanced Privileged Access Never (EPAN) allows Privileged
+	  Access Never to be used with Execute-only mappings.
 
-	 The feature is detected at runtime, and will remain disabled
-	 if the cpu does not implement the feature.
-endmenu
+	  The feature is detected at runtime, and will remain disabled
+	  if the cpu does not implement the feature.
+endmenu # "ARMv8.7 architectural features"
 
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
@@ -1991,7 +1990,7 @@ config ARM64_DEBUG_PRIORITY_MASKING
 	  the validity of ICC_PMR_EL1 when calling concerned functions.
 
 	  If unsure, say N
-endif
+endif # ARM64_PSEUDO_NMI
 
 config RELOCATABLE
 	bool "Build a relocatable kernel image" if EXPERT
@@ -2050,7 +2049,7 @@ config STACKPROTECTOR_PER_TASK
 	def_bool y
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
 
-endmenu
+endmenu # "Kernel Features"
 
 menu "Boot options"
 
@@ -2114,7 +2113,7 @@ config EFI
 	help
 	  This option provides support for runtime services provided
 	  by UEFI firmware (such as non-volatile variables, realtime
-          clock, and platform reset). A UEFI stub is also provided to
+	  clock, and platform reset). A UEFI stub is also provided to
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
@@ -2129,7 +2128,7 @@ config DMI
 	  However, even with this option, the resultant kernel should
 	  continue to boot on existing non-UEFI platforms.
 
-endmenu
+endmenu # "Boot options"
 
 config SYSVIPC_COMPAT
 	def_bool y
@@ -2150,7 +2149,7 @@ config ARCH_HIBERNATION_HEADER
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
-endmenu
+endmenu # "Power management options"
 
 menu "CPU Power Management"
 
@@ -2158,7 +2157,7 @@ source "drivers/cpuidle/Kconfig"
 
 source "drivers/cpufreq/Kconfig"
 
-endmenu
+endmenu # "CPU Power Management"
 
 source "drivers/acpi/Kconfig"
 
@@ -2166,4 +2165,4 @@ source "arch/arm64/kvm/Kconfig"
 
 if CRYPTO
 source "arch/arm64/crypto/Kconfig"
-endif
+endif # CRYPTO
-- 
2.32.0

