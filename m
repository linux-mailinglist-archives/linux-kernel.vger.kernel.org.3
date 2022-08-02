Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC3588306
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiHBUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiHBUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3DB721E28
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659471286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQisCAy7HNNwKYr6ELuiJoYK6OFmrDK937rIepfeneQ=;
        b=dYo+eBkXAOEPcpXZrQIhkeJq/Ht9JJupNa3Dvg5uhkX9L2pcrhKAvJlsI4fSzuAd2DOQoU
        Cuvf0t1fUj1/Yf5XfdgZyfnX2nnma2+SSFlHH3r6HzMDjkilfHUf+N8nJnofwm53z4hCtM
        h0Lqc6q8GlfSuhMs06YIlXc3kTXbR0U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-_NMk25bhNcCwjS38L1DFiw-1; Tue, 02 Aug 2022 16:14:45 -0400
X-MC-Unique: _NMk25bhNcCwjS38L1DFiw-1
Received: by mail-qt1-f199.google.com with SMTP id w24-20020ac843d8000000b0031ecbfedc25so9708553qtn.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQisCAy7HNNwKYr6ELuiJoYK6OFmrDK937rIepfeneQ=;
        b=tmw4pXD2KiDMAybXbTLJE1uJCyKD6nkcKlZDF+2y2aBzf0/nRxM/7TvN9vIefO0Lo6
         6/bzygfaUaVgeppnio3JCK2oa9ID0IrRHSMtRiBiTPExUo/1XOlFFO7QvkfID3WHkbxk
         tqjeTus1UOZJAjr8F46RbnTFD8X538wzKrfXpSPut9axeRruoCIUNZtU4l0ZSbVvSlL9
         tvYYv2GXdqHLyGtgX+Y4zEO53BDCR0z7oWPeUiwJholjlHEtFwSRmbEmAZmsB8xB4JIQ
         cyxvrNmSnnUwpf0EyA4e2oWbgu3b0PP15eaBNfcCOU33cMwXdZzPi/XjFuink0ZxVdDZ
         Etew==
X-Gm-Message-State: AJIora95LxdAeudknhtb1Utctq8555Qwsw3PJ3JgEABCrr3tcHBxGnaj
        breuUGK+vGw1jL160/tvVkXJyojELeymTNFT6tRss2XBwgZH91nh6Z/NqRONSmz5hCLtc58inZi
        HK4XgoCm3xgNCj//bL6jNz9fw
X-Received: by 2002:a05:622a:189d:b0:31f:11f:a20a with SMTP id v29-20020a05622a189d00b0031f011fa20amr20531410qtc.73.1659471285232;
        Tue, 02 Aug 2022 13:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tPRWv06YrqyYoTEBCtGfYFCxOPgElMsYRgWTY8LxU+iuLv7opi4J+hQsc5C3Bce9EPMhzcOg==
X-Received: by 2002:a05:622a:189d:b0:31f:11f:a20a with SMTP id v29-20020a05622a189d00b0031f011fa20amr20531394qtc.73.1659471284952;
        Tue, 02 Aug 2022 13:14:44 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id z5-20020a05622a124500b0031ef67386a5sm9494433qtx.68.2022.08.02.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:14:44 -0700 (PDT)
Date:   Tue, 2 Aug 2022 16:14:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
Message-ID: <YumFs0jpCc/Mwjzf@xz-m1.local>
References: <20220729014041.21292-1-peterx@redhat.com>
 <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
 <YuhVJmSsgs4Q1bYJ@xz-m1.local>
 <49434bea-3862-1052-2993-8ccad985708b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49434bea-3862-1052-2993-8ccad985708b@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 02:06:37PM +0200, David Hildenbrand wrote:
