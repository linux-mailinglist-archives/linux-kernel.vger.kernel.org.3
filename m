Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD84D9F76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbiCOP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiCOP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:59:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD44B1EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:58:34 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37D2C1EC0531;
        Tue, 15 Mar 2022 16:58:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647359908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lC8jcaGts7r1gdMNNH3SVw263gKeOh6pMHTZ9Q+Ob4w=;
        b=HlmIh0YB5agwSBo8lMcMAhj6VbkuvrMOsiZ+2Y6FM0m1kPYgMP7nIpW4JPRrJbCKsCQpqV
        09dtU8CVDJWRyYqdbltPq4B++L9jY1sIPo0U37kVnWchdY5xBVhRowjc/p7QacYIIYlvze
        XJAo/Wcot6q1p/SbkAbDN24mh06IZTE=
Date:   Tue, 15 Mar 2022 16:56:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Message-ID: <YjC3HuH7mrupwwwd@zn.tnic>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-4-kirill.shutemov@linux.intel.com>
 <YioZnTYahkoy2Mxz@zn.tnic>
 <20220310212059.6abpmnsgodqqqnfm@black.fi.intel.com>
 <20220310214828.52etbjdo6ha3vozx@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220310214828.52etbjdo6ha3vozx@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:48:28AM +0300, Kirill A. Shutemov wrote:
> Here how it can look like. Is it what you want?

Yap, that's better.

> diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
> index f00fd3a39b64..b26eab2c3c59 100644
> --- a/arch/x86/boot/compressed/tdx.c
> +++ b/arch/x86/boot/compressed/tdx.c
> @@ -3,6 +3,7 @@
>  #include "../cpuflags.h"
>  #include "../string.h"
>  #include "../io.h"
> +#include "error.h"
> 
>  #include <vdso/limits.h>
>  #include <uapi/asm/vmx.h>
> @@ -16,6 +17,11 @@ bool early_is_tdx_guest(void)
>  	return tdx_guest_detected;
>  }
> 
> +void __tdx_hypercall_failed(void)
> +{
> +	error("TDVMCALL failed. TDX module bug?");
> +}
> +
>  static inline unsigned int tdx_io_in(int size, u16 port)
>  {
>  	struct tdx_hypercall_args args = {


> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 8e19694d33e2..29fc5941b80c 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -53,6 +53,11 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>  	return __tdx_hypercall(&args, 0);
>  }
> 
> +void __tdx_hypercall_failed(void)
> +{
> +	panic("TDVMCALL failed. TDX module bug?");
> +}

Btw, if there's going to be more code duplication in TDX-land, I'd
suggest doing a shared file like

arch/x86/kernel/sev-shared.c

which you can include in both kernel stages.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
