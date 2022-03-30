Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17E84ECF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351563AbiC3WUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351524AbiC3WU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:20:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681C26567;
        Wed, 30 Mar 2022 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648678720; x=1680214720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6Su9gEZZpLP5r4KSP0gYOEU6AbFcQ8ZX11qIxT+1j8=;
  b=Hqi5ZQPLyTC9wuRwAVq2g+LpHC8yFvKy427SQyDz7x2ZJP8QkS7X9RRg
   vdQF1xWHIuwzRg5aHRAlA7eyUbPZXFA3BHaq2CdqS9CzKqubcWbYXzV3+
   yAGU+wJ8kSdgX6ZPNzlBxSiAoK0vKBVMzaVYOKgVQHcnHosQCPJnTZzdd
   aEckEYDO8zjF12Yo9YS4h5QHZ548ays02WfLEJLW9lkrhiCUgTgL+rb1S
   u63wazQjjE0Hvh8CWIch7r06ORCwTR2GDyJhZDr7cyUPWB7vNR/sSdi0T
   9R3BQRvg5ZRbGLBJ9VtQRgARbjwh8OZgx553bYddcKto4wN4/zeOGUS4J
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241811852"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241811852"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788171869"
Received: from ksanitha-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.123.221])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:22 -0700
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
Subject: [PATCH v2 2/6] x86/tdx: Add tdx_hcall_get_quote() API support
Date:   Wed, 30 Mar 2022 15:18:01 -0700
Message-Id: <4ebf6b5c5676718f115e29c9fd34bc11f0c3a799.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
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

Attestation is the process used by two un-trusted entities to prove to
each other that it can be trusted. In TDX guest, attestation is mainly
used to verify the trustworthiness of a TD to the 3rd party key
servers.

First step in the attestation process is to generate the TDREPORT data.
This support is added using tdx_mcall_tdreport() API. The second stage
in the attestation process is for the guest to request the VMM generate
and sign a quote based on the TDREPORT acquired earlier. More details
about the steps involved in attestation process can be found in TDX
Guest-Host Communication Interface (GHCI) for Intel TDX 1.5, section
titled "TD attestation"

Add tdx_hcall_get_quote() helper function to implement the GetQuote
hypercall.

More details about the GetQuote TDVMCALL are in the Guest-Host
Communication Interface (GHCI) Specification, sec 3.3, titled
"VP.VMCALL<GetQuote>".

This will be used by the TD attestation driver in follow-on patches.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c    | 47 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3721e357262e..54b54e321c63 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -21,6 +21,7 @@
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
+#define TDVMCALL_GET_QUOTE		0x10002
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -42,6 +43,10 @@
 #define TDCALL_INVALID_OPERAND		0x8000000000000000
 #define TDCALL_OPERAND_BUSY		0x8000020000000000
 
+/* TDX hypercall error codes */
+#define TDVMCALL_GET_QUOTE_ERR		0x8000000000000000
+#define TDVMCALL_GET_QUOTE_QGS_UNAVIL	0x8000000000000001
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -151,6 +156,48 @@ int tdx_mcall_tdreport(void *data, void *reportdata)
 }
 EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
 
+/*
+ * tdx_hcall_get_quote() - Generate TDQUOTE using TDREPORT_STRUCT.
+ *
+ * @data        : Address of 8KB GPA memory which contains
+ *                TDREPORT_STRUCT.
+ * @len		: Length of the GPA in bytes.
+ *
+ * return 0 on success or failure error number.
+ */
+int tdx_hcall_get_quote(void *data, u64 len)
+{
+	u64 ret;
+
+	/*
+	 * Use confidential guest TDX check to ensure this API is only
+	 * used by TDX guest platforms.
+	 */
+	if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return -EINVAL;
+
+	/*
+	 * Pass the physical address of tdreport data to the VMM
+	 * and trigger the tdquote generation. Quote data will be
+	 * stored back in the same physical address space. More info
+	 * about ABI can be found in TDX Guest-Host-Communication
+	 * Interface (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
+	 */
+	ret = _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(data)),
+			     len, 0, 0);
+
+	if (ret) {
+		if (ret == TDVMCALL_GET_QUOTE_ERR)
+			return -EINVAL;
+		else if (ret == TDVMCALL_GET_QUOTE_QGS_UNAVIL)
+			return -EBUSY;
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 343fd8b17e66..23c5023704a3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -68,6 +68,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_tdreport(void *data, void *reportdata);
 
+int tdx_hcall_get_quote(void *data, u64 len);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.25.1

