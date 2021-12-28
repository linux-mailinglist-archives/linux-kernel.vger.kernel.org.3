Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5D480C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhL1Sju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:39:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38556 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233454AbhL1Sjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:39:48 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6299B1EC036C;
        Tue, 28 Dec 2021 19:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640716783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gwZ5IJaYWewq5I0luDCo78Jt9ATQc/oPqujx9m6rEmQ=;
        b=CiBOfY+vwJ+YHZL/p3HqOfWoD6bAbGwRyfBLQ5SRadAQJ5iqeoHnRHdOucx4JWn6KIkrxa
        Se3Gvvx3EugnIbFtQ3Nw/vhCrPAAxoAZS3tSOiYuusuhS1awZXgiq6lAHxwz5WAyuSFBjd
        1XXJK/4QDXYOzBKk91QiHOjTONLL7uk=
Date:   Tue, 28 Dec 2021 19:39:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <YctZ8gCoaLgFCClP@zn.tnic>
References: <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <YcmoucfxOF8mwox8@zn.tnic>
 <20211227141436.ahvdngnae6xnf4nl@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227141436.ahvdngnae6xnf4nl@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 05:14:36PM +0300, Kirill A. Shutemov wrote:
> On Mon, Dec 27, 2021 at 12:51:21PM +0100, Borislav Petkov wrote:
> > On Fri, Dec 24, 2021 at 02:03:00PM +0300, Kirill A. Shutemov wrote:
> > > Okay. Meanwhile I leave it this way:
> > > 
> > > 	pgprot_t pgprot_cc_encrypted(pgprot_t prot)
> > > 	{
> > > 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > > 			if (cc_platform_has(CC_ATTR_GUEST_TDX))
> > > 				return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
> > > 			else if (sme_me_mask)
> > > 				return __pgprot(__sme_set(pgprot_val(prot)));
> > > 			else
> > > 				WARN_ON_ONCE(1);
> > 
> > I'm wondering if defining a generic cc_attr especially for this:
> > 
> > 	if (cc_platform_has(CC_ATTR_MEMORY_SHARING))
> > 
> > to mean, the CC guest needs to do special stuff in order to share memory
> > with the host (naming sucks, ofc) would be cleaner?
> 
> Looks like CC_ATTR_MEM_ENCRYPT already does this. The attribute doesn't
> have much meaning beyond that, no?

It means that *some* memory encryption - guest or host - is in use.

But my point about removing the outer check is bull - you need the
TDX/SEV checks too to figure out which mask to use.

So, reading Tom's latest email, having

	cc_pgprot_encrypted(prot)

and
	cc_pgprot_decrypted(prot)

in cc_platform.c and which hide all that logic inside doesn't sound like
a bad idea. And cc_platform.c already looks at sme_me_mask and we do
that there for the early path so I guess that's probably halfway fine...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
