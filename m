Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0155890C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiHCQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiHCQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D14B720BE4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659545134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ojfn7cuIMbHCcuvRihfgUsrNAOLm8Anqm64eT7HEXNM=;
        b=AGvozYQwLWhP9/r3F9VHY5IMTmJlSnern+IJECdo+OD/8A8dxNgG9ehu3O5UQR/hgjNaMr
        WPK8rSEpHvMdQtJIAZUxPOJwNzLukmHyC18y9hYGB8Nudm8sG2yvhNEmT8iwLQ2zxHiQKu
        r++CRllnC0h7bd6n3b4cltKYYpzE0Cw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-2WiguyjnNxmOrsG8qhbv8w-1; Wed, 03 Aug 2022 12:45:33 -0400
X-MC-Unique: 2WiguyjnNxmOrsG8qhbv8w-1
Received: by mail-qv1-f69.google.com with SMTP id e1-20020ad44181000000b00472f8ad6e71so10457256qvp.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ojfn7cuIMbHCcuvRihfgUsrNAOLm8Anqm64eT7HEXNM=;
        b=KL2ADjlvD245nbpLamg/ELriy1rrMWtsJpwl6OpWsmgxPyo8lSFz5ZAt4+FdoLiZpz
         TkUYz7bSxPlvFQZxPwW/b0zui8xeWOpjAZJEP2XOavHyJXyu7Xt2klNNC6dlRRbFuQBV
         IFpuNSIx+ki03pcZp2xXTS78BBcdd2pzDZqyU2c33wn8cZa4H6CQtmlRNIxjrbByZxe+
         qWq53/pOBZ8Br8ASRimKNffSH2rNc9UZKc8M5GjzrwOUBj099PG8A4e5s+CunS9QmqZH
         3vgDZ5O0RAxQN88f7KeOSagSlMPjrmZfR8gWC0byC2Hv812WCKgG52imLtJ582ONu/rH
         WD2Q==
X-Gm-Message-State: AJIora/dEWzgEsBvFs3tScjX0+D5B5LNsCxYFME92lqqOVLi1/Ao8uj5
        crSxeOZGX85KZrr1BJNgv74KGJDsJXGKvLDnZNTGLe/hO5ltPP6/r24I3tENtsMqzA0WYgtkFg8
        w6TQ02Zzv/UOIVq0by5dcTcPZ
X-Received: by 2002:ac8:7c48:0:b0:31f:83:85d9 with SMTP id o8-20020ac87c48000000b0031f008385d9mr22976766qtv.105.1659545132272;
        Wed, 03 Aug 2022 09:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8eQT06Po6PUhbOVkVB5uPwil19CmoUApfs94oFCHAADSF7K2hjPl6HOraQaf1D9DfVt5AZA==
X-Received: by 2002:ac8:7c48:0:b0:31f:83:85d9 with SMTP id o8-20020ac87c48000000b0031f008385d9mr22976749qtv.105.1659545131985;
        Wed, 03 Aug 2022 09:45:31 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id i7-20020a05622a08c700b0031ef69c9024sm11080429qte.91.2022.08.03.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:45:31 -0700 (PDT)
Date:   Wed, 3 Aug 2022 12:45:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
Message-ID: <YuqmKmVtVYnkDF7J@xz-m1.local>
References: <20220803012159.36551-1-peterx@redhat.com>
 <20220803012159.36551-3-peterx@redhat.com>
 <EEBB9DDB-3D67-42BD-BD16-4264F40760CD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EEBB9DDB-3D67-42BD-BD16-4264F40760CD@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 12:42:54AM -0700, Nadav Amit wrote:
> On Aug 2, 2022, at 6:21 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> > When page migration happens, we always ignore the young bit settings in the
> > old pgtable, and marking the page as old in the new page table using either
> > pte_mkold() or pmd_mkold().
> > 
> > That's fine from functional-wise, but that's not friendly to page reclaim
> > because the moving page can be actively accessed within the procedure.  Not
> > to mention hardware setting the young bit can bring quite some overhead on
> > some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
> > 
> > Actually we can easily remember the young bit configuration and recover the
> > information after the page is migrated.  To achieve it, define a new bit in
> > the migration swap offset field to show whether the old pte has young bit
> > set or not.  Then when removing/recovering the migration entry, we can
> > recover the young bit even if the page changed.
> > 
> > One thing to mention is that here we used max_swapfile_size() to detect how
> > many swp offset bits we have, and we'll only enable this feature if we know
> > the swp offset can be big enough to store both the PFN value and the young
> > bit.  Otherwise the young bit is dropped like before.
> 
> I gave it some more thought and I am less confident whether this is the best
> solution. Not sure it is not either, so I am raising an alternative with
> pros and cons.
> 
> An alternative would be to propagate the access bit into the page (i.e.,
> using folio_set_young()) and then set it back into the PTE later (i.e.,
> based on folio_test_young()). It might even seem that in general it is
> better to always set the page access bit if folio_test_young().

