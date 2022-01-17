Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886CF491051
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiAQScy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:32:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236207AbiAQScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:32:53 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D6B11EC0531;
        Mon, 17 Jan 2022 19:32:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642444368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tMYLEKtwmKZnMDQqe7i5oMHWWonGj1KvrD1gDeyu4sQ=;
        b=DD48inKHSf6nNdN24Lltg/F/tclIN08m5nZO3lL4pVJWodmJrKBqdWSw6Ec/RnW5EhOkax
        jYMyYxxv03sWTWvT5knpRylIUrwLaz9cTCtF8B7E6HopMStP5E1aTXIMiPzhg6d0tbpq50
        Nr0oLbTkjaxMRU+V0KxX+A+ujD0cSpA=
Date:   Mon, 17 Jan 2022 19:32:51 +0100
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <YeW2U9vH65NcLHtY@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
 <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 05:39:20PM +0300, Kirill A. Shutemov wrote:
> arch/x86/boot and arch/x86/boot/compressed are separate linking domains.
> boot/ uses own implementation while boot/compressed uses implementation
> from <asm/io.h>. Decopliing boot/compressed from <asm/io.h> requires hack.
> See #define _ACPI_IO_H_ below.

I am painfully aware. And the need to share code with kernel proper has
grown quite the nasties in the meantime.

So, we talked about what to do here recently and the suggestion was to
librarize common functionality so that

1. it can be shared between the two.
2. changes in the kernel proper headers do not break the boot stubs.

So, instead of yet another duplication, I think what we should do is
start growing a shared/ header namespace, i.e.,

arch/x86/include/asm/shared/

for example, and put there common, well, shared, functionality between
boot stubs and kernel proper. Stuff which is basic and generic enough so
that it can be shared by both.

That would be a prepatch.

Then, ontop, I'm wondering if it would be cleaner to have in/out
function pointers in the boot stub which are assigned by default to
those __in/__out generic shared handlers and then early_tdx_detect()
would assign to them tdx_io_{in,out} when it detects it is running as a
TDX guest.

Hmmm...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
