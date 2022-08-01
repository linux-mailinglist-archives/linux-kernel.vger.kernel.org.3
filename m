Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F9587401
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiHAWf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiHAWfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B0B0165AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659393321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BGq/9sKWsp0P6HkN6ECK5vjCzI7FVypb04D1n+18zbc=;
        b=gRSBAiNg3akrW3bOuWMCrI4NxNntvvMIZOyG/br2uietjYrT2er+FvDjwPTJsAHYXPujsL
        wRMxdLiDCpuVQqyAPZ9gCw8EdPsDUtuaifxqPmnq27StWYrMHdbknMuNaj2Oycb1iMCa9o
        rWfdnrnM9VhQmLJKVr5rL4SZ0HYT/fg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-iyIRC1BLNk-9l9FDRzElcA-1; Mon, 01 Aug 2022 18:35:20 -0400
X-MC-Unique: iyIRC1BLNk-9l9FDRzElcA-1
Received: by mail-qv1-f71.google.com with SMTP id q1-20020a056214018100b0047464a85fc4so7167705qvr.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGq/9sKWsp0P6HkN6ECK5vjCzI7FVypb04D1n+18zbc=;
        b=E4xlGKiJiqsfJ3z2YmdsyulWas60Z2J7jgQDbQXshyAzVfmjteCtFF2/ycGYYpm+Ax
         T1jl0G+ayevcsg7rqH1ojm2pa3RajyDIqgBsnW05BwVsA0/jWZ4RjQ9BfGO7HDGT5cEM
         7FVwHlpwxF1bVb4JzFdmD3T6mtzIH+owbdjFcztkhBneES/1xJulRqPVIW51fpAMXDKY
         /LCVOVkA+ROW4BwSH1b7uuVPrWwo6ZHI6+snE6gUN0ap2Ulx4Gow7Eph084iMjdQ8Qrs
         JX+7Rhx5PkvaUS8J/qa1VPBnvjda1J38N6Rs9kaEPHAYv2VhJOiqv8i+yNYsoRklhUQX
         QA9g==
X-Gm-Message-State: AJIora86PGGgaop5fF4Z55vNSp9hMZDhwlK/WkPm2vHFXBj+cvjTYrPL
        6UQGj0E9oHf6z9/4Ou3M7Ggrs0Ix/LyV5+Mah4RHLKIDPXy+r/sTe3dzTrIpYBuMCflv164iWp3
        kQAsmeNB2asKqXD8Q33nZHZ54
X-Received: by 2002:a05:620a:2804:b0:6b8:62a5:71bf with SMTP id f4-20020a05620a280400b006b862a571bfmr12962975qkp.545.1659393320210;
        Mon, 01 Aug 2022 15:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1smlmETeKn/0A2gBE08E372BSHdi6gbCTTefeQWYqHn5sTafMHwXCGBPznb08dz8HUSiP5Vbw==
X-Received: by 2002:a05:620a:2804:b0:6b8:62a5:71bf with SMTP id f4-20020a05620a280400b006b862a571bfmr12962958qkp.545.1659393319964;
        Mon, 01 Aug 2022 15:35:19 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id d17-20020a05622a15d100b0031eb215a682sm8346216qty.13.2022.08.01.15.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:35:19 -0700 (PDT)
Date:   Mon, 1 Aug 2022 18:35:18 -0400
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
Message-ID: <YuhVJmSsgs4Q1bYJ@xz-m1.local>
References: <20220729014041.21292-1-peterx@redhat.com>
 <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f23b71e5-a5f5-bb39-dbec-3e85af344185@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:21:32AM +0200, David Hildenbrand wrote:
> On 29.07.22 03:40, Peter Xu wrote:
> > [Marking as RFC; only x86 is supported for now, plan to add a few more
> >  archs when there's a formal version]
> > 
> > Problem
> > =======
> > 
> > When migrate a page, right now we always mark the migrated page as old.
> > The reason could be that we don't really know whether the page is hot or
> > cold, so we could have taken it a default negative assuming that's safer.
> > 
> > However that could lead to at least two problems:
> > 
> >   (1) We lost the real hot/cold information while we could have persisted.
> >       That information shouldn't change even if the backing page is changed
> >       after the migration,
> > 
> >   (2) There can be always extra overhead on the immediate next access to
> >       any migrated page, because hardware MMU needs cycles to set the young
> >       bit again (as long as the MMU supports).
> > 
> > Many of the recent upstream works showed that (2) is not something trivial
> > and actually very measurable.  In my test case, reading 1G chunk of memory
> > - jumping in page size intervals - could take 99ms just because of the
> > extra setting on the young bit on a generic x86_64 system, comparing to 4ms
> > if young set.
> > 
> > This issue is originally reported by Andrea Arcangeli.
> > 
> > Solution
> > ========
> > 
> > To solve this problem, this patchset tries to remember the young bit in the
> > migration entries and carry it over when recovering the ptes.
> > 
> > We have the chance to do so because in many systems the swap offset is not
> > really fully used.  Migration entries use swp offset to store PFN only,
> > while the PFN is normally not as large as swp offset and normally smaller.
> > It means we do have some free bits in swp offset that we can use to store
> > things like young, and that's how this series tried to approach this
> > problem.
> > 
> > One tricky thing here is even though we're embedding the information into
> > swap entry which seems to be a very generic data structure, the number of
> > bits that are free is still arch dependent.  Not only because the size of
> > swp_entry_t differs, but also due to the different layouts of swap ptes on
> > different archs.
> > 
> > Here, this series requires specific arch to define an extra macro called
> > __ARCH_SWP_OFFSET_BITS represents the size of swp offset.  With this
> > information, the swap logic can know whether there's extra bits to use,
> > then it'll remember the young bits when possible.  By default, it'll keep
> > the old behavior of keeping all migrated pages cold.
> > 
> 
> 
> I played with a similar idea when working on pte_swp_exclusive() but
> gave up, because it ended up looking too hacky. Looking at patch #2, I
> get the same feeling again. Kind of hacky.

Could you explain what's the "hacky" part you mentioned?

I used swap entry to avoid per-arch operations. I failed to figure out a
common way to know swp offset length myself so unluckily in this RFC I
still needed one macro per-arch.  Ying's suggestion seems to be a good fit
here to me to remove the last arch-specific dependency.

> 
> 
> If we mostly only care about x86_64, and it's a performance improvement
> after all, why not simply do it like
> pte_swp_mkexclusive/pte_swp_exclusive/ ... and reuse a spare PTE bit?

Page migration works for most archs, I want to have it work for all archs
that can easily benefit from it.

Besides I actually have a question on the anon exclusive bit in the swap
pte: since we have that anyway, why we need a specific migration type for
anon exclusive pages?  Can it be simply read migration entries with anon
exclusive bit set?

Thanks,

-- 
Peter Xu

