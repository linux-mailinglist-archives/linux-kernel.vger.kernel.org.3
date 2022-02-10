Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D04B0287
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiBJB5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:57:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiBJB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:13 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43025FF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:40:00 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id d27so2231124vkn.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jIXSaB8xvY9E3Pj5RaMVht3zqZ9BnD/HDQ3wc2/KqUo=;
        b=WdEa0kEtsZFGVVXPkdBFJi072XyN3Og2lEwLElheq0+LpHUZlc3OABduwfH+b46cUq
         CAcSm2tBw7fJ9VwigOLightNC72EXnZ0l1/T5E5l+M4LZlGCZam7cfREjiyv/cUBSJIi
         LrCUZ9UxkWyrtg2+uX6zFDyXXAXdAkELDO3SvGYqQKDdwS+nzFh/wzhcB2QEu+T9+94z
         lJIzMXdXdpt7ModmsGoMdDofiM4XqYqXf+4WrxBwWDO3qZYKRT93E5BYZ/oET/cRM5kS
         mKnlpzjbJAj69Eee4S2Hj4ATkTwD6XE4gpUtmTw4iEzdRJ+NIs71d/O3tOBMVvgVvKHb
         t9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jIXSaB8xvY9E3Pj5RaMVht3zqZ9BnD/HDQ3wc2/KqUo=;
        b=qxhFTY7IdE4K68qU6Favvi9Hw6LrBtziWrjRA1LxRDGc3IAAnmUjElsWCuF5KfF1QC
         htDm0yW+2I+wBZ9ONEDRmFgmzOFdemLvPeYaB5kR33UfTp+0/9sa7PS7y0neIJ+nwlXd
         g3Mg6K51XBfi1y1mpJ1ubdZt8K2XcfB04+bI1fvILfZbKGnQNhK8d7pGZveGD6T1Lpmh
         uHUbfcrvW52mqztaWP10sW2vwfH34JBl+hva2hG3KKVSq6vVPP9r8rPXIy1xJzJx8075
         c4wTGiQriiXXtlTV6GV5i5DuB9cfTpOYB9af4mr8e0WsqDLOWl2xygod8s+YG8ndq6RM
         940w==
X-Gm-Message-State: AOAM5308am5nBQQXszIv69lfCjVsMi9Bfe21YfRRJsMhV7jcvTCaBzC1
        8Syh9uNJhopNZquNh7MfZ/5SoFVCSA/m2w==
X-Google-Smtp-Source: ABdhPJxm54Fh/75WZhWkTP2V0zd5dpthm24AqtRHufGYkhtFLZDthkRpQ5Pj4HbzT6cv45nhUpeb8g==
X-Received: by 2002:a62:7c92:: with SMTP id x140mr4140320pfc.35.1644455521031;
        Wed, 09 Feb 2022 17:12:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s14sm21252255pfk.65.2022.02.09.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 17:12:00 -0800 (PST)
Date:   Thu, 10 Feb 2022 01:11:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 00/23] KVM: MMU: MMU role refactoring
Message-ID: <YgRmXDn7b8GQ+VzX@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <YgGmgMMR0dBmjW86@google.com>
 <YgGq31edopd6RMts@google.com>
 <CALzav=d05sMd=ARkV+GMf9SkxKcg9c9n5ttb274M2fZrP27PDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=d05sMd=ARkV+GMf9SkxKcg9c9n5ttb274M2fZrP27PDA@mail.gmail.com>
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

