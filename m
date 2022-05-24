Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0861532DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiEXPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiEXPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:48:34 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A1E6D4D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:48:33 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id e20so14513949qvr.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hWo9Bh8Rusf7eYw4FNO2yhUn6v5U25aYOQhsBBIC7XE=;
        b=KVed7RtXba0869bB9np3IE7JU4RHUTooAjzTeCZv0y8jHUUnpfrWQk4XpHzA9gt/b0
         z24JdkfMCQfox9fBonuKsyL8qnNOfHVcBqivjKRVsoIrVpZnUcziUJzQ4pO8GLle6cyu
         HAiEmGUWHdTd2ptoKbvfWtUV7WMKpt5+AgNNvDrlbfIgfU9cDs/bMIsudtMjgc58wv4m
         BdJoBDUIZqpsnENvN5635RLIsLyGDrYpUCA38O0o7OfjL042ivcaX3T0HBQglhAsXz3Q
         t5qgU6RRp+YfSv1pBwhWVOxJsQDZu9BEouftxbuwmUOFVZiENMKVyw8Vep0K3aureq89
         9wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWo9Bh8Rusf7eYw4FNO2yhUn6v5U25aYOQhsBBIC7XE=;
        b=MdQyfAADDmE3dJ7/1wwRUXwmkOsDuTHNm9Zgvj1IdEakfHDvq/TRrnd8Y3KV48OVUM
         15I4AT/eMjRuEvB94tfZn2peImdD30p5SiwsX1HhWgMj0D5RqTCexZIHCmQ+T9SmRsTB
         w7sDhCn2MQeTBePG5EQhpaQNe5VL42EXvD7B69mkpH9WhgFU8yHbLliE7qglvk55i38x
         XFiMvf01ID/O31D4eaGBaBU8bNY483n63ufr/z9ysvFSyYLTA5aajGvd1hcU1yBGqEjB
         ENgCALd/7MWUeEjbObcm/4VGiJhNlUDhrQh8t/sSFY9qORuiiQ3dLeAZWrDByShONi19
         EpoQ==
X-Gm-Message-State: AOAM5338TAMGasR/GDJKtMoQI1TFWot/A1ycktWK8vrdGpbIji1pDn6O
        zh2mNG04g8KBXp2AioZzEMaPCw==
X-Google-Smtp-Source: ABdhPJwCagbsFvuDCCmZfoGWTxPXfWGu0wSXS88thKs9HBOg8xwa5wwPEEi44z/h89tY+75XEIlI7g==
X-Received: by 2002:a05:6214:d03:b0:462:344c:554a with SMTP id 3-20020a0562140d0300b00462344c554amr10026099qvh.104.1653407312650;
        Tue, 24 May 2022 08:48:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c13-20020ac85a8d000000b002f39b99f6bfsm6705923qtc.89.2022.05.24.08.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:48:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ntWlr-00BPZd-7s; Tue, 24 May 2022 12:48:31 -0300
Date:   Tue, 24 May 2022 12:48:31 -0300
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
Message-ID: <20220524154831.GC2661880@ziepe.ca>
References: <YnyCqwY4DxcZ/NjM@google.com>
 <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
 <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
 <YoxqSud9fvNXqo89@google.com>
 <20220524141937.GA2661880@ziepe.ca>
 <Yoz9H95uXbjoKwdC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoz9H95uXbjoKwdC@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:43:27AM -0700, Minchan Kim wrote:
> On Tue, May 24, 2022 at 11:19:37AM -0300, Jason Gunthorpe wrote:
> > On Mon, May 23, 2022 at 10:16:58PM -0700, Minchan Kim wrote:
> > > On Mon, May 23, 2022 at 07:55:25PM -0700, John Hubbard wrote:
> > > > On 5/23/22 09:33, Minchan Kim wrote:
> > > > ...
> > > > > > So then:
> > > > > > 
> > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > index 0e42038382c1..b404f87e2682 100644
> > > > > > +++ b/mm/page_alloc.c
> > > > > > @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
> > > > > >          word_bitidx = bitidx / BITS_PER_LONG;
> > > > > >          bitidx &= (BITS_PER_LONG-1);
> > > > > > 
> > > > > > -       word = bitmap[word_bitidx];
> > > > > > +       /*
> > > > > > +        * This races, without locks, with set_pageblock_migratetype(). Ensure
> > > > >                                               set_pfnblock_flags_mask would be better?
> > > > > > +        * a consistent (non-tearing) read of the memory array, so that results,
> > > > > 
> > > > > Thanks for proceeding and suggestion, John.
> > > > > 
> > > > > IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.
> > > > 
> > > > Did it? [1] fixed something, but I'm not sure we can claim that that
> > > > code is now safe against tearing in all possible cases, especially given
> > > > the recent discussion here. Specifically, having this code do a read,
> > > > then follow that up with calculations, seems correct. Anything else is
> > > 
> > > The load tearing you are trying to explain in the comment would be
> > > solved by [1] since the bits will always align on a word and accessing
> > > word size based on word aligned address is always atomic so there is
> > > no load tearing problem IIUC.
> > 
> > That is not technically true. It is exactly the sort of thing
> > READ_ONCE is intended to guard against.
> 
> Oh, does word access based on the aligned address still happen
> load tearing? 
> 
> I just referred to
> https://elixir.bootlin.com/linux/latest/source/Documentation/memory-barriers.txt#L1759

I read that as saying load tearing is technically allowed but doesn't
happen in gcc, and so must use the _ONCE macros.

> I didn't say it doesn't refetch the value without the READ_ONCE.
> 
> What I am saying is READ_ONCE(bitmap_word_bitidx] prevents "refetching"
> issue rather than "tearing" issue in specific __get_pfnblock_flags_mask
> context because I though there is no load-tearing issue there since
> bitmap is word-aligned/accessed. No?

It does both. AFAIK our memory model has no guarentees on what naked C
statements will do. Tearing, multi-load, etc - it is all technically
permitted. Use the proper accessors.

Jason
