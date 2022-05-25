Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF103533DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiEYNcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbiEYNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:32:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7F222B6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:32:10 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D7D0F3F1F1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653485528;
        bh=gdKfbm5VrhgrnmDEpSvU9Ypgfgpc8pgNQoJ/q4vbTi8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RxNYuX6y4zgISvPtV6NT1hteh5hbQ9wJKcr+mcDMMnR8tjP00krgB6MdJCrLg4nzy
         IiwCncZNn3fSKKC2t/DnUnVcP5EhjxJupV0LYEyP3m9EeNZWxzxyFC4K5xlfC5zkdh
         juKXoXzeMnsxpTMhWEmhlLxMQO3yPhf8l+FPCpWtV53d3wF1N7DhEQIHV+BLPpy7CM
         uOlg05N5JGBT8shYXJLgf48vt3+018aFv2cMhNUeTKf28cTwLE7U3IALNqjQeUNCZ5
         PT20ZQKRrj5ZYgFu1UoyCFWEg88+N6uAg5RpkJityx7MEY7n/atU71hQ+XEXrARcJd
         K60IXCuQGO/3Q==
Received: by mail-ej1-f70.google.com with SMTP id b17-20020a170906491100b006feec47b64bso4502457ejq.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdKfbm5VrhgrnmDEpSvU9Ypgfgpc8pgNQoJ/q4vbTi8=;
        b=Vq7b5Gh2v3L0dI2HMrosCEfdwc2jjlcNBWLKeHqnSmQCgS/aPSUPi6uiAv1gu389lU
         i32KQnOGqghHodTlKVUo/XeWUYk6OaiOCtuCiWnmiJaOEhAMp3hjawlqhCse3ka5MJaK
         BFaaHmIoDv8u5O0CB5ShvypDWJV3sDFskkoqnZ3CHiHJSBt8uORkWvs4BsW3cf9ONAuL
         eY5mI1jJudEkZsp7MzPRIt6WWwZ0dUlJGXzbSLMw8++T2ajkvGMOibOiASEjxAKqHsRB
         faTA8BzOL+L2ITveFldp21qeC/XgK9XoR6a+uYlUo67wcBHm9sXs3CX8IOnKZf9JjTta
         pMlg==
X-Gm-Message-State: AOAM53379Eyj74X+KeftXyBGETKuCO7sf2EsJTjkWVyaSOhJA2doM/BT
        KtsGmNNQ0xyyrlIkxZ5MYQa+XwZCOWKeTSEqH8OdFfWJX7a4brbVqIYNx0R6kgoaXMOTqhkLRBd
        rOsmCr+smbbyEDh8hGPz7c/T8A1ZnBGgJlOV1CpHyew==
X-Received: by 2002:a05:6402:524d:b0:42a:f9e9:8013 with SMTP id t13-20020a056402524d00b0042af9e98013mr33748886edd.65.1653485528212;
        Wed, 25 May 2022 06:32:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW/RCoTC7mCQWghNsaJYwSF/8hyQOg5CnOjXvHQm9LCGqC8/uaECRQJacSz56iPGytG9buew==
X-Received: by 2002:a05:6402:524d:b0:42a:f9e9:8013 with SMTP id t13-20020a056402524d00b0042af9e98013mr33748859edd.65.1653485527886;
        Wed, 25 May 2022 06:32:07 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090694c800b006fe9209a9edsm3723388ejy.128.2022.05.25.06.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:32:07 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/2] x86: Kconfig: Fix indentation and add endif comments
Date:   Wed, 25 May 2022 15:32:02 +0200
Message-Id: <20220525133203.52463-2-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525133203.52463-1-juerg.haefliger@canonical.com>
References: <20220525133203.52463-1-juerg.haefliger@canonical.com>
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

