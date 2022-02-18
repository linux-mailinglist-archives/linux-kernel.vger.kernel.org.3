Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E964BBE13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiBRRPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbiBRRPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEE4B850
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so9105727pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xH/IlepHKMPyzwGE0aHvfUnRRSRkxlsVgqDXZENsWF4=;
        b=CCZJEx6wJo54CRJ1nw52S3756+GgvbkbG4fFiUiKvWxfwo3MAxnvlqtWClKtKtJhBR
         rAlT6HU9MUCOUOWOB/f+bl21qmDRIi2eShXVQuQB4QooVixEMhz9TMdgMO2+H9q0djig
         QSzuZrCKSTBBPSM0GNZenFIkkaY9EbveT+FpSAmKoN2B8A3YeTLtptVHTaTz4Zwc4GZ/
         Bz6MbtsB1jEqlTbzVmeTMH+B8mMJM9A8re+zHSmQGH7YpupplZdGb3VfwbIMf87lBjcA
         /z0B5whNJpDv3VA31g5ARfkabFqCYKAdZIwjZCZanyTeUF64kKRqOspmZmOvrs2pu/K+
         uf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xH/IlepHKMPyzwGE0aHvfUnRRSRkxlsVgqDXZENsWF4=;
        b=WHgV/YY6VgFzWWoSyxfesnoIZIPd6CVzKwxAkkpaR6VGIHceN51aSP0kr+i/pWrsgY
         wjr/BFFxkSu05xb4JGIryrJA2tM5+eVGmUtbhDfh0+YckvGX7gp4613YcL+YR/L7R1sw
         ExH3axUE5F08C5DAkqiZSrsVf3X4inC00jJ3EO9zKPET+GuLngI7gZ/UIdC3BwMKzK6t
         dRrNtT+WdI/DSgyy0kmvkIX+g8zpbYaUn059vGs+0MiQykDgm5vk7kLzmMM0nnm3OMts
         /3esQywC5xewY+tZX2ID4VZdFRZtSujKxeIL8y6mWn2r+qPEqUVKEuVcTb1Qt+/TYPey
         IElw==
X-Gm-Message-State: AOAM531AYTOxeE+TUpszSQSm435+9vQl491YTtv1DZn7BA5OS36i7r+t
        VLdHuW+WkwFo+yQV2IbFf3j74qP4QKkMxg==
X-Google-Smtp-Source: ABdhPJyIt9N0yCc8Xc8p3SzO2o/LXgdOK3B0rha1X07eij+FvPTnQ1VvSItUKF7LOU8F+RELqJdHMg==
X-Received: by 2002:a17:902:6aca:b0:14d:5b32:eb0e with SMTP id i10-20020a1709026aca00b0014d5b32eb0emr8030672plt.31.1645204494478;
        Fri, 18 Feb 2022 09:14:54 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 19sm3447140pfz.153.2022.02.18.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:14:53 -0800 (PST)
Date:   Fri, 18 Feb 2022 17:14:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/18] KVM: x86/mmu: WARN if PAE roots linger after
 kvm_mmu_unload
Message-ID: <Yg/UCQggoKQ27pVm@google.com>
References: <20220217210340.312449-1-pbonzini@redhat.com>
 <20220217210340.312449-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217210340.312449-4-pbonzini@redhat.com>
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

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 296f8723f9ae..a67071ac80f3 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5086,12 +5086,21 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
>  	return r;
>  }
>  
> +static void __kvm_mmu_unload(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
> +{
> +	int i;
> +	kvm_mmu_free_roots(vcpu, mmu, KVM_MMU_ROOTS_ALL);
> +	WARN_ON(VALID_PAGE(mmu->root_hpa));
> +	if (mmu->pae_root) {
> +		for (i = 0; i < 4; ++i)
> +			WARN_ON(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
> +	}
> +}
> +
>  void kvm_mmu_unload(struct kvm_vcpu *vcpu)
>  {
> -	kvm_mmu_free_roots(vcpu, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
> -	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root_hpa));
> -	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
> -	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root_hpa));
> +	__kvm_mmu_unload(vcpu, &vcpu->arch.root_mmu);
> +	__kvm_mmu_unload(vcpu, &vcpu->arch.guest_mmu);

Can we just drop this one?  Checkpatch doesn't like it, and IMO the existing asserts
are unnecessary.  IIRC you said this one never actually fired?

WARNING: Missing commit description - Add an appropriate one

WARNING: Missing a blank line after declarations
#22: FILE: arch/x86/kvm/mmu/mmu.c:5092:
+	int i;
+	kvm_mmu_free_roots(vcpu, mmu, KVM_MMU_ROOTS_ALL);


>  }
>  
>  static bool need_remote_flush(u64 old, u64 new)
> -- 
> 2.31.1
> 
> 
