Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8672952C15F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiERRMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiERRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:12:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC123D6838
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:11:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b32so3325340ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZBlJV5SkOMUJnqiFtH47DECyQFpTZiRBCog/QFYkaA=;
        b=TdqfYQ45NIxmdRDL/iBJjaUrU26F6Gcl3kfGKUBBKB1jcuk3PqVsn13jUbEmqHiLGa
         22IGAWbWQdq+/DMQfFPC2fX8Z/7037DA4aax3BFQHx5YbIVDEnHfieOugOKla7sSmEMR
         IayWw03MJ7zT3J9pNQm6fzPr1VXIoc1ao4S220W0vBDc9KJ23sOZ1X85vTKClnhHCd0V
         j044YA5VELx15EUPI7pFNei0de35boewEyRj+eK+WvHwLK6eymIXeheRzPoto4trAg4m
         qkb3HDtcIt0o5FfstriJ7H1WKZUbpRUUeGf14eBs6OXgccLXnh/3h3DlAvcTazmYgkSF
         c+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZBlJV5SkOMUJnqiFtH47DECyQFpTZiRBCog/QFYkaA=;
        b=jpCvs7lofvpxj0knMxhO2ZUccoXw0JKmBGULAH38/pgbqIyaxhqwQHRFDffmUlukaq
         rpMHc5L5x4nV2p7lbTwIY5JLhBrWRMo7hsKEezPilIjVEMCZUUVqfuAG9fIcdzNC/P0O
         HAnz4ONPzvSoXnHLj88hugMPzdWE3RHAF8OxP+juUaqOegFpEjhkAwwjB113MS0LZ8q7
         aUniyHMEXriASSELZAknMp8CYzSfmoR7+o07VqCnaIOhrTScK2UTWxfTT1IEn6V29Lgz
         PQ/BMffkq5LBvhucD9HbtctCVnnMKfIUqMVoBU01WyL6kn6XNul4OFDjFRkJFLBS50fG
         0kTQ==
X-Gm-Message-State: AOAM5313gBWBujtGk7dp+Nn69Z6+wymoNwtrUSPBkYXW3CwPgtL2VRE1
        IMMdc9O+wSONaHa3a5IQgIqPAYBR1iGpI1BvKhJ3pQ==
X-Google-Smtp-Source: ABdhPJyBkM6A1SesEEsi7CUd4eASLAmMUNIZ2b7t65sLE8Fo2Igp/CWfwHG+dUEz/9VlmAd8UBpIrP5NXdIxeBW8BuI=
X-Received: by 2002:a2e:b98b:0:b0:24f:1b64:a7b7 with SMTP id
 p11-20020a2eb98b000000b0024f1b64a7b7mr197861ljp.331.1652893916972; Wed, 18
 May 2022 10:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220518135111.3535-1-ubizjak@gmail.com>
In-Reply-To: <20220518135111.3535-1-ubizjak@gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Wed, 18 May 2022 10:11:30 -0700
Message-ID: <CALzav=e4G_=uSLaRetNFn5FGEiuRFK7=za0Wi9G422LsxFVruA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Use try_cmpxchg64 in tdp_mmu_set_spte_atomic
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, May 18, 2022 at 7:08 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
> tdp_mmu_set_spte_atomic.  cmpxchg returns success in ZF flag, so this
> change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg). Also, remove explicit assignment to iter->old_spte
> when cmpxchg fails, this is what try_cmpxchg does implicitly.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Nice cleanup.

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
> Patch requires commits 0aa7be05d83cc584da0782405e8007e351dfb6cc
> and c2df0a6af177b6c06a859806a876f92b072dc624 from tip.git
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 922b06bf4b94..1ccc1a0f8123 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -633,7 +633,6 @@ static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
>                                           u64 new_spte)
>  {
>         u64 *sptep = rcu_dereference(iter->sptep);
> -       u64 old_spte;
>
>         /*
>          * The caller is responsible for ensuring the old SPTE is not a REMOVED
> @@ -649,17 +648,8 @@ static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
>          * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
>          * does not hold the mmu_lock.
>          */
> -       old_spte = cmpxchg64(sptep, iter->old_spte, new_spte);
> -       if (old_spte != iter->old_spte) {
> -               /*
> -                * The page table entry was modified by a different logical
> -                * CPU. Refresh iter->old_spte with the current value so the
> -                * caller operates on fresh data, e.g. if it retries
> -                * tdp_mmu_set_spte_atomic().
> -                */
> -               iter->old_spte = old_spte;
> +       if (!try_cmpxchg64(sptep, &iter->old_spte, new_spte))
>                 return -EBUSY;
> -       }
>
>         __handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
>                               new_spte, iter->level, true);
> --
> 2.35.1
>
