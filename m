Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D784ECF89
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351555AbiC3WUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350829AbiC3WU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:20:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDEC22B32;
        Wed, 30 Mar 2022 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648678719; x=1680214719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kly4qeQAabhb76qO6g+KTLxtkuf1koGEHnFCcB0GO9Y=;
  b=cJAWcu61RdkTOtmye7YPFfbZoGJZYRp0MX/8vi449XRb39jztaztWoVd
   QBmYjjIhsSvj1LmI0Dmpm0qAwfykf1FHcthQjIUXD1eh+8sWP20N1Yoq8
   kfme+jhc68yZuWe0rUsx2W3i7hRUBINMsyC7mUfIqPnRP/kNDETMAGt8/
   aMXvFlXS46MayN0WEJN/ele3NSp+T7EJrlst/qU+h+V0klfjUzyYbk0Rs
   wIl+t9HpWxLOTaS/+O40OoTTSyx9qgUd1ENk2TTMkh6YJQYl9t940bfwK
   SBNlFkb8w48xzOb1nmVU1c56OtB5Ss4A1s/2jlnUzNqmwaiAzu47Axz4p
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241811847"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241811847"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788171863"
Received: from ksanitha-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.123.221])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:21 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 1/6] x86/tdx: Add tdx_mcall_tdreport() API support
Date:   Wed, 30 Mar 2022 15:18:00 -0700
Message-Id: <53663f824e7cfb09cb9bbb3dedfcb834f20ec64a.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
References: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guest, attestation is mainly used to verify the trustworthiness
of a TD to the 3rd party key servers. First step in attestation process
is to get the TDREPORT data and the generated data is further used in
subsequent steps of the attestation process. TDREPORT data contains
details like TDX module version information, measurement of the TD,
along with a TD-specified nonce

Add a wrapper function (tdx_mcall_tdreport()) to get the TDREPORT from
the TDX Module.

More details about the TDREPORT TDCALL can be found in TDX Guest-Host
Communication Interface (GHCI) for Intel TDX 1.5, section titled
"TDCALL [MR.REPORT]".

Steps involved in attestation process can be found in TDX Guest-Host
Communication Interface (GHCI) for Intel TDX 1.5, section titled
"TD attestation"

This API will be mainly used by the attestation driver. Attestation
driver support will be added by upcoming patches.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c    | 53 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index d509ea0ed601..3721e357262e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -11,10 +11,12 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/io.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
 
 /* TDX hypercall Leaf IDs */
@@ -34,6 +36,12 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+/* TDX Module call error codes */
+#define TDCALL_RETURN_CODE_MASK		0xffffffff00000000
+#define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
+#define TDCALL_INVALID_OPERAND		0x8000000000000000
+#define TDCALL_OPERAND_BUSY		0x8000020000000000
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,6 +106,51 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/*
+ * tdx_mcall_tdreport() - Generate TDREPORT_STRUCT using TDCALL.
+ *
+ * @data        : Address of 1024B aligned data to store
+ *                TDREPORT_STRUCT.
+ * @reportdata  : Address of 64B aligned report data
+ *
+ * return 0 on success or failure error number.
+ */
+int tdx_mcall_tdreport(void *data, void *reportdata)
+{
+	u64 ret;
+
+	/*
+	 * Check for a valid TDX guest to ensure this API is only
+	 * used by TDX guest platform. Also make sure "data" and
+	 * "reportdata" pointers are valid.
+	 */
+	if (!data || !reportdata || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return -EINVAL;
+
+	/*
+	 * Pass the physical address of user generated reportdata
+	 * and the physical address of out pointer to store the
+	 * TDREPORT data to the TDX module to generate the
+	 * TD report. Generated data contains measurements/configuration
+	 * data of the TD guest. More info about ABI can be found in TDX
+	 * Guest-Host-Communication Interface (GHCI), sec titled
+	 * "TDG.MR.REPORT".
+	 */
+	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(data),
+				virt_to_phys(reportdata), 0, 0, NULL);
+
+	if (ret) {
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+			return -EINVAL;
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_OPERAND_BUSY)
+			return -EBUSY;
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ea92641dd1f8..343fd8b17e66 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -66,6 +66,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+int tdx_mcall_tdreport(void *data, void *reportdata);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.25.1