While add it, add missing trailing endif comments and squeeze multiple
empty lines.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/x86/Kconfig | 101 +++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d..edfc4bad6f16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -41,11 +41,11 @@ config FORCE_DYNAMIC_FTRACE
 	depends on FUNCTION_TRACER
 	select DYNAMIC_FTRACE
 	help
-	 We keep the static function tracing (!DYNAMIC_FTRACE) around
-	 in order to test the non static function tracing in the
-	 generic code, as other architectures still use it. But we
-	 only need to keep it around for x86_64. No need to keep it
-	 for x86_32. For x86_32, force DYNAMIC_FTRACE. 
+	  We keep the static function tracing (!DYNAMIC_FTRACE) around
+	  in order to test the non static function tracing in the
+	  generic code, as other architectures still use it. But we
+	  only need to keep it around for x86_64. No need to keep it
+	  for x86_32. For x86_32, force DYNAMIC_FTRACE.
 #
 # Arch settings
 #
@@ -389,9 +389,9 @@ config CC_HAS_SANE_STACKPROTECTOR
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
 	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
 	help
-	   We have to make sure stack protector is unconditionally disabled if
-	   the compiler produces broken code or if it does not let us control
-	   the segment on 32-bit kernels.
+	  We have to make sure stack protector is unconditionally disabled if
+	  the compiler produces broken code or if it does not let us control
+	  the segment on 32-bit kernels.
 
 menu "Processor type and features"
 
@@ -525,7 +525,7 @@ config X86_EXTENDED_PLATFORM
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-endif
+endif # X86_32
 
 if X86_64
 config X86_EXTENDED_PLATFORM
@@ -544,7 +544,7 @@ config X86_EXTENDED_PLATFORM
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-endif
+endif # X86_64
 # This is an alphabetically sorted list of 64 bit extended platforms
 # Please maintain the alphabetic order if and when there are additions
 config X86_NUMACHIP
@@ -592,9 +592,9 @@ config X86_GOLDFISH
 	bool "Goldfish (Virtual Platform)"
 	depends on X86_EXTENDED_PLATFORM
 	help
-	 Enable support for the Goldfish virtual platform used primarily
-	 for Android development. Unless you are building for the Android
-	 Goldfish emulator say N here.
+	  Enable support for the Goldfish virtual platform used primarily
+	  for Android development. Unless you are building for the Android
+	  Goldfish emulator say N here.
 
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
@@ -878,7 +878,7 @@ config ACRN_GUEST
 	  IOT with small footprint and real-time features. More details can be
 	  found in https://projectacrn.org/.
 
-endif #HYPERVISOR_GUEST
+endif # HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
 
@@ -1139,16 +1139,16 @@ config X86_MCE_INTEL
 	prompt "Intel MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC
 	help
-	   Additional support for intel specific MCE features such as
-	   the thermal monitor.
+	  Additional support for intel specific MCE features such as
+	  the thermal monitor.
 
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC && AMD_NB
 	help
-	   Additional support for AMD specific MCE features such as
-	   the DRAM Error Threshold.
+	  Additional support for AMD specific MCE features such as
+	  the DRAM Error Threshold.
 
 config X86_ANCIENT_MCE
 	bool "Support for old Pentium 5 / WinChip machine checks"
@@ -1226,18 +1226,18 @@ config X86_VSYSCALL_EMULATION
 	default y
 	depends on X86_64
 	help
-	 This enables emulation of the legacy vsyscall page.  Disabling
-	 it is roughly equivalent to booting with vsyscall=none, except
-	 that it will also disable the helpful warning if a program
-	 tries to use a vsyscall.  With this option set to N, offending
-	 programs will just segfault, citing addresses of the form
-	 0xffffffffff600?00.
+	  This enables emulation of the legacy vsyscall page.  Disabling
+	  it is roughly equivalent to booting with vsyscall=none, except
+	  that it will also disable the helpful warning if a program
+	  tries to use a vsyscall.  With this option set to N, offending
+	  programs will just segfault, citing addresses of the form
+	  0xffffffffff600?00.
 
-	 This option is required by many programs built before 2013, and
-	 care should be used even with newer programs if set to N.
+	  This option is required by many programs built before 2013, and
+	  care should be used even with newer programs if set to N.
 
-	 Disabling this option saves about 7K of kernel size and
-	 possibly 4K of additional runtime pagetable memory.
+	  Disabling this option saves about 7K of kernel size and
+	  possibly 4K of additional runtime pagetable memory.
 
 config X86_IOPL_IOPERM
 	bool "IOPERM and IOPL Emulation"
@@ -1984,15 +1984,15 @@ config EFI_MIXED
 	bool "EFI mixed-mode support"
 	depends on EFI_STUB && X86_64
 	help
-	   Enabling this feature allows a 64-bit kernel to be booted
-	   on a 32-bit firmware, provided that your CPU supports 64-bit
-	   mode.
+	  Enabling this feature allows a 64-bit kernel to be booted
+	  on a 32-bit firmware, provided that your CPU supports 64-bit
+	  mode.
 
-	   Note that it is not possible to boot a mixed-mode enabled
-	   kernel via the EFI boot stub - a bootloader that supports
-	   the EFI handover protocol must be used.
+	  Note that it is not possible to boot a mixed-mode enabled
+	  kernel via the EFI boot stub - a bootloader that supports
+	  the EFI handover protocol must be used.
 
-	   If unsure, say N.
+	  If unsure, say N.
 
 source "kernel/Kconfig.hz"
 
@@ -2217,16 +2217,16 @@ config RANDOMIZE_MEMORY
 	select DYNAMIC_MEMORY_LAYOUT
 	default RANDOMIZE_BASE
 	help
-	   Randomizes the base virtual address of kernel memory sections
-	   (physical memory mapping, vmalloc & vmemmap). This security feature
-	   makes exploits relying on predictable memory locations less reliable.
+	  Randomizes the base virtual address of kernel memory sections
+	  (physical memory mapping, vmalloc & vmemmap). This security feature
+	  makes exploits relying on predictable memory locations less reliable.
 
-	   The order of allocations remains unchanged. Entropy is generated in
-	   the same way as RANDOMIZE_BASE. Current implementation in the optimal
-	   configuration have in average 30,000 different possible virtual
-	   addresses for each memory section.
+	  The order of allocations remains unchanged. Entropy is generated in
+	  the same way as RANDOMIZE_BASE. Current implementation in the optimal
+	  configuration have in average 30,000 different possible virtual
+	  addresses for each memory section.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
 config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	hex "Physical memory mapping padding" if EXPERT
@@ -2236,12 +2236,12 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	range 0x1 0x40 if MEMORY_HOTPLUG
 	range 0x0 0x40
 	help
-	   Define the padding in terabytes added to the existing physical
-	   memory size during kernel memory randomization. It is useful
-	   for memory hotplug support but reduces the entropy available for
-	   address randomization.
+	  Define the padding in terabytes added to the existing physical
+	  memory size during kernel memory randomization. It is useful
+	  for memory hotplug support but reduces the entropy available for
+	  address randomization.
 
-	   If unsure, leave at the default value.
+	  If unsure, leave at the default value.
 
 config HOTPLUG_CPU
 	def_bool y
@@ -2600,7 +2600,6 @@ source "drivers/idle/Kconfig"
 
 endmenu
 
-
 menu "Bus options (PCI etc.)"
 
 choice
@@ -2824,7 +2823,6 @@ config AMD_NB
 
 endmenu
 
-
 menu "Binary Emulations"
 
 config IA32_EMULATION
@@ -2876,11 +2874,10 @@ config COMPAT_FOR_U64_ALIGNMENT
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on SYSVIPC
-endif
+endif # COMPAT
 
 endmenu
 
-
 config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
-- 
2.32.0

