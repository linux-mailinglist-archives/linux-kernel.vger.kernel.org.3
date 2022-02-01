Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08C44A683D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242197AbiBAWxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:53:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiBAWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:53:29 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643756008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UKpogTyMTQbCLa6Swh1U7pKphU59nS9oRkx0NlHefU=;
        b=S/0ORMRsIWkKxl0Ghor8KuZ1NXHlgqE52MUjHSJTGQHLHA7rVAm1n5/KTEm52XhJBgEJUY
        6Cu8OOzCb/98gWR/O9s/dPKk1Ten1x3EO58mG2TeMwX5M6EQ5X+ZA3BO77lfoEcPu62d81
        o+xfH6ao+Brrn3pRcsLS2v90fjwHUeTkSV2FnnkXyb6CxnFaeN/lddufqBsBjf/RlyvrYc
        im5h6wprKv2ATghMgzM/YZaB6PkU+YtawyUtxo7M0hwLVmXdSmqFY3PtKymHaC9ZraGt3Y
        rlzAl7d3QCOM+8eWDWnL3Mk/my2VWVMKKZfcV1Oxy5KQmD5QmYzRVFn86X2Oew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643756008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UKpogTyMTQbCLa6Swh1U7pKphU59nS9oRkx0NlHefU=;
        b=bfo83/Ft3MVKuFcbcFO7gnJ6kA3SCbemDb47fYAKh2NsiaDbEf2bCdT7l91Z2oYYBrrpfB
        du58gvdX8yKp78Ag==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 11/29] x86/boot: Allow to hook up alternative port I/O
 helpers
In-Reply-To: <87k0eexlde.ffs@tglx>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-12-kirill.shutemov@linux.intel.com>
 <87k0eexlde.ffs@tglx>
Date:   Tue, 01 Feb 2022 23:53:28 +0100
Message-ID: <87ee4mxkpj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01 2022 at 23:39, Thomas Gleixner wrote:

> On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
>
>> Port I/O instructions trigger #VE in the TDX environment. In response to
>> the exception, kernel emulates these instructions using hypercalls.
>>
>> But during early boot, on the decompression stage, it is cumbersome to
>> deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
>> handling.
>>
>> Add a way to hook up alternative port I/O helpers in the boot stub.
>> All port I/O operations are routed via 'pio_ops'. By default 'pio_ops'
>> initialized with native port I/O implementations.
>>
>> This is a preparation patch. The next patch will override 'pio_ops' if
>> the kernel booted in the TDX environment.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> Aside of Borislav's comments:
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Second thoughts.

> +#include <asm/shared/io.h>
> +
> +struct port_io_ops {
> +	unsigned char (*inb)(int port);
> +	unsigned short (*inw)(int port);
> +	unsigned int (*inl)(int port);
> +	void (*outb)(unsigned char v, int port);
> +	void (*outw)(unsigned short v, int port);
> +	void (*outl)(unsigned int v, int port);
> +};

Can we please make that u8, u16, u32 instead of unsigned char,short,int?

That's the kernel convention for hardware related functions for many
years now.

Thanks,

        tglx
