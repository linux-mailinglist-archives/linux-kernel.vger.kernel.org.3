Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB396520A17
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiEJA0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiEJAZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:25:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3B3CFFB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:20:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c14so13593220pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 17:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6TNojKVv56zEQu5J8y3waUGCEfzye1TQUE2vhIo/SI=;
        b=K/VwXwWBexGPAq6+q5UO1BP/yQQjJh8FEjb7U6eKXcyATKVgTk+8v8zgwmQqAdR50d
         WjJzY9jicDv+OMv2H2FI1pXR46tKTZdWKJgyXU5D0RfWEi3PbrcGJSL2d2xG2nVb30/9
         NYuxSOdFYLfTpqaFlv8VA1hOMqE4TryI5+WQW51X7fwMZ/Y4Hxvo9xmJQruSvIC3d/HX
         wCtcvaUTLS2+HD5NrQXkWNW3L5aILTrxMZkYafBBCgNk1lpdihMhZAXw1ZnDUskcYYj4
         z38+gC4DtrNIt6LR6i/0sOR7yAx5k3b2eGjMAHgZmzMBVrBo+FaZQAQVKhhk/kL0CK2j
         CHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6TNojKVv56zEQu5J8y3waUGCEfzye1TQUE2vhIo/SI=;
        b=evy3bdecRrwtibPdYWp6opAxbc7cf06g2UfqmbP8kWWOx6t9M63mjFCJBM9eaCVh1V
         zL6R6baeaAZCNIxFqQdgbdPn/ws2/wl7bU4hPJ0e050g1NVtZ9JmzXi0P7cG4Kf6V1fp
         PNhEcroReCmFKmlbv4cZATBmuma0S0OVl+6xhvtqEPNsawuIbdCwlXC2CDmBqR2yItVS
         7i9jU4E79+uso+ey0qLHWBkp1VDOHGt2ILqeDXaiSB8N32a6oALGdq1AmFu9CqXHfvks
         Edb34r4z6CLLazPUAZbo6Bv1kkSv560EdrIwBRW2HMPcCFeWPTquFQxaQOWrjopKlB+r
         HwSA==
X-Gm-Message-State: AOAM5306z+ZEVVZr1mW+jCKQ70Dr+NlC2JzyepOB9uBKf1ldcLGysl/K
        cl4sbuboFJXDfVfo5wZLGANtmw==
X-Google-Smtp-Source: ABdhPJyP7ZCnz+cpRIYlUMC6ytpr2/AQUZHK2XO9558Nvr7psT8O2WYE8oPo/zCH2LrCmZlrrlrG6Q==
X-Received: by 2002:aa7:970f:0:b0:50d:301e:e6ce with SMTP id a15-20020aa7970f000000b0050d301ee6cemr18194913pfg.61.1652142046206;
        Mon, 09 May 2022 17:20:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 2-20020aa79242000000b0050dc762813csm9170494pfp.22.2022.05.09.17.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 17:20:45 -0700 (PDT)
Date:   Tue, 10 May 2022 00:20:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 16/22] KVM: x86/mmu: remove redundant bits from extended
 role
Message-ID: <Ynmv2X5eLz2OQDMB@google.com>
References: <20220414074000.31438-1-pbonzini@redhat.com>
 <20220414074000.31438-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414074000.31438-17-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022, Paolo Bonzini wrote:
> Before the separation of the CPU and the MMU role, CR0.PG was not
> available in the base MMU role, because two-dimensional paging always
> used direct=1 in the MMU role.  However, now that the raw role is
> snapshotted in mmu->cpu_role, CR0.PG *can* be found (though inverted)
> as !cpu_role.base.direct.  There is no need to store it again in union
> kvm_mmu_extended_role; instead, write an is_cr0_pg accessor by hand that
> takes care of the inversion.
> 
> Likewise, CR4.PAE is now always present in the CPU role as
> !cpu_role.base.has_4_byte_gpte.  The inversion makes certain tests on
> the MMU role easier, and is easily hidden by the is_cr4_pae accessor
> when operating on the CPU role.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 --
>  arch/x86/kvm/mmu/mmu.c          | 14 ++++++++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 6bc5550ae530..52ceeadbed28 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -367,8 +367,6 @@ union kvm_mmu_extended_role {
>  	struct {
>  		unsigned int valid:1;
>  		unsigned int execonly:1;
> -		unsigned int cr0_pg:1;
> -		unsigned int cr4_pae:1;
>  		unsigned int cr4_pse:1;
>  		unsigned int cr4_pke:1;
>  		unsigned int cr4_smap:1;
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 483a3761db81..cf8a41675a79 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -224,16 +224,24 @@ static inline bool __maybe_unused is_##reg##_##name(struct kvm_mmu *mmu)	\
>  {								\
>  	return !!(mmu->cpu_role. base_or_ext . reg##_##name);	\
>  }
> -BUILD_MMU_ROLE_ACCESSOR(ext,  cr0, pg);
>  BUILD_MMU_ROLE_ACCESSOR(base, cr0, wp);
>  BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pse);
> -BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pae);
>  BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smep);
>  BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smap);
>  BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pke);
>  BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
>  BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
>  
> +static inline bool is_cr0_pg(struct kvm_mmu *mmu)
> +{
> +        return !mmu->cpu_role.base.direct;
> +}
> +
> +static inline bool is_cr4_pae(struct kvm_mmu *mmu)
> +{
> +        return !mmu->cpu_role.base.has_4_byte_gpte;

If it's not too late for fixup, this should be:

	return is_cr0_pg(mmu) && !mmu->cpu_role.base.has_4_byte_gpte;

because has_4_byte_gpte will also be false when paging is disabled.  The current
code works because the only users check is_cr0_pg() before hand, but IMO this is
unnecessarily dangerous to leave lying around (and the previous code set cr4_pae
iff cr0_pg=1).

If it's too late for fixup...

--
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 9 May 2022 17:13:39 -0700
Subject: [PATCH] KVM: x86/mmu: Return true from is_cr4_pae() iff CR0.PG is set

Condition is_cr4_pae() on is_cr0_pg() in addition to the !4-byte gPTE
check.  From the MMU's perspective, PAE is disabling if paging is
disabled.  The current code works because all callers check is_cr0_pg()
before invoking is_cr4_pae(), but relying on callers to maintain that
behavior is unnecessarily risky.

Fixes: faf729621c96 ("KVM: x86/mmu: remove redundant bits from extended role")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 909372762363..d1c20170a553 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -240,7 +240,7 @@ static inline bool is_cr0_pg(struct kvm_mmu *mmu)

 static inline bool is_cr4_pae(struct kvm_mmu *mmu)
 {
-        return !mmu->cpu_role.base.has_4_byte_gpte;
+        return is_cr0_pg(mmu) && !mmu->cpu_role.base.has_4_byte_gpte;
 }

 static struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)

base-commit: 2764011106d0436cb44702cfb0981339d68c3509
--

