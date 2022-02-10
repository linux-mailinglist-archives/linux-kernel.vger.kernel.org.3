Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8704C4B1956
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbiBJXUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:20:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbiBJXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:20:46 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C245F57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:20:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 10so3210281plj.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEYBOwazyXBB4q5swn+VHc3cWEwmBk8oN2W6oZO8MnU=;
        b=MzhO8xcLsRI7FWAY02lyiPIXr7mHwL1mJGN5kGNR8IvvlT9AHw/RgTFstkhVslQ9lA
         EZFFcZVJRCDhb3xMs+Ux9fF+trUl+zP/ZMsduNwa6eJWrsGX/5jtlTcHcgrFK4JHESp4
         0vG5jcKgzHMFjgNN136mdmTfBH5V5xz4Hv97M2bXKpBT/8GnWqX55ro9B3Rx1uqW7dTe
         6H9V6fNxaECJvTRsfAgjUW8HKbBvMAzhV7yS+ETdhQIA0wCOr1eP/D6IgvpusmOEJcyG
         MvnRg/JUO8xYdmc2+FMI2Dxx4v0wiaDuh8Zx3OUaJdP68gubm4PA+k9QV92uMx6PfsI+
         nzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEYBOwazyXBB4q5swn+VHc3cWEwmBk8oN2W6oZO8MnU=;
        b=j+F63GAH7mCmmnyfiFcL1PiyD0DXrckBdCiowAH2YjI0eZxZDtP8tX+Bj78VbffuTO
         pWKCMSKhZvF+MOHdRWoHbRGota7DGiB4SJv58jyTbsERck8dbI3dKmiJJpoCwJ/00Z8k
         /a4J4yVXcPoPiTmFOk9nuYPgppF5qM3XYn11aIT5ka8+eMFTyYWAl/M86ze5EXKOnvby
         K/j9vHAtG8rA5Hb2VixqKvWryS3WZAyUyduc2JGUQvfPmUmYpP56vfeQyX4XnniA4RQt
         iaq3tv5VPQK7vOJY5qbTUT16ZuOpqCfaPZ2FFZbIv6V/RZP4pZ72YwNz+UDgC50VNacy
         FtJw==
X-Gm-Message-State: AOAM530HMDJwyr3aTMp0s8t8HjSLe46TT+f/HvelAPNQ3OiFY+76R/dw
        Nd4uaGkRVPoVIDxt6q1k1JoRew==
X-Google-Smtp-Source: ABdhPJyhYDtkDRNZ6HXA+/v9rlFDnE0EuMGR4gHDzmuf1fZWBqX1CDR1beqTGYtqoNv3a1Xd6i9I2A==
X-Received: by 2002:a17:902:d4c1:: with SMTP id o1mr9966260plg.167.1644535244250;
        Thu, 10 Feb 2022 15:20:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 3sm3097905pjk.29.2022.02.10.15.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:20:43 -0800 (PST)
Date:   Thu, 10 Feb 2022 23:20:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 04/12] KVM: MMU: WARN if PAE roots linger after
 kvm_mmu_unload
Message-ID: <YgWdyN3uarajuLdG@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209170020.1775368-5-pbonzini@redhat.com>
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

On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e0c0f0bc2e8b..7b5765ced928 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5065,12 +5065,21 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
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

I'm somewhat ambivalent, but if you're at all on the fence, I vote to drop this
one.  I've always viewed the WARN on root_hpa as gratuitous.

But, if it helped during development, then why not...
