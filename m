Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04B64CDB83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbiCDSBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiCDSBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:01:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D31BA170
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:00:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso8152326pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gOSuCZJSJyv9Fk46Zy5MRnYMeO+km0CcjJ45q6xala0=;
        b=UXiVs5PD/oudeyljFe5MkcKgB17Zbvvdka9m0Pp+csic1Nj2RfowEYoP4qe72Tnxvz
         rJozb8c686JzOixxCdDYoDkXy/7orWlD5VQFRxs3Pid+GyCem979PLi87BjUAqVsEiZi
         9YyAz7icChgaPRY4o6Pam/oXpX7KePfrjRowZflZaFIMbPzISKyi8zHSb14Z0BtQcPiW
         +0TMP9OcbnfVIWP0R+eddhcrNLqcekd2ciqUtqN+HGYlmo0WjR/7yQhAc9W9ezGlWskX
         uB3zLqnLv2EssGhE7DplYAT2zeVC4WJy7zT6082isWHedIiuAo7WnyxnwczNxllD0irp
         QaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOSuCZJSJyv9Fk46Zy5MRnYMeO+km0CcjJ45q6xala0=;
        b=7NWbkm8ceRwT9fzzXvbUUVr8HGZ4XrgmsacBA3csZTY+dOR3QEjbAfC9NT5zZT2Ec5
         fGX/IFuTpZ6h46O08L2clqJ9Gpw2oTvv+VI1miq5P1J57F0lfMUuGzS/R/RZonRh8FJ7
         y2ZJtaljVvL2+iw+I6ZKB7vav2v4cSgqLAG2pcmPBrJ4J1fQAvTvkHwWLUV8Qh2UHsPL
         VhiVpoL7rS2oCZ53EWAGnXvbp6s0UqgSsjV0ulc8jNnf5NH9LOhvY/hYN3gBWgoEHhdn
         W4LFgB0+j5nyZRB9TpUDrI+5wvUN4m+EVNWxy2ZuXgn5KORQJjz+OUi2VSnE7EojoTzG
         oQLA==
X-Gm-Message-State: AOAM532eKR6s0T4wZG37u8Ajsr3e7fiuNNonyjn56KCpEyrALGyTLrW6
        pBnLGFr+U2h8GFq4niD7vvu5rw==
X-Google-Smtp-Source: ABdhPJzX4GgSd9HnuFMROf+zCp4N/ARdTpi45m8BEbvzz/FKMDHUkgHJFafPpSNVl2gHZDc29CaZIQ==
X-Received: by 2002:a17:902:c1d4:b0:151:b56c:41ef with SMTP id c20-20020a170902c1d400b00151b56c41efmr6475093plc.77.1646416845683;
        Fri, 04 Mar 2022 10:00:45 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm6723222pfj.43.2022.03.04.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:00:45 -0800 (PST)
Date:   Fri, 4 Mar 2022 18:00:41 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v4 18/30] KVM: x86/mmu: Zap only TDP MMU leafs in
 kvm_zap_gfn_range()
Message-ID: <YiJTyYIyBvGoczw+@google.com>
References: <20220303193842.370645-1-pbonzini@redhat.com>
 <20220303193842.370645-19-pbonzini@redhat.com>
 <YiFoi8SjWiCHax0P@google.com>
 <YiI6GJCsJERzHB8W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiI6GJCsJERzHB8W@google.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022, Sean Christopherson wrote:
> On Fri, Mar 04, 2022, Mingwei Zhang wrote:
> > On Thu, Mar 03, 2022, Paolo Bonzini wrote:
> > > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > > index f3939ce4a115..c71debdbc732 100644
> > > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > > @@ -834,10 +834,8 @@ bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
> > >  }
> > >  
> > >  /*
> > > - * Tears down the mappings for the range of gfns, [start, end), and frees the
> > > - * non-root pages mapping GFNs strictly within that range. Returns true if
> > > - * SPTEs have been cleared and a TLB flush is needed before releasing the
> > > - * MMU lock.
> > > + * Zap leafs SPTEs for the range of gfns, [start, end). Returns true if SPTEs
> > > + * have been cleared and a TLB flush is needed before releasing the MMU lock.
> > 
> > I think the original code does not _over_ zapping. But the new version
> > does.
> 
> No, the new version doesn't overzap.

It does overzap, but it does not matter and the semantic does not
change.
> 
> > Will that have some side effects? In particular, if the range is
> > within a huge page (or HugeTLB page of various sizes), then we choose to
> > zap it even if it is more than the range.

ACK.
> 
> The old version did that too.  KVM _must_ zap a hugepage that overlaps the range,
> otherwise the guest would be able to access memory that has been freed/moved.  If
> the operation has unmapped a subset of a hugepage, KVM needs to zap and rebuild
> the portions that are still valid using smaller pages.
> 
> > Regardless of side effect, I think we probably should mention that in
> > the comments?
> > > -		/*
> > > -		 * If this is a non-last-level SPTE that covers a larger range
> > > -		 * than should be zapped, continue, and zap the mappings at a
> > > -		 * lower level, except when zapping all SPTEs.
> > > -		 */
> > > -		if (!zap_all &&
> > > -		    (iter.gfn < start ||
> > > -		     iter.gfn + KVM_PAGES_PER_HPAGE(iter.level) > end) &&
> > > +		if (!is_shadow_present_pte(iter.old_spte) ||
> > >  		    !is_last_spte(iter.old_spte, iter.level))
> 
> It's hard to see in the diff, but the key is the "!is_last_spte()" check.  The
> check before was skipping non-leaf, a.k.a. shadow pages, if they weren't in the
> range.  The new version _always_ skips shadow pages.  Hugepages will always
> return true for is_last_spte() and will never be skipped.

ACK

Reviewed-by: Mingwei Zhang <mizhang@google.com>
