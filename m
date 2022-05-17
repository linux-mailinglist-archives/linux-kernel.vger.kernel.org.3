Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB252A414
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348140AbiEQOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbiEQOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:00:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA6CFE6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:00:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x9so14347969qts.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/MwsWMteoBW+4/j8srpBSGX4SxYxtrIV85OC3p6eyjA=;
        b=SRItJRyDmSjb0OAm1/Lj+Tmcc0pWAEDI0PlR0ySs940MEM69mMnJz8xDpjW03V7A2f
         5rrUNkOAJphHo45pfgZXBjaZcPXb/A4mferWbN3eusBlhhDMgp9ghXKbxKID/N2z5diO
         cNiJRsfmF12/OI8vuIPV6mNTt2TfF24j9zjpPGTm5AMjWs1PAaudbYVgxBVq/lS87sfV
         0UbVb0THn66XMk+3fcmzQGb6OE1i0MZIQeWHoR/xlX04t2xol3YcFIMDq9XaZ/tIqQwY
         3T0Zx4cPq5pyu8i/7m2hCWm0CMsXshb7sLGQUyYK1NkcGC0jGmZ1e84QaaBv9TjifQrs
         qWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/MwsWMteoBW+4/j8srpBSGX4SxYxtrIV85OC3p6eyjA=;
        b=iGflCfgnTIHf3yIFYlWTn1KlkdcqT0Hhqw0YW24TnSLqBD2Z98ywQTYOCiiM9vvaAI
         gltJG9l7KgsHB0uNeNdz+3sJo1gq0TLfWpoaWYDsUThop0VKfqHXi/ZOikf+qNtVv6+D
         xZqxiGWq9pd294MdFy2FMNsNWXWVPlRRl4IaB32ug0UuFl/oRuHpHlBOugMm/RkfIlQo
         BwlLvHKy4Rx7XppPH1XFGAknzUcoNap6v59xB68/3MK3p5lfZ1PF42ydZwePS8mAQCE6
         8xq7sfJ+w31Mp5TfUp9wuQfGGa+r5RrnQI+rA+kZpS+vCJLxpen7DgYVZ5avlQJ2EBK6
         wwuA==
X-Gm-Message-State: AOAM5304uKSqKj201IvCpQeN6sKDIag0Jbh6WbuzcAO6sD8moiQLBlNW
        LqKqIc7SlYSMn5pOBEcg6pPjUQ==
X-Google-Smtp-Source: ABdhPJweSJXOQL3TpRAb7UibqsGcu+1c3zZZyxmp7gBl2Tw5hA/HKnbgypl+VfW3Sv5BJdCnjrPXCQ==
X-Received: by 2002:ac8:7f46:0:b0:2f3:cd89:8ee0 with SMTP id g6-20020ac87f46000000b002f3cd898ee0mr19622801qtk.498.1652796050708;
        Tue, 17 May 2022 07:00:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bb30-20020a05622a1b1e00b002f39b99f6bfsm7916712qtb.89.2022.05.17.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:00:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nqxkn-0083Q2-7j; Tue, 17 May 2022 11:00:49 -0300
Date:   Tue, 17 May 2022 11:00:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220517140049.GF63055@ziepe.ca>
References: <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnyCqwY4DxcZ/NjM@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:44:43PM -0700, Minchan Kim wrote:
> On Wed, May 11, 2022 at 07:18:56PM -0700, John Hubbard wrote:
> > On 5/11/22 18:08, John Hubbard wrote:
> > > On 5/11/22 18:03, Minchan Kim wrote:
> > > > > 
> > > > > Or there might be some code path that really hates a READ_ONCE() in
> > > > > that place.
> > > > 
> > > > My worry about chaning __get_pfnblock_flags_mask is it's called
> > > > multiple hot places in mm codes so I didn't want to add overhead
> > > > to them.
> > > 
> > > ...unless it really does generate the same code as is already there,
> > > right? Let me check that real quick.
> > > 
> > 
> > It does change the generated code slightly. I don't know if this will
> > affect performance here or not. But just for completeness, here you go:
> > 
> > free_one_page() originally has this (just showing the changed parts):
> > 
> >     mov    0x8(%rdx,%rax,8),%rbx
> >     and    $0x3f,%ecx
> >     shr    %cl,%rbx
> >     and    $0x7,
> > 
> > 
> > And after applying this diff:
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0e42038382c1..df1f8e9a294f 100644
> > +++ b/mm/page_alloc.c
> > @@ -482,7 +482,7 @@ unsigned long __get_pfnblock_flags_mask(const struct
> > page *page,
> >         word_bitidx = bitidx / BITS_PER_LONG;
> >         bitidx &= (BITS_PER_LONG-1);
> > 
> > -       word = bitmap[word_bitidx];
> > +       word = READ_ONCE(bitmap[word_bitidx]);
> >         return (word >> bitidx) & mask;
> >  }
> > 
> > 
> > ...it now does an extra memory dereference:
> > 
> >     lea    0x8(%rdx,%rax,8),%rax
> >     and    $0x3f,%ecx
> >     mov    (%rax),%rbx
> >     shr    %cl,%rbx
> >     and    $0x7,%ebx

Where is the extra memory reference? 'lea' is not a memory reference,
it is just some maths?

> Thanks for checking, John.
> 
> I don't want to have the READ_ONCE in __get_pfnblock_flags_mask 
> atm even though it's an extra memory dereference for specific
> architecutre and specific compiler unless other callsites *do*
> need it.

If a callpath is called under locking or not under locking then I
would expect to have two call chains clearly marked what their locking
conditions are. ie __get_pfn_block_flags_mask_unlocked() - and
obviously clearly document and check what the locking requirements are
of the locked path.

IMHO putting a READ_ONCE on something that is not a memory load from
shared data is nonsense - if a simple == has a stability risk then so
does the '(word >> bitidx) & mask'.

Jason
