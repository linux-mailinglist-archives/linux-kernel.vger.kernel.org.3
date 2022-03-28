Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B54E9EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiC1SX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245196AbiC1SX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:23:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831A363539
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:22:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 5so26251107lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=987VgRiKOzh7tTiNOEp75EzBpME2g11sCtBMEaePFH4=;
        b=LJ6wJ7vclB+ET04zMco5AkQet5XMwRyLiSn+jxzEXOIPjSxemr+NgjzAZIF2etD7lN
         UUu2nIjBIV46zJTsxDO70RmVdI/1aSxh0HzFT0BRDlnCUUoAfE3mqTQM5jAQjPxHrvBO
         leNJnMUav125+ns6yVCcX7Y8Zx16s4AY5FKQDr6813/UBYsl3jj2qbXoRRoLO8zh1KJi
         3z6WwbaUGklayIl7UO2JZ4Zfzus51PSUCOisIE3apd8inwMhQ1cD+ypuhC6XzMEWl+9O
         z2KBqa+o69jfjgrf92pevt7XIYigf3swSTYVfhf9pcMuN/knkV/zIAUsON02QYaGJark
         3rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=987VgRiKOzh7tTiNOEp75EzBpME2g11sCtBMEaePFH4=;
        b=fwREOP/Z0rfaZ82CPBbs4fEEgRfRaQbvXl5wOKGcLBQysvaNwFUgfw0sRaIs3ij0Sw
         pezf13LAjI4p12cgmdf6SVSHnZBzc2MYGkH1Hjvz6j8mAqtaR/CDusNauW6eVAZUZQt5
         E38xw8ZbiIpAu3cMpngBiVC3OfWP+DxtdGCskAc/eXoQZygPYAm+Yrn52w2dzdzferYd
         kyj3TklyutVatbTp4gYSX947bc64rVZahG6CN1ydKuS5ZzY5x/y4APJgGJFHfCC45YyS
         PEqqJOcLEnRTENoaxPEPBEc6AML4GcDaCDavoPnxxV1HbJmoEXRtHacbihYvfz0Olpt3
         zZlQ==
X-Gm-Message-State: AOAM532EocQbmVwYMBtUqLPg7jTO/oqhoH09VGYTL5IpoLB/aBBpKapM
        Te4U4YxengT78MHkC1nZIFKtO3n9hdo3TjAOGFBSqA==
X-Google-Smtp-Source: ABdhPJwztCsb7GzFt1s3bJnytaNxnFZxeCMhiEh+wpognksZjWLtEf2i4HepyzfDleS9wLFpcu6YHPK6wOq9mhJ9gj4=
X-Received: by 2002:a05:6512:2282:b0:44a:93d2:dfd with SMTP id
 f2-20020a056512228200b0044a93d20dfdmr6862318lfu.102.1648491731786; Mon, 28
 Mar 2022 11:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220321224358.1305530-1-bgardon@google.com> <20220321224358.1305530-10-bgardon@google.com>
