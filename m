Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED947E7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhLWSxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:53:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhLWSxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:53:54 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8724C1EC052C;
        Thu, 23 Dec 2021 19:53:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640285629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AIazUNLO3p7a4oqusvv9ABmSmXcPzzPfbx/UFIVRn1g=;
        b=i1L8g/w79h+7xzZV5283d6HY/t3ByvUuIcvhG0vqxQxNJbWS8izcNWt8bACjiEEEzUWDKn
        mb1r0JjfvG35HcYzEHBRpJOLe+9HWY0iAJSG7T0GnWPpfH83fg7zes3BOex9vjWVhSlkFU
        ntHXhrh3nSxyEBN36u32Dv4m7HKKJiI=
Date:   Thu, 23 Dec 2021 19:53:50 +0100
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/26] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YcTFvoVMYSIxFIyX@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-4-kirill.shutemov@linux.intel.com>
 <YcIm8fngUsVulUoI@zn.tnic>
 <20211223165548.xr57h25g4diixivp@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223165548.xr57h25g4diixivp@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 07:55:48PM +0300, Kirill A. Shutemov wrote:
> What about this?
> 
> 	In a TDX based VM, since the VMM is an untrusted entity, an intermediary
> 	layer -- TDX module -- facilitates secure communication between the host
> 	and the guest. TDX module is loaded like a firmware into a special CPU
> 	mode called SEAM. TDX guests communicate with the TDX module using the
> 	TDCALL instruction.
> 
> Does it look fine?

Yap, thx.

> Ah, okay. I did not know about special treatment for .L labels.
> Again, will check whole patchset.

Yeah, those are local labels. From the gas manpage:

       -L
       --keep-locals
           Keep (in the symbol table) local symbols.  These symbols start with system-
           specific local label prefixes, typically .L for ELF systems or L for
           traditional a.out systems.

Apparently, one can even add own prefix for local labels too:

       -local-prefix=prefix
           Mark all labels with specified prefix as local. But such label can be marked
           global explicitly in the code. This option do not change default local label
           prefix ".L", it is just adds new one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
