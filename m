Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876E946C85E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242662AbhLGXrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbhLGXrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:47:22 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A22C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:43:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id o4so826280pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 15:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gYp2DzxK1joVr3jiyTurY0/zwc2R2+PwLXfgju6vouA=;
        b=Ae3LF1Klq9HeyREkoOxoL5jPB3p2i/u1/szy0oSm1JardG5YubXcYPlzRmLbou3ERn
         48x+Ff+n0+2pEA0uF2I7gON8OJZzttboBoOsNg63h1din1Q4OOTORuwLsxOExLvtOhjM
         +T//YSQYUOpqfT3C/aKvPMtaTxxGSfNvPKaO0iV312mdQNRDmYft8wHiN3BjCKCI8NVe
         3gIUWGIkvV7bM8YfI6JhA8rJcij/4T4AfvFYQqYndjtWYsb+hCtsBWY+USLLJbOaxlJq
         8Oh1FV4Ro69cirnNM8TLA8UnGTD0G14KLVTA9wXSPXAKuJTFgCM7j4II+vaRjsQYdpWu
         S6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gYp2DzxK1joVr3jiyTurY0/zwc2R2+PwLXfgju6vouA=;
        b=R6w4aR0UCQVWOv+Jpo6qCBrFflbitnuTnC5pC/c4A/awgbV65sN9BveX84vQ6Njf+O
         KrlZbKOKRbML3TXRlUANkRcy9SZf4y3YJ5eaO5824KYL3YZnFuOW3fiPLWE4D4KFQyxj
         BzlMBniWS8ASSNvQKAhl0wZBbeFIy9fgJB/0uygvDABKnAZJIohMChCwAFlwmfHYgDAT
         /NyYr4phZlWJINh4WGZ0BdY4JEkxbtYxGTVUaGcIJP+UWe38VrIpttE9LNPsVK2FF5r6
         UW7w3t28Ye7O1vojmpZf9+Ffml1NxxERzigMyfpFb63brKn1wCDLyNeP46sFWOj9ic0j
         hgOg==
X-Gm-Message-State: AOAM531ZHHScTf8fXnZW2e0LeV7nwbG5hir7tPq8NxmRAGXb0g04zEEZ
        3n5mTMyOrMO+jQ8ExD4ui+zqWw==
X-Google-Smtp-Source: ABdhPJxmkkxGmdyO/JpGqq2H28H9dDLraA9Ntf1o//ODVHEaLAifAouREYlZPB7NSPmU0xwN373BvQ==
X-Received: by 2002:a05:6a00:1412:b0:4a7:ec46:29d1 with SMTP id l18-20020a056a00141200b004a7ec4629d1mr2454569pfu.16.1638920631504;
        Tue, 07 Dec 2021 15:43:51 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z22sm906718pfe.108.2021.12.07.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 15:43:51 -0800 (PST)
Date:   Tue, 7 Dec 2021 23:43:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 16/15] KVM: X86: Update mmu->pdptrs only when it is
 changed
Message-ID: <Ya/xsx1pcB0Pq/Pm@google.com>
References: <20211108124407.12187-1-jiangshanlai@gmail.com>
 <20211111144527.88852-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111144527.88852-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> It is unchanged in most cases.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kvm/x86.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6ca19cac4aff..0176eaa86a35 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -828,10 +828,13 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
>  		}
>  	}
>  
> -	memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
> -	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
> -	/* Ensure the dirty PDPTEs to be loaded. */
> -	kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
> +	kvm_register_mark_available(vcpu, VCPU_EXREG_PDPTR);
> +	if (memcmp(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs))) {
> +		memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
> +		kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
> +		/* Ensure the dirty PDPTEs to be loaded. */
> +		kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
> +	}

Can this be unqueued until there's sufficient justification that (a) this is
correct and (b) actually provides a meaningful performance optimization?  There
have been far too many PDPTR caching bugs to make this change without an analysis
of why it's safe, e.g. what guarantees the that PDPTRs in the VMCS are sync'd
with mmu->pdptrs?  I'm not saying they aren't, I just want the changelog to prove
that they are.

The next patch does add a fairly heavy unload of the current root for !TDP, but
that's a bug fix and should be ordered before any optimizations anyways.

>  	vcpu->arch.pdptrs_from_userspace = false;
>  
>  	return 1;
> -- 
> 2.19.1.6.gb485710b
> 
