Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3744C7F08
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiCAAMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiCAAMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:12:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D8D4C98
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:12:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i11so19830348eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Jq5c+6vhvuF7Ybk2lRX6RTPY/8mW01cAvWtc5ooEkc=;
        b=qVLdh0ag0EcbKeamPlw5IhI6fH/Fdz2yENO78FGpjCRZFakmIC4oBvnX0wwDF45o+P
         aSjhAttFyjLqWMxdbNe6wWCiauI9b2PSCgqzXyczs+t3TdTaWoZccUA4uBj0ODw1Al0a
         q58QYElr/+kt//TTsmFbwKtF3IiHzE5i7GTQ398Fb4M1NIwqhrSQrErgy7TACNDCguPn
         wyeXcF9VbYuTuJ6A/OXXhn9eYVHJdaJZ7NJiWRMy/jUtFf858qKKVzCKPzuOVtwfM6TQ
         kcpbaW1TdnsLucM6eUa5v6THR++M6r98Qt47iga1pN1HrxNEG+lvjszYOV9XYDAwhNmI
         w7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Jq5c+6vhvuF7Ybk2lRX6RTPY/8mW01cAvWtc5ooEkc=;
        b=GwpW8KgxMkR8JQumAeogUtvFvzAklBo8FcIaTMzo7A6wYYBClv/7kCH0zAd9GxJlm0
         dcKH8RwB1SN9Uul25NLScKYQoq/vsxo4dQ1uGSAhfg1L/ogKN1QGgjhX6EMG10gN2Zc2
         f06IgAZ1poGyXxqYzUurhiLjSysrDcYaMzk2SWv3yLJMGgVfy/H+8YxKFLzkAedA8OeZ
         4WK85ET3VG5ufNrex4b9knsvZIXCJp5TqS4S5jTrEnCD54sNozNssNjrfVVIXNXzRIJ7
         DNc3fv8iTMPzW3bRGOfoiGjwNl8MgM+nErVw2AdA6BIwFKgGC18x8nGl0I+Zr5YicLWD
         jFQQ==
X-Gm-Message-State: AOAM533877PisIJ0nkpi+h2aR41M1xyy/9m6ZvpulaIjNGb2hT2p+IBY
        ymF2nGY5+fQfi2lqSpKqiM7oPkIcPTYrnyc7/6IsXw==
X-Google-Smtp-Source: ABdhPJzuKSMkJZz6ebGwDWDdOXVLCUMS1Xt9739nwOVdugCCXgHLWklSsFilog60I/iYwsoH4EsC0bgcUkfF1R/PRK8=
X-Received: by 2002:aa7:c612:0:b0:40f:2a41:bddb with SMTP id
 h18-20020aa7c612000000b0040f2a41bddbmr21772637edq.291.1646093530737; Mon, 28
 Feb 2022 16:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com> <20220226001546.360188-8-seanjc@google.com>
In-Reply-To: <20220226001546.360188-8-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 28 Feb 2022 16:11:59 -0800
Message-ID: <CANgfPd-KFQp=T_z+1y6N2sgPEaC-KdkdzuGcgb1SZSJhE+sRMQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/28] KVM: x86/mmu: Check for !leaf=>leaf, not PFN
 change, in TDP MMU SP removal
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
> Look for a !leaf=>leaf conversion instead of a PFN change when checking
> if a SPTE change removed a TDP MMU shadow page.  Convert the PFN check
> into a WARN, as KVM should never change the PFN of a shadow page (except
> when its being zapped or replaced).
>
> From a purely theoretical perspective, it's not illegal to replace a SP
> with a hugepage pointing at the same PFN.  In practice, it's impossible
> as that would require mapping guest memory overtop a kernel-allocated SP.
> Either way, the check is odd.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 189f21e71c36..848448b65703 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -505,9 +505,12 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>
>         /*
>          * Recursively handle child PTs if the change removed a subtree from
> -        * the paging structure.
> +        * the paging structure.  Note the WARN on the PFN changing without the
> +        * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
> +        * pages are kernel allocations and should never be migrated.
>          */
> -       if (was_present && !was_leaf && (pfn_changed || !is_present))
> +       if (was_present && !was_leaf &&
> +           (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
>                 handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
>  }
>
> --
> 2.35.1.574.g5d30c73bfb-goog
>
