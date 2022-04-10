Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3A94FB030
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiDJUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiDJUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:40:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223A21E25
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 13:37:52 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD3881EC02B9;
        Sun, 10 Apr 2022 22:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649623066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V8ZzOUBL7xD1yUccl21XOGqXXja/Y5DnANuDg4EUg+4=;
        b=BPFkxgPstSR5/P/X7db6tYPIBiAI29xBlCNirXUz45ijMZbOcx9sErW8xObtt5DxNsLCys
        zFojJ8BOmAhMeiQobD9ofQvf/hHw1si52EEKeoOoT7Dn6WJQqTBvFXTeXWz0UIeqjsqTZR
        LsF6nbqaRR0J1nkGprDqD/kvq2YIq0w=
Date:   Sun, 10 Apr 2022 22:37:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 14/30] x86: Consolidate port I/O helpers
Message-ID: <YlNAGcXS1fmTu/WS@zn.tnic>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
 <20220405232939.73860-15-kirill.shutemov@linux.intel.com>
 <YlK4SYXV6zbDa1Lq@zn.tnic>
 <20220410200025.3stf4jjvwfe5oxew@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220410200025.3stf4jjvwfe5oxew@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 11:00:25PM +0300, Kirill A. Shutemov wrote:
> Right. <asm/shared/io.h> is enough for lib/kaslr.c.
> 
> What about this:
> 
> From 164de295599f8befa2ee1ff05dc03542c02b0800 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Sun, 10 Apr 2022 22:49:28 +0300
> Subject: [PATCH] x86/kaslr: Fix build warning in KASLR code in boot stub
> 
> lib/kaslr.c used by both the main kernel and the boot stub. It includes
> <asm/io.h> that intended to be used in the main kernel. It leads to
> build warnings like this:
> 
> 	warning: implicit declaration of function 'outl' is invalid in
> 	C99 [-Wimplicit-function-declaration]
> 
> Replace <asm/io.h> with <asm/shared/io.h> which is suitable for both
> cases.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 1e8f93e18379 ("x86: Consolidate port I/O helpers")

Reported-by: me

> ---
>  arch/x86/lib/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
> index 2b3eb8c948a3..a58f451a7dd3 100644
> --- a/arch/x86/lib/kaslr.c
> +++ b/arch/x86/lib/kaslr.c
> @@ -11,7 +11,7 @@
>  #include <asm/msr.h>
>  #include <asm/archrandom.h>
>  #include <asm/e820/api.h>
> -#include <asm/io.h>
> +#include <asm/shared/io.h>
>  
>  /*
>   * When built for the regular kernel, several functions need to be stubbed out
> -- 

Thanks, that works and looks nice too.

I'll queue it tomorrow.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
