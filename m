Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84E34A6925
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243283AbiBBASp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:18:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbiBBASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:18:42 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643761120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLeMv/6RS1ogEasjh9A5UMG6k0Sx2F9mFXDj2XcIXBw=;
        b=0mMOatM2Wvl0WOsQZITl8s0objldVvOXxRC3Ox2mRIUqFByfCxR8r2GOhmU4RtkXkSoh3o
        y1yPgpOZ3ATBmWppZDm8QbIsIE2Bhb3NNH1BHD0CR5fnS2xAYvj0hqtFNjx3BHrRmvuqyz
        54MAKuYtc+eAmsf9rsoy35oN3p4ihr7pKnU3VXYqvsBpXu0Y82b+HStYMuAFKpNgDAcunA
        k8l11H1Y+1w2wa62S6X+F/fUnAZ4x24MI6vDTxSYjK/IW5R5nOJ1vkoLvgjVh/B+kOfloT
        b+6dbn6WLO533IuLodJoYV4rXN1o/ZfcEjj91TT9iLwKLOoAMuMVs1fuM0+V9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643761120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLeMv/6RS1ogEasjh9A5UMG6k0Sx2F9mFXDj2XcIXBw=;
        b=MnhYGecwZI372SPHnzkYGxMXuGTriiBgN12nFF3QkqYw5gwclVjTVJJ2SVrjkt621AwdDh
        w9kOTUG+oMllBHAw==
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
Subject: Re: [PATCHv2 21/29] x86/tdx: Exclude shared bit from __PHYSICAL_MASK
In-Reply-To: <20220124150215.36893-22-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-22-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 01:18:40 +0100
Message-ID: <87ee4mw273.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:

> In TDX guests, by default memory is protected from host access. If a
> guest needs to communicate with the VMM (like the I/O use case), it uses
> a single bit in the physical address to communicate the protected/shared
> attribute of the given page.
>
> In the x86 ARCH code, __PHYSICAL_MASK macro represents the width of the
> physical address in the given architecture. It is used in creating
> physical PAGE_MASK for address bits in the kernel. Since in TDX guest,
> a single bit is used as metadata, it needs to be excluded from valid
> physical address bits to avoid using incorrect addresses bits in the
> kernel.
>
> Enable DYNAMIC_PHYSICAL_MASK to support updating the __PHYSICAL_MASK.
>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Impressive....

> ---
>  arch/x86/Kconfig      | 1 +
>  arch/x86/kernel/tdx.c | 8 ++++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
