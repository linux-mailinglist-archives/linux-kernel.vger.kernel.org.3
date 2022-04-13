Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A34FF80F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiDMNqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiDMNqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D17EE2018B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649857465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LhTw9F9UDchErjlX1iEf9dQ5QBg67b/AFMenqWnDONU=;
        b=PIpOq8iChqGPj9XE/cNJOZcBdHXTtgFHAEFFo5LCCy6DrnRZnQC04Ow8Tj8DcTJ+RMn2LM
        RsU+bcqhIhPV2ImwyQNUPWnZoLdeK+sfXZDCwB35pi697b0pBpU6WrgAQ/su/q2TAmfJhG
        CfiZdHFkN8qw6hWEa3yUJzvuwBsAQyo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-Z4zkpSHsO4megauwekuySg-1; Wed, 13 Apr 2022 09:44:24 -0400
X-MC-Unique: Z4zkpSHsO4megauwekuySg-1
Received: by mail-il1-f197.google.com with SMTP id j5-20020a056e020ee500b002cbc90840ecso1112875ilk.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LhTw9F9UDchErjlX1iEf9dQ5QBg67b/AFMenqWnDONU=;
        b=UhKifCKSRNpcXruIZ2GlFmnhsrSnOcOErIcNnSZNElcZp5XoeLvWvESnMsuSlbMI7Y
         zz2dq6C9EJQNlASXUUl9wVf0Dn8B6ZB7iylZx1e6uPQAxOLB8B9fjkS9/NJRznoQgttN
         10R58EUpmMzUna12o3f5LqwO6LfByAsOp/mC9v9mGbcVGnVx/h/S4h2l9SIAxo2WXWqT
         rb9iA11OEC3pXUmovEh9KQpb35MDTrENw6YitkBrRwE2g3amh7IaYNI8SX/yO7Hyc0MW
         x17cKyHK7xfi2iSZoM2zMHJCccV/6JtGUiGBNb0h5lUL3xHACNMtc2oynw5XzOQDcqZ2
         omMQ==
X-Gm-Message-State: AOAM530RpySPlFGep5MuMeVLDvCgcDbh64DyztQgsmuI6ZrfjLpU3qxA
        6M1OhZ4rtkPT06snJNf3cCJTpD5wlR9JW9JRI2gdJ2U0Nn017oTxTFHuzJxU/czKU5I2txhU5nZ
        EbDbBuQU6qEHej27ym9mETBCa
X-Received: by 2002:a05:6638:2587:b0:323:bc9f:9230 with SMTP id s7-20020a056638258700b00323bc9f9230mr19657054jat.216.1649857464178;
        Wed, 13 Apr 2022 06:44:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziFlvv7OvSg+9WwNOlAr419a4UYKWbNEeCzGwsPZS9ePMKd3bDn+XBMGy9rVOnJXBw3bnJPg==
X-Received: by 2002:a05:6638:2587:b0:323:bc9f:9230 with SMTP id s7-20020a056638258700b00323bc9f9230mr19657044jat.216.1649857463928;
        Wed, 13 Apr 2022 06:44:23 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a9-20020a926609000000b002ca50234d00sm23633ilc.2.2022.04.13.06.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:44:23 -0700 (PDT)
Date:   Wed, 13 Apr 2022 09:44:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 01/23] mm: Introduce PTE_MARKER swap entry
Message-ID: <YlbTtUqa61ygTn1F@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014646.13522-2-peterx@redhat.com>
 <87bkx7ayfs.fsf@nvdebian.thelocal>
 <YlXWzf3nF+lGA5fn@xz-m1.local>
 <8735ihbw6g.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735ihbw6g.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:30:33AM +1000, Alistair Popple wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Apr 12, 2022 at 11:07:56AM +1000, Alistair Popple wrote:
> >> Hi Peter,
> >
> > Hi, Alistair,
> >
> >>
> >> I noticed this while reviewing the next patch in the series. I think you need to
> >> add CONFIG_PTE_MARKER to the below as well:
> >>
> >> #if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION) || \
> >>     defined(CONFIG_DEVICE_PRIVATE)
> >> static inline int non_swap_entry(swp_entry_t entry)
> >> {
> >> 	return swp_type(entry) >= MAX_SWAPFILES;
> >> }
> >> #else
> >> static inline int non_swap_entry(swp_entry_t entry)
> >> {
> >> 	return 0;
> >> }
> >> #endif
> >>
> >> Otherwise marker entries will be treated as swap entries, which is wrong for
> >> example in swapin_walk_pmd_entry() as marker entries are no longer considered
> >> pte_none().
> >
> > Thanks for the comment, that makes sense.
> >
> > Instead of adding PTE_MARKER into this equation, I'm going backward and
> > wondering purely on why we need to bother with non_swap_entry() at all if
> > MAX_SWAPFILES is already defined with proper knowledges of all these bits.
> 
> I was going to suggest it was to help the compiler optimise the non-swap entry
> code away. But I just tested and it makes no difference in .text section size
> either way so I think your suggestion is good unless that isn't true for other
> architecture/compiler combinations (I only tried gcc-10.2.1 and x86_64).
> 
> That's a possibility because the optimisation isn't obvious to me at least.
> 
> non_swap_entry() is equivalent to:
> 
> (entry.val >> SWP_TYPE_SHIFT) >= MAX_SWAPFILES;
> (entry.val >> (BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)) >= (1<<5);
> (entry.val >> (BITS_PER_LONG - 1 - 5)) >= (1<<5);
> (entry.val >> 58) >= (1<<5);
> 
> Where entry.val is a long. So from that alone it's not obvious this could be
> optimised away, because nothing there implies entry.val != (1<<63) which would
> make the conditional true. But there's a lot of inlining going on in the
> creation of swap entries which I didn't trace, so something must end up implying
> entry.val < (1<<63).

I think my point was that we check non_swap_entry() with a pre-assumption
that it's a swap entry, then it means it's the slow path already after
we've parsed the pte entry and be aware it's not present.

So I'm doubting how much the optimization (even if at last, applicable)
could help in reality, not to mention that it'll only have an effect when
all of the configs are not set, so it's a micro optimization on slow path
in a rare config setup.

For any sane modern hosts I'd expect CONFIG_MIGRATION should at least be
set.. then it invalidates any potential optimization we're discussing here.

Let me post a patch for this and move the discussion there.  Thanks a lot
for looking into it.

-- 
Peter Xu

