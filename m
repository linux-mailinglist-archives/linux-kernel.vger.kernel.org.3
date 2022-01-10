Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF948A03F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbiAJTfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiAJTfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:35:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB9C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:35:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso274661pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hnak1p9+aKuYwFU3li7V5wBlcAqKG8Pi1Q3J+QpSIvQ=;
        b=Sdy8Q+HzL9d3kr3kmMyeK8HlWXKHX0vZap/itvaSt8Jy3t0jvWIjjoOp6RR0FaMiwg
         n6wCf8NkgRs3XPStOx8dLTGVkJvSMi/x2KtCkCFWG7ZhT6mjMZNqio+6dGHZXoJG+1oH
         bZAW+Ff5dZp4va6LGcE1ZAr2h+AVaEQDbHZtBVWiNQiBR/HzjXL0iYYnnVSKkFGFjM3L
         GwdbMVBCuiz5l3ZJADRh23ggkS4kH18PIz2FFhLSbNJJMdZspaGXHVXK5pRVko5LSc7a
         7/s6gawMKi4i0Nlf2rshjGlo8OsyL7QlIZ01BiEctN1Pvml+oKPioE2Hk7zd5qO+PhVt
         lp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hnak1p9+aKuYwFU3li7V5wBlcAqKG8Pi1Q3J+QpSIvQ=;
        b=kHOVnonxz1YIY8/QUf/25+rQMPc1CIIi+oBfqwNS0MWBryTPG6KekpAowkeGo4bMaQ
         oBjEic9tx2/eDWnmGKujjPXMXIi0to6ueO/UPsi10sSaf4aRj9oFJ4brBgd8XzYkZxZW
         egXh8WFlxHidRSLI335RzY9CM/KR+xf4NvtRMOmgDmFj5Mekzi6wePWlQ2WQYho+fSVA
         zrGVxNrqs2PmQzLSqUaEh5LX579b1IMhtUodp292WYCgWGLo4uZtpermCn3U5Ab33kHq
         LUugQW8mY/D1Fs3ThQUdltTwqEb0SXaEEw1TDWWSpCoc+48xWz1zq/wPoCbCGbjrylUa
         6jfQ==
X-Gm-Message-State: AOAM533l1QYWPzZH7s5VUw/99YhVngwATErs8uHG3rzGgUZKvIjLr1XH
        OIpiBT+Garpq6xc9eIeY1K6WpQ==
X-Google-Smtp-Source: ABdhPJxSTRlCepVyIDHO6kmWw/80RHpzBjHOSOVWXo5orq3bwGdimKz51CHMaHKcUPcTOpSBzxeJGg==
X-Received: by 2002:a63:b90e:: with SMTP id z14mr1051928pge.189.1641843353162;
        Mon, 10 Jan 2022 11:35:53 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g9sm7666339pfc.203.2022.01.10.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:35:52 -0800 (PST)
Date:   Mon, 10 Jan 2022 19:35:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kechen Lu <kechenl@nvidia.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, wanpengli@tencent.com,
        vkuznets@redhat.com, mst@redhat.com, somduttar@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] KVM: x86: move ()_in_guest checking to vCPU
 scope
Message-ID: <YdyKlIHgf3b1K57O@google.com>
References: <20211221090449.15337-1-kechenl@nvidia.com>
 <20211221090449.15337-3-kechenl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221090449.15337-3-kechenl@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shortlog is weird, I get what you're going for with the "()", but it honestly
looks like a typo :-)  And add "power management" so that there's a bit more context
in the shortlog?  Maybe this?

  KVM: x86: Move *_in_guest power management flags to vCPU scope

On Tue, Dec 21, 2021, Kechen Lu wrote:
> For futher extensions on finer-grained control on per-vCPU exits
> disable control, and because VM-scoped restricted to set before
> vCPUs creation, runtime disabled exits flag check could be purely
> vCPU scope.

State what the patch does, not what it "could" do.  E.g.

Make the runtime disabled mwait/hlt/pause/cstate exits flags vCPU scope
to allow finer-grained, per-vCPU control.  The VM-scoped control is only
allowed before vCPUs are created, thus preserving the existing behavior
is a simple matter of snapshotting the flags at vCPU creation.

A few nits below that aren't even from this path, but otherwise,

Reviewed-by: Sean Christopherson <seanjc@google.com>

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Kechen Lu <kechenl@nvidia.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  5 +++++
>  arch/x86/kvm/cpuid.c            |  2 +-
>  arch/x86/kvm/lapic.c            |  2 +-
>  arch/x86/kvm/svm/svm.c          | 10 +++++-----
>  arch/x86/kvm/vmx/vmx.c          | 16 ++++++++--------
>  arch/x86/kvm/x86.c              |  6 +++++-
>  arch/x86/kvm/x86.h              | 16 ++++++++--------
>  7 files changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2164b9f4c7b0..edc5fca4d8c8 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -908,6 +908,11 @@ struct kvm_vcpu_arch {
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t hv_root_tdp;
>  #endif
> +
> +	bool mwait_in_guest;
> +	bool hlt_in_guest;
> +	bool pause_in_guest;
> +	bool cstate_in_guest;
>  };
>  
>  struct kvm_lpage_info {
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 07e9215e911d..6291e15710ba 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -177,7 +177,7 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
>  
>  	best = kvm_find_kvm_cpuid_features(vcpu);
> -	if (kvm_hlt_in_guest(vcpu->kvm) && best &&
> +	if (kvm_hlt_in_guest(vcpu) && best &&
>  		(best->eax & (1 << KVM_FEATURE_PV_UNHALT)))

Can you (or Paolo?) opportunistically align this?  And maybe even shuffle the
check on "best" to pair the !NULL check with the functional check?  E.g.

	if (kvm_hlt_in_guest(vcpu) &&
	    best && (best->eax & (1 << KVM_FEATURE_PV_UNHALT)))
		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);

>  		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
>  
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index f206fc35deff..effb994e6642 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -119,7 +119,7 @@ static bool kvm_can_post_timer_interrupt(struct kvm_vcpu *vcpu)
>  bool kvm_can_use_hv_timer(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_x86_ops.set_hv_timer
> -	       && !(kvm_mwait_in_guest(vcpu->kvm) ||
> +	       && !(kvm_mwait_in_guest(vcpu) ||

And another opportunistic tweak?  I'm been itching for an excuse to "fix" this
particular helper for quite some time :-)

	return kvm_x86_ops.set_hv_timer &&
	       !(kvm_mwait_in_guest(vcpu) || kvm_can_post_timer_interrupt(vcpu));

That overruns the 80 char soft limit, but IMO it's worth it in this case as the
resulting code is more readable.


>  		    kvm_can_post_timer_interrupt(vcpu));
>  }
>  EXPORT_SYMBOL_GPL(kvm_can_use_hv_timer);
