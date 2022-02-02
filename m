Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F84A76A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbiBBRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:17:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48122 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBBRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:17:09 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643822228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVGod8/S5K2PAKJCQYQ6Y6ycPz5/OAlUAGaRa4NjEl0=;
        b=LPRvBFq+SqTFRbmMUemvAjMtesnDb37o5k8J+K42ROg39phkJQCcFk9X50qiiDUB2Y8Oqh
        4qeh73u+ualuIScefkB6k+WnHqqpgnYALiht2HeDmVJ8bOSjaIbysaqEtd/JVX23LTb5CW
        pUQonoBqk1SAPIRT58fr5QFr4nHDtN7/cQdexp2OJBNu9u6zRX2H9YZy9cV5qae59p3wwx
        6DHIuP7+sacxCZ0cMa/DfbV4emjT+mMfZOz1J5f2U5UCP78/o2plJ+vcpLMNDiLZ0NLboZ
        aHXT+Ig2wQPY+MlagbzSHdGweI4I0ZU52SXwN+rgvMscZCI4YlfClcKemHt7bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643822228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVGod8/S5K2PAKJCQYQ6Y6ycPz5/OAlUAGaRa4NjEl0=;
        b=GiblYRkTJDRAS/GDFQhoC3TIlFUOq6/PvLSXVBH76zRKyQ1Jv4oWRGVQp3VSNTiLLVzfHB
        6xp8n5QIXjHZltCg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     bp@alien8.de, aarcange@redhat.com, ak@linux.intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv2.1 05/29] x86/tdx: Add HLT support for TDX guests
In-Reply-To: <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx> <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
Date:   Wed, 02 Feb 2022 18:17:08 +0100
Message-ID: <875ypxur1n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2022 at 15:48, Kirill A. Shutemov wrote:

> On Tue, Feb 01, 2022 at 10:21:58PM +0100, Thomas Gleixner wrote:
>> On Sun, Jan 30 2022 at 01:30, Kirill A. Shutemov wrote:
>> This really can be simplified:
>> 
>>         cmpl	$EXIT_REASON_SAFE_HLT, %r11d
>>         jne	.Lnohalt
>>         movl	$EXIT_REASON_HLT, %r11d
>>         sti
>> .Lnohalt:
>> 	tdcall
>> 
>> and the below becomes:
>> 
>> static bool tdx_halt(void)
>> {
>> 	return !!__tdx_hypercall(EXIT_REASON_HLT, !!irqs_disabled(), 0, 0, 0, NULL);
>> }
>> 
>> void __cpuidle tdx_safe_halt(void)
>> {
>>         if (__tdx_hypercall(EXIT_REASON_SAFE_HLT, 0, 0, 0, 0, NULL)
>>         	WARN_ONCE(1, "HLT instruction emulation failed\n");
>> }
>> 
>> Hmm?
>
> EXIT_REASON_* are architectural, see SDM vol 3D, appendix C. There's no
> EXIT_REASON_SAFE_HLT.
>
> Do you want to define a synthetic one? Like
>
> #define EXIT_REASON_SAFE_HLT	0x10000
> ?

That was my idea, yes.

> Looks dubious to me, I donno. I worry about possible conflicts with the
> spec in the future.

The spec should have a reserved space for such things :)

But you might think about having a in/out struct similar to the module
call or just an array of u64.

and the signature would become:

__tdx_hypercall(u64 op, u64 flags, struct inout *args)
__tdx_hypercall(u64 op, u64 flags, u64 *args)

and have flag bits:

    HCALL_ISSUE_STI
    HCALL_HAS_OUTPUT

Hmm?

Thanks,

        tglx
