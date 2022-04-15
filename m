Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8B503143
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356301AbiDOWEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiDOWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:04:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B62A278;
        Fri, 15 Apr 2022 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650060091; x=1681596091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4jrQfGzOOz8NYN3WWxiP4ysiHxJPzuBRgwyiKBFv+oo=;
  b=DrD8wg5aUCfBgemjiurqYSfVJ2uJzxi6AmMwDysWkH+8Olz1HSpO0RZA
   jkLcfWxDG+3iMNlg3Qg92m+nAzca5N67Spk0EgeP8a2EjsfxDjWOuiiUS
   GUUn9/WA3KnQvxKCXEUB3DKAlWQAxcrxA9su7ifWj4vNks5y89aR4wwZ2
   HrgZvAFcyxwNrozPg8m5/TQR0YSSzp36COpvYP38Q5xm9RVekb6yR+S9H
   9CONNJ4H2j3/J64cc1UipvoO+kBGCzYknYO+D9QZzUjGBAQ32QLeB+8Y+
   EtJJl/+w2XhEtKjZtiGzLG/zeU4K8n+dQ6gjrzxSqstbftjRhKe8ue+vR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="288303530"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="288303530"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="612949090"
Received: from smashtou-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.128.210])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:29 -0700
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
Subject: [PATCH v3 1/4] x86/tdx: Add tdx_mcall_tdreport() API support
Date:   Fri, 15 Apr 2022 15:01:06 -0700
Message-Id: <20220415220109.282834-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
 arch/x86/coco/tdx/tdx.c    | 46 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 03deb4d6920d..3e409b618d3f 100644
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
@@ -34,6 +36,10 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+/* TDX Module call error codes */
+#define TDCALL_RETURN_CODE_MASK		0xffffffff00000000
+#define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,6 +104,46 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
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
+long tdx_mcall_tdreport(void *data, void *reportdata)
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
+	if (ret)
+		return TDCALL_RETURN_CODE(ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a7c729..a151f69dd6ef 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+long tdx_mcall_tdreport(void *data, void *reportdata);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.25.1

