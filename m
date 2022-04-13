Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A4550014E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiDMVpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiDMVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:45:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC93035DD0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:43:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bd13so2442917pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RNkb+Oz3fazVqY2YiyD/9DFwcBXuYmOA0gGrRMvalDM=;
        b=HkTIU0JG4LDuTnA3bgfA8NvKFHvyzU1rJt7UcW5fR5WC1rTXY+xVvmCUfcNN3wZlIR
         1csW2Ttr6MR3Jbcu7FPnUxwsncmOguFxKEVZCZnvsR+fxryqWyu1XcEbqx2eCljPHyEj
         JIPm72GsnBaHOTSMd2DhCq8PLhcTBStFsPiNUZEtWkoh10TKgPjBMMOPivQuj2OhsIKg
         qlWMQ9R6Fb1FDTAXdXceRoveGf01fvms2aIk9KXO0HULl+BSafNZan6w/4pZANu4GIuS
         upNiZthvk73a/xo/RyAXhj9U9juH3Tp6FdHDLGjDCy5N0hhjA1u3l4Ohh0R+iboNIX8J
         QpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNkb+Oz3fazVqY2YiyD/9DFwcBXuYmOA0gGrRMvalDM=;
        b=psf7duK5w2VNKyo7mrPLXQyQdLoHxXG0ciI+x1BFrPwMXRu1pco2hmbCtmXeJ6il5t
         aSez5bo6jrpzlcyhwi48pOGGgDpjj9JOrj/V56gp/96PImaSTzQlcWT7HAdWLrgqnVoi
         JbC3QDvYoeYTr0BluvEi9iXdz9oZZHR0o7PPpd6rgLSWB3gle+UGx+yFL/pF4uYOTI38
         zR3HF1ECd67QOAAbDcMsevYLIiFmdThors0BNNj8uBY+2Dvz96gH2azYwtazSmxTXl87
         D/M8yLE8PauMTfDLB8l3l9k5TRUN6qIkFd2kFCZdRKGVc2aD0OWf7SVPHZpoWeco3EN5
         G3tQ==
X-Gm-Message-State: AOAM531b3fbGROTAucQ2x7CJ0naV8MgoFC/Hb0lDHHucli4mc7U8hqpc
        nRhOVH1L6Vzxk5k4yQeXpwLwVg==
X-Google-Smtp-Source: ABdhPJz3759MNqht0yGbqAq5Kwbautm4cXXROrqa3tKvLnE/Oug6IsZUYDHzoO4rNy+k5OaKzAoZdA==
X-Received: by 2002:a65:5582:0:b0:39d:7611:c318 with SMTP id j2-20020a655582000000b0039d7611c318mr11506875pgs.213.1649886188203;
        Wed, 13 Apr 2022 14:43:08 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e126-20020a621e84000000b0050567191161sm26520pfe.210.2022.04.13.14.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:43:07 -0700 (PDT)
Date:   Wed, 13 Apr 2022 21:43:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] KVM: X86: Boost vCPU which is in critical section
Message-ID: <YldD56m2nEUPLwx1@google.com>
References: <1648800605-18074-1-git-send-email-wanpengli@tencent.com>
 <1648800605-18074-4-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648800605-18074-4-git-send-email-wanpengli@tencent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+tglx and PeterZ

On Fri, Apr 01, 2022, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The missing semantic gap that occurs when a guest OS is preempted 
> when executing its own critical section, this leads to degradation 
> of application scalability. We try to bridge this semantic gap in 
> some ways, by passing guest preempt_count to the host and checking 
> guest irq disable state, the hypervisor now knows whether guest 
> OSes are running in the critical section, the hypervisor yield-on-spin 
> heuristics can be more smart this time to boost the vCPU candidate 
> who is in the critical section to mitigate this preemption problem, 
> in addition, it is more likely to be a potential lock holder.
> 
> Testing on 96 HT 2 socket Xeon CLX server, with 96 vCPUs VM 100GB RAM,
> one VM running benchmark, the other(none-2) VMs running cpu-bound 
> workloads, There is no performance regression for other benchmarks 
> like Unixbench etc.

...

> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c       | 22 ++++++++++++++++++++++
>  include/linux/kvm_host.h |  1 +
>  virt/kvm/kvm_main.c      |  7 +++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9aa05f79b743..b613cd2b822a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10377,6 +10377,28 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>  	return r;
>  }
>  
> +static bool kvm_vcpu_is_preemptible(struct kvm_vcpu *vcpu)
> +{
> +	int count;
> +
> +	if (!vcpu->arch.pv_pc.preempt_count_enabled)
> +		return false;
> +
> +	if (!kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_pc.preempt_count_cache,
> +	    &count, sizeof(int)))
> +		return !(count & ~PREEMPT_NEED_RESCHED);

As I pointed out in v1[*], this makes PREEMPT_NEED_RESCHED and really the entire
__preempt_count to some extent, KVM guest/host ABI.  That needs acks from sched
folks, and if they're ok with it, needs to be formalized somewhere in kvm_para.h,
not buried in the KVM host code.

[*] https://lore.kernel.org/all/YkOfJeXm8MiMOEyh@google.com

> +
> +	return false;
> +}
> +
