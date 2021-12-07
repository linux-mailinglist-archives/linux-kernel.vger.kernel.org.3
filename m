Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1A46C1B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhLGRbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhLGRbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:31:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD21C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:28:12 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q25so84635oiw.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=127Blks1Q4VlpHmKrrK4q+CkIfRWXTNrw0+PbJStkv4=;
        b=FV1EPNx67UXO23hXV9Xyq3h7F7fWDd2yKX0bHvgoo4z1ZjUNL53qm6PmL4V0+6W3Nx
         Dv3qhZzdPvO2ucuR8HrROUe8QfjBYN331KzuQMHYaWczxCVYVfUWP4PvbbDzmuhjuCAO
         ClZYHXHsrNSd3W8wMzaajjAR1M85NwhoqKD8zcUs1qv3mS1PFS35w8uwBwdUsroPQJRD
         qK0Qdff+TgSsFXOeRqkVfRMOp9G+zjilFQvSm5AZzUVORPOQqlukH76jm76tJTAFq/7A
         ztukYdYKkeFKWzFeghD7Irx0F8ngWORJVE7EMsWi8LYb5DSNwDKfl6/m8TJsML2FyH3X
         YnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=127Blks1Q4VlpHmKrrK4q+CkIfRWXTNrw0+PbJStkv4=;
        b=tGEFgaSZjBzM1rLKid1dJtkmvf/3gkhi1BIG2kMDxya5ae9uPpc3EP8BkeDjEFKhI8
         1F51SKCJgWtBGLjlBwe4kpuyqrJx8SKIklkdr2xCSO9S8M4IC4DSrCZJAWZgaMOnEZh3
         8VfpbEb3VMZsLRFVlPr/PnskTp29+Edeg0RJfXA5iI+6UPQv03lGXyyxKBxy7YFsg55z
         Pu2EcthBc0XcD6eCmDCxuh33CV/c7e55MWdH7fLUfh18Bo9c/Mfw8lbvg2jOH00yC1vh
         CUsdqfrft/hdts8lJWJT1NjZ3n8ivqYJ1PTboZLvy9aJhZF/rWcR92TOhybW/dB5Fhoz
         dlMw==
X-Gm-Message-State: AOAM533zDavqqJVBt+XEgUGalGn7zwVXovwoDV3RqnorTyG9dOz1wL87
        KNbSBBB4WjwRY92mmUHiux8jLi3XGTV1NG1pS24K+w==
X-Google-Smtp-Source: ABdhPJwttMytLV3WL5lm3rs4pFXF3nwOFzB+IFRe4OLexZMF01fCVZcoMcGDdanImUMhmqKolsN+DsINpk+QRf6kJxw=
X-Received: by 2002:aca:2319:: with SMTP id e25mr6523576oie.164.1638898091817;
 Tue, 07 Dec 2021 09:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20211207043100.3357474-1-marcorr@google.com> <c8889028-9c4e-cade-31b6-ea92a32e4f66@amd.com>
 <CAA03e5E7-ns7w9B9Tu7pSWzCo0Nh7Ba5jwQXcn_XYPf_reRq9Q@mail.gmail.com> <5e69c0ca-389c-3ace-7559-edd901a0ab3c@amd.com>