On Mon, Feb 07, 2022, David Matlack wrote:
> On Mon, Feb 7, 2022 at 3:27 PM Sean Christopherson <seanjc@google.com> wrote:
> > > What do you think about calling this the guest_role instead of cpu_role?
> > > There is a bit of a precedent for using "guest" instead of "cpu" already
> > > for this type of concept (e.g. guest_walker), and I find it more
> > > intuitive.
> >
> > Haven't looked at the series yet, but I'd prefer not to use guest_role, it's
> > too similar to is_guest_mode() and kvm_mmu_role.guest_mode.  E.g. we'd end up with
> >
> >   static union kvm_mmu_role kvm_calc_guest_role(struct kvm_vcpu *vcpu,
> >                                               const struct kvm_mmu_role_regs *regs)
> >   {
> >         union kvm_mmu_role role = {0};
> >
> >         role.base.access = ACC_ALL;
> >         role.base.smm = is_smm(vcpu);
> >         role.base.guest_mode = is_guest_mode(vcpu);
> >         role.base.direct = !____is_cr0_pg(regs);
> >
> >         ...
> >   }
> >
> > and possibly
> >
> >         if (guest_role.guest_mode)
> >                 ...
> >
> > which would be quite messy.  Maybe vcpu_role if cpu_role isn't intuitive?
> 
> I agree it's a little odd. But actually it's somewhat intuitive (the
> guest is in guest-mode, i.e. we're running a nested guest).
> 
> Ok I'm stretching a little bit :). But if the trade-off is just
> "guest_role.guest_mode" requires a clarifying comment, but the rest of
> the code gets more readable (cpu_role is used a lot more than
> role.guest_mode), it still might be worth it.

It's not just guest_mode, we also have guest_mmu, e.g. we'd end up with

	vcpu->arch.root_mmu.guest_role.base.level
	vcpu->arch.guest_mmu.guest_role.base.level
	vcpu->arch.nested_mmu.guest_role.base.level

In a vacuum, I 100% agree that guest_role is better than cpu_role or vcpu_role,
but the term "guest" has already been claimed for "L2" in far too many places.

While we're behind the bikeshed... the resulting:

	union kvm_mmu_role cpu_role;
	union kvm_mmu_page_role mmu_role;

is a mess.  Again, I really like "mmu_role" in a vacuum, but juxtaposed with
	
	union kvm_mmu_role cpu_role;

it's super confusing, e.g. I expected

	union kvm_mmu_role mmu_role;

Nested EPT is a good example of complete confusion, because we compute kvm_mmu_role,
compare it to cpu_role, then shove it into both cpu_role and mmu_ole.  It makes
sense once you reason about what it's doing, but on the surface it's confusing.

	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
	u8 level = vmx_eptp_page_walk_level(new_eptp);
	union kvm_mmu_role new_role =
		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
						   execonly, level);

	if (new_role.as_u64 != context->cpu_role.as_u64) {
		/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
		context->cpu_role.as_u64 = new_role.as_u64;
		context->mmu_role.word = new_role.base.word;

Mabye this?

	union kvm_mmu_vcpu_role vcpu_role;
	union kvm_mmu_page_role mmu_role;

and some sample usage?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d25f8cb2e62b..9f9b97c88738 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4836,13 +4836,16 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 {
        struct kvm_mmu *context = &vcpu->arch.guest_mmu;
        u8 level = vmx_eptp_page_walk_level(new_eptp);
-       union kvm_mmu_role new_role =
+       union kvm_mmu_vcpu_role new_role =
                kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
                                                   execonly, level);

-       if (new_role.as_u64 != context->cpu_role.as_u64) {
-               /* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
-               context->cpu_role.as_u64 = new_role.as_u64;
+       if (new_role.as_u64 != context->vcpu_role.as_u64) {
+               /*
+                * EPT, and thus nested EPT, does not consume CR0, CR4, nor
+                * EFER, so the mmu_role is a strict subset of the vcpu_role.
+               */
+               context->vcpu_role.as_u64 = new_role.as_u64;
                context->mmu_role.word = new_role.base.word;

                context->page_fault = ept_page_fault;



And while I'm on a soapbox....  am I the only one that absolutely detests the use
of "context" and "g_context"?  I'd be all in favor of renaming those to "mmu"
throughout the code as a prep to this series.

I also think we should move the initializing of guest_mmu => mmu into the MMU
helpers.  Pulling the mmu from guest_mmu but then relying on the caller to wire
up guest_mmu => mmu so that e.g. kvm_mmu_new_pgd() works is gross and confused
the heck out of me.  E.g.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d25f8cb2e62b..4e7fe9758ce8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4794,7 +4794,7 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
                             unsigned long cr4, u64 efer, gpa_t nested_cr3)
 {
-       struct kvm_mmu *context = &vcpu->arch.guest_mmu;
+       struct kvm_mmu *mmu = &vcpu->arch.guest_mmu;
        struct kvm_mmu_role_regs regs = {
                .cr0 = cr0,
                .cr4 = cr4 & ~X86_CR4_PKE,
@@ -4806,6 +4806,8 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
        mmu_role = cpu_role.base;
        mmu_role.level = kvm_mmu_get_tdp_level(vcpu);

+       vcpu->arch.mmu = &vcpu->arch.guest_mmu;
+
        shadow_mmu_init_context(vcpu, context, cpu_role, mmu_role);
        kvm_mmu_new_pgd(vcpu, nested_cr3);
 }
@@ -4834,12 +4836,14 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
                             int huge_page_level, bool accessed_dirty,
                             gpa_t new_eptp)
 {
-       struct kvm_mmu *context = &vcpu->arch.guest_mmu;
+       struct kvm_mmu *mmu = &vcpu->arch.guest_mmu;
        u8 level = vmx_eptp_page_walk_level(new_eptp);
        union kvm_mmu_role new_role =
                kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
                                                   execonly, level);

+       vcpu->arch.mmu = mmu;
+
        if (new_role.as_u64 != context->cpu_role.as_u64) {
                /* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
                context->cpu_role.as_u64 = new_role.as_u64;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1218b5a342fc..d0f8eddb32be 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -98,8 +98,6 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)

        WARN_ON(mmu_is_nested(vcpu));

-       vcpu->arch.mmu = &vcpu->arch.guest_mmu;
-
        /*
         * The NPT format depends on L1's CR4 and EFER, which is in vmcb01.  Note,
         * when called via KVM_SET_NESTED_STATE, that state may _not_ match current



