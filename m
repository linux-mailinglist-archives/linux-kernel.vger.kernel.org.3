Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3551E4F1E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiDDVxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380127AbiDDS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:56:32 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E513D6E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:54:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l36so11848831ybj.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8mit+XlQ6apyh1F4jfrqqHIA4eEylIGf1MuyIy7G0w=;
        b=PM4i8G7PuyPWh/Jh9WnN4Tc/zwjQEad3lXcESc58rdhEMEtNtrfp3EvtKDzn33YGLL
         Ah9HMvzVmk+19QgvIdPGm2Qy8B+5Bhymxchtuhd4gi3ACCM9Vk6ox4xbJUDzI844mU3o
         fI3DGkcyZEWjORi53NCXSOrNZ3mBIVSmiqvn2RR4iWr5D66CHx+vr0yBBrDtXk03BVF3
         uPByraxCdF6tH8BpXS/H5eUklX5UmhgLB8rhQBRdrCCrvLc58/EOzFLiJqDDoYunDsnW
         OGBag5j0nhEE+u/AshEBp5mRkboIy4PSRoM3H5qXf5bRGE7sehTqwo1Q/y/kjMEki0+b
         GJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8mit+XlQ6apyh1F4jfrqqHIA4eEylIGf1MuyIy7G0w=;
        b=yiL3eFiEhPz6U5QSIMKN5nNIRIp5TMkiXehJhLP5bB4Ay7Ldik9U8Gk/l1zwRaSpsf
         hOx5TktSHXenb+YdU2EzV6EFxp/WxHHRuSXJF8+WBMJZxZqWJbxEn3FSki1/GAsXr5pe
         PdPYdV1dBCVtokG8iweaCfJPOFlKkerP53JfenHCrZT6S8mqZIpLYG5WAQiY0yAdg1XK
         T6MwPTe+vzbRT6N+Oi0qCpld3uRcQOlM9Z0mkUvUCZvgACIOTm0dsLQtfrCY0sVZZfuv
         /j8yng12VGVKSJc6ilUyekNgXO65qSxwS8HmGKeD+vFNdXEMUEPK3oyY3/6hqNFYCr9E
         CMWg==
X-Gm-Message-State: AOAM531caGMuDQf+1EUYgGAd9/o+prGi+iOxOyJcDwnOSvbnTsza7Moe
        u+corik3dbc8f3DsNyAaUOC8zeDJTVYu40v5xSBypw==
X-Google-Smtp-Source: ABdhPJwjJQ5m+emITxY/LAnT5oJzYuka5uam0lN2TpPbt6LFR63y589nSovGkoW5FpbIS60tBIHHrrrIU9o7chH6ft4=
X-Received: by 2002:a25:ab6b:0:b0:63d:a27b:8bcd with SMTP id
 u98-20020a25ab6b000000b0063da27b8bcdmr1033768ybi.391.1649098474246; Mon, 04
 Apr 2022 11:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220401063636.2414200-1-mizhang@google.com> <20220401063636.2414200-2-mizhang@google.com>
 <CANgfPd9OqV35BGfRCvJZNK_kemgqDWPx8TKKObfyGb0iiC-uxg@mail.gmail.com> <Yks2ymJzY4S9x4zx@google.com>
In-Reply-To: <Yks2ymJzY4S9x4zx@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 4 Apr 2022 11:54:23 -0700
Message-ID: <CANgfPd-rOActegQ-c2frr0RnseT5am1tfvswhWqDRWWgW+9RqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] KVM: x86/mmu: Set lpage_disallowed in TDP MMU
 before setting SPTE
To:     Sean Christopherson <seanjc@google.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>
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

On Mon, Apr 4, 2022 at 11:20 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Apr 04, 2022, Ben Gardon wrote:
> > On Thu, Mar 31, 2022 at 11:36 PM Mingwei Zhang <mizhang@google.com> wrote:
> > > diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> > > index 1bff453f7cbe..4a0087efa1e3 100644
> > > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > > @@ -168,7 +168,7 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
> > >
> > >  void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> > >
> > > -void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> > > +void __account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> >
> > I believe we need to modify the usage of this function in
> > paging_tmpl.h as well, at which point there should be no users of
> > account_huge_nx_page, so we can just modify the function directly
> > instead of adding a __helper.
> > (Disregard if the source I was looking at was out of date. Lots of
> > churn in this code recently.)
>
> paging_tmpl.h is shadow paging only, i.e. will always handled page faults with
> mmu_lock held for write and it also needs the check for sp->lpage_disallowed
> already being set.  Only the TDP MMU code is special in that (a) it holds mmu_lock
> for read and (b) never reuses shadow pages when inserting into the page tables.
>
> Or did I completely misunderstand what you meant by "need to modify the usage"?

Ah right duh. For some reason I thought we were modifying __direct_map
in this commit too. Nevermind, no change needed.
