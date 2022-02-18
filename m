Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D974BBD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiBRQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:17:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiBRQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF3022518
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201033; x=1676737033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o7VDf0nJv0XlRbUzs4IaCYJuN/W3ueBazitrj9bCGEQ=;
  b=UHBDb7/060JOat4hOTCukzG6JAIQ+WTxkpPJ7T3A8yLiW5D4ZvF/kHLU
   von9E+RgbvmbKHK9ks3t++qv0JxLfVVi5t7xgZTtASmCY7g3cU8ytYuJX
   Dqf76cPmLWGdj2Emt3W1XUnZx2DPJ8NPrSrcRtcEhvLx9FRcBC8ysl92A
   iVkFyZ9F48BotRFfyI/PHZxPR6PgG/bC2td4ivyaZj2l4pGoDqoiIV+Ah
   yIRIA8ONSSDCaV91NiM8/MRoRxkQ/ot5wT/YB66sNJaxXw/jkLAJVoeL4
   O26T5Q8l9W7BF82OlQBIj4naQCCQXgBDeA4Fsn/xpXnobks8KTWL7iP6D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231138278"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231138278"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="572355105"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2022 08:17:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 11C5E73; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCHv3 01/32] x86/mm: Fix warning on build with X86_MEM_ENCRYPT=y
Date:   Fri, 18 Feb 2022 19:16:47 +0300
Message-Id: <20220218161718.67148-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, AMD_MEM_ENCRYPT is the only user of X86_MEM_ENCRYPT. TDX will be
the second. It will make mem_encrypt.c build without AMD_MEM_ENCRYPT,
which triggers a warning:

arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for
	function 'mem_encrypt_init' [-Wmissing-prototypes]

Fix it by moving mem_encrypt_init() declaration outside of #ifdef
CONFIG_AMD_MEM_ENCRYPT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 20f07a044a76 ("x86/sev: Move common memory encryption code to mem_encrypt.c")
Acked-by: David Rientjes <rientjes@google.com>
---
 arch/x86/include/asm/mem_encrypt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index e2c6f433ed10..88ceaf3648b3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -49,9 +49,6 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void __init sev_es_init_vc_handling(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -89,6 +86,9 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void);
+
 /*
  * The __sme_pa() and __sme_pa_nodebug() macros are meant for use when
  * writing to or comparing values from the cr3 register.  Having the
-- 
2.34.1

