Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746CA4A6120
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbiBAQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:14:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240852AbiBAQOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:14:15 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDBF61EC0513;
        Tue,  1 Feb 2022 17:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643732049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u08dnbgx1LBEwbuQspydhnHsaYEH/sXoKrEPeTC84ow=;
        b=bGt5KmIjA4N9/cftFkiGy5w7NrP5jyW7uw980piWYO5hVeYMn352tlNlE4MiRaHRlCrp+k
        vHEtMfUCXBR8QQ+4DGo0nhNY20h5rhimkY11d59hG9rm9JsGBXanL54hMU8+xrLe8Bo4yW
        vpDPHQE5B/68HFeB+hPtPhe7AgrTFPw=
Date:   Tue, 1 Feb 2022 17:14:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     dave.hansen@intel.com, jpoimboe@redhat.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        sdeep@vmware.com, seanjc@google.com, tglx@linutronix.de,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCHv2.1 08/29] x86/tdx: Handle in-kernel MMIO
Message-ID: <YflcTVWWZQzDD25X@zn.tnic>
References: <12fb2758-8c06-8ab8-03d8-d77bd1edfce1@intel.com>
 <20220124230432.78003-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124230432.78003-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:04:32AM +0300, Kirill A. Shutemov wrote:
> MMIO addresses can be used with any CPU instruction that accesses
> memory. This patch, however, covers only MMIO accesses done via io.h

Just like the last time:

s/This patch, however, covers only/Address only/

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> helpers, such as 'readl()' or 'writeq()'.
> 
> readX()/writeX() helpers limit the range of instructions which can trigger
> MMIO. It makes MMIO instruction emulation feasible. Raw access to MMIO

"Raw access to a MMIO region allows the compiler to ..."

> region allows compiler to generate whatever instruction it wants.
> Supporting all possible instructions is a task of a different scope
								     ^
								     . Fullstop


...

> @@ -149,6 +151,111 @@ static bool tdx_handle_cpuid(struct pt_regs *regs)
>  	return true;
>  }
>  
> +static int tdx_mmio(int size, bool write, unsigned long addr,
> +		     unsigned long *val)

You don't need to break that line.

Rest LGTM.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
