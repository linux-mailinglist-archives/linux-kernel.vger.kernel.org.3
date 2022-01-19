Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56FD4941AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357255AbiASU0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiASU0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:26:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61877C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:26:17 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 853361EC04EC;
        Wed, 19 Jan 2022 21:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642623970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gcsbQtvTIZjcCY2Tai3gH/ZSFkICJFR6G+ix5XAvRhg=;
        b=k2wSjGGfuBDKNaKVP/qMJOn9ps1+pu3c3E0zXA8WQk40NF8todODr8JcT58jelE5We0m22
        +XVBb3rNiOFZX5SwDV1SYrwf0gOkADaqkh3xityWpO+8c8ShK8A6VdnjfL/TqvEDK8OHee
        yx7aHLHTW5wbRchV/rsrlxyWC+/UxC8=
Date:   Wed, 19 Jan 2022 21:26:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <Yehz3eqq670WRVJE@zn.tnic>
References: <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
 <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
 <YeW2U9vH65NcLHtY@zn.tnic>
 <20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name>
 <YegTjdltOFBIDlf2@zn.tnic>
 <20220119154925.mzri4zaz3o477e3k@box.shutemov.name>
 <YehqkKNgQ65uUOe6@zn.tnic>
 <20220119200841.fupa3hemmswllmxc@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119200841.fupa3hemmswllmxc@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:08:41PM +0300, Kirill A. Shutemov wrote:
> > Relocation section '.rela.data.rel.local' at offset 0x5c18 contains 6 entries:
			^^^^^^

> JFYI, the message comes from ASSERT in vmlinux.lds.S.

Yah, because those relocations are put in a .rela section and that one
matches.

And looking at which commit added it:

527afc212231 ("x86/boot: Check that there are no run-time relocations")

the removed comment kinda explains it - decompressor kernel cannot
handle runtime relocations. Obviously.

Now we need to figure out how to avoid those...

> I assume for now I can proceed with the assignment that works, right?
> It can be changed later once we figure out what is going on.

Right.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
