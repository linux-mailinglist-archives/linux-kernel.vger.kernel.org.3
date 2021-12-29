Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B64815DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhL2Rfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbhL2Rft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:35:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB57C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:35:48 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCF5F1EC0118;
        Wed, 29 Dec 2021 18:35:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640799343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OzHflimpAKBwUeVPDtHgVS0xnmMSycRmuKswryUb0+Y=;
        b=m+KcQ+AX2c5KJmj6r5qJWYDOKsQUelgT3SrrW0Jg6N2xjVGo6oOVwIJgOzVquoJFuWNRMU
        dK5ky8vSM7KUVylBaZzr7qsbaIZxUzzkiaNCzrWKzw3RGYc5Coch+MX1dHBURLl89CyeP7
        oh9PQfmlEG6f9TeJ6LIeTkzHFqmp+h8=
Date:   Wed, 29 Dec 2021 18:35:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YcyccW9yzAPoo/rX@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
 <YcxGrw6Ymqs8NPjY@zn.tnic>
 <YcyV1uwa72vhPXPV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcyV1uwa72vhPXPV@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 05:07:34PM +0000, Sean Christopherson wrote:
> FWIW, virtual/guest NMIs are blocked by the TDX module until pending #VE info
> is retrieved via TDGETVEINFO.  Hardware has nothing to do with that behavior.

The TDX module can block NMIs?! Can we get that functionality exported
to baremetal too pls? Then we can get rid of the NMI nesting crap.

> Yes?  The rules would be the same as whatever existing rules we have for taking
> #DBs in NMI, but that's because the subsequent IRET unblocking NMIs, not because
> there's anything special about #VE.  Pending NMIs are blocked by the regular NMI
> status (unblocked by IRET) _and_ by an unread #VE info.
> 
> The unread #VE info clause in NMI blocking is purely to prevent an NMI from being
> injected before the guest's #VE handler can do TDGETVEINFO, otherwise a #VE at
> _any_ point in the NMI handler would be fatal due to it clobbering the unread #VE
> info (it'd be a similar problem to SEV-ES's GHCB juggling).

I guess this is what Kirill means with:

"The critical part is that #VE must not be triggered in NMI entry code,
before kernel is ready to handle nested NMIs."

I read that as "you die if you get it then" but it sounds like it is
"it'll overwrite #VE info and you'll probably die eventually." Or so.

Yeah, so this commit message text - and I actually think that this is
much more important than to put just in a commit message - so this text
would need a lot more scrubbing and put somewhere - maybe over the #VE
handler - and explain what the situation is wrt NMIs and #VEs. And those
formulations about a TDX guest expecting stuff to be a certain way are
just silly.

TDX guest either enforces them or throws hands in the air and does not
boot.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
