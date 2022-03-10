Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D444D53E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbiCJVto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiCJVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:49:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF19ECC5A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646948918; x=1678484918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qqgAJpkBaj0Ci2Ldzpf/p1oTvGcM8YnhIO04LX1V4q8=;
  b=BakhkS485FDf5lnpv6aIB024lb2AN4P8QDWcvvuqL/QvWdeOOXcyfgap
   RsYiOxmSeE5XSb1DLAiT06C90VgHWK0axkLmBVGa5ejVY8VfPOsE5/zXl
   Vv2OGFpZ/8k3fCafL99zzA80OHiwPiNlPbYXtPMyqzjC14p3tVUMaVxMn
   jAGHpj3waBL8+bEQ+IR5Loq7XbLFO+3AGDFhPhYwj09f7ijTKu4l2OmAQ
   mbs+D47St5KahOKlXVsBkPhnXNbFX/4CBuhpnG69OZ5N+mQwBaag9tZzf
   P50Img+8FWNjBqNCZyZJCyKNuUCoiu0DVkdU1qlrjm0T6i8RXGF2w4Ac5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237560617"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="237560617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:48:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="514171522"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2022 13:48:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0A562107; Thu, 10 Mar 2022 23:48:28 +0200 (EET)
Date:   Fri, 11 Mar 2022 00:48:28 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 03/30] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20220310214828.52etbjdo6ha3vozx@black.fi.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
 <YioZnTYahkoy2Mxz@zn.tnic>
 <20220310212059.6abpmnsgodqqqnfm@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310212059.6abpmnsgodqqqnfm@black.fi.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
> > > +	/*
> > > +	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
> > > +	 * something has gone horribly wrong with the TDX module.
> > > +	 *
> > > +	 * The return status of the hypercall operation is in a separate
> > > +	 * register (in R10). Hypercall errors are a part of normal operation
> > > +	 * and are handled by callers.
> > > +	 */
> > > +	testq %rax, %rax
> > > +	jne .Lpanic
> > 
> > Hm, can this call a C function which does the panic so that a proper
> > error message is dumped to the user so that at least she knows where the
> > panic comes from?
> 
> Sure we can. But it would look somewhat clunky.

Here how it can look like. Is it what you want?

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index f00fd3a39b64..b26eab2c3c59 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -3,6 +3,7 @@
 #include "../cpuflags.h"
 #include "../string.h"
 #include "../io.h"
+#include "error.h"

 #include <vdso/limits.h>
 #include <uapi/asm/vmx.h>
@@ -16,6 +17,11 @@ bool early_is_tdx_guest(void)
 	return tdx_guest_detected;
 }

+void __tdx_hypercall_failed(void)
+{
+	error("TDVMCALL failed. TDX module bug?");
+}
+
 static inline unsigned int tdx_io_in(int size, u16 port)
 {
 	struct tdx_hypercall_args args = {
diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 22832f19df2c..f39de4b01a9c 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -197,5 +197,5 @@ SYM_FUNC_START(__tdx_hypercall)

 	retq
 .Lpanic:
-	ud2
+	call __tdx_hypercall_failed
 SYM_FUNC_END(__tdx_hypercall)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8e19694d33e2..29fc5941b80c 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -53,6 +53,11 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 	return __tdx_hypercall(&args, 0);
 }

+void __tdx_hypercall_failed(void)
+{
+	panic("TDVMCALL failed. TDX module bug?");
+}
+
 /*
  * The TDG.VP.VMCALL-Instruction-execution sub-functions are defined
  * independently from but are currently matched 1:1 with VMX EXIT_REASONs.
-- 
 Kirill A. Shutemov
