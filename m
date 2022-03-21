Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0C4E32D9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiCUWq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiCUWqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:46:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D559399B48
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:25:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yy13so32726202ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=174oOQBn0fyyPOME33fxi6ZYYLy/uC/7bWFXFETZpkQ=;
        b=bwhTGLYQycrJ+z9zDqbYI3PNgdpiVnH0J4Kfgd1Vyq4twj1tCNeyCazfcEqgZRa7/o
         /stYkcUmR30etffbFq6NQuGOK5B7LotJR+sZBqgzNLiVXQb0JQJGjbdDN7QGCJDj+RFq
         +zWqBfSspkEZ+7CMmDH5KU7bhv0Z5hAmCAIaqGQ7XlU29M1AYADyoH73XBfngp4Iw/KZ
         7hKA/n/mum0aHXa7/gTnAFclhHpCPu4cl+lIkB1ZwR2LoBJkh5HDvEMugHPBdLZsCVVj
         KhcuAGsuVYzPrEG7DINl4t7E505I8lq/qmCPZ38aDaIpedGVVyciXCBPexb5K9t3pcl5
         2+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=174oOQBn0fyyPOME33fxi6ZYYLy/uC/7bWFXFETZpkQ=;
        b=jYR7nE+I03JnZVCh3yOGDBgVruVnRNUXDXqOa5YItf0Lc9o/LzAejaMiRNE4A97okn
         ouhCYD1TNk4ebJMCajcuOipr9sgz15EBNwHlww3QjMLH9gFot8qmP0mWFjP+4708fDdb
         ur/5iByhSTa6Fci4wN+ITika9QnPW8lfxO9yEmQyp5zpxUF+xBgcd2/A+zbXceizkkqt
         KmTPYRErbHI0mhjk5OvrTp2wIC+/ldn7H/e6dKAXCT+ihfLTFWNQW/bhXDq9BsWbeq5g
         rGa97uwbmd1cABe6x4+oF0NqattctNDeEdWrb2MJEHGjiFl5w8Ih2iMDuWglZ6bLV3j1
         MddA==
X-Gm-Message-State: AOAM5331gD9JXQANZyt6S7W5XgYwgvzpdEYYhu74V2ysvF6VoBVjAgat
        55mQ6Fwpyvao4E+hBiPeqQTaJVMEiaarisFGn+432x2gKaU=
X-Google-Smtp-Source: ABdhPJwpozCcbej623QSrjdR2iRrofqIOPIBxiJYga7zOjmvy8zsTMu8Be27CzPe/oak9GPCwvhEMjt0eFFBFImUeWQ=
X-Received: by 2002:a19:490f:0:b0:448:4bf8:6084 with SMTP id
 w15-20020a19490f000000b004484bf86084mr15705861lfa.537.1647901021259; Mon, 21
 Mar 2022 15:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220321002638.379672-1-mizhang@google.com> <20220321002638.379672-4-mizhang@google.com>
 <CALzav=dU5TPfhp1=n+zo+AcPkL4rpWCRpMCL91vE5z20R+mmjg@mail.gmail.com>
In-Reply-To: <CALzav=dU5TPfhp1=n+zo+AcPkL4rpWCRpMCL91vE5z20R+mmjg@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 21 Mar 2022 15:16:34 -0700
Message-ID: <CALzav=fFK1725dVBc=N181qP-Nua8M0rsKhXm1=zTRmG2Msjgg@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: explicitly check nx_hugepage in disallowed_hugepage_adjust()
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>, Ben Gardon <bgorden@google.com>
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

On Mon, Mar 21, 2022 at 3:00 PM David Matlack <dmatlack@google.com> wrote:
>
> On Sun, Mar 20, 2022 at 5:26 PM Mingwei Zhang <mizhang@google.com> wrote:
> >
> > Add extra check to specify the case of nx hugepage and allow KVM to
> > reconstruct large mapping after dirty logging is disabled. Existing code
> > works only for nx hugepage but the condition is too general in that does
> > not consider other usage case (such as dirty logging).
>
> KVM calls kvm_mmu_zap_collapsible_sptes() when dirty logging is
> disabled. Why is that not sufficient?

Ahh I see, kvm_mmu_zap_collapsible_sptes() only zaps the leaf SPTEs.
Could you add a blurb about this in the commit message for future
reference?

>
> > Moreover, existing
> > code assumes that a present PMD or PUD indicates that there exist 'smaller
> > SPTEs' under the paging structure. This assumption may no be true if
> > consider the zapping leafs only behavior in MMU.
>
> Good point. Although, that code just got reverted. Maybe say something like:
>
>   This assumption may not be true in the future if KVM gains support
> for zapping only leaf SPTEs.

Nevermind, support for zapping leaf SPTEs already exists for zapping
collapsible SPTEs.



>
> >
> > Missing the check causes KVM incorrectly regards the faulting page as a NX
> > huge page and refuse to map it at desired level. And this leads to back
> > performance in shadow mmu and potentiall TDP mmu.
>
> s/potentiall/potentially/
>
> >
> > Fixes: b8e8c8303ff2 ("kvm: mmu: ITLB_MULTIHIT mitigation")
> > Cc: stable@vger.kernel.org
> >
> > Reviewed-by: Ben Gardon <bgardon@google.com>
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 5628d0ba637e..4d358c273f6c 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -2919,6 +2919,16 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
> >             cur_level == fault->goal_level &&
> >             is_shadow_present_pte(spte) &&
> >             !is_large_pte(spte)) {
> > +               struct kvm_mmu_page *sp;
> > +               u64 page_mask;
> > +               /*
> > +                * When nx hugepage flag is not set, there is no reason to
> > +                * go down to another level. This helps demand paging to
> > +                * generate large mappings.
> > +                */
> > +               sp = to_shadow_page(spte & PT64_BASE_ADDR_MASK);
> > +               if (!sp->lpage_disallowed)
> > +                       return;
> >                 /*
> >                  * A small SPTE exists for this pfn, but FNAME(fetch)
> >                  * and __direct_map would like to create a large PTE
> > @@ -2926,8 +2936,8 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
> >                  * patching back for them into pfn the next 9 bits of
> >                  * the address.
> >                  */
> > -               u64 page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
> > -                               KVM_PAGES_PER_HPAGE(cur_level - 1);
> > +               page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
> > +                       KVM_PAGES_PER_HPAGE(cur_level - 1);
> >                 fault->pfn |= fault->gfn & page_mask;
> >                 fault->goal_level--;
> >         }
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >
