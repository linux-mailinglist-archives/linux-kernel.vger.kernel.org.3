Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80A59079C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiHKU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiHKU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 468FE81694
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660251491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umhJQzJAWrnjkW3zfGMLL67VJqv1wRHTW7++Jt2gnz8=;
        b=RYHHOqkLJQ8+Gy6iHhjK1QkzGE56NXIm7L2UQEQEHguko+UCYLBNrDuR/f6YfSTg9yGjIZ
        7dAHASWYh9MAcoJE2BhWyUB3w+46VW+5vQCWN/WYKYqzdElVzsi4o5Mx0augekIrcDiIcM
        JLU+V4fgi9XLAgTRABaVNJx/CcwBf8Q=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-F19paLcHO0qGJZyg94w6fw-1; Thu, 11 Aug 2022 16:58:10 -0400
X-MC-Unique: F19paLcHO0qGJZyg94w6fw-1
Received: by mail-io1-f71.google.com with SMTP id y23-20020a5e8717000000b00680064a707eso10127512ioj.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=umhJQzJAWrnjkW3zfGMLL67VJqv1wRHTW7++Jt2gnz8=;
        b=ToEh+KBeLrId64o7YFWPw7/6Gg8PXxN6gftq0cdOTi84XgIhwPY2lORqOMICgPFEzf
         nYIeyKKUT4D9PT0kzc/4E8zNOibtuBPFyWuwS/zDlsXJey/7q9O42icG4YkccUDuGnNk
         4TT3keRqTC89tdSKVRrBRTbC+8lBGpXg+m6ceW/MO4vWhbh5vbBglaSETd5w1+bGktdG
         JzazACk8L3qekuvJkhJVmHt1u7XiAp4cXGL7zceA5xY24uHVJghm+XfxyBsdy9ZobYGt
         p5jEGXGEcB0OTm4QIZobAY2unowhDTlzU+Ft2Hs/N7xIVU78AGlXXw6ad8D9Ust4MfC5
         XqQQ==
X-Gm-Message-State: ACgBeo02lS1JkvECxAptMUBee/0MkF0izBbs6hhQEqTAyi8p8xUTmyzE
        W0A/XwRljhzL4nJ4V6RbQ6KFx5cOGeMNS9BdodWabqeKZhhH+0i4hpuFyXYILdPZEyE8h2Ruz5V
        HVAHMZYEYHaQ5k0JWeePNVpgp
X-Received: by 2002:a05:6602:2b84:b0:684:fb55:663b with SMTP id r4-20020a0566022b8400b00684fb55663bmr420195iov.13.1660251489446;
        Thu, 11 Aug 2022 13:58:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7xVXDdje7GojW2eJGsfbGHzi0u/S8iOtnP4nn3QprAKSMlWTOAhg/IOfoqAcJtKHrMPgHh7A==
X-Received: by 2002:a05:6602:2b84:b0:684:fb55:663b with SMTP id r4-20020a0566022b8400b00684fb55663bmr420184iov.13.1660251489147;
        Thu, 11 Aug 2022 13:58:09 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id z6-20020a05663822a600b0034294118e1bsm215302jas.126.2022.08.11.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:58:08 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:58:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v2 3/3] kvm/x86: Allow to respond to generic signals
 during slow page faults
Message-ID: <YvVtX+rosTLxFPe3@xz-m1.local>
References: <20220721000318.93522-1-peterx@redhat.com>
 <20220721000318.93522-4-peterx@redhat.com>
 <YvVitqmmj7Y0eggY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvVitqmmj7Y0eggY@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 08:12:38PM +0000, Sean Christopherson wrote:
> On Wed, Jul 20, 2022, Peter Xu wrote:
> > All the facilities should be ready for this, what we need to do is to add a
> > new "interruptible" flag showing that we're willing to be interrupted by
> > common signals during the __gfn_to_pfn_memslot() request, and wire it up
> > with a FOLL_INTERRUPTIBLE flag that we've just introduced.
> > 
> > Note that only x86 slow page fault routine will set this to true.  The new
> > flag is by default false in non-x86 arch or on other gup paths even for
> > x86.  It can actually be used elsewhere too but not yet covered.
> > 
> > When we see the PFN fetching was interrupted, do early exit to userspace
> > with an KVM_EXIT_INTR exit reason.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/arm64/kvm/mmu.c                   |  2 +-
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c    |  2 +-
> >  arch/powerpc/kvm/book3s_64_mmu_radix.c |  2 +-
> >  arch/x86/kvm/mmu/mmu.c                 | 16 ++++++++++++--
> >  include/linux/kvm_host.h               |  4 ++--
> >  virt/kvm/kvm_main.c                    | 30 ++++++++++++++++----------
> >  virt/kvm/kvm_mm.h                      |  4 ++--
> >  virt/kvm/pfncache.c                    |  2 +-
> >  8 files changed, 41 insertions(+), 21 deletions(-)
> 
> I don't usually like adding code without a user, but in this case I think I'd
> prefer to add the @interruptible param and then activate x86's kvm_faultin_pfn()
> in a separate patch.  It's rather difficult to tease out the functional x86
> change, and that would also allow other architectures to use the interruptible
> support without needing to depend on the functional x86 change.
> 
> And maybe squash the addition of @interruptible with the previous patch?  I.e.
> add all of the infrastructure for KVM_PFN_ERR_SIGPENDING in patch 2, then use it
> in x86 in patch 3.

Sounds good.

> 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 17252f39bd7c..aeafe0e9cfbf 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3012,6 +3012,13 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  static int handle_abnormal_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >  			       unsigned int access)
> >  {
> > +	/* NOTE: not all error pfn is fatal; handle sigpending pfn first */
> > +	if (unlikely(is_sigpending_pfn(fault->pfn))) {
> 
> Move this into kvm_handle_bad_page(), then there's no need for a comment to call
> out that this needs to come before the is_error_pfn() check.  This _is_ a "bad"
> PFN, it just so happens that userspace might be able to resolve the "bad" PFN.

It's a pity it needs to be in "bad pfn" category since that's the only
thing we can easily use, but true it is now.

> 
> > +		vcpu->run->exit_reason = KVM_EXIT_INTR;
> > +		++vcpu->stat.signal_exits;
> > +		return -EINTR;
> 
> For better or worse, kvm_handle_signal_exit() exists and can be used here.  I
> don't love that KVM details bleed into xfer_to_guest_mode_work(), but that's a
> future problem.
> 
> I do think that the "return -EINTR" should be moved into kvm_handle_signal_exit(),
> partly for code reuse and partly because returning -EINTR is very much KVM ABI.
> Oof, but there are a _lot_ of paths that can use kvm_handle_signal_exit(), and
> some of them don't select KVM_XFER_TO_GUEST_WORK, i.e. kvm_handle_signal_exit()
> should be defined unconditionally.  I'll work on a series to handle that separately,
> no reason to take a dependency on that cleanup.
> 
> So for now,
> 
> static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> {
> 	if (pfn == KVM_PFN_ERR_SIGPENDING) {
> 		kvm_handle_signal_exit(vcpu);
> 		return -EINTR;
> 	}
> 
> 	...
> }

Sounds good too here.  Also all points taken in the wording of patch 2.

Will respin shortly, thanks Sean.

-- 
Peter Xu