In-Reply-To: <5e69c0ca-389c-3ace-7559-edd901a0ab3c@amd.com>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 7 Dec 2021 09:28:00 -0800
Message-ID: <CAA03e5Gf=ZsAKhuLCEtYCCf0UuNXSHRXQHgmjOj3MKtbiSMbqQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Always set kvm_run->if_flag
To:     Tom Lendacky <Thomas.Lendacky@amd.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 8:00 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 12/7/21 9:14 AM, Marc Orr wrote:
> > On Tue, Dec 7, 2021 at 6:43 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 12/6/21 10:31 PM, Marc Orr wrote:
> >>> The kvm_run struct's if_flag is apart of the userspace/kernel API. The
> >>> SEV-ES patches failed to set this flag because it's no longer needed by
> >>> QEMU (according to the comment in the source code). However, other
> >>> hypervisors may make use of this flag. Therefore, set the flag for
> >>> guests with encrypted regiesters (i.e., with guest_state_protected set).
> >>>
> >>> Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
> >>> Signed-off-by: Marc Orr <marcorr@google.com>
> >>> ---
> >>>    arch/x86/include/asm/kvm-x86-ops.h | 1 +
> >>>    arch/x86/include/asm/kvm_host.h    | 1 +
> >>>    arch/x86/kvm/svm/svm.c             | 8 ++++++++
> >>>    arch/x86/kvm/vmx/vmx.c             | 6 ++++++
> >>>    arch/x86/kvm/x86.c                 | 9 +--------
> >>>    5 files changed, 17 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> >>> index cefe1d81e2e8..9e50da3ed01a 100644
> >>> --- a/arch/x86/include/asm/kvm-x86-ops.h
> >>> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> >>> @@ -47,6 +47,7 @@ KVM_X86_OP(set_dr7)
> >>>    KVM_X86_OP(cache_reg)
> >>>    KVM_X86_OP(get_rflags)
> >>>    KVM_X86_OP(set_rflags)
> >>> +KVM_X86_OP(get_if_flag)
> >>>    KVM_X86_OP(tlb_flush_all)
> >>>    KVM_X86_OP(tlb_flush_current)
> >>>    KVM_X86_OP_NULL(tlb_remote_flush)
> >>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> >>> index 860ed500580c..a7f868ff23e7 100644
> >>> --- a/arch/x86/include/asm/kvm_host.h
> >>> +++ b/arch/x86/include/asm/kvm_host.h
> >>> @@ -1349,6 +1349,7 @@ struct kvm_x86_ops {
> >>>        void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
> >>>        unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
> >>>        void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
> >>> +     bool (*get_if_flag)(struct kvm_vcpu *vcpu);
> >>>
> >>>        void (*tlb_flush_all)(struct kvm_vcpu *vcpu);
> >>>        void (*tlb_flush_current)(struct kvm_vcpu *vcpu);
> >>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >>> index d0f68d11ec70..91608f8c0cde 100644
> >>> --- a/arch/x86/kvm/svm/svm.c
> >>> +++ b/arch/x86/kvm/svm/svm.c
> >>> @@ -1585,6 +1585,13 @@ static void svm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
> >>>        to_svm(vcpu)->vmcb->save.rflags = rflags;
> >>>    }
> >>>
> >>> +static bool svm_get_if_flag(struct kvm_vcpu *vcpu)
> >>> +{
> >>> +     struct vmcb *vmcb = to_svm(vcpu)->vmcb;
> >>> +
> >>> +     return !!(vmcb->control.int_state & SVM_GUEST_INTERRUPT_MASK);
> >>
> >> I'm not sure if this is always valid to use for non SEV-ES guests. Maybe
> >> the better thing would be:
> >>
> >>          return sev_es_guest(vcpu->kvm) ? vmcb->control.int_state & SVM_GUEST_INTERRUPT_MASK
> >>                                         : kvm_get_rflags(vcpu) & X86_EFLAGS_IF;
> >>
> >> (Since this function returns a bool, I don't think you need the !!)
> >
> > I had the same reservations when writing the patch. (Why fix what's
> > not broken.) The reason I wrote the patch this way is based on what I
> > read in APM vol2: Appendix B Layout of VMCB: "GUEST_INTERRUPT_MASK -
> > Value of the RFLAGS.IF bit for the guest."
>
> I just verified with the hardware team that this flag is indeed only set
> for a guest with protected state (SEV-ES / SEV-SNP). An update to the APM
> will be made.

Got it now. Then the change you suggested is a must! Thanks, Tom.
