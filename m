Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6D58978E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbiHDFww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiHDFwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:52:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92502606AA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659592369; x=1691128369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WWJ2nxf8DmAoNTiMy7J5Jl0UJtHRXxyUfURlVtvvZ/k=;
  b=mnyKPNY0FV6A8xNkGOn9cl5rAJ4EoN0SOXQ5WZN278Kxn95kpL7rVbUr
   UXqUH4ZrroxD8H7TTsqnkzfsfKCtgPpwfYlXESSyzaFESME3sctHoBuys
   uJ2CBHCYAcVL+ZrvV5h1isu2zelkonp4C8A+MEGfaFuxfW7oAr4t6EnGw
   S4BEM8+SyFfENZqYRMzTUs4qeg9qaQXFyS/gdEqe411FwRWiy2fcgFh0u
   VIE2cY0h68A66sTvRNQe6Ze9zgqvMJPudFFN9mtz/PcZTPkuKICsz/uX+
   RXk9XF/Ha9Nmabeus47nU8JhOfowLCVyf5SEtc5xWHiZcY56O+rLrJij2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="287407994"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="287407994"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 22:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="553592910"
Received: from louislifei-optiplex-7090.sh.intel.com ([10.239.146.218])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 22:52:46 -0700
From:   Fei Li <fei1.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        yu1.wang@intel.com, conghui.chen@intel.com, fei1.li@intel.com
Subject: [PATCH] x86/acrn: Set up timekeeping
Date:   Thu,  4 Aug 2022 13:59:03 +0800
Message-Id: <20220804055903.365211-1-fei1.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACRN Hypervisor reports timing information via CPUID leaf 0x40000010.
Get the TSC and CPU frequency via CPUID leaf 0x40000010 and set the
kernel values accordingly.

Signed-off-by: Fei Li <fei1.li@intel.com>
Reviewed-by: Conghui <conghui.chen@intel.com>
---
 arch/x86/include/asm/acrn.h | 14 ++++++++++++++
 arch/x86/kernel/cpu/acrn.c  |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index e003a01b7c67..1dd14381bcb6 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -10,6 +10,15 @@
 /* Bit 0 indicates whether guest VM is privileged */
 #define	ACRN_FEATURE_PRIVILEGED_VM	BIT(0)
 
+/*
+ * Timing Information.
+ * This leaf returns the current TSC frequency in kHz.
+ *
+ * EAX: (Virtual) TSC frequency in kHz.
+ * EBX, ECX, EDX: RESERVED (reserved fields are set to zero).
+ */
+#define ACRN_CPUID_TIMING_INFO		0x40000010
+
 void acrn_setup_intr_handler(void (*handler)(void));
 void acrn_remove_intr_handler(void);
 
@@ -21,6 +30,11 @@ static inline u32 acrn_cpuid_base(void)
 	return 0;
 }
 
+static inline unsigned long acrn_get_tsc_khz(void)
+{
+	return cpuid_eax(ACRN_CPUID_TIMING_INFO);
+}
+
 /*
  * Hypercalls for ACRN
  *
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 23f5f27b5a02..485441b7f030 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -28,6 +28,9 @@ static void __init acrn_init_platform(void)
 {
 	/* Setup the IDT for ACRN hypervisor callback */
 	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
+
+	x86_platform.calibrate_tsc = acrn_get_tsc_khz;
+	x86_platform.calibrate_cpu = acrn_get_tsc_khz;
 }
 
 static bool acrn_x2apic_available(void)

base-commit: e0dccc3b76fb35bb257b4118367a883073d7390e
-- 
2.34.1

