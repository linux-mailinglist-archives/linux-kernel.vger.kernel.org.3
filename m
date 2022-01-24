Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADDD4982F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiAXPDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:24561 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240334AbiAXPCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036556; x=1674572556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uav+UwLJTiQzJso3hjEQdqtULUSM2290C08sG/C0E5c=;
  b=i81tDKDNHkhJumD/BI+dj3j2K1JNMwNh1+/OywP64pNwBqIUpenAnh8U
   Iv5o9UFbp49L74E0M9nOFWiMatBJxgi1zFNiwsEdcgpwC9fY1RGsi40Hu
   trtPGvgeMQCpahuGY2Ctj4vq+SJ3kSCDAVWbX5Ah6pX9YvbAvniKbel9d
   8MDPdH+3GMhYNMwJ6CtW2ZCm7lDpAeibJfghOOvxSS4D6BaXdUdJlmVTX
   z/FCRXFMy89+zKad8Z4HssET1PWoj56sTWavEZ4J1joSRLebJw/9RRtly
   5unXHko86V83OKhFHRuvaOuXCB2krrRVhTbWB6wBIwUL/6IAs9kibVC4P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245843930"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245843930"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627523593"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 07:02:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AAC23DD9; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 28/29] x86/tdx: Warn about unexpected WBINVD
Date:   Mon, 24 Jan 2022 18:02:14 +0300
Message-Id: <20220124150215.36893-29-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WBINVD causes #VE in TDX guests. There's no reliable way to emulate it.
The kernel can ask for VMM assistance, but VMM is untrusted and can ignore
the request.

Fortunately, there is no use case for WBINVD inside TDX guests.

Warn about any unexpected WBINVD.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 6048887ac846..22c785c2059c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -530,6 +530,10 @@ static bool tdx_virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
 	case EXIT_REASON_IO_INSTRUCTION:
 		ret = tdx_handle_io(regs, ve->exit_qual);
 		break;
+	case EXIT_REASON_WBINVD:
+		WARN_ONCE(1, "Unexpected WBINVD\n");
+		ret = true;
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		break;
-- 
2.34.1

