Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D022E4B0286
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiBJB4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:56:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiBJBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:55:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2512B6AD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:44:52 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c3so528498pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FeQIZwYV9Kr9xuueKFIwhbOFaFrQZ6eikRo6PhomRJ0=;
        b=HyP0G2xVMdq2VnlsZov6+NhKm2+A8CE6JKO3PZuIkSe952Mf2X7Tyk2LNNrhVao/RJ
         MaxjSCCpfnkbhmTlTDOJ+ov9Ph5M1U3H38ZkRPw0+Ya/cLM2p9QCFBYrpxbHg7Bxxt91
         djknGKt1nsczuyoQ9wbTeN1/DzJfLYlVThpCBRhG7ERfQ6lXgjrQ+7L+0pc04qxCJNQd
         9KwZn6CZjVljGizTubX32VnRR7mqswelugRWXOAchatkQobdqySfZqswOKGGJpXUeGVR
         ySvFAeQRsQHbn8++ILwblyHIqqdSVA+9Sq+ge4uED81RzeJVfzIXiJHbouKVF1ZidkYv
         SdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FeQIZwYV9Kr9xuueKFIwhbOFaFrQZ6eikRo6PhomRJ0=;
        b=I5icHrBGzmTJ67exbhYlUm7Aibt0xQ/p+tJMVIvw51xQh802OaQGgjBZWAWTooxth0
         4TDNw/SBFLueiOO9i3lqCGC5vm3S9fMrl6gFO5A+0R9YM4S00MChK9mcVu6Yp1Coyo05
         3K1v1nrxREqYsSURSGADCuyUFWWLWpX0bCS9qdUO2SkII2utqHezg1HGHVt2XPlyx9ij
         M+9UwgDudlPtLzHawuWshyvCAYwMhepj6Y+wCEVO52xaORESV2827SDB5C0TreuXDLBt
         CzTgIOibcvRTnz1iVDByucYaCQYBFfYysNxXZFEnKNP9vBLkvJXvYoZJZOhoJZ0FpoLg
         xt+A==
X-Gm-Message-State: AOAM533cvKR90U31iclaEaULlDv/abDCGB5+uMfJ705xhMk+yfjK015E
        2XE3XI3lALtQTKWikq8mVJ42Sh4k+J4Cww==
X-Google-Smtp-Source: ABdhPJwFGI08SMoF42QjabCXD1l2JAJoIhfk+mU1gxaZWTzjAYyCs2422HTKsZ96FXJ1qNg2rSVMFg==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr5081998plb.147.1644454064446;
        Wed, 09 Feb 2022 16:47:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b20sm2043396pfv.31.2022.02.09.16.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:47:43 -0800 (PST)
Date:   Thu, 10 Feb 2022 00:47:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 07/23] KVM: MMU: remove kvm_mmu_calc_root_page_role
Message-ID: <YgRgrCxLM0Ctfwrj@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204115718.14934-8-pbonzini@redhat.com>
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

On Fri, Feb 04, 2022, Paolo Bonzini wrote:
> Since the guest PGD is now loaded after the MMU has been set up
> completely, the desired role for a cache hit is simply the current
> mmu_role.  There is no need to compute it again, so __kvm_mmu_new_pgd
> can be folded in kvm_mmu_new_pgd.
> 
> As an aside, the !tdp_enabled case in the function was dead code,
> and that also gets mopped up as a side effect.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

...

> @@ -4871,7 +4864,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
>  
>  	shadow_mmu_init_context(vcpu, context, &regs, new_role);
>  	reset_shadow_zero_bits_mask(vcpu, context, is_efer_nx(context));
> -	__kvm_mmu_new_pgd(vcpu, nested_cr3, new_role.base);
> +	kvm_mmu_new_pgd(vcpu, nested_cr3);

I'm not a fan of this change.  Conceptually it makes perfect sense, but I really,
really don't like the hidden dependency between shadow_mmu_init_context() and
kvm_mmu_new_pgd().

It's less bad once patch 01 is jettisoned, but I still don't love.  Yes, it's
silly to call __kvm_mmu_new_pgd() before the role is set, but it is robust.  And
either way we end up with an incoherent state, e.g. with this change, the role of
the shadow page pointed at by mmu->root_hpa doesn't match the role of the mmu itself.

Furthermore, the next patch to take advantage of this change is subtly broken/wrong.
It drops kvm_mmu_calc_root_page_role() from kvm_mmu_new_pgd() under the guise that
kvm_mmu_new_pgd() is called with an up-to-date mmu_role, but that is incorrect for
both nested VM-Enter with TDP disabled in the host and nested VM-Exit (regardless of
TDP enabling).

Both nested_vmx_load_cr3() and nested_svm_load_cr3() load a new CR3 before updating
the mmu.  Why, I have no idea.  Probably a historical wart

The nested mess is likely easily solved, I don't see any obvious issue with swapping
the order.  But I still don't love the subtlety.  I do like shaving cycles, just
not the subtlety...

If we do rework things to have kvm_mmu_new_pgd() pull the role from the mmu, then
we should first add a long overdue audit/warn that KVM never runs with a mmu_role
that isn't consistent with respect to its root SP's role.  E.g. finally get rid of
mmu_audit.c, add a proper CONFIG_KVM_AUDIT_MMU (which I'll happily turn on for all
my kernels), and start adding WARNs and other assertions.
