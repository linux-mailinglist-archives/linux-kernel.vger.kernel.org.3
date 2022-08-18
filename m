Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07359846C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbiHRNlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbiHRNkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:40:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C5EA6C0F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:40:05 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 045341EC0629;
        Thu, 18 Aug 2022 15:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660829999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zwPlC5rl838F3z1Af5qijAM7dgfF+8E3ih+zEH2G/fc=;
        b=hh2VA3um5AUKWqT+5TojJMSAm2qQPvZQhWSkGSVFiL64dVvVRAlof5c46Yi8vIql5atOrj
        EUes+8eLbXmDv3Yohj3AHoPJOHC/yfmiiAzwxCVSxbbggYCl9WgVmvHRHOvCpsUCjL2KDE
        7OLG9TVuyTwA7NROu4qsrctiuF50dlQ=
Date:   Thu, 18 Aug 2022 15:39:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/2] x86/sev: Add SNP-specific unaccepted memory
 support
Message-ID: <Yv5BKgbwNC2WY2/+@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1660579062.git.thomas.lendacky@amd.com>
 <202f4e1ed9fc585f503da57cb8a8dd35e83758d1.1660579062.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202f4e1ed9fc585f503da57cb8a8dd35e83758d1.1660579062.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:57:43AM -0500, Tom Lendacky wrote:
> Add SNP-specific hooks to the unaccepted memory support in the boot
> path (__accept_memory()) and the core kernel (accept_memory()) in order
> to support booting SNP guests when unaccepted memory is present. Without
> this support, SNP guests will fail to boot and/or panic() when unaccepted
> memory is present in the EFI memory map.
> 
> The process of accepting memory under SNP involves invoking the hypervisor
> to perform a page state change for the page to private memory and then
> issuing a PVALIDATE instruction to accept the page.
> 
> Create the new header file arch/x86/boot/compressed/sev.h because adding
> the function declaration to any of the existing SEV related header files
> pulls in too many other header files, causing the build to fail.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/Kconfig                |  1 +
>  arch/x86/boot/compressed/mem.c  |  3 +++
>  arch/x86/boot/compressed/sev.c  | 10 +++++++++-
>  arch/x86/boot/compressed/sev.h  | 23 +++++++++++++++++++++++
>  arch/x86/include/asm/sev.h      |  3 +++
>  arch/x86/kernel/sev.c           | 16 ++++++++++++++++
>  arch/x86/mm/unaccepted_memory.c |  4 ++++
>  7 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/boot/compressed/sev.h

Looks mostly ok to me...

> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 730c4677e9db..d4b06c862094 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -115,7 +115,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> -static inline bool sev_snp_enabled(void)
> +bool sev_snp_enabled(void)
>  {
>  	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>  }

This is another one of my pet peeves and now it even gets exported but
it is the early decompressor crap so I won't even try to mention cc_*
helpers...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
