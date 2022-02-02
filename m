Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374C4A7879
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbiBBTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiBBTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:05:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0205AC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:05:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643828702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQsXc1Zxb+pGxJoQp3PoB5VRWYtVvxluIxZ+/EPywAo=;
        b=g02XSIvHN+JdOOFwQIIBaqUINGKngZ5nK9uBECvchnXbLZhj2IiF+CNYbh6wcxohqY9YKJ
        GtgzBGLzOZpWwHkVUhxoubD50TGYdLuAZ2AX262LBFQhbEEdbyyF7hq17X43EH+PApTJGm
        ySkPrKoRcPND1uj+FjQk3z8UR4LVXVxbQ9kb/hFFrBc8zqHHvMEeq/A3j++pM/3ocz5PP3
        LrrWbIQpc64fwvY6nH5a4mlkTmfg5UKZ6PptI0XKXQK+0480gzd0Nm6Ok3nYp0JSNVT8SB
        XH9UlZaah+lj3bkzgjrrtSybVyEhGYdRUvqvnc4Qpr34KoCJS60cTDi8yLbcaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643828702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQsXc1Zxb+pGxJoQp3PoB5VRWYtVvxluIxZ+/EPywAo=;
        b=HZ5oDR8XnSCKkNZLqNBKfJIHqjdFZ2IjeSyPJTDsHnAdWLBsrnOJTOgyltiaI6kihMwv3S
        PIfsyeF/BiRwVuBQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 11/29] x86/boot: Allow to hook up alternative port I/O
 helpers
In-Reply-To: <20220202172026.ukebjmavzvahi556@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-12-kirill.shutemov@linux.intel.com>
 <87k0eexlde.ffs@tglx> <87ee4mxkpj.ffs@tglx>
 <20220202172026.ukebjmavzvahi556@black.fi.intel.com>
Date:   Wed, 02 Feb 2022 20:05:02 +0100
Message-ID: <87fsp1t7hd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2022 at 20:20, Kirill A. Shutemov wrote:
> On Tue, Feb 01, 2022 at 11:53:28PM +0100, Thomas Gleixner wrote:
>> Can we please make that u8, u16, u32 instead of unsigned char,short,int?
>> 
>> That's the kernel convention for hardware related functions for many
>> years now.
>
> I inherited these prototypes from the main kernel I/O helpers. See patch
> 10/29.
>
> Do you want 10/29 to be changed to use u8/16/32?
>
> Maybe a separate patch to convert main kernel to u8/16/32 before
> consolidation with boot stub?

Yes, please. That aligns them also with the asm-generic/io.h
implementation.

Thanks,

        tglx
