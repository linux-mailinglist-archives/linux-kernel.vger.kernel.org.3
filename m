Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD34BF93C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiBVN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiBVN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:28:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185791AC3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:28:19 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACA621EC02DD;
        Tue, 22 Feb 2022 14:28:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645536493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=juKznDx9eV+56JG3xixJfXKzB0BohPu6r4RuDHT3slo=;
        b=R1/FKGa4Bxdr3BQjU5gD1x4h5fn6Gk/K6FX3Bjd48e/PeULkwkwZjiodegpTljabnTu2HU
        MdmvB+5jkcC3qZGlzMqVR+17BgxHCsOdPCIk5RBxHFvzEUYUfN0m+GXuAbQVa7tvVIoCwB
        z6CzJuG7Rk9c40lZOFMHrF7FjNHDEiw=
Date:   Tue, 22 Feb 2022 14:28:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Message-ID: <YhTk8ZoBtxkHkJHI@zn.tnic>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
 <YhPst1DdG3T5hsnM@zn.tnic>
 <20220221222149.jpuwlinaihq6fjwy@black.fi.intel.com>
 <YhQYgBYOBtdPD65X@zn.tnic>
 <20220221231831.dukkbvjdc5e3mu7c@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221231831.dukkbvjdc5e3mu7c@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:18:31AM +0300, Kirill A. Shutemov wrote:
> On Mon, Feb 21, 2022 at 11:56:00PM +0100, Borislav Petkov wrote:
> > On Tue, Feb 22, 2022 at 01:21:49AM +0300, Kirill A. Shutemov wrote:
> > > Well, it actually going to be
> > > 
> > >  	cpa.mask_set = enc ? cc_mkenc(__pgprot(0)) : cc_mkdec(__pgprot(0));
> > >  	cpa.mask_clr = enc ? cc_mkdec(__pgprot(0)) : cc_mkenc(__pgprot(0));
> > > 
> > > as '0' is not a valid pgprot_t.
> > > 
> > > Still wonna go this path?
> > 
> > Why "still"? What's wrong with that?
> 
> IMO, it makes these statement substantially uglier.

As opposed to what you had:

+	cpa.mask_set = __pgprot(cc_get_mask(enc));
+	cpa.mask_clr = __pgprot(cc_get_mask(!enc));

?

Sorry, but cc_get_mask() - first, the name is very misleading - and then
a function argument saying what mask to return is more confusing.

The fact that each vendor chose alternating representations of what an
encrypted page means needs to be abstracted away - the API should not
ask the user of the function what mask she wants. Your functions need
to return an encrypted mask or a decripted mask, not "hey, what kind of
mask do you want".

If you want to make it even simpler, you can hide the pgprot creation
inside the function even - I'm looking at how pgprot_nx() is defined:

	cpa.mask_set = enc ? pgprot_enc(0) : pgprot_dec(0);
	cpa.mask_clr = enc ? pgprot_dec(0) : pgprot_enc(0);

Or, if you think this is still not readable enough, you carve it out
into a separate function:

	cpa_set_masks(struct cpa_data *cpa, bool enc);

and go to town there, do comments, do pgprot conversion per-hand,
whatever.

*BUT* it all depends on what your full requirements for those functions
are for how these masks are going to be used throughout the tree. So I'm
guessing a usage analysis will give you the proper design.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
