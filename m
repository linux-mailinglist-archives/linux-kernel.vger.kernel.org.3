Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AFB52E7C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiETIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbiETIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:38:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BDC9E9E6;
        Fri, 20 May 2022 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pxggZUUsNsOcqH9iLg2oJLg6WmEmCBTVD52cAZNze7E=; b=f18j+M0/1MTZ6wPOZo6o/pbIpZ
        QzyvPytWu44BPAqWPQbCGV6YNYjcGXnjo2o0+OIuladBTSprxtvid50mc+NjW1icENd1wy/pv6ezs
        ESlixUCnaL2mDjsFRyxU/D5/YHzld+kkcfdHxUBEt2U3r/rvz1lJsmgf4tXG/OqGTEZcjML+93PH8
        83fR4Oh5zqPMs4rFyj+v5pYotCPtrM2Ip/PLQnTjqdrc3ARPyVAfqJrRe3PU0NjXYQC7AFuendUeX
        yJuPtxE098+fnmKIiaxZQMMQdpVLeZVUD/9YCCiBsONRBmushSEqyWVF6VXh5zhW0il3QD2puRwtX
        WFXcnqaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nry9f-002HFc-Hw; Fri, 20 May 2022 08:38:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 145B4980E7F; Fri, 20 May 2022 10:38:39 +0200 (CEST)
Date:   Fri, 20 May 2022 10:38:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: [PATCH] x86/tdx: Fix tdx asm
Message-ID: <20220520083839.GR2578@worktop.programming.kicks-ass.net>
References: <20220405232939.73860-4-kirill.shutemov@linux.intel.com>
 <164946766187.4207.15170758896351389068.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164946766187.4207.15170758896351389068.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 01:27:41AM -0000, tip-bot2 for Kuppuswamy Sathyanarayanan wrote:
> +SYM_FUNC_START(__tdx_module_call)
> +	FRAME_BEGIN
> +	TDX_MODULE_CALL host=0
> +	FRAME_END
> +	ret
> +SYM_FUNC_END(__tdx_module_call)

> +SYM_FUNC_START(__tdx_hypercall)

> +
> +	retq
> +.Lpanic:
> +	call __tdx_hypercall_failed
> +	/* __tdx_hypercall_failed never returns */
> +	jmp .Lpanic
> +SYM_FUNC_END(__tdx_hypercall)

:-(

---
Subject: x86/tdx: Fix tdx asm

Because build-testing is over-rated, a few trivial objtool complaints:

  vmlinux.o: warning: objtool: __tdx_module_call+0x3e: missing int3 after ret
  vmlinux.o: warning: objtool: __tdx_hypercall+0x6e: missing int3 after ret

Fixes: eb94f1b6a70a ("x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/coco/tdx/tdcall.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index eeb4511dc414..f9eb1134f22d 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -73,7 +73,7 @@ SYM_FUNC_START(__tdx_module_call)
 	FRAME_BEGIN
 	TDX_MODULE_CALL host=0
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(__tdx_module_call)

 /*
@@ -196,7 +196,7 @@ SYM_FUNC_START(__tdx_hypercall)

 	FRAME_END

-	retq
+	RET
 .Lpanic:
 	call __tdx_hypercall_failed
 	/* __tdx_hypercall_failed never returns */

