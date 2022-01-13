Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A851B48D950
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiAMNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:51:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50402 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbiAMNv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:51:57 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D3BB1EC04EC;
        Thu, 13 Jan 2022 14:51:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642081911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y8w94p+41spft2dqOu5To4130OIb6SsnTSnYHXl+Jb0=;
        b=BUxgTk1D+V/+5nko0eooqknopuO7YGIJUzbKaigQbd8pf/b2aToxr2vXskRFCFq65aenCT
        SiQG9Mt9HsjvRt1EDZGInLGJgMTuJEESFPXjD+BVUnGNpEZWybbCocnJLQnOk9CGMqaLxv
        +FlVK2leheswku/HyIHNkJH4PEFUgD8=
Date:   Thu, 13 Jan 2022 14:51:54 +0100
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
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <YeAuehoOEjUH3vZ3@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:48PM +0300, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Port IO triggers a #VE exception in TDX guests.  During normal runtime,
> the kernel will handle those exceptions for any port IO.
> 
> But for the early code in the decompressor, #VE cannot be used because
> the IDT needed for handling the exception is not set up.
							  ... yet.

Well, we're setting up and IDT twice in

arch/x86/boot/compressed/idt_64.c

as early as startup_64 for SEV. And the second stage one
do_boot_stage2_vc() handles port IO too.

Can't you hook in your VE handler there too?

> Replace IN/OUT instructions with TDX IO hypercalls by defining helper
> macros __in/__out and by re-defining them in the decompressor code.
> Also, since TDX IO hypercall requires an IO size parameter, allow
> __in/__out macros to accept size as an input parameter.

Please end function/macro names with parentheses. I think in this
particular case you wanna say

"__in*()/__out*() macros"

When a function is mentioned in the changelog, either the text body or the
subject line, please use the format 'function_name()'. Omitting the
brackets after the function name can be ambiguous::

  Subject: subsys/component: Make reservation_count static

  reservation_count is only used in reservation_stats. Make it static.

The variant with brackets is more precise::

  Subject: subsys/component: Make reservation_count() static

  reservation_count() is only called from reservation_stats(). Make it
  static.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
