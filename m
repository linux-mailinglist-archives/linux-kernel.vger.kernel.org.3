Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E14BBE04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiBRRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:08:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbiBRRIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:08:30 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25836698
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:08:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g1so2792737pfv.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ll9T055JzV/wdZpn69fyeh7rHkmZmXKfJNyyV9dc/Ag=;
        b=FoT4ywa0lsi4Q3P6AqAntiw3MSb+cD6KgA9QQiR5TUcijEoS6W3qURgnIevv5OZtYs
         /zCj/fKUri1RFOIsQAG8t3gKjMm5wGapBoVzmo31uNAuMOeb6V1wm61wvb0EHVqbCVy6
         OgInI7BUjeUEvAwuhDO1Bb1iQayrDDodwGSNabdj1/BpZJgbsY5fPP5T1hY2sskXD909
         Ywg0fpbMi0q7eGjILGfYuKFR0IzMd28wkSRsUiUNonMg1buTyUP5J0SWhu7/HUBwatPd
         y3/DGYFrSpanixG8KhIdvaQXdSYZWKj4tmI/i89WSXT4qi4c3J2ypX2flom2r1IrQk1W
         BjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ll9T055JzV/wdZpn69fyeh7rHkmZmXKfJNyyV9dc/Ag=;
        b=USWnJbgxAzO4Wt5a/CWdfb+CR446mrfQxXT42oLXlLareiUu4trBzFWeoFdX6O0wUn
         bsSvI8TzZ358bCe/TldO0dee25I5tnmO01C3VwZ6BKvWhANrIT6e8bTOr0FC2rZb4kte
         j8XWByAqU+7+NPs1Nq4F0uz03C1u4RuIQmXdbFtvIagpJfPokBVSscshdyklVkZrDXlm
         wnF5xx8DFqK82MOjq0bckXx4b3QgZ1GWRjWeBYZXRqB0/BzbIsxNv1ln5ysqHolEDrkd
         EA25xoMq1B4ONK9CexAp/Tv1Xr3ukA+Dnb3lhl0/M5F0rcfFewp4ZOB05VGD0Uo3DImF
         hcNQ==
X-Gm-Message-State: AOAM5316oGQ3RCBRS+XfREsTVO8Msd5EFdIzkegE9uHJbt2YA5t122Yb
        BhYKVCVbvgcNYeh2VxWWjpTN5g==
X-Google-Smtp-Source: ABdhPJw/DQfbXN1JM/YyP1jNU/eCsVFHl7l0+hZi656gcs+xQh6y73X/pDa10jfoz87JL3QLjF3d5g==
X-Received: by 2002:a05:6a00:8d5:b0:4e1:77c9:def8 with SMTP id s21-20020a056a0008d500b004e177c9def8mr8713738pfu.55.1645204091920;
        Fri, 18 Feb 2022 09:08:11 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m126sm9994947pga.94.2022.02.18.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:08:11 -0800 (PST)
Date:   Fri, 18 Feb 2022 17:08:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 01/18] KVM: x86: host-initiated EFER.LME write affects
 the MMU
Message-ID: <Yg/Sd3UE2aCNimGj@google.com>
References: <20220217210340.312449-1-pbonzini@redhat.com>
 <20220217210340.312449-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217210340.312449-2-pbonzini@redhat.com>
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

The shortlog doesn't come remotely close to saying what this patch does, it's
simply a statement.

  KVM: x86: Reset the MMU context if host userspace toggles EFER.LME

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> While the guest runs, EFER.LME cannot change unless CR0.PG is clear, and therefore
> EFER.NX is the only bit that can affect the MMU role.  However, set_efer accepts
> a host-initiated change to EFER.LME even with CR0.PG=1.  In that case, the
> MMU has to be reset.

Wrap at ~75 please.

> Fixes: 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated writes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

With nits addressed,

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  arch/x86/kvm/mmu.h | 1 +
>  arch/x86/kvm/x86.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 51faa2c76ca5..a5a50cfeffff 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -48,6 +48,7 @@
>  			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE)
>  
>  #define KVM_MMU_CR0_ROLE_BITS (X86_CR0_PG | X86_CR0_WP)
> +#define KVM_MMU_EFER_ROLE_BITS (EFER_LME | EFER_NX)
>  
>  static __always_inline u64 rsvd_bits(int s, int e)
>  {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d3da64106685..99a58c25f5c2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1647,7 +1647,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	}
>  
>  	/* Update reserved bits */

This comment needs to be dropped, toggling EFER.LME affects more than just reserved
bits.

> -	if ((efer ^ old_efer) & EFER_NX)
> +	if ((efer ^ old_efer) & KVM_MMU_EFER_ROLE_BITS)
>  		kvm_mmu_reset_context(vcpu);
>  
>  	return 0;
> -- 
> 2.31.1
> 
> 
