Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9348A18B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiAJVKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiAJVKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:10:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC2BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:10:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id oa15so14304684pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJc19i/SFb8fDASSOqMu23EH/ZlObMF2YEBy+h3uMCs=;
        b=sx85pG28fY85G3zh5bIfPiPUegT10kTOfJRNx6ALvvXJTrw6QxF+CpSrehUnHxwZgE
         xqy+86Xap/bcQxibYFcjqMdQBDpqi4/ZF8yZurwC2eHh5TUEs4nZEfzZi8hSoEg/xCe5
         QFluQ47dESWQmdJdSl0pvPUvqYy3wmHatprOVaGCxTzx9TQNGpbOwS8epUyPuKHxT7Cj
         9J3GogIGxVTSYoN3lOmhWyq8pHxPZV2kVy60x4/YgSKJXpvOOmFyZKw69gjj9KFC4w5z
         +S7ckbrZyKupTlNs8x85m8MSoTRDEnFY0dP2rIcTjjW/ikLXkiYuhiCo573+9UlKsRdc
         6NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJc19i/SFb8fDASSOqMu23EH/ZlObMF2YEBy+h3uMCs=;
        b=RfGkP8L+crp4p+F1OHj227qo4TLwOm2PqIWHUb7AZgaXFEKWDfitOH2BOJxv7d6kCv
         HG8UaQnvyqxfglHBjC5gIlOVnLMJeMSFlJCKIgmxiaEH/8MBj9c5o1lKiRVTB1JnxSeH
         x4JmnzZIqsfloWVaoFTBMg4g0nYngsotmVbV8vJwDx1QO2JuDKaHXaG1Fdp6fFLt0liJ
         gyc+CQppZ4L4Wo72C0+NgvM0o040aMVc33bTbsE/qCQcaguatci6HKwg4baqbRAM33MS
         kr1S+G3e8cOIutQz7kmVKJDWGZfrWdYtzIbYr15A3L9iZXH5NwznfEJOGkCpo10pMgSn
         Foxw==
X-Gm-Message-State: AOAM533W25/j9vmaEjq0n7Bty26SyMpAEFEc9b2N+0VpBzHVa9yWMWn+
        pUnjhd7SNpo5Uj1qpIRRleBsxg==
X-Google-Smtp-Source: ABdhPJwOh9yRpqcK7UEYXGr9S8tX1kbo/tHV/l/RDtkP2w6cFx6T8QE6usDza6YAws00S39Vhr5EIQ==
X-Received: by 2002:a63:194b:: with SMTP id 11mr1322457pgz.461.1641849014564;
        Mon, 10 Jan 2022 13:10:14 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t207sm7332477pfc.205.2022.01.10.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:10:14 -0800 (PST)
Date:   Mon, 10 Jan 2022 21:10:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] KVM: x86: Use kvm_x86_ops in
 kvm_arch_check_processor_compat
Message-ID: <YdygsjmoqmfwOVgv@google.com>
References: <20211227081515.2088920-1-chao.gao@intel.com>
 <20211227081515.2088920-3-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227081515.2088920-3-chao.gao@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021, Chao Gao wrote:
> check_processor_compatibility() is a "runtime" ops now. Use
> kvm_x86_ops directly such that kvm_arch_check_processor_compat
> can be called at runtime.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  arch/x86/kvm/x86.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6411417b6871..770b68e72391 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11383,7 +11383,6 @@ void kvm_arch_hardware_unsetup(void)
>  int kvm_arch_check_processor_compat(void *opaque)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
> -	struct kvm_x86_init_ops *ops = opaque;
>  
>  	WARN_ON(!irqs_disabled());
>  
> @@ -11391,7 +11390,7 @@ int kvm_arch_check_processor_compat(void *opaque)
>  	    __cr4_reserved_bits(cpu_has, &boot_cpu_data))
>  		return -EIO;
>  
> -	return ops->runtime_ops->check_processor_compatibility();
> +	return kvm_x86_ops.check_processor_compatibility();

I'd just squash this with patch 01.  And might as well make this a static_call().

>  }
>  
>  bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
> -- 
> 2.25.1
> 
