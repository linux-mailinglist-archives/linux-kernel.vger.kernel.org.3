Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3331B5B0BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiIGRoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIGRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:44:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1437FBD291
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:44:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s14so5726031plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=b81zlqF5ysM4kpc1s037FlTMUfnuY8dmKnhbffyhccc=;
        b=W5b19ldWBf/f/FgPMapegVS3BCm+xIEUzedVudlupZbPvwM/9eKgw/P8X8fwNE6ss1
         6AEbbCbdwZ8TnpsBJBKSxSBqPdEw55ANnmK7T/8a+w8U/xaaj3XUvQTrxtlAZqgbEUUb
         ABWeg+nOWxDglmTTqOJ9SGMY6dMrEKqcCbFRZ6uQGaX0dLipr+Ti5dkfuRcv0TrZTZ+l
         3AXVFQs5To4p2ZsyelXlhguuENGbJPhqks+joShTtYqk13zhu5aPot0AXPz39tMH8nPB
         nD/PKg3I9T0CToftr2flpbv+miFfotTTyfCLGaOsZobm597m7TAAgqp+4aYRN+LAvPCb
         ZlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=b81zlqF5ysM4kpc1s037FlTMUfnuY8dmKnhbffyhccc=;
        b=0sNNoQy41EF4+gO3X2luvJCPpVqXDPfLVrFA9gwAWvSkGEBBh1xMtWN4n5IvQgUpLK
         1ggpEVszGc5lpGcBeWf5MrWNd1dJ01EssoE8oP6DX4egCTgS0YOXEIdvYou8O8w3wJwW
         OTic8p3Phc6OIBk+AfuCsI5VNuw7G/kxTxg57Hw+K2hXPx7Sk4CTWg9IeX+psjb/l4w1
         yGVT7qMFLBzJ/eKvaUoM7RrrSEWjvogREm87FtxodnBn0YlqShFi+o3yqu7V04xJCiGd
         CPXfK0C8WRBzif6cGnNKl+S3wJ2igPrHUXQiJenBfU/K0EIb6ApkJHA8R7gC3VITP+vl
         af3A==
X-Gm-Message-State: ACgBeo2f/WEeVQmP2WUTaOkOog6MIJocYubdzhajDQEM2EJyQwTz2/ce
        uN90uaKwhSL8n1QTiaIGVJnMUw==
X-Google-Smtp-Source: AA6agR5sAZjjMfqycbPQ1M4IStTczWMsH9myfWV6H4TmRp7CMiAoULAhnfiVQiir/BlwUDaak5nlmA==
X-Received: by 2002:a17:903:228a:b0:176:cd0b:8c9f with SMTP id b10-20020a170903228a00b00176cd0b8c9fmr4774908plh.120.1662572640337;
        Wed, 07 Sep 2022 10:44:00 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b001768db880c4sm9911288plb.275.2022.09.07.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:43:59 -0700 (PDT)
Date:   Wed, 7 Sep 2022 10:43:54 -0700
From:   David Matlack <dmatlack@google.com>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] KVM: x86/mmu: Fix wrong gfn range of tlb flushing
 in validate_direct_spte()
Message-ID: <YxjYWtgLZMxFBrjl@google.com>
References: <cover.1661331396.git.houwenlong.hwl@antgroup.com>
 <c0ee12e44f2d218a0857a5e05628d05462b32bf9.1661331396.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ee12e44f2d218a0857a5e05628d05462b32bf9.1661331396.git.houwenlong.hwl@antgroup.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:29:18PM +0800, Hou Wenlong wrote:
> The spte pointing to the children SP is dropped, so the
> whole gfn range covered by the children SP should be flushed.
> Although, Hyper-V may treat a 1-page flush the same if the
> address points to a huge page, it still would be better
> to use the correct size of huge page. Also introduce
> a helper function to do range-based flushing when a direct
> SP is dropped, which would help prevent future buggy use
> of kvm_flush_remote_tlbs_with_address() in such case.
> 
> Fixes: c3134ce240eed ("KVM: Replace old tlb flush function with new one to flush a specified range.")
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e418ef3ecfcb..a3578abd8bbc 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -260,6 +260,14 @@ void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
>  	kvm_flush_remote_tlbs_with_range(kvm, &range);
>  }
>  
> +/* Flush all memory mapped by the given direct SP. */
> +static void kvm_flush_remote_tlbs_direct_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
> +{
> +	WARN_ON_ONCE(!sp->role.direct);
> +	kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
> +					   KVM_PAGES_PER_HPAGE(sp->role.level + 1));

nit: I think it would make sense to introduce
kvm_flush_remote_tlbs_gfn() in this patch since you are going to
eventually use it here anyway.

> +}
> +
>  static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
>  			   unsigned int access)
>  {
> @@ -2341,7 +2349,7 @@ static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  			return;
>  
>  		drop_parent_pte(child, sptep);
> -		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn, 1);
> +		kvm_flush_remote_tlbs_direct_sp(vcpu->kvm, child);
>  	}
>  }
>  
> -- 
> 2.31.1
> 