In-Reply-To: <20220321224358.1305530-10-bgardon@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 28 Mar 2022 11:21:45 -0700
Message-ID: <CALzav=c3+RXA1Sw2koaNY8LDA8B3KXdk1ZPGSkR=JzX54irYGw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] KVM: x86/mmu: Promote pages in-place when
 disabling dirty logging
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 21, 2022 at 3:44 PM Ben Gardon <bgardon@google.com> wrote:
>
> When disabling dirty logging, the TDP MMU currently zaps each leaf entry
> mapping memory in the relevant memslot. This is very slow. Doing the zaps
> under the mmu read lock requires a TLB flush for every zap and the
> zapping causes a storm of ETP/NPT violations.
>
> Instead of zapping, replace the split large pages with large page
> mappings directly. While this sort of operation has historically only
> been done in the vCPU page fault handler context, refactorings earlier
> in this series and the relative simplicity of the TDP MMU make it
> possible here as well.
>
> Running the dirty_log_perf_test on an Intel Skylake with 96 vCPUs and 1G
> of memory per vCPU, this reduces the time required to disable dirty
> logging from over 45 seconds to just over 1 second. It also avoids
> provoking page faults, improving vCPU performance while disabling
> dirty logging.
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          |  4 +-
>  arch/x86/kvm/mmu/mmu_internal.h |  6 +++
>  arch/x86/kvm/mmu/tdp_mmu.c      | 73 ++++++++++++++++++++++++++++++++-
>  3 files changed, 79 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6f98111f8f8b..a99c23ef90b6 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -100,7 +100,7 @@ module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
>   */
>  bool tdp_enabled = false;
>
> -static int max_huge_page_level __read_mostly;
> +int max_huge_page_level;
>  static int tdp_root_level __read_mostly;
>  static int max_tdp_level __read_mostly;
>
> @@ -4486,7 +4486,7 @@ static inline bool boot_cpu_is_amd(void)
>   * the direct page table on host, use as much mmu features as
>   * possible, however, kvm currently does not do execution-protection.
>   */
> -static void
> +void
>  build_tdp_shadow_zero_bits_mask(struct rsvd_bits_validate *shadow_zero_check,
>                                 int shadow_root_level)
>  {
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index 1bff453f7cbe..6c08a5731fcb 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -171,4 +171,10 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>  void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
>  void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
>
> +void
> +build_tdp_shadow_zero_bits_mask(struct rsvd_bits_validate *shadow_zero_check,
> +                               int shadow_root_level);
> +
> +extern int max_huge_page_level __read_mostly;
> +
>  #endif /* __KVM_X86_MMU_INTERNAL_H */
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index af60922906ef..eb8929e394ec 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1709,6 +1709,66 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
>                 clear_dirty_pt_masked(kvm, root, gfn, mask, wrprot);
>  }
>
> +static bool try_promote_lpage(struct kvm *kvm,
> +                             const struct kvm_memory_slot *slot,
> +                             struct tdp_iter *iter)
> +{
> +       struct kvm_mmu_page *sp = sptep_to_sp(iter->sptep);
> +       struct rsvd_bits_validate shadow_zero_check;
> +       bool map_writable;
> +       kvm_pfn_t pfn;
> +       u64 new_spte;
> +       u64 mt_mask;
> +
> +       /*
> +        * If addresses are being invalidated, don't do in-place promotion to
> +        * avoid accidentally mapping an invalidated address.
> +        */
> +       if (unlikely(kvm->mmu_notifier_count))
> +               return false;
> +
> +       if (iter->level > max_huge_page_level || iter->gfn < slot->base_gfn ||
> +           iter->gfn >= slot->base_gfn + slot->npages)
> +               return false;
> +
> +       pfn = __gfn_to_pfn_memslot(slot, iter->gfn, true, NULL, true,
> +                                  &map_writable, NULL);
> +       if (is_error_noslot_pfn(pfn))
> +               return false;
> +
> +       /*
> +        * Can't reconstitute an lpage if the consituent pages can't be
> +        * mapped higher.
> +        */
> +       if (iter->level > kvm_mmu_max_mapping_level(kvm, slot, iter->gfn,
> +                                                   pfn, PG_LEVEL_NUM))
> +               return false;
> +
> +       build_tdp_shadow_zero_bits_mask(&shadow_zero_check, iter->root_level);
> +
> +       /*
> +        * In some cases, a vCPU pointer is required to get the MT mask,
> +        * however in most cases it can be generated without one. If a
> +        * vCPU pointer is needed kvm_x86_try_get_mt_mask will fail.
> +        * In that case, bail on in-place promotion.
> +        */
> +       if (unlikely(!static_call(kvm_x86_try_get_mt_mask)(kvm, iter->gfn,
> +                                                          kvm_is_mmio_pfn(pfn),
> +                                                          &mt_mask)))
> +               return false;
> +
> +       __make_spte(kvm, sp, slot, ACC_ALL, iter->gfn, pfn, 0, false, true,
> +                 map_writable, mt_mask, &shadow_zero_check, &new_spte);
> +
> +       if (tdp_mmu_set_spte_atomic(kvm, iter, new_spte))
> +               return true;

Ah shoot, tdp_mmu_set_spte_atomic() now returns 0/-EBUSY, so this
conditional needs to be flipped.

> +
> +       /* Re-read the SPTE as it must have been changed by another thread. */
> +       iter->old_spte = READ_ONCE(*rcu_dereference(iter->sptep));

tdp_mmu_set_spte_atomic() does this for you now.

> +
> +       return false;
> +}
> +
>  /*
>   * Clear leaf entries which could be replaced by large mappings, for
>   * GFNs within the slot.
> @@ -1729,8 +1789,17 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
>                 if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
>                         continue;
>
> -               if (!is_shadow_present_pte(iter.old_spte) ||
> -                   !is_last_spte(iter.old_spte, iter.level))
> +               if (iter.level > max_huge_page_level ||
> +                   iter.gfn < slot->base_gfn ||
> +                   iter.gfn >= slot->base_gfn + slot->npages)
> +                       continue;
> +
> +               if (!is_shadow_present_pte(iter.old_spte))
> +                       continue;
> +
> +               /* Try to promote the constitutent pages to an lpage. */
> +               if (!is_last_spte(iter.old_spte, iter.level) &&
> +                   try_promote_lpage(kvm, slot, &iter))
>                         continue;
>
>                 pfn = spte_to_pfn(iter.old_spte);
> --
> 2.35.1.894.gb6a874cedc-goog
>