That's indeed an option.  It's just that the Young bit (along with Idle
bit) is only defined with PAGE_IDLE feature enabled, or they're all no-op.

Another thing is even though using page flags looks clean, it'll lose the
granule of virtual address spaces when the page can be mapped in multiple
mm/vmas.  I don't think there's a major difference here since page reclaim
will collect either pte young or page young (as long as page idle defined)
so it'll be the same. But there'll be other side effects as long as related
to the virtual address space. E.g. extra TLB flush needed as you said even
if the pages were not accessed by some mapping at all, so they become false
positive "young" pages after migration entries recovered.

In short, it'll be slightly less accurate than storing it in pgtables.

> 
> This can be simpler and more performant. Setting the access-bit would not
> impact reclaim decisions (as the page is already considered young), would
> not induce overheads on clearing the access-bit (no TLB flush is needed at
> least on x86), and would save the time the CPU takes to set the access bit
> if the page is ever accessed (on x86).

Agreed.  These benefits should be shared between both the pgtable approach
or the PageYoung approach you mentioned.

> 
> It may also improve the preciseness of page-idle mechanisms and the
> interaction with it.

IIUC this may need extra work for page idle.

Currently when doing rmap walks we either only look at migration entries or
never look at them, according to the PVMW_MIGRATION flag.  We'll need to
teach the page idle code and rmap walker to be able to walk with both
present ptes and migration entries at the same time to achieve that
preciseness.

> IIUC, page-idle does not consider migration entries, so
> the user would not get indication that pages under migration are not idle.
> When page-idle is reset, migrated pages might be later reinstated as
> “accessed”, giving wrong indication that the pages are not-idle, when in
> fact they are.

Before this patchset, we'll constantly loosing that young bit, hence it'll
be a false negative after migration entries recovered.

After this patchset, we'll have a possible race iff the page idle was
triggered during migrating some pages, but it's a race condition only and
the young bit will be correctly collected after migration completed.

So I agree it's a problem as you mentioned, but probably it's still better
with current patch than without it.

If ultimately we decided to go with page flags approach as you proposed,
just to mention that setting PageYoung is not enough - that bit is only
used to reserve page reclaim logic and not being interrupted by page idle.
IMO what we really will need is clearing PageIdle instead.

> 
> On the negative side, I am not sure whether other archs, that might require
> a TLB flush for resetting the access-bit, and the overhead of doing atomic
> operation to clear the access-bit, would not induce more overhead than they
> would save.

I think your proposal makes sense and looks clean, maybe even cleaner than
the new max_swapfile_size() approach (and definitely nicer than the old one
of mine). It's just that I still want this to happen even without page idle
enabled - at least Fedora doesn't have page idle enabled by default.  I'm
not sure whether it'll be worth it to define Young bit just for this (note:
iiuc we don't need Idle bit in this case, but only the Young bit).

The other thing is whether there's other side effect of losing pte level
granularity of young bit, since right after we merge them into the page
flags, then that granule is lost.  So far I don't worry a lot on the tlb
flush overhead, but hopefully nothing else we missed.

> 
> One more unrelated point - note that remove_migration_pte() would always set
> a clean PTE even when the old one was dirty…

Correct.  Say it in another way, at least initial writes perf will still
suffer after migration on x86.

Dirty bit is kind of different in this case so I didn't yet try to cover
it.  E.g., we won't lose it even without this patchset but consolidates it
into PageDirty already or it'll be a bug.

I think PageDirty could be cleared during migration procedure, if so we
could be wrongly applying the dirty bit to the recovered pte.  I thought
about this before posting this series, but I hesitated on adding dirty bit
altogether with it at least in these initial versions since dirty bit may
need some more justifications.

Please feel free to share any further thoughts on the dirty bit.

Thanks,

-- 
Peter Xu

