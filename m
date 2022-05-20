Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF952EDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350044AbiETOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiETN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:59:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0731061631;
        Fri, 20 May 2022 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653055195; x=1684591195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UEij5xiezDoVf9uAqUDOLlsI0A2NNtQUjynutPVKIq8=;
  b=MyU7Ko82oXA2EL/CfTNfIYl1BKpny39NWrOdGoyRGgRIQM+51agVSvbz
   2fxRHd6j79UCnQn2tfwTY7Yp+CIOu5frCbDhCPLxAUQVNojoHmtwRb/zS
   h65OIxGsXIiar1jQDjVzkrZkbtZP56gCq9ERTW/LVW7Qp/xZCLraEBYKN
   o5oJHGnKMyn833LjrTwVztOovviUEvvnLPxWVjJm/iLLMfYhZirKQ8lOl
   KR77I5cunVclBjvMCc4voPhzEGzQfOmbgOBtc7oLsaVU/TE2GdDrCYWev
   fV6XXCKNcih7qyM+N/a5HzKwDRjmoqoa8nK0GpC8shABI2P7qQlzYC6lH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="252497313"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="252497313"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="662269862"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 May 2022 06:59:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2E69B109; Fri, 20 May 2022 16:59:52 +0300 (EEST)
Date:   Fri, 20 May 2022 16:59:52 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [PATCH] x86/tdx: Fix tdx asm
Message-ID: <20220520135952.umeymprcfrkkc4wt@black.fi.intel.com>
References: <20220405232939.73860-4-kirill.shutemov@linux.intel.com>
 <164946766187.4207.15170758896351389068.tip-bot2@tip-bot2>
 <20220520083839.GR2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520083839.GR2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 10:38:39AM +0200, Peter Zijlstra wrote:
> On Sat, Apr 09, 2022 at 01:27:41AM -0000, tip-bot2 for Kuppuswamy Sathyanarayanan wrote:
> > +SYM_FUNC_START(__tdx_module_call)
> > +	FRAME_BEGIN
> > +	TDX_MODULE_CALL host=0
> > +	FRAME_END
> > +	ret
> > +SYM_FUNC_END(__tdx_module_call)
> 
> > +SYM_FUNC_START(__tdx_hypercall)
> 
> > +
> > +	retq
> > +.Lpanic:
> > +	call __tdx_hypercall_failed
> > +	/* __tdx_hypercall_failed never returns */
> > +	jmp .Lpanic
> > +SYM_FUNC_END(__tdx_hypercall)
> 
> :-(
> 
> ---
> Subject: x86/tdx: Fix tdx asm
> 
> Because build-testing is over-rated, a few trivial objtool complaints:
> 
>   vmlinux.o: warning: objtool: __tdx_module_call+0x3e: missing int3 after ret
>   vmlinux.o: warning: objtool: __tdx_hypercall+0x6e: missing int3 after ret
> 
> Fixes: eb94f1b6a70a ("x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Oopsie :(

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> ---
>  arch/x86/coco/tdx/tdcall.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
> index eeb4511dc414..f9eb1134f22d 100644
> --- a/arch/x86/coco/tdx/tdcall.S
> +++ b/arch/x86/coco/tdx/tdcall.S
> @@ -73,7 +73,7 @@ SYM_FUNC_START(__tdx_module_call)
>  	FRAME_BEGIN
>  	TDX_MODULE_CALL host=0
>  	FRAME_END
> -	ret
> +	RET
>  SYM_FUNC_END(__tdx_module_call)
> 
>  /*
> @@ -196,7 +196,7 @@ SYM_FUNC_START(__tdx_hypercall)
> 
>  	FRAME_END
> 
> -	retq
> +	RET
>  .Lpanic:
>  	call __tdx_hypercall_failed
>  	/* __tdx_hypercall_failed never returns */
> 

-- 
 Kirill A. Shutemov
