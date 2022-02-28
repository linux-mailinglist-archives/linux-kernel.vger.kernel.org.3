Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21354C7E31
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiB1XSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiB1XSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:18:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B83FBF7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:18:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s14so19798435edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ng4LgEMIm2ZmUALh0wWhtFzvLwEBPi1PEXH7f99he44=;
        b=UcalAtgGjlIwzx3+xqpfMMaSA+UIKPp2JQD8fF1yqEpiQ0kzSf8wbW2lrxYMICigY4
         z7efQTSrHexP+Bzvzqj67TrfRKFsg0fUVpU7jfvKpls13Fqv1r3kyWDfCalgrvr1eLpJ
         UUo8EAT+TW/ArMaAS0LL1FvVCIqzlz8IpdZKEpEXBOWPp755E0V8cOYTXvrMp2+AkQpt
         m/THDPcHTWk+O2FqsxBmN5J2a2clKFu0QtdfgkMWrfV5GjaD/bo+PItPiY8u/tIqk+mi
         PBnIKZKkDVz5lTuuCNuBgvtYwY/uYWD8PFKw6B9uVFzQJSYFIUxsfkI68Qtd5j2ZVR1q
         twaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ng4LgEMIm2ZmUALh0wWhtFzvLwEBPi1PEXH7f99he44=;
        b=nCcbP5V2etH0geZ52mmGN+4S7ZS6tk4mj+LnCcKIfjXSiOTZWbYlOiq9F6v7SJexyq
         mapOpj5SpBCYuLwBcMIXyBTUgIAUhsxIc8VuG8FWRs03OvyPH+Ak6Vr7Pt3nQFuUXuG0
         +dfsMQCkZl6w8/pHiBGj8mGBpJTgxPN7zocB9s10xYOZ6cR+Ofj10covk+zodt4FZrWs
         zBbyveLo4nI6+57m9f2HSaGvuLbMXALuEovR+YxqZBdOeKeqkqPh/Zxx27xCPVRgaAJh
         OnOzj0qw3Pe4tmIQLSi3IC1VK/J7a22x2eJr4r9vQ1jK/xQNb2gM+ZiWLe5MhnI1EjtR
         AvFA==
X-Gm-Message-State: AOAM533q1BCq1MbpuEPGceoTXr7OI3LGXTFYPwbxJj6SwRdinzHIqZdn
        HSQMP37UtFrj5Jr29tQRdH6V2w37jHhOsl7u4l5Rzg==
X-Google-Smtp-Source: ABdhPJxwokUiklXKZIjrW6pYM3G4wNkwPkn+R0wZeLRCT52J8+Qv6rRQzZQyE2NIfqAVvBsu1Q/jKr2DWPW1vJBSyLI=
X-Received: by 2002:aa7:c982:0:b0:406:3862:a717 with SMTP id
 c2-20020aa7c982000000b004063862a717mr21982583edt.358.1646090285006; Mon, 28
 Feb 2022 15:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com> <20220226001546.360188-6-seanjc@google.com>
In-Reply-To: <20220226001546.360188-6-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 28 Feb 2022 15:17:53 -0800
Message-ID: <CANgfPd_G7yiByHfrJDvmQq8b--P7a9BqcLs8SHyxPM2pfrMJAg@mail.gmail.com>
Subject: Re: [PATCH v3 05/28] KVM: x86/mmu: Document that zapping invalidated
 roots doesn't need to flush
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 4:16 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Remove the misleading flush "handling" when zapping invalidated TDP MMU
> roots, and document that flushing is unnecessary for all flavors of MMUs
> when zapping invalid/obsolete roots/pages.  The "handling" in the TDP MMU
> is dead code, as zap_gfn_range() is called with shared=true, in which
> case it will never return true due to the flushing being handled by
> tdp_mmu_zap_spte_atomic().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c     | 10 +++++++---
>  arch/x86/kvm/mmu/tdp_mmu.c | 15 ++++++++++-----
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 5a931c89d27b..1c4b84e80841 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5615,9 +5615,13 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
>         }
>
>         /*
> -        * Trigger a remote TLB flush before freeing the page tables to ensure
> -        * KVM is not in the middle of a lockless shadow page table walk, which
> -        * may reference the pages.
> +        * Kick all vCPUs (via remote TLB flush) before freeing the page tables
> +        * to ensure KVM is not in the middle of a lockless shadow page table
> +        * walk, which may reference the pages.  The remote TLB flush itself is
> +        * not required and is simply a convenient way to kick vCPUs as needed.
> +        * KVM performs a local TLB flush when allocating a new root (see
> +        * kvm_mmu_load()), and the reload in the caller ensure no vCPUs are
> +        * running with an obsolete MMU.
>          */
>         kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
>  }
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index e35bd88d92fd..5994db5d5226 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -843,12 +843,20 @@ void kvm_tdp_mmu_zap_all(struct kvm *kvm)
>  void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
>  {
>         struct kvm_mmu_page *root;
> -       bool flush = false;
>
>         lockdep_assert_held_read(&kvm->mmu_lock);
>
>         for_each_invalid_tdp_mmu_root_yield_safe(kvm, root) {
> -               flush = zap_gfn_range(kvm, root, 0, -1ull, true, flush, true);
> +               /*
> +                * A TLB flush is unnecessary, invalidated roots are guaranteed
> +                * to be unreachable by the guest (see kvm_tdp_mmu_put_root()
> +                * for more details), and unlike the legacy MMU, no vCPU kick
> +                * is needed to play nice with lockless shadow walks as the TDP
> +                * MMU protects its paging structures via RCU.  Note, zapping
> +                * will still flush on yield, but that's a minor performance
> +                * blip and not a functional issue.
> +                */
> +               (void)zap_gfn_range(kvm, root, 0, -1ull, true, false, true);
>
>                 /*
>                  * Put the reference acquired in kvm_tdp_mmu_invalidate_roots().
> @@ -856,9 +864,6 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm)
>                  */
>                 kvm_tdp_mmu_put_root(kvm, root, true);
>         }
> -
> -       if (flush)
> -               kvm_flush_remote_tlbs(kvm);
>  }
>
>  /*
> --
> 2.35.1.574.g5d30c73bfb-goog
>
