Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC56B588417
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiHBWQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiHBWPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3106A20F7E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659478524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FqVRlEHur0d/fmsso+w0FT2BQvJDAm+QPlbVTAl1QMc=;
        b=OSzqSLvIU2rzjQBvrhv1k66hb4qW1nu3nAj4noRUqhbmJy0dslpZwsyW5FihOJIeZG1CEk
        hflYSv87aqyvPlbu5SJJx4Zg//fER7cCNggpKnIrbFb7Z/aB6lYmWIvzOPU4eItCtMmx+d
        eyv1anxYPoPCeco4ntjtwqZQz/qpSWw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-p1B_33BWOG2eITejV62R6w-1; Tue, 02 Aug 2022 18:15:23 -0400
X-MC-Unique: p1B_33BWOG2eITejV62R6w-1
Received: by mail-qk1-f198.google.com with SMTP id m8-20020a05620a24c800b006b5d8eb23efso12543976qkn.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FqVRlEHur0d/fmsso+w0FT2BQvJDAm+QPlbVTAl1QMc=;
        b=LPNRc0z17jGULaY7gP8Cthi/Le1L1sZDPZjHhxAdSimKKxQVA3/XVRObw2tiSQQZE9
         LXsQNfBPvH1zekNxM1SMfOy+0UHt9r5HqzLVWNGwRG0CgShP9EopUfe640XZk2TVNxwo
         O7nrCabTxNZtpG9HiD9LFofU9Wn5cUhwx3Tjjpf6oKF5vUPxReUIm8FAWi1sIkUJwXvR
         RBCjMDzMjm/H0TsnBalVdOV45knZioYhY75t2PUP63hj/qa9MhaG1uVVymFWYz+yCSfJ
         RIprY/gv/m2ucN+M37IFgFzchqB4PwkpDcNXUebjgqlmCw22znQ9vefFUV6TMZtW+ggN
         B4Og==
X-Gm-Message-State: AJIora8FsJdGJ/ZtqRwG1wa6BNHQVlhaaJLqTWmgfOQp2MQJYEGS3du0
        JdVCzCPyQnjNlgROLbsiwf6960WFGYGvaQaFuK4jP81cy/atiL+dzaZwefYEmdo4EhjU0IvPpgr
        603zMpqLQGss3KlTAIHub6dHn
X-Received: by 2002:a05:622a:547:b0:31f:226a:c89 with SMTP id m7-20020a05622a054700b0031f226a0c89mr20174606qtx.417.1659478522560;
        Tue, 02 Aug 2022 15:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tsI8Yn1r/qgEcDC82gRZwFw6b4Ddz79TVKpLZddeqmj0YlSWs1QaSK7GzDZgUoKDhW1AA2ng==
X-Received: by 2002:a05:622a:547:b0:31f:226a:c89 with SMTP id m7-20020a05622a054700b0031f226a0c89mr20174591qtx.417.1659478522270;
        Tue, 02 Aug 2022 15:15:22 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id d21-20020ac84e35000000b0031ed3d79556sm9629389qtw.53.2022.08.02.15.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 15:15:21 -0700 (PDT)
Date:   Tue, 2 Aug 2022 18:15:20 -0400
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
Message-ID: <Yumh+EzU5TpCCjSo@xz-m1.local>
References: <20220729014041.21292-1-peterx@redhat.com>
 <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
 <YuhVJmSsgs4Q1bYJ@xz-m1.local>
 <49434bea-3862-1052-2993-8ccad985708b@redhat.com>
 <YumFs0jpCc/Mwjzf@xz-m1.local>
 <24ffea6e-ca66-2b94-c682-48a42a655fd1@redhat.com>
 <YumKlqjv8PaafpER@xz-m1.local>
 <4f876ff0-c6d2-2ebb-5917-dc1ff98fa8b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f876ff0-c6d2-2ebb-5917-dc1ff98fa8b0@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:59:42PM +0200, David Hildenbrand wrote:
