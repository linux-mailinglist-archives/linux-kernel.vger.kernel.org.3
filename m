Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3523752ABEA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352714AbiEQT2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352738AbiEQT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:28:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BC522D1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:28:28 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t16so106257qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+GTnHqdgmyXOm9RkzWehTMYO1EHztDKBHLGlaNOOrk=;
        b=kQ25g3ZuZJkfW9Uvs/URM4ncmDrq6i0piKeLO7/nWk0OvMMj4CNIcNIbNxqIwugSF8
         rtDHDiUWwuKQe5I2FGGjr1cfLxJSjxy4lzzZ6NOfPzQUxtwXF3qxduuzeZ0nu2kuVNJL
         CHmvtctmC3GEY1CrimqTyybUbnHxYCK1tHjMGfOhCgtED6jdXvujJhEXRGt0nXXxZyzf
         QqQHSWf8Yn0VKEqzNDzMcxQszBPpcSfrxHwi58uNqxFfRPCBuPPfpyX4SOEV/NTxEewK
         4lJpIzWcxzX7C7dHvoh6nK5YeN5B6L2d0NDAXty2hRuoQceuXW1H2XEl7j7r42Ddkxzc
         5bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+GTnHqdgmyXOm9RkzWehTMYO1EHztDKBHLGlaNOOrk=;
        b=gS+ebcRsis/GvR2VTMKe+JYsf2+r8BG2QzcvVGFeVUcJRrp4Wp5xcr/pfh2+FHTK3q
         7dZiM5ATpThYTYyjsj2bWe30nh1x2A21ERWTdOnPQZ/cuwMJK0w2R0COW0Zgg4UGrqfO
         UI6MTWdCMgMttYmXKWB9q/8qQAjqyAWnnCZ9Eu2wxAAHbaoKbSSgC4tVczJ7A9L7uqa7
         cTTbRDJFU0WNoXeZ9BGlaDAXY+F+NHiyL1MzSMYPZTPlCL0/7zej9BJu2260np+wBFBc
         ZZpahEoj7e1Rg0Oae5Zd3utMbwMorujbULm7aZX1hhKYK7bXWaeXzuXJKtwnxVBT5bHL
         2bNg==
X-Gm-Message-State: AOAM532oRqwbBRkCk7znRC9AffI4tI7fepdGhIyjh7F+plcSFYkdzswH
        NPwn0eccGc7omjBRD+8a9lnjJw==
X-Google-Smtp-Source: ABdhPJxwA9mNXuOulavrU7Eibv9h7BDB+IkcxLIqfNM1emBRCPvM2g7PLBMn9dePNbP/MWUY5k/8wA==
X-Received: by 2002:ac8:5913:0:b0:2f3:a402:1054 with SMTP id 19-20020ac85913000000b002f3a4021054mr21594800qty.513.1652815707493;
        Tue, 17 May 2022 12:28:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x124-20020a37ae82000000b0069fc13ce1eesm22395qke.31.2022.05.17.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:28:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nr2rq-0089si-04; Tue, 17 May 2022 16:28:26 -0300
Date:   Tue, 17 May 2022 16:28:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220517192825.GM63055@ziepe.ca>
References: <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
 <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:12:37AM -0700, John Hubbard wrote:
