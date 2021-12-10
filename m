Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1068470C43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbhLJVMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhLJVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:12:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B95C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:08:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so10302175pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7YWN7QNEw58GJU0f1doXJ0tviD5btTumk7hJkf2VRQ8=;
        b=s6OlLRIXTbRNHDBdgq+dNs5RwdPVo7VbtMRpIdsXGpW4wu677S1ev3KGFG+sOjmjxo
         +IeXIzHFBnte+qjwOvx6LbwiMf3jv0OGb8SpRwtE4LalIncm0FdygQDRtMR/63nRwYWK
         pGnNAvrd4O21NJ10y0JEmgKi86zg6LPlaSHvSLuQ1IdFlWSqmcv2bJMlDp+kPEuX6dJU
         EyVv4aPLLurLkT70sP2J2xzfGxAyLPIAnso8CBAafglZhOEDs9WyNuP81G5/uz+8Ls10
         eb21Hf52f5Tor84SEZZB17gevQnvZan0VdieUE5oGeUDw3A+S2LitH+PW1n4AwQPsR1H
         YqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YWN7QNEw58GJU0f1doXJ0tviD5btTumk7hJkf2VRQ8=;
        b=e1f2L4/2IXpMl5eTFIiuGlLGrbTADHGk1kizAmfHbTU3ERhLEMvm7kfLk/n2dVG3dV
         ZbczG6s/QKIKtFYYm1aNAGJI0zx3UDrGB777wO9n7uD630jLDCniF+pt3yoeqz5dwNGf
         RTrtSX91SpX5jJc4XMoUu2Ibe5mKzuhAE3xlrcijavzM4EM/TgaV3IN6Urx7+mANwy35
         42Z7k5faJthB/EoX4LC0Mi+iFK/hLwOej+6nMiJtr7oQV69itIEjfGDbVuXg85rE+19u
         Ic7oLbpua0TUQ8heI00PTz1rKNkT4VDlOUKgkahENL3z1D963SwRhvTZZOU+N19iBzq1
         wbCw==
X-Gm-Message-State: AOAM533neXDH1Z4aJpu7xkaba+VUx3s2zacyPGGnh4AZo/IvxIbMBb3z
        +//VzlBBILi+R7tise+99iJP9Q==
X-Google-Smtp-Source: ABdhPJyKHLgCj/s9OBwsYtjRFtAP/OiYef0WzgqjEsZQqZ/3qp1QYTv9wkjyAp6ZVDGSGsnI4RHJLw==
X-Received: by 2002:a17:90a:880a:: with SMTP id s10mr26562982pjn.214.1639170511791;
        Fri, 10 Dec 2021 13:08:31 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d20sm4339385pfl.88.2021.12.10.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:08:31 -0800 (PST)
Date:   Fri, 10 Dec 2021 21:08:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH 17/15] KVM: X86: Ensure pae_root to be reconstructed for
 shadow paging if the guest PDPTEs is changed
Message-ID: <YbPBy5yvAmPTjv+I@google.com>
References: <20211108124407.12187-1-jiangshanlai@gmail.com>
 <20211111144634.88972-1-jiangshanlai@gmail.com>
 <Ya/5MOYef4L4UUAb@google.com>
 <11219bdb-669c-cf6f-2a70-f4e5f909a2ad@redhat.com>
 <YbPBjdAz1GQGr8DT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbPBjdAz1GQGr8DT@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021, Sean Christopherson wrote:
> On Thu, Dec 09, 2021, Paolo Bonzini wrote:
> > On 12/8/21 01:15, Sean Christopherson wrote:
> > > > @@ -832,8 +832,14 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
> > > >   	if (memcmp(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs))) {
> > > >   		memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
> > > >   		kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
> > > > -		/* Ensure the dirty PDPTEs to be loaded. */
> > > > -		kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
> > > > +		/*
> > > > +		 * Ensure the dirty PDPTEs to be loaded for VMX with EPT
> > > > +		 * enabled or pae_root to be reconstructed for shadow paging.
> > > > +		 */
> > > > +		if (tdp_enabled)
> > > > +			kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
> > > > +		else
> > > > +			kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOT_CURRENT);
> > > Shouldn't matter since it's legacy shadow paging, but @mmu should be used instead
> > > of vcpu->arch.mmuvcpu->arch.mmu.
> > 
> > In kvm/next actually there's no mmu parameter to load_pdptrs, so it's okay
> > to keep vcpu->arch.mmu.
> > 
> > > To avoid a dependency on the previous patch, I think it makes sense to have this be:
> > > 
> > > 	if (!tdp_enabled && memcmp(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs)))
> > > 		kvm_mmu_free_roots(vcpu, mmu, KVM_MMU_ROOT_CURRENT);
> > > 
> > > before the memcpy().
> > > 
> > > Then we can decide independently if skipping the KVM_REQ_LOAD_MMU_PGD if the
> > > PDPTRs are unchanged with respect to the MMU is safe.
> > 
> > Do you disagree that there's already an invariant that the PDPTRs can only
> > be dirty if KVM_REQ_LOAD_MMU_PGD---and therefore a previous change to the
> > PDPTRs would have triggered KVM_REQ_LOAD_MMU_PGD?
> 
> What I think is moot, because commit 24cd19a28cb7 ("KVM: X86: Update mmu->pdptrs
> only when it is changed") breaks nested VMs with EPT in L0 and PAE shadow paging
> in L2.  Reproducing is trivial, just disable EPT in L1 and run a VM.  I haven't

Doh, s/L2/L1

> investigating how it breaks things, because why it's broken is secondary for me.
> 
> My primary concern is that we would even consider optimizing the PDPTR logic without
> a mountain of evidence that any patch is correct for all scenarios.  We had to add
> an entire ioctl() just to get PDPTRs functional.  This apparently wasn't validated
> against a simple use case, let alone against things like migration with nested VMs,
> multliple L2s, etc...
