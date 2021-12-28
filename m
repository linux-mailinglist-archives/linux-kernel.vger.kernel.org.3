Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B659480DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhL1XyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhL1XyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:54:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 15:54:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so17710262pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 15:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qwG3+knHz/y15NSm8VuLqIc8tLJMm1hb1QKvFClBg7k=;
        b=kBwxTBaN7QgTvA6QsbnhGLCzz4/df0tMalo70CsON6/KKAxoXaWDwHIW8w+7PbCmpa
         0CQ040wdisE2/xw9XS7lsmPqHTe09yCI9QRWTFWtd9ZtIFY5tZL8CcLJkaq3Qwq/1pjZ
         hz0F4SSjA9IU+1RP2EHxRxJdAp28aV2MXhoh38aMXdvGvWmZel9cDxEnwDWas1VH7YtM
         9UUutKlR1wLkOz4Oto6SswemB1TqsfozUHmnwq5ED8PWzd1dygkkWmwB6AwbEw7STFxi
         XalVTYjeqmejua1y0QCOTNNhp+K5fGI036/y7SbrjrR2isg3KeuHe/Sfo/te2Gktxh87
         xU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qwG3+knHz/y15NSm8VuLqIc8tLJMm1hb1QKvFClBg7k=;
        b=qhPIcMIFTvatN3aJFaYr0k+u9Al3NcV3CKyA7ygTS9rc7sVejU0K10tpTNyF+CsyrN
         70bHoZVexFD1WvhEC+Jg57cg108CO7+C8zTL3ddEtmrw8AeLYG5TYLumW1eNveblmNCq
         2RNSTwNYDf75v2SM6Ipx2QfR0vKtveZ9CXkbtDBo1NcpbQoBMRkuAKQ/a4oZmOcp8yze
         tt06gGLAG3isewZLL3Bq2C+Jw3wwBWEq2zkdeT8i7zXgJsvo1DiYs3Yllb5tlsWoW4dh
         SlOMsQRKoeSOST+DbjxPngoNXy9aM05h32b0HngvK4Js5P1t8uJ9Xrty/yKUYLugVyZn
         PZpw==
X-Gm-Message-State: AOAM532j1dkUYDDALTLJethcL9RlH3dJz2D+v0Gc30QRK+w9xMGEu7fg
        sR0quo5ePgcLpYGuWczKFzMaSA==
X-Google-Smtp-Source: ABdhPJxxqVLu3MJ+H57Rawx3JssQCVKS5xD1nhF8/2MBGh8YET98U7ys6HIqDxoO06iJGKE/yEOs/g==
X-Received: by 2002:a17:902:d50e:b0:148:b614:54a1 with SMTP id b14-20020a170902d50e00b00148b61454a1mr23740168plg.163.1640735646088;
        Tue, 28 Dec 2021 15:54:06 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l6sm17236876pjt.54.2021.12.28.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 15:54:05 -0800 (PST)
Date:   Tue, 28 Dec 2021 23:54:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jing Liu <jing2.liu@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, yang.zhong@intel.com
Subject: Re: [PATCH v3 09/22] kvm: x86: Enable dynamic XSAVE features at
 KVM_SET_CPUID2
Message-ID: <YcujmvvSEuoC2xRz@google.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-10-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222124052.644626-10-jing2.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021, Jing Liu wrote:
> Statically enable all xfeatures allowed by guest perm in

Statically isn't the right word.  It's not dymanic with respect to running the
vCPU, but it's certainly not static.  I think you can just omit "Statically"
entirely.

> KVM_SET_CPUID2, with fpstate buffer sized accordingly. This avoids
> run-time expansion in the emulation and restore path of XCR0 and
> XFD MSR [1].
> 
> Change kvm_vcpu_after_set_cpuid() to return error given fpstate
> reallocation may fail.
> 
> [1] https://lore.kernel.org/all/20211214024948.048572883@linutronix.de/
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index a068373a7fbd..eb5a5070accb 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -204,10 +204,12 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_update_cpuid_runtime);
>  
> -static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> +static int kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  	struct kvm_cpuid_entry2 *best;
> +	u64 xfeatures;
> +	int r;
>  
>  	best = kvm_find_cpuid_entry(vcpu, 1, 0);
>  	if (best && apic) {
> @@ -222,9 +224,17 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	best = kvm_find_cpuid_entry(vcpu, 0xD, 0);
>  	if (!best)
>  		vcpu->arch.guest_supported_xcr0 = 0;
> -	else
> -		vcpu->arch.guest_supported_xcr0 =
> -			(best->eax | ((u64)best->edx << 32)) & supported_xcr0;
> +	else {
> +		xfeatures = best->eax | ((u64)best->edx << 32);
> +
> +		vcpu->arch.guest_supported_xcr0 = xfeatures & supported_xcr0;
> +
> +		if (xfeatures != vcpu->arch.guest_fpu.xfeatures) {
> +			r = fpu_update_guest_perm_features(&vcpu->arch.guest_fpu);
> +			if (r)
> +				return r;

IMO, this should be done and check before "committing" state, otherwise KVM will
set the vCPU's CPUID info and update a variety of state, but then tell userspace
that it failed.  The -EPERM case in particular falls squarely into the "check"
category.
