Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78CC4D91EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbiCOBE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbiCOBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:04:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0767B1704A;
        Mon, 14 Mar 2022 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306173; x=1678842173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=j5Z7W/eNDFVp1vn/RhufUi3FFCeP2bMVKDVUk+7YP/M=;
  b=eh6iMJlXaYA8pBLOUe2Q9gS56zLnEjUj8Od9rMVv1+KbqikytLb2oo5Y
   V8DShSotiOzk4O4ryCK3rv+Gt77iMlyzQOP41/CGylep2x0/c626Mh12b
   6alMiVHgZPH6bIRMCOnPspGIDBUAU77oTv2dv25+Sxk2tC2uSHQweIV4h
   wmA9fN0JAZSN4AWuxsfI9pgcEd+P+1eB0SW5o4J6EYm3vXcGrOcZn2h5Z
   2M5hawFo1F6RZn82NT9KPVny13mLdkpCTrGdb3/IzxnBXODX6aosa8NEK
   IaDzA3jTfhwLF75pZhd6xw0NzI8ALoZVf5kvovPxY0p6Hnlu0fvFgrMaw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912379"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912379"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669381"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:51 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 09/10] x86/cpu: Call ENCLS[EUPDATESVN] procedure in microcode update
Date:   Tue, 15 Mar 2022 09:02:59 +0800
Message-Id: <20220315010300.10199-10-cathy.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315010300.10199-1-cathy.zhang@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EUPDATESVN is the SGX instruction which allows enclave attestation
to include information about updated microcode without a reboot.

Microcode updates which affect SGX require two phases:

1. Do the main microcode update
2. Make the new CPUSVN available for enclave attestation via
   EUPDATESVN.

Before a EUPDATESVN can succeed, all enclave pages (EPC) must be
marked as unused in the SGX metadata (EPCM). This operation destroys
all preexisting SGX enclave data and metadata. This is by design and
mitigates the impact of vulnerabilities that may have compromised
enclaves or the SGX hardware itself prior to the update.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>

---
Changes since v1:
 - Remove the sysfs file svnupdate. (Thomas Gleixner, Dave Hansen)
 - Let late microcode load path call ENCLS[EUPDATESVN] procedure
   directly. (Borislav Petkov)
 - Redefine update_cpusvn_intel() to return void instead of int.
---
 arch/x86/include/asm/microcode.h |  5 +++++
 arch/x86/include/asm/sgx.h       |  5 +++++
 arch/x86/kernel/cpu/common.c     |  9 +++++++++
 arch/x86/kernel/cpu/sgx/main.c   | 12 ++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index d6bfdfb0f0af..1ba66b9fe198 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_MICROCODE_H
 
 #include <asm/cpu.h>
+#include <asm/sgx.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
 
@@ -137,4 +138,8 @@ static inline void load_ucode_ap(void)				{ }
 static inline void reload_early_microcode(void)			{ }
 #endif
 
+#ifndef update_cpusvn_intel
+static inline void update_cpusvn_intel(void) {}
+#endif
+
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index d5942d0848ec..d0f2832a57b3 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -412,4 +412,9 @@ int sgx_virt_einit(void __user *sigstruct, void __user *token,
 int sgx_set_attribute(unsigned long *allowed_attributes,
 		      unsigned int attribute_fd);
 
+#ifdef CONFIG_X86_SGX
+void update_cpusvn_intel(void);
+#define update_cpusvn_intel update_cpusvn_intel
+#endif
+
 #endif /* _ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 64deb7727d00..514e621f04c3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/sgx.h>
 
 #include "cpu.h"
 
@@ -2165,6 +2166,14 @@ void microcode_check(void)
 
 	perf_check_microcode();
 
+	/*
+	 * SGX related microcode update requires EUPDATESVN to update CPUSVN, which
+	 * will destroy all enclaves to ensure EPC is not in use. If SGX is configured
+	 * and EUPDATESVN is supported, call the EUPDATESVN procecure.
+	 */
+	if (IS_ENABLED(CONFIG_X86_SGX) && (cpuid_eax(SGX_CPUID) & SGX_CPUID_EUPDATESVN))
+		update_cpusvn_intel();
+
 	/* Reload CPUID max function as it might've changed. */
 	info.cpuid_level = cpuid_eax(0);
 
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 123818fa2386..d86745d8cc7d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1380,3 +1380,15 @@ static int sgx_updatesvn(void)
 
 	return ret;
 }
+
+void update_cpusvn_intel(void)
+{
+	sgx_lock_epc();
+	if (sgx_zap_pages())
+		goto out;
+
+	sgx_updatesvn();
+
+out:
+	sgx_unlock_epc();
+}
-- 
2.17.1

