Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3044A670E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiBAV06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBAV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:26:57 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:26:57 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v74so17044247pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bfms6OERIF6gyLtv4E3Fdr6nSEeZPjmkZ1JmHeeuQzo=;
        b=qoUR44HEV0B7dtMLN+eucmdkyZqotSw6EyKeN5nxJ/lTXwnOfkyLjEFD/HN9tqGu8a
         g9pLmmC9sECjrUTWjds+0gbWZ+uK00keHd6EhGnEAkgAG0Anj3wihmuEAUbmkureQbV1
         ZD4mMHotw+GAfMCAwCsXgyfz1wS7wso2XKBDuV62O4c6JfDCilbmWQiyGkgxwrnK1o9Q
         qV/g0aCNxq2Ge6fOc/UbCkbdTv4zYTF4RHjQEN/AbOcHuXyJk0wo1xYFXLytxKDZ6IKz
         b9JACr+L3ASoY+CqAX0+WYq7Oa7ELY2O9FQCLfqkCs+kAHJf8qexLgicBKlo/RN1Di8D
         4m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bfms6OERIF6gyLtv4E3Fdr6nSEeZPjmkZ1JmHeeuQzo=;
        b=iiYhNJWU6wfmCDUey14KAc15VrN831O7adSb3sTZvfYPx4d5Io9xr2oSGSzYUxbYMm
         +qvMEgZxWmSIVlqDkcQko48FHizVmUP6pVzmsC8n/fY+hSdnzd4XE21v3F2GWfUPxPLi
         4mS9Ilfb3eQnfJrcRTshyN2NPCOxsBPKwyJ8X1OINaufQcFFBDGcYHpEh+ZTAQ99MzGF
         VnPhtVQDlZTYqdjTqfCY/LXiCFv9xZy3gY331VEd29srokeyw0+TTTguc2AWY0ybTaoc
         3GSHF06fSsMnjyU59eXCu3FiWRzOTYRRFuOmyX+uWglTEs7vjvibhku/smPx/p8lk/Rb
         y+Mg==
X-Gm-Message-State: AOAM5327kA8vtU4KSKP0lQIz0GcfvjCieimB0BZmVkdEYK59kHiFvk0c
        +6LwgxIwQyoeD62xgfyC/7QXfQ==
X-Google-Smtp-Source: ABdhPJw5umHLrk7zL2ZcpH812CHZTNxeGlROBo3bACLT6RYYQcuMRVraXPb4dagTZtsPS+n9us2bRw==
X-Received: by 2002:a05:6a00:190a:: with SMTP id y10mr26588265pfi.52.1643750816410;
        Tue, 01 Feb 2022 13:26:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id mj23sm3793213pjb.54.2022.02.01.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:26:55 -0800 (PST)
Date:   Tue, 1 Feb 2022 21:26:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCHv2 04/29] x86/traps: Add #VE support for TDX guest
Message-ID: <YfmlnJ6LS935AMS4@google.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-5-kirill.shutemov@linux.intel.com>
 <877daez4em.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877daez4em.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> > index df0fa695bb09..1da074123c16 100644
> > --- a/arch/x86/kernel/idt.c
> > +++ b/arch/x86/kernel/idt.c
> > @@ -68,6 +68,9 @@ static const __initconst struct idt_data early_idts[] = {
> >  	 */
> >  	INTG(X86_TRAP_PF,		asm_exc_page_fault),
> >  #endif
> > +#ifdef CONFIG_INTEL_TDX_GUEST
> > +	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
> > +#endif
> >  
> > +bool tdx_get_ve_info(struct ve_info *ve)
> > +{
> > +	struct tdx_module_output out;
> > +
> > +	/*
> > +	 * NMIs and machine checks are suppressed. Before this point any
> > +	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
> > +	 * additional #VEs are permitted (but it is expected not to
> > +	 * happen unless kernel panics).
> 
> I really do not understand that comment. #NMI and #MC are suppressed
> according to the above. How long are they suppressed and what's the
> mechanism? Are they unblocked on return from __tdx_module_call() ?

TDX_GET_VEINFO is a call into the TDX module to get the data from #VE info struct
pointed at by the VMCS.  Doing TDX_GET_VEINFO also clears that "valid" flag in
the struct.  It's basically a CMPXCHG on the #VE info struct, except that it routes
through the TDX module.

The TDX module treats virtual NMIs as blocked if the #VE valid flag is set, i.e.
refuses to inject NMI until the guest does TDX_GET_VEINFO to retrieve the info for
the last #VE.

I don't understand the blurb about #MC.  Unless things have changed, the TDX module
doesn't support injecting #MC into the guest.

> What prevents a nested #VE? If it happens what makes it fatal? Is it
> converted to a #DF or detected by software?

A #VE that would occur is morphed to a #DF by the TDX module if the #VE info valid
flag is already set.  But nested #VE should work, so long as the nested #VE happens
after TDX_GET_VEINFO.

> Also I do not understand that the last sentence tries to tell me. If the
> suppression of #NMI and #MC is lifted on return from tdcall then both
> can be delivered immediately afterwards, right?

Yep, NMI can be injected on the instruction following the TDCALL.  

Something like this?
	
	/*
	 * Retrieve the #VE info from the TDX module, which also clears the "#VE
	 * valid" flag.  This must be done before anything else as any #VE that
	 * occurs while the valid flag is set, i.e. before the previous #VE info
	 * was consumed, is morphed to a #DF by the TDX module.  Note, the TDX
	 * module also treats virtual NMIs as inhibited if the #VE valid flag is
	 * set, e.g. so that NMI=>#VE will not result in a #DF.
	 */
 
> I assume the additional #VE is triggered by software or a bug in the
> kernel.

I'm curious if that will even hold true, there's sooo much stuff that can happen
from NMI context.  I don't see much value in speculating what will/won't happen
after retrieving the #VE info.