> On 02.08.22 22:35, Peter Xu wrote:
> > On Tue, Aug 02, 2022 at 10:23:49PM +0200, David Hildenbrand wrote:
> >>> I don't think we only care about x86_64?  Should other archs have the same
> >>> issue as long as there's the hardware young bit?
> >>>
> >>> Even without it, it'll affect page reclaim logic too, and that's also not
> >>> x86 only.
> >>
> >> Okay, reading the cover letter and looking at the code my understanding
> >> was that x86-64 is the real focus.
> >>
> >>>>
> >>>>>
> >>>>> Besides I actually have a question on the anon exclusive bit in the swap
> >>>>> pte: since we have that anyway, why we need a specific migration type for
> >>>>> anon exclusive pages?  Can it be simply read migration entries with anon
> >>>>> exclusive bit set?
> >>>>
> >>>> Not before all arch support pte_swp_mkexclusive/pte_swp_exclusive/.
> >>>>
> >>>> As pte_swp_mkexclusive/pte_swp_exclusive/ only applies to actual swap
> >>>> PTEs, you could even reuse that bit for migration entries and get at
> >>>> alteast the most relevant 64bit architectures supported easily.
> >>>
> >>> Yes, but I think having two mechanisms for the single problem can confuse
> >>> people.
> >>>
> >>
> >> It would be one bit with two different meanings depending on the swp type.
> >>
> >>> IIUC the swap bit is already defined in major archs anyway, and since anon
> >>> exclusive bit is best-effort (or am I wrong?..), I won't worry too much on
> >>
> >> It kind-of is best effort, but the goal is to have all archs support it.
> >>
> >> ... just like the young bit here?
> > 
> > Exactly, so I'm also wondering whether we can move the swp pte anon
> > exclusive bit into swp entry.  It just sounds weird to have them defined in
> > two ways.
> 
> I'd argue it's just the swp vs. nonswp difference that are in fact two
> different concepts (device+offset vs. type+pte). And some dirty details
> how swp entries are actually used.
> 
> With swp entries you have to be very careful, for example, take a look
> at radix_to_swp_entry() and swp_to_radix_entry(). That made me refrain
> from touching anything inside actual swp entries and instead store it in
> the pte.

I don't really see any risk - it neither touches the swp entry nor do
complicated things around it (shift 1 and set bit 0 to 1).  Please feel
free to share your concern in case I overlooked something, though.

> 
> > 
> >>
> >>> archs outside x86/arm/ppc/s390 on having anon exclusive bit lost during
> >>> migrations, because afaict the whole swap type of ANON_EXCLUSIVE_READ is
> >>> only servicing that very minority.. which seems to be a pity to waste the
> >>
> >> I have a big item on my todo list to support all, but I have different
> >> priorities right now.
> >>
> >> If there is no free bit, simply steal one from the offset ... which is
> >> the same thing your approach would do, just in a different way, no?
> >>
> >>> swp type on all archs even if the archs defined swp pte bits just for anon
> >>> exclusive.
> >>
> >> Why do we care? We walk about one type not one bit.
> > 
> > The swap type address space is still limited, I'd say we should save when
> > possible.  I believe people caring about swapping care about the limit of
> > swap devices too.  If the offset can keep it, I think it's better than the
> 
> Ehm, last time I did the math I came to the conclusion that nobody
> cares. Let me redo the math:
> 
> MAX_SWAPFILES = 1<<5 - 1 - 1 - 4 - 3 - 1 = 22
> 
> Which is the worst case right now with all kinds of oddity compiled in
> (sorry CONFIG_DEVICE_PRIVATE).
> 
> So far nobody complaint.

Yeah.  To me using one bit of it is fine especially if that's the best to
do.  Here what confuses me is we have two ways to represent "whether this
page is anon exclusive" in a swap pte, either we need to go into the type
or using the bit.  The trick here is whether the swap pte bit makes sense
depends on the swp type first too, while the swap type can be "anon
exclusive read migration" itself.

> 
> > swap type.  De-dup either the type or the swap pte bit would be nicer, imho.
> > 
> 
> If you manage bits in the pte manually, you might be able to get a
> better packing density, if bits are scattered around. Just take a look
> at the x86_64 location of _PAGE_SWP_EXCLUSIVE.
> 
> What I'm rooting for is something like
> 
> #define pte_nonswp_mkyoung pte_swp_mkexclusive
> 
> Eventually with some VM_BUG_ONs to make sure people call it on the right
> swp ptes.
> 
> If we ever want to get rid of SWP_MIGRATION_READ_EXCLUSIVE (so people
> can have 23 swap devices), and eventually have separate bits for both.
> For now it's not necessary.

Okay, but that's probably the last thing I'd like to try - I don't want to
further complicate the anon exclusive bit in swap pte..  I'd think cleaning
that up somehow would be nice, but as you mentioned if no one complains I
have no strong opinion either.

Thanks,

-- 
Peter Xu