> On 5/17/22 07:00, Jason Gunthorpe wrote:
> > > > It does change the generated code slightly. I don't know if this will
> > > > affect performance here or not. But just for completeness, here you go:
> > > > 
> > > > free_one_page() originally has this (just showing the changed parts):
> > > > 
> > > >      mov    0x8(%rdx,%rax,8),%rbx
> > > >      and    $0x3f,%ecx
> > > >      shr    %cl,%rbx
> > > >      and    $0x7,
> > > > 
> > > > 
> > > > And after applying this diff:
> > > > 
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 0e42038382c1..df1f8e9a294f 100644
> > > > +++ b/mm/page_alloc.c
> > > > @@ -482,7 +482,7 @@ unsigned long __get_pfnblock_flags_mask(const struct
> > > > page *page,
> > > >          word_bitidx = bitidx / BITS_PER_LONG;
> > > >          bitidx &= (BITS_PER_LONG-1);
> > > > 
> > > > -       word = bitmap[word_bitidx];
> > > > +       word = READ_ONCE(bitmap[word_bitidx]);
> > > >          return (word >> bitidx) & mask;
> > > >   }
> > > > 
> > > > 
> > > > ...it now does an extra memory dereference:
> > > > 
> > > >      lea    0x8(%rdx,%rax,8),%rax
> > > >      and    $0x3f,%ecx
> > > >      mov    (%rax),%rbx
> > > >      shr    %cl,%rbx
> > > >      and    $0x7,%ebx
> > 
> > Where is the extra memory reference? 'lea' is not a memory reference,
> > it is just some maths?
> 
> If you compare this to the snippet above, you'll see that there is
> an extra mov statement, and that one dereferences a pointer from
> %rax:
> 
>     mov    (%rax),%rbx

That is the same move as:

   mov    0x8(%rdx,%rax,8),%rbx

Except that the EA calculation was done in advance and stored in rax.

lea isn't a memory reference, it is just computing the pointer value 
that 0x8(%rdx,%rax,8) represents. ie the lea computes

  %rax = %rdx + %rax*8 + 6

Which is then fed into the mov. Maybe it is an optimization to allow
one pipe to do the shr and an other to the EA - IDK, seems like a
random thing for the compiler to do.
> > IMHO putting a READ_ONCE on something that is not a memory load from
> > shared data is nonsense - if a simple == has a stability risk then so
> > does the '(word >> bitidx) & mask'.
> 
> Doing something like this:
> 
>     int __x = y();
>     int x = READ_ONCE(__x);
> 
> is just awful! I agree. Really, y() should handle any barriers, because
> otherwise it really does look pointless, and people reading the code
> need something that is clearer. My first reaction was that this was
> pointless and wrong, and it turns out that that's only about 80% true:
> as long as LTO-of-the-future doesn't arrive, and as long as no one
> refactors y() to be inline.

It is always pointless, because look at the whole flow:

 y():
   word = bitmap[word_bitidx];
   return (word >> bitidx) & mask;

 int __x = y()
 int x = READ_ONCE(__x)

The requirement here is for a coherent read of bitmap[word_bitidx]
that is not mangled by multi-load, load tearing or other theoritcal
compiler problems. Stated more clearly if bitmap[] has values {A,B,C}
then the result of all this in x should always be {A',B',C'} according
to the given maths, never, ever an impossible value D.

The nature of the compiler problems we are trying to prevent is that
the compiler my take a computation that seems deterministic and
corrupt it somehow by making an assumption that the memory is stable
when it is not.

For instance == may not work right if the compiler decides to do:

 if (READ_ONCE(a) == 1 && READ_ONCE(a) == 1)

This also means that >> and & could malfunction. So when LTO expands
and inlines everything and you get this:

 if (READ_ONCE((bitmap[word_bitidx] >> bitidx) & mask) == MIGRATE_CMA)

It is still not safe because the >> and & could have multi-loaded or
torn the read in some way that it is no longer a sane
calculation. (for instance imagine that the compiler decides to read
the value byte-at-a-time without READ_ONCE)

ie the memory may have had A racing turning into C but x computed into
D not A'.

Paul can correct me, but I understand we do not have a list of allowed
operations that are exempted from the READ_ONCE() requirement. ie it
is not just conditional branching that requires READ_ONCE().

This is why READ_ONCE() must always be on the memory load, because the
point is to sanitize away the uncertainty that comes with an unlocked
read of unstable memory contents. READ_ONCE() samples the value in
memory, and removes all tearing, multiload, etc "instability" that may
effect down stream computations. In this way down stream compulations
become reliable.

Jason
