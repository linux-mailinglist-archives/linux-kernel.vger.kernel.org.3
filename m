Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7F49564B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378059AbiATWT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:19:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347534AbiATWTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:19:20 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8EF11EC0495;
        Thu, 20 Jan 2022 23:19:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642717155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sm06uOifofySe0c77atH7w607/k9r2r372tihL26X3I=;
        b=fX2Z0BqPYajyprJw79CWSKVmEK/S9s5BKiGNX5IpHja2GjoJAhYh3APLamRPY1fc4zCaT4
        NZYC/UDPhsqKW0E+8ZPCwlR0Tr/3z/F/YF4UPWT2+RHVaQ1ky52Rthe0Ke10y9FOJOoPnu
        jz5OawPS1wdq7ofn7us1JHoW9YLA0VE=
Date:   Thu, 20 Jan 2022 23:19:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <Yenf20Qn9DTvXbbY@zn.tnic>
References: <Yehz3eqq670WRVJE@zn.tnic>
 <20220120021545.7786-1-kirill.shutemov@linux.intel.com>
 <20220120021545.7786-2-kirill.shutemov@linux.intel.com>
 <20220120163826.bits6ffbnbal4yse@box.shutemov.name>
 <20220120211347.6gglputnh7n3wbvw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120211347.6gglputnh7n3wbvw@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 01:13:47PM -0800, Josh Poimboeuf wrote:
> This one:
> 
> 	pio_ops = (struct port_io_ops){
> 		.inb = inb,
> 		.inw = inw,
> 		.inl = inl,
> 		.outb = outb,
> 		.outw = outw,
> 		.outl = outl,
> 	};
> 
> .. actually allocates an anonymous struct in the .data section, which is
> memcpy'ed at runtime when the assignment occurs.  That anonymous struct
> has .data -> .text relocations which have to be resolved at runtime
> because the distance between .data and .text isn't constant.

Yap, and this is the key point - decompressor kernel is a -pie
executable so it needs to resolve .data section relocations at *runtime*
but we don't have a dynamic linker during early boot.

We could patch at early boot by going through the .data runtime
relocations and patch in the target locations but that would be probably
too much just so that we can do those struct initializers.

And, I'm being told, global .data section things should be avoided, if
possible.

> The working version:
> 
>  	pio_ops.inb = inb;
>  	pio_ops.inw = inw;
>  	pio_ops.inl = inl;
>  	pio_ops.outb = outb;
>  	pio_ops.outw = outw;
>  	pio_ops.outl = outl;
> 
> ... only needs .text -> .text relocations which can be resolved at link
> time.

So yeah, we can simply do this and forget about it.

If someone is bored and wants to fixup such runtime relocations at,
well, runtime, sure. But until then...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
