Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F754B639
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbiFNQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiFNQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:31:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C494477A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:31:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s10so10324817ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2fZye6UdimpBGkNb+1XWvu1Hsvf3MmLKdDgNGiZcbY=;
        b=MKAutI88yTh1uEp9FHB/z8i4rfULiSmiDbjPxv80KvCvVInAbz+dGPX4QFiWDzChOM
         N6MDGNBPodnWa+NaXV6vmjDgqx8c6dD0VzqUWiqikQf5mpme/wGMpoE9QVbtjfu3okfw
         klu0yAQwuPT6gFYMfejmiYxiQU5bhrCHdFuKAzO5e9MmGKsUA5eTht8qR672q3N8t/bQ
         eqAMdht0Ri+B4I9LgO8VsnrjGFKODiJwdvk5tDAnFJ9ul07Q3E2h/MIF8OIjC7rmtFi/
         TQX8AwwPIXm2byRjC0ZctS4bsYmwG2VB/ZNjeDrDaagaJSdyF6vYsJjrRmEXDwfNhCsV
         Go9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2fZye6UdimpBGkNb+1XWvu1Hsvf3MmLKdDgNGiZcbY=;
        b=ULp70aCInuYfk4o6c2Aw0AHnmmcxQAGd4XOHyIN4vSK7maDUOn4XobQaxlc+N4Esr2
         JSRWti2tGkApzo+Do89S1RUrASIX9jihmn8jDxEod8TEqAFJqUViF7GWkdygc185Q5wx
         VEfTim58Ha9yVUQUne0AwklGwzKeoppmy/EEmMduwqewfxBNMZEVaPJzAukkeWNK6zHk
         LWtQC0Z/Sm9/Zw5+LtPZygb0GRYnIgzbK1ToRkH/z6iSfvoYoPDCb/TJI7nOF2rDwFTv
         T6nMcvB0w5Ldbl0wzgX3DSYb4MFpCWlzHvdeSjBB6wWP/Ju6sWItIDmHLuJeza+scsQm
         2XtQ==
X-Gm-Message-State: AJIora9tVffjRBGKgiwCygmSc8HEqgs+Py7RXLwtt34ebbLUbtYSisr+
        zMjEcF5XeAbpeenwmfd6FLm9/XzwBMa7yTt5huBdOg==
X-Google-Smtp-Source: AGRyM1s4iRYkG2siPCjYVba9R+Y1+hhqAPDrDABhkovtuwAIMqrcG4dvYvBUXWiUUS4XoTC74KcetA/5uIWFMg6VOk0=
X-Received: by 2002:a2e:9195:0:b0:258:e918:2610 with SMTP id
 f21-20020a2e9195000000b00258e9182610mr2961188ljg.361.1655224310168; Tue, 14
 Jun 2022 09:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220614093222.25387-1-liubo03@inspur.com> <YqiigqccucuU2AQg@google.com>
In-Reply-To: <YqiigqccucuU2AQg@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 14 Jun 2022 09:31:23 -0700
Message-ID: <CALzav=deWrsJjNigiAOGkG-LjWuW91-NKfAx0ZkVj1CEZEZLZg@mail.gmail.com>
Subject: Re: [PATCH] KVM: Use consistent type for return value of kvm_mmu_memory_cache_nr_free_objects()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Bo Liu <liubo03@inspur.com>, Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 8:01 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jun 14, 2022, Bo Liu wrote:
> > The return value type of the function rmap_can_add() is "bool", and it will
> > returns the result of the function kvm_mmu_memory_cache_nr_free_objects().
> > So we should change the return value type of
> > kvm_mmu_memory_cache_nr_free_objects() to "bool".
> >
> > Signed-off-by: Bo Liu <liubo03@inspur.com>
> > ---
> >  include/linux/kvm_host.h | 2 +-
> >  virt/kvm/kvm_main.c      | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index c20f2d55840c..a399a7485795 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1358,7 +1358,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm);
> >
> >  #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
> >  int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min);
> > -int kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc);
> > +bool kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc);
> >  void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
> >  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> >  #endif
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index a67e996cbf7f..2872569e3580 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -394,9 +394,9 @@ int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
> >       return 0;
> >  }
> >
> > -int kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc)
> > +bool kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc)
>
> Absolutely not, the name of the function is "nr_free_objects".  Renaming it to
> "has_free_objects" is not a net positive IMO.

Also nested eager page splitting [1] uses
kvm_mmu_memory_cache_nr_free_objects() and needs to know the number of
free objects.

[1] https://lore.kernel.org/all/20220516232138.1783324-23-dmatlack@google.com/

> If we really care about returning
> a bool then we can tweak rmap_can_add().
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 17252f39bd7c..047855d134da 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1018,7 +1018,7 @@ static bool rmap_can_add(struct kvm_vcpu *vcpu)
>         struct kvm_mmu_memory_cache *mc;
>
>         mc = &vcpu->arch.mmu_pte_list_desc_cache;
> -       return kvm_mmu_memory_cache_nr_free_objects(mc);
> +       return !!kvm_mmu_memory_cache_nr_free_objects(mc);
>  }
>
>  static void rmap_remove(struct kvm *kvm, u64 *spte)
