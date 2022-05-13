Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050A4526BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384583AbiEMUyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381755AbiEMUyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:54:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A338BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:54:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q130so11626666ljb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+/wjN2hthJC17ySiU4gVRZzaMAdl4cqYaPna/HTq9c=;
        b=WEjf2vk0jU+IvGj5zt678lWoxJ0tMqIjyfMopMo8H+50y+jmTe1YdKjv4Jx3laaaHW
         BfUdYOat6avRaXmJreSaxYhP0vLs+fKDBTBUJawKVF75KUDXEnZkIchuAjwHBYeT1cy4
         zxMdEiYq8hYbnvuk8urLbmUsNngDlTMZuucIRqIw+aiiNNP63ARTAIvpSTXRTj4bqFFr
         X/vIKGugG0JuJipPJFQnMCkwBNkTp81ufXbwl5aE8LQuGSUxFcdljju+0XvkundGFOCK
         IUCM4UruWadxkX5O5xOtYDxaWfk0bA8OKgvpMcm20c71z96N5n4pqaDhMIB+Sya5jLUo
         04+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+/wjN2hthJC17ySiU4gVRZzaMAdl4cqYaPna/HTq9c=;
        b=5/9Zt3KQec++wz8JQA0hjUgWme+OL96PLAwmxsiMEfiI3lFnCAxdvd1rr2QOygYj/T
         y5jktTTcwrAgsrZbPATgXFlT7t+yQ7T1JvMO1fC0Km9z9Fr6xGFlA86tFdw9qtV9OpTs
         j3YyTAGzghFuTtzKsONE9ecSqgefEmnQ6zW+C35YWE1DFr27a/YH0dFU2nhlhbv6aEki
         f+Bv+h8aK1JX16bBqZ9S7SmZrERg5Vb4CjptHWfn6Suna2gE33cO0Tqijr2ASR67/ooA
         2ZbBj7GznnKV6lapV9SUpoqsV35naqJnLRzyVhDkvmk1GDlOY4GgCJg5GOwFZNkCxU2a
         XO6Q==
X-Gm-Message-State: AOAM531d2uNg5vaWOWnQTd3OB25X4djI+u+1A+AvcsBjH4VlJ4rVhM6r
        DpWxy7fujUTmuSNvvixdyO6madInVP1Rv2QQz41t/A==
X-Google-Smtp-Source: ABdhPJz9o8gLlEco5hGoxJ1+k/s1sqVYBkSWyf4sELwYQQfWTnGIOzxqn+5UR5G9thjEBel+QJAFI6BK1/+s+jGZmz0=
X-Received: by 2002:a2e:b98b:0:b0:24f:1b64:a7b7 with SMTP id
 p11-20020a2eb98b000000b0024f1b64a7b7mr4049491ljp.331.1652475286071; Fri, 13
 May 2022 13:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220513195000.99371-1-seanjc@google.com> <20220513195000.99371-2-seanjc@google.com>
In-Reply-To: <20220513195000.99371-2-seanjc@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Fri, 13 May 2022 13:54:19 -0700
Message-ID: <CALzav=d36gccJv345Phdr0AJx9=6=TP=iZ60dscgQr64Rq4Kew@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Drop RWX=0 SPTEs during ept_sync_page()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>
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

On Fri, May 13, 2022 at 12:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Drop SPTEs whose new protections will yield a RWX=0 SPTE, i.e. a SPTE
> that is marked shadow-present but is not-present in the page tables.  If
> EPT with execute-only support is in use by L1, KVM can create a RWX=0
> SPTE can be created for an EPTE if the upper level combined permissions
> are R (or RW) and the leaf EPTE is changed from R (or RW) to X.

For some reason I found this sentence hard to read. What about this:

  When shadowing EPT and NX HugePages is enabled, if the guest changes
the permissions on a huge page in the EPT12 to be execute-only, KVM
will end shadowing it with an RWX=0 SPTE in the EPT02 when it picks up
the change in FNAME(sync_page). Note that the guest can't induce KVM
to create a RWX=0 during FNAME(fetch), since the only valid way for
the guest to fault in an execute-only huge page is with an instruction
fetch, which KVM will handle by mapping the page as an executable 4KiB
page.

> Because
> the EPTE is considered present when viewed in isolation, and no reserved
> bits are set, FNAME(prefetch_invalid_gpte) will consider the GPTE valid.
>
> Creating a not-present SPTE isn't fatal as the SPTE is "correct" in the
> sense that the guest translation is inaccesible (the combined protections
> of all levels yield RWX=0), i.e. the guest won't get stuck in an infinite
> loop.  If EPT A/D bits are disabled, KVM can mistake the SPTE for an
> access-tracked SPTE.  But again, such confusion isn't fatal as the "saved"
> protections are also RWX=0.
>
> Add a WARN in make_spte() to detect creation of SPTEs that will result in
> RWX=0 protections, which is the real motivation for fixing ept_sync_page().
> Creating a useless SPTE means KVM messed up _something_, even if whatever
> goof occurred doesn't manifest as a functional bug.
>
> Fixes: d95c55687e11 ("kvm: mmu: track read permission explicitly for shadow EPT page tables")
> Cc: David Matlack <dmatlack@google.com>
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 9 ++++++++-
>  arch/x86/kvm/mmu/spte.c        | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index b025decf610d..d9f98f9ed4a0 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -1052,7 +1052,14 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>                 if (sync_mmio_spte(vcpu, &sp->spt[i], gfn, pte_access))
>                         continue;
>
> -               if (gfn != sp->gfns[i]) {
> +               /*
> +                * Drop the SPTE if the new protections would result in a RWX=0
> +                * SPTE or if the gfn is changing.  The RWX=0 case only affects
> +                * EPT with execute-only support, i.e. EPT without an effective
> +                * "present" bit, as all other paging modes will create a
> +                * read-only SPTE if pte_access is zero.
> +                */
> +               if ((!pte_access && !shadow_present_mask) || gfn != sp->gfns[i]) {
>                         drop_spte(vcpu->kvm, &sp->spt[i]);
>                         flush = true;
>                         continue;
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 75c9e87d446a..9ad60662beac 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -101,6 +101,8 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
>         u64 spte = SPTE_MMU_PRESENT_MASK;
>         bool wrprot = false;
>
> +       WARN_ON_ONCE(!pte_access && !shadow_present_mask);
> +
>         if (sp->role.ad_disabled)
>                 spte |= SPTE_TDP_AD_DISABLED_MASK;
>         else if (kvm_mmu_page_ad_need_write_protect(sp))
> --
> 2.36.0.550.gb090851708-goog
>