> On 02.08.22 00:35, Peter Xu wrote:
> > On Mon, Aug 01, 2022 at 10:21:32AM +0200, David Hildenbrand wrote:
> >> On 29.07.22 03:40, Peter Xu wrote:
> >>> [Marking as RFC; only x86 is supported for now, plan to add a few more
> >>>  archs when there's a formal version]
> >>>
> >>> Problem
> >>> =======
> >>>
> >>> When migrate a page, right now we always mark the migrated page as old.
> >>> The reason could be that we don't really know whether the page is hot or
> >>> cold, so we could have taken it a default negative assuming that's safer.
> >>>
> >>> However that could lead to at least two problems:
> >>>
> >>>   (1) We lost the real hot/cold information while we could have persisted.
> >>>       That information shouldn't change even if the backing page is changed
> >>>       after the migration,
> >>>
> >>>   (2) There can be always extra overhead on the immediate next access to
> >>>       any migrated page, because hardware MMU needs cycles to set the young
> >>>       bit again (as long as the MMU supports).
> >>>
> >>> Many of the recent upstream works showed that (2) is not something trivial
> >>> and actually very measurable.  In my test case, reading 1G chunk of memory
> >>> - jumping in page size intervals - could take 99ms just because of the
> >>> extra setting on the young bit on a generic x86_64 system, comparing to 4ms
> >>> if young set.
> >>>
> >>> This issue is originally reported by Andrea Arcangeli.
> >>>
> >>> Solution
> >>> ========
> >>>
> >>> To solve this problem, this patchset tries to remember the young bit in the
> >>> migration entries and carry it over when recovering the ptes.
> >>>
> >>> We have the chance to do so because in many systems the swap offset is not
> >>> really fully used.  Migration entries use swp offset to store PFN only,
> >>> while the PFN is normally not as large as swp offset and normally smaller.
> >>> It means we do have some free bits in swp offset that we can use to store
> >>> things like young, and that's how this series tried to approach this
> >>> problem.
> >>>
> >>> One tricky thing here is even though we're embedding the information into
> >>> swap entry which seems to be a very generic data structure, the number of
> >>> bits that are free is still arch dependent.  Not only because the size of
> >>> swp_entry_t differs, but also due to the different layouts of swap ptes on
> >>> different archs.
> >>>
> >>> Here, this series requires specific arch to define an extra macro called
> >>> __ARCH_SWP_OFFSET_BITS represents the size of swp offset.  With this
> >>> information, the swap logic can know whether there's extra bits to use,
> >>> then it'll remember the young bits when possible.  By default, it'll keep
> >>> the old behavior of keeping all migrated pages cold.
> >>>
> >>
> >>
> >> I played with a similar idea when working on pte_swp_exclusive() but
> >> gave up, because it ended up looking too hacky. Looking at patch #2, I
> >> get the same feeling again. Kind of hacky.
> > 
> > Could you explain what's the "hacky" part you mentioned?
> 
> SWP_PFN_OFFSET_FREE_BITS :)
> 
> It's a PFN offset and we're mangling in random other bits. That's hacky
> IMHO.
> 
> I played with the idea of converting all code to store bits in addition
> to the type + offset. But that requires digging through a lot of arch
> code to teach that code about additional flags, so I discarded that idea
> when working on the COW fixes.

Having SWP_PFN_OFFSET_FREE_BITS was the cleanest approach I could think of
before I know the max_swapfile_size() trick. It only needs the arch to
define this one macro and swapops.h will take action accordingly.

OTOH, I don't want to use swap pte bits not only because there aren't a lot
left for some archs (x86_64 only has bit 4 left, afaict), but also since
this is a page migration issue it'll be nicer to me if can be solved in the
swp entry level, not pte.

> 
> > 
> > I used swap entry to avoid per-arch operations. I failed to figure out a
> > common way to know swp offset length myself so unluckily in this RFC I
> > still needed one macro per-arch.  Ying's suggestion seems to be a good fit
> > here to me to remove the last arch-specific dependency.
> 
> Instead of mangling this into the PFN offset and let the arch tell you
> which bits of the PFN offset are unused ... rather remove the bits from
> the offset and define them manually to have a certain meaning. That's
> exactly how pte_swp_mkexclusive/pte_swp_exclusive/ is supposed to be
> handled on architectures that want to support it.
> 
> I hope I could make it clearer what the hacky part is IMHO :)
> 
> > 
> >>
> >>
> >> If we mostly only care about x86_64, and it's a performance improvement
> >> after all, why not simply do it like
> >> pte_swp_mkexclusive/pte_swp_exclusive/ ... and reuse a spare PTE bit?
> > 
> > Page migration works for most archs, I want to have it work for all archs
> > that can easily benefit from it.
> 
> Yet we only care about x86-64 IIUC regarding performance, just the way
> the dirty bit is handled?

I don't think we only care about x86_64?  Should other archs have the same
issue as long as there's the hardware young bit?

Even without it, it'll affect page reclaim logic too, and that's also not
x86 only.

> 
> > 
> > Besides I actually have a question on the anon exclusive bit in the swap
> > pte: since we have that anyway, why we need a specific migration type for
> > anon exclusive pages?  Can it be simply read migration entries with anon
> > exclusive bit set?
> 
> Not before all arch support pte_swp_mkexclusive/pte_swp_exclusive/.
> 
> As pte_swp_mkexclusive/pte_swp_exclusive/ only applies to actual swap
> PTEs, you could even reuse that bit for migration entries and get at
> alteast the most relevant 64bit architectures supported easily.

Yes, but I think having two mechanisms for the single problem can confuse
people.

IIUC the swap bit is already defined in major archs anyway, and since anon
exclusive bit is best-effort (or am I wrong?..), I won't worry too much on
archs outside x86/arm/ppc/s390 on having anon exclusive bit lost during
migrations, because afaict the whole swap type of ANON_EXCLUSIVE_READ is
only servicing that very minority.. which seems to be a pity to waste the
swp type on all archs even if the archs defined swp pte bits just for anon
exclusive.

Thanks,

-- 
Peter Xu

