Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65D57B709
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiGTNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiGTNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 194572315B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658322641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dFlb3qAG0P2dgOAUGD2eXn+YURleKGghkF1TrKpP95A=;
        b=GzKGWbh1pq4OL4gVDpVP5U1Bqsy5j5fb0KUhMMfO5B8U5O1A7odjQpLvqreHJXcKCQYSfW
        lkgT4cQucrxKMdv+/8QovIYUooq+KoGabq4SabNOyIomFiOLaxGEtHUPbV9TJTiHPNUAvx
        HmkR2E/W1pFWgNeZFXbFnVb3zAM1/Go=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-nT-4YpxAOqK1NNCp4gLd2Q-1; Wed, 20 Jul 2022 09:10:40 -0400
X-MC-Unique: nT-4YpxAOqK1NNCp4gLd2Q-1
Received: by mail-qt1-f200.google.com with SMTP id t9-20020ac85309000000b0031ee055ad11so8883658qtn.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFlb3qAG0P2dgOAUGD2eXn+YURleKGghkF1TrKpP95A=;
        b=ekr5YFciwC1/eZXSRiHI1kjn4wknu8W/M3zS3Yg04boIX9dLnXWH+6kAMGC5jvbmLh
         vcSw6vsmpwPSNRA6MqM5VDZd3DWd9OkHIIT49f6k0Qah0ywOl1HrDbKPLjHqPraX/d+D
         hKEH2wtYjYidGup/NPwMAEdi2MR66QrRfCBWFlcGoxPYbDaQI5CxZketm/Ni51yingKC
         nIfBJRZtgAkLwd0jPalZk+xHBMZV8vpRq8y3c1MlXfOUaUYoenkPtewjzHix7rv89TsL
         ApldgOn7Q5nK/EmHPfWw+rGmAF6cpFviuvel7pzcsCjRiAChGkMXh9HWzho+uFTjxoBu
         dT9Q==
X-Gm-Message-State: AJIora+d7ESfRTrJaXW1hHehfq3ARgksW+syvWhRSwmzP4P+7XqwC8eS
        ef6lbmt2ThlZlzsqLEfd+X8gza16K29nDx7cjPSsMonNpIgaWsfH7wU1w/4b+JRJGVc3fVl57Eu
        qDNtwec3Lne6EXKBZKsJLCQER
X-Received: by 2002:a05:620a:25c9:b0:6b2:7409:892e with SMTP id y9-20020a05620a25c900b006b27409892emr23739285qko.367.1658322639484;
        Wed, 20 Jul 2022 06:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXkQe6Uk4jZjI3ombLhQcay8rk3R1JIP6PL9j2qltDZvZr9cg7EUE9jey9R73N1/4YMzfsAQ==
X-Received: by 2002:a05:620a:25c9:b0:6b2:7409:892e with SMTP id y9-20020a05620a25c900b006b27409892emr23739243qko.367.1658322639013;
        Wed, 20 Jul 2022 06:10:39 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s10-20020ac85eca000000b0031ede43512bsm9647133qtx.44.2022.07.20.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:10:38 -0700 (PDT)
Date:   Wed, 20 Jul 2022 09:10:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Message-ID: <Ytf+zIxVPTVXTZdp@xz-m1.local>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
 <YtcYVMoSRVxRH70Z@xz-m1.local>
 <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <017facf0-7ef8-3faf-138d-3013a20b37db@redhat.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:39:23AM +0200, David Hildenbrand wrote:
> On 19.07.22 22:47, Peter Xu wrote:
> > On Mon, Jul 18, 2022 at 05:01:59AM -0700, Nadav Amit wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >>
> >> When userfaultfd makes a PTE writable, it can now change the PTE
> >> directly, in some cases, without going triggering a page-fault first.
> >> Yet, doing so might leave the PTE that was write-unprotected as old and
> >> clean. At least on x86, this would cause a >500 cycles overhead when the
> >> PTE is first accessed.
> >>
> >> Use MM_CP_WILL_NEED to set the PTE as young and dirty when userfaultfd
> >> gets a hint that the page is likely to be used. Avoid changing the PTE
> >> to young and dirty in other cases to avoid excessive writeback and
> >> messing with the page reclamation logic.
> >>
> >> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Yu Zhao <yuzhao@google.com>
> >> Cc: Nick Piggin <npiggin@gmail.com>
> >> ---
> >>  include/linux/mm.h | 2 ++
> >>  mm/mprotect.c      | 9 ++++++++-
> >>  mm/userfaultfd.c   | 8 ++++++--
> >>  3 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 9cc02a7e503b..4afd75ce5875 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -1988,6 +1988,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
> >>  /* Whether this change is for write protecting */
> >>  #define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
> >>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
> >> +/* Whether to try to mark entries as dirty as they are to be written */
> >> +#define  MM_CP_WILL_NEED		   (1UL << 4)
> >>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
> >>  					    MM_CP_UFFD_WP_RESOLVE)
> >>  
> >> diff --git a/mm/mprotect.c b/mm/mprotect.c
> >> index 996a97e213ad..34c2dfb68c42 100644
> >> --- a/mm/mprotect.c
> >> +++ b/mm/mprotect.c
> >> @@ -82,6 +82,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
> >>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
> >>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
> >>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> >> +	bool will_need = cp_flags & MM_CP_WILL_NEED;
> >>  
> >>  	tlb_change_page_size(tlb, PAGE_SIZE);
> >>  
> >> @@ -172,6 +173,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
> >>  				ptent = pte_clear_uffd_wp(ptent);
> >>  			}
> >>  
> >> +			if (will_need)
> >> +				ptent = pte_mkyoung(ptent);
> > 
> > For uffd path, UFFD_FLAGS_ACCESS_LIKELY|UFFD_FLAGS_WRITE_LIKELY are new
> > internal flags used with or without the new feature bit set.  It means even
> > with !ACCESS_HINT we'll start to set young bit while we used not to?  Is
> > that some kind of a light abi change?
> > 
> > I'd suggest we only set will_need if ACCESS_HINT is set.
> > 
> >> +
> >>  			/*
> >>  			 * In some writable, shared mappings, we might want
> >>  			 * to catch actual write access -- see
> >> @@ -187,8 +191,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
> >>  			 */
> >>  			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
> >>  			    !pte_write(ptent) &&
> >> -			    can_change_pte_writable(vma, addr, ptent))
> >> +			    can_change_pte_writable(vma, addr, ptent)) {
> >>  				ptent = pte_mkwrite(ptent);
> >> +				if (will_need)
> >> +					ptent = pte_mkdirty(ptent);
> > 
> > Can we make this unconditional?  IOW to cover both:
> > 
> >   (1) When will_need is not set, or
> >   (2) mprotect() too
> > 
> > David's patch is good in that we merged the unprotect and CoW.  However
> > that's not complete because the dirty bit ops are missing.
> > 
> > Here IMHO we should have a standalone patch to just add the dirty bit into
> > this logic when we'll grant write bit.  IMHO it'll make the write+dirty
> > bits coherent again in all paths.
> 
> I'm not sure I follow.
> 
> We *surely* don't want to dirty random pages (especially once in the
> pagecache/swapcache) simply because we change protection.
> 
> Just like we don't set all pages write+dirty in a writable VMA on a read
> fault.

IMO unmprotect (in generic mprotect form or uffd form) has a stronger sign
of page being written, unlike read faults, as many of them happen because
page being written and message generated.

But yeah you have a point too, maybe we shouldn't assume such a condition.
Especially as long as we won't set write=1 without soft-dirty tracking
enabled, I think it should be safe.

-- 
Peter Xu

