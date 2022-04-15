Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3505030E3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355788AbiDOWEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356269AbiDOWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:04:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270FA35DE2;
        Fri, 15 Apr 2022 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650060093; x=1681596093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MFGHhgLkVammlMUcup3VFIj0qo6uQ1md0in8hWs4fk0=;
  b=aAQvBSlMRtbqBeDLsytxJbLWtLYsX70UPMlNjdMoOJzRG8XO/zbUuGTm
   WnDI8WzvLoQmlvvI0Q26jZQz9doSswnZWtZASvJ6iA0gEmfcZLokOtRT1
   oSceJMpeEmjEUfn+/2Qna6MaXRB5wtxKmDMdPJ5lKVZHz9Y+tEmN5p68J
   wYpHTPu8QRYx0gsRzYw1ti6GxxYzBSP+hKq4vIAbNq8GBOlC3SETszR8e
   7bucajJzVI4MXi2Z3QklYDkFzKybBteA9J3PVj8d/P+48LoMVBglQmzvE
   MgF+9ejNrOm4IjbEwH4ARo/VStc8o3L15wZeB4N3uVc22W01KIqyGkooP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="288303532"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="288303532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="612949094"
Received: from smashtou-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.128.210])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:30 -0700
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
Subject: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
Date:   Fri, 15 Apr 2022 15:01:07 -0700
Message-Id: <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/coco/tdx/tdx.c    | 38 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3e409b618d3f..c259d81a5d7f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -21,6 +21,7 @@
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
+#define TDVMCALL_GET_QUOTE		0x10002
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -144,6 +145,43 @@ long tdx_mcall_tdreport(void *data, void *reportdata)
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
+long tdx_hcall_get_quote(void *data, u64 len)
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
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a151f69dd6ef..014cc6192dc5 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -69,6 +69,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 long tdx_mcall_tdreport(void *data, void *reportdata);
 
+long tdx_hcall_get_quote(void *data, u64 len);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.25.1

