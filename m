Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30B747368C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhLMVZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhLMVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:25:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE02C061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:25:47 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b19so23792969ljr.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+tkjtiKE4PQywm3LVg9i1CKxKQ0WdBnc1gv2fjUePM=;
        b=K9VnqRqylJIX/G5yx3eF3tq/fUQhkWESuuE0Hj1THqYfv/Q2Rp+rzSgVorw9mFUIwa
         RDnxdnKNf8/TWVb0pZTn1IJjkvWYB4MSecWCPqDl7KWUOY64vie79jkdodpcxsDnyJNo
         jktwUZ41TV+Yvf7hNExCBfkuikdDqFM7cR3QIKpgPC7/PcQ4k3gt5kwYYjHSf5Wo7/MG
         VXA0OGVpqect0Rz30MefHCto7n2RnMl/goNnblVTbemnIInHY8mcayQCNXkr3+J0Ah93
         YFWNHVuLXOEqIknAy2NrphPVf6Vj1HAZBqb++9eYajPYGwsGQSFwK8rPEHBXLkE3cWUh
         +yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+tkjtiKE4PQywm3LVg9i1CKxKQ0WdBnc1gv2fjUePM=;
        b=qyLz1vu1KLwk65/Y1EX2RW2IP/lkY4Df9szlTvMlI4QYfAVswE1QyDkaBkFSSLGn65
         wUsxDRDNYKHwel7TxUNVopfn1E7soj2dhP+12B5R7lwk7Zcxp8XwYGjKMhCNw7lKZCgX
         2fPaZpeXMR0eW2KPTYk+j9zJHliO8LZfWcEoH4RjJvLbR3daxOAdYITYtEFvGsyblEU3
         FNLQELuK0xbkjDArCNPk/W85jAmOLylDqO0RhRd4h7QLyuwoCQWglUioeLNr6e5dhZsY
         Q5Im8bUuWitEcMvSNI3RPhdkrcFyNyjqEqTHn1+msk1OmbJlqAVDZv7c/bU4vFbHb1/A
         gMKw==
X-Gm-Message-State: AOAM533H5dlLUZ1Lro7r4ozMWQ2Px29xCGttOOkZFkNRssVCY91nz/Ol
        6kjZioZHGUfZVSNsCJRseUKxKvVZp0ruwdtM1INEcA==
X-Google-Smtp-Source: ABdhPJxBfWZvQRcNPHwmqwxKnL5xyxbE1L7eXNgUPnSKiL3tSR81flv5yM3hb0wvM1H/QFxVD3v3g85RIt9tBLSEF64=
X-Received: by 2002:a2e:7a06:: with SMTP id v6mr1016023ljc.198.1639430745237;
 Mon, 13 Dec 2021 13:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20211211001157.74709-1-pbonzini@redhat.com>
In-Reply-To: <20211211001157.74709-1-pbonzini@redhat.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 13 Dec 2021 13:25:18 -0800
Message-ID: <CALzav=eFgjTV_4f_RfG9xA3DUy3n=TDth86AHX1XmYC6CAaj=w@mail.gmail.com>
Subject: Re: [PATCH] Revert "KVM: VMX: Save HOST_CR3 in vmx_prepare_switch_to_guest()"
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        laijs@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 4:12 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This reverts commit 15ad9762d69fd8e40a4a51828c1d6b0c1b8fbea0.
>
> David Matlack reports:
>
> "While testing some patches I ran into a VM_BUG_ON that I have been able to
> reproduce at kvm/queue commit 45af1bb99b72 ("KVM: VMX: Clean up PI
> pre/post-block WARNs").
>
> To repro run the kvm-unit-tests on a kernel built from kvm/queue with
> CONFIG_DEBUG_VM=y. I was testing on an Intel Cascade Lake host and have not
> tested in any other environments yet. The repro is not 100% reliable, although
> it's fairly easy to trigger and always during a vmx* kvm-unit-tests
>
> Given the details of the crash, commit 15ad9762d69f ("KVM: VMX: Save HOST_CR3
> in vmx_prepare_switch_to_guest()") and surrounding commits look most suspect."
>
> Reported-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I have not been able to reproduce the VM_BUG_ON with this revert.

Tested-by: David Matlack <dmatlack@google.com>

> ---
>         Not tested yet.  I did reproduce the WARN with debug kernels though.
> ---
>  arch/x86/kvm/vmx/nested.c |  8 +++++++-
>  arch/x86/kvm/vmx/vmx.c    | 17 +++++++----------
>  2 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 2f6f465e575f..26b236187850 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3054,7 +3054,7 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
>  static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
> -       unsigned long cr4;
> +       unsigned long cr3, cr4;
>         bool vm_fail;
>
>         if (!nested_early_check)
> @@ -3077,6 +3077,12 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>          */
>         vmcs_writel(GUEST_RFLAGS, 0);
>
> +       cr3 = __get_current_cr3_fast();
> +       if (unlikely(cr3 != vmx->loaded_vmcs->host_state.cr3)) {
> +               vmcs_writel(HOST_CR3, cr3);
> +               vmx->loaded_vmcs->host_state.cr3 = cr3;
> +       }
> +
>         cr4 = cr4_read_shadow();
>         if (unlikely(cr4 != vmx->loaded_vmcs->host_state.cr4)) {
>                 vmcs_writel(HOST_CR4, cr4);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 640f4719612c..7826556b2a47 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1103,7 +1103,6 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>  #ifdef CONFIG_X86_64
>         int cpu = raw_smp_processor_id();
>  #endif
> -       unsigned long cr3;
>         unsigned long fs_base, gs_base;
>         u16 fs_sel, gs_sel;
>         int i;
> @@ -1168,14 +1167,6 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>  #endif
>
>         vmx_set_host_fs_gs(host_state, fs_sel, gs_sel, fs_base, gs_base);
> -
> -       /* Host CR3 including its PCID is stable when guest state is loaded. */
> -       cr3 = __get_current_cr3_fast();
> -       if (unlikely(cr3 != host_state->cr3)) {
> -               vmcs_writel(HOST_CR3, cr3);
> -               host_state->cr3 = cr3;
> -       }
> -
>         vmx->guest_state_loaded = true;
>  }
>
> @@ -6638,7 +6629,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_vmx *vmx = to_vmx(vcpu);
> -       unsigned long cr4;
> +       unsigned long cr3, cr4;
>
>         /* Record the guest's net vcpu time for enforced NMI injections. */
>         if (unlikely(!enable_vnmi &&
> @@ -6683,6 +6674,12 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>                 vmcs_writel(GUEST_RIP, vcpu->arch.regs[VCPU_REGS_RIP]);
>         vcpu->arch.regs_dirty = 0;
>
> +       cr3 = __get_current_cr3_fast();
> +       if (unlikely(cr3 != vmx->loaded_vmcs->host_state.cr3)) {
> +               vmcs_writel(HOST_CR3, cr3);
> +               vmx->loaded_vmcs->host_state.cr3 = cr3;
> +       }
> +
>         cr4 = cr4_read_shadow();
>         if (unlikely(cr4 != vmx->loaded_vmcs->host_state.cr4)) {
>                 vmcs_writel(HOST_CR4, cr4);
> --
> 2.31.1
>
