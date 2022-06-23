Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E038F55898D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiFWTuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiFWTuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:50:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FAB2E08D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:48:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 184so368272pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fwXOVWaOks5aEB9DnQ0+LscIdibd3v9vBir98C6rDhg=;
        b=CQndzaYspw1/WKtdaLFGLHVaJegMtkhawi5iLktrm/WtozYiFtOC8IG/36xJvdHg4W
         k6vB1z9W/Cs08olUSBnSn32v+KVGz9b0wEvkWCRfKCMpZi3y8M/brwvaxp/GZVlJsdE+
         a5ACIRVUCZAO29t6ZGW5et/uRRD1d3WvAgDAcb2SSxWfqVGM12ELdbBknV/GtDWC6mKA
         vP4/Z9l+Rztp5bFydD/NohQTZcm/AUhsbJonqQaWM8fuRR+S///2Ib7H9EtQuQMn2i4X
         KMVLtUOUN9eYoG6H9iKils1LWKtkKcSn59RJkEiJWSH634OQjWGq5brVdUBGXvOiHxB4
         Yv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwXOVWaOks5aEB9DnQ0+LscIdibd3v9vBir98C6rDhg=;
        b=dU9FKSXvVY/rcLiKOeMiG6SZlGI441hSbX7rqPAEAs9lgJry6kECtZXRKxRW/ORLac
         3mz2dm9qFSmnzhOVkVNOpWCjpjExRh0DibDtyad8uGENnaAV8gtmGwkni7KG3Jhj4JJR
         srsbw6IDGVlT269rbb1ZzLp+OL9Vmhf6GuBNIdOOvSWd6gFABogeKP+uVJWHYmsV24g2
         H4kgzLbqBOu4UMhWlxHaOk+TOGlrkYSQew236tecgj381tfrBnb0uwglxp6CZvYNC2hC
         /0olJq06844xI4cNGtJZmkOAiIgRS6wiLqhkqFOKImzGyCGV4fp3jKBWAavW9fPVyHGI
         8IeA==
X-Gm-Message-State: AJIora8kH6FLHsX6yifFQftUlgARG3BC+a6sIjV2/27r6g4YAmkf8+pl
        +LPkCWjqgEjNtTkQRKCJrm+OrA==
X-Google-Smtp-Source: AGRyM1sfHJfUUw/z2jILs3RXN+LCGbbXiT6lLVzBDJ8fDqyWZMCpRFSMeph94IMzJrMYodDY7V2XQg==
X-Received: by 2002:a63:790c:0:b0:40c:3c04:e3d3 with SMTP id u12-20020a63790c000000b0040c3c04e3d3mr8898464pgc.44.1656013686345;
        Thu, 23 Jun 2022 12:48:06 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id i13-20020aa787cd000000b00522d329e36esm22686pfo.140.2022.06.23.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 12:48:05 -0700 (PDT)
Date:   Thu, 23 Jun 2022 19:48:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" 
        <kvm-riscv@lists.infradead.org>, Peter Feiner <pfeiner@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v7 22/23] KVM: x86/mmu: Extend Eager Page Splitting to
 nested MMUs
Message-ID: <YrTDcrsn0/+alpzf@google.com>
References: <20220622192710.2547152-1-pbonzini@redhat.com>
 <20220622192710.2547152-23-pbonzini@redhat.com>
 <CALzav=fH_9_LKVE0_UCftwy2KZaB3nSBoWU07aPWALag4_mcHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=fH_9_LKVE0_UCftwy2KZaB3nSBoWU07aPWALag4_mcHQ@mail.gmail.com>
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

On Thu, Jun 23, 2022, David Matlack wrote:
> On Wed, Jun 22, 2022 at 12:27 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

Please trim replies.

> > +static int topup_split_caches(struct kvm *kvm)
> > +{
> > +       int r;
> > +
> > +       lockdep_assert_held(&kvm->slots_lock);
> > +
> > +       /*
> > +        * It's common to need all SPLIT_DESC_CACHE_MIN_NR_OBJECTS (513) objects
> > +        * when splitting a page, but setting capacity == min would cause
> > +        * KVM to drop mmu_lock even if just one object was consumed from the
> > +        * cache.  So make capacity larger than min and handle two huge pages
> > +        * without having to drop the lock.
> 
> I was going to do some testing this week to confirm, but IIUC KVM will
> only allocate from split_desc_cache if the L1 hypervisor has aliased a
> huge page in multiple {E,N}PT12 page table entries. i.e. L1 is mapping
> a huge page into an L2 multiple times, or mapped into multiple L2s.
> This should be common in traditional, process-level, shadow paging,
> but I think will be quite rare for nested shadow paging.

Ooooh, right, I forgot that that pte_list_add() needs to allocate if and only if
there are multiple rmap entries, otherwise rmap->val points that the one and only
rmap directly.

Doubling the capacity is all but guaranteed to be pointless overhead.  What about
buffering with the default capacity?  That way KVM doesn't have to topup if it
happens to encounter an aliased gfn.  It's arbitrary, but so is the default capacity
size.

E.g. as fixup

---
 arch/x86/kvm/mmu/mmu.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 22b87007efff..90d6195edcf3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6125,19 +6125,23 @@ static bool need_topup_split_caches_or_resched(struct kvm *kvm)

 static int topup_split_caches(struct kvm *kvm)
 {
-	int r;
-
-	lockdep_assert_held(&kvm->slots_lock);
-
 	/*
-	 * It's common to need all SPLIT_DESC_CACHE_MIN_NR_OBJECTS (513) objects
-	 * when splitting a page, but setting capacity == min would cause
-	 * KVM to drop mmu_lock even if just one object was consumed from the
-	 * cache.  So make capacity larger than min and handle two huge pages
-	 * without having to drop the lock.
+	 * Allocating rmap list entries when splitting huge pages for nested
+	 * MMUs is rare as KVM needs to allocate if and only if there is more
+	 * than one rmap entry for the gfn, i.e. requires an L1 gfn to be
+	 * aliased by multiple L2 gfns, which is very atypical for VMMs.  If
+	 * there is only one rmap entry, rmap->val points directly at that one
+	 * entry and doesn't need to allocate a list.  Buffer the cache by the
+	 * default capacity so that KVM doesn't have to topup the cache if it
+	 * encounters an aliased gfn or two.
 	 */
-	r = __kvm_mmu_topup_memory_cache(&kvm->arch.split_desc_cache,
-					 2 * SPLIT_DESC_CACHE_MIN_NR_OBJECTS,
+	const int capacity = SPLIT_DESC_CACHE_MIN_NR_OBJECTS +
+			     KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
+	int r;
+
+	lockdep_assert_held(&kvm->slots_lock);
+
+	r = __kvm_mmu_topup_memory_cache(&kvm->arch.split_desc_cache, capacity,
 					 SPLIT_DESC_CACHE_MIN_NR_OBJECTS);
 	if (r)
 		return r;

base-commit: 436b1c29f36ed3d4385058ba6f0d6266dbd2a882
--

