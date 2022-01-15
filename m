Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BCD48F6AD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiAOMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:16:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbiAOMQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:16:05 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBF011EC0532;
        Sat, 15 Jan 2022 13:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642248960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XDUwwnpPc5KwpAAkqbYEfqsdrcjLzqvdebpXHdKPZLY=;
        b=UNo+2SwrTtGsfgL6nkTxji4FyiiWt124eMOwE5dgY0RyvznkitqoY4NS9beAvTYNeCfIsw
        FSf8ezvDCOuMsJGa99DDxC4efUghIBXlmBUz7MTi204T00FyxYndyi3rr62wD2jDmJ3sVg
        jNSMHJBU1OpNccW8u4vPVNsPvO4Xe20=
Date:   Sat, 15 Jan 2022 13:16:00 +0100
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
Message-ID: <YeK7AJXGN5GVGkRV@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 04:01:55AM +0300, Kirill A. Shutemov wrote:
> Do you see it differently? Do you want to switch to #VE here?

I'm just comparing to what SEV does and wondering why you guys do it
differently. But if you think hypercalls is easier, fine by me.

The thing I don't like about that patch is you mixing up kernel proper
io helpers with the decompressor code instead of modifying the ones in
arch/x86/boot/boot.h.

We need to hammer out how the code sharing between kernel proper and the
decompressor should be done but that ain't it, especially if there are
already special io helpers in the decompressor.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
