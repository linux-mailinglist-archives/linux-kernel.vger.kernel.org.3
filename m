Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE33532F54
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiEXQ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiEXQ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:59:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC00703F2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:59:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j6so16931444pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/DtubZRV7+ZvAxCcXKcVcJC6FOQ/XSxjh1i8plYq8E=;
        b=IEuiV1KeWuIAcNcCISdUIiHcWWP1KJRAs3fa0pHMvO5vMyfyBqrfLsRT/rZjpslM4r
         SVnnvlDGHlmn5HQ1Neyg18m/enu3+pQtgY1uk5KUJgNHUD/8GW8R+vL/kD6bOdTJM9eG
         QrEILSJ22hzajUE3DsSFNteYaE3cKCjFEtvLTFicOtkLK1iRoK3jLMFX+cyaZtIkY+JH
         tc734EMQg5ghsGwZzA+0f3tgUQdHaqOMFccoF9wHKkideIM2R47mwvp5f76R/wbKLEuX
         EvOqvZZhGN8duC6fI1LkDQNGZhrRFWyb2kRt2tTDsrbrCf0tRXwmvPzWT94mMU5QtB72
         950w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=H/DtubZRV7+ZvAxCcXKcVcJC6FOQ/XSxjh1i8plYq8E=;
        b=CccE5Jp6CMpxcN7S10JYhx5z4LMeL+6MaYYKlYgfQWczWQ9mQVTUtjFDa6q7ZNljZK
         mditN9eHKzPQd3pzX7bUgnjioiYj9HOzManEwPiq0wZSJWKRZUIRCaPzddFw3nMXdban
         3Ktr56RWHSb77cDdN5ykkva2lRCRMC6VYk7FZx5x0q1tj7MzGzKmiSe4cNJ84haOiAaB
         IC4oLuf2vSbGubhZgbYLXTplALI8Oid/PbYyknoTHvpUcwjhWDlCDXMrWdP3ZQ1kl7QL
         xpu+YUpTscC2PFu1GFgxeR0Rx29knSECRFNZwYhf7tpFe33uejcORTeSi7klfxjFFgaz
         xWMw==
X-Gm-Message-State: AOAM531581rh2mfUEOTewmDqk4TEjKNhP6TIgzI3coGWmNQn5fxCpjVi
        apQRBBo362I+DBhCLykfMqI=
X-Google-Smtp-Source: ABdhPJw0xiqNUbqGmI1l6crxfJjDQWf95J/3+y1s+hIoflR3DM1A6OaKu1llWGqfdCzhZnql5UlTtQ==
X-Received: by 2002:a05:6a00:1411:b0:4fd:e594:fac0 with SMTP id l17-20020a056a00141100b004fde594fac0mr29249931pfu.79.1653411546988;
        Tue, 24 May 2022 09:59:06 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:20f:8bc7:9098:371f])
        by smtp.gmail.com with ESMTPSA id h11-20020a65518b000000b003c644b2180asm6894498pgq.77.2022.05.24.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 09:59:06 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 24 May 2022 09:59:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <Yo0O2EDhfZ66SJur@google.com>
References: <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
 <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
 <YoxqSud9fvNXqo89@google.com>
 <20220524141937.GA2661880@ziepe.ca>
 <Yoz9H95uXbjoKwdC@google.com>
 <20220524154831.GC2661880@ziepe.ca>
 <20220524163728.GO1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524163728.GO1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 09:37:28AM -0700, Paul E. McKenney wrote:
> On Tue, May 24, 2022 at 12:48:31PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 24, 2022 at 08:43:27AM -0700, Minchan Kim wrote:
> > > On Tue, May 24, 2022 at 11:19:37AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, May 23, 2022 at 10:16:58PM -0700, Minchan Kim wrote:
> > > > > On Mon, May 23, 2022 at 07:55:25PM -0700, John Hubbard wrote:
> > > > > > On 5/23/22 09:33, Minchan Kim wrote:
> > > > > > ...
> > > > > > > > So then:
> > > > > > > > 
> > > > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > > > index 0e42038382c1..b404f87e2682 100644
> > > > > > > > +++ b/mm/page_alloc.c
> > > > > > > > @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
> > > > > > > >          word_bitidx = bitidx / BITS_PER_LONG;
> > > > > > > >          bitidx &= (BITS_PER_LONG-1);
> > > > > > > > 
> > > > > > > > -       word = bitmap[word_bitidx];
> > > > > > > > +       /*
> > > > > > > > +        * This races, without locks, with set_pageblock_migratetype(). Ensure
> > > > > > >                                               set_pfnblock_flags_mask would be better?
> > > > > > > > +        * a consistent (non-tearing) read of the memory array, so that results,
> > > > > > > 
> > > > > > > Thanks for proceeding and suggestion, John.
> > > > > > > 
> > > > > > > IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.
> > > > > > 
> > > > > > Did it? [1] fixed something, but I'm not sure we can claim that that
> > > > > > code is now safe against tearing in all possible cases, especially given
> > > > > > the recent discussion here. Specifically, having this code do a read,
> > > > > > then follow that up with calculations, seems correct. Anything else is
> > > > > 
> > > > > The load tearing you are trying to explain in the comment would be
> > > > > solved by [1] since the bits will always align on a word and accessing
> > > > > word size based on word aligned address is always atomic so there is
> > > > > no load tearing problem IIUC.
> > > > 
> > > > That is not technically true. It is exactly the sort of thing
> > > > READ_ONCE is intended to guard against.
> > > 
> > > Oh, does word access based on the aligned address still happen
> > > load tearing? 
> > > 
> > > I just referred to
> > > https://elixir.bootlin.com/linux/latest/source/Documentation/memory-barriers.txt#L1759
> > 
> > I read that as saying load tearing is technically allowed but doesn't
> > happen in gcc, and so must use the _ONCE macros.
> 
> This is in fact the intent, except...
> 
> And as that passage goes on to state, there really are compilers (such
> as GCC) that tear stores of constants to machine aligned/sized locations.
> 
> In short, use of the _ONCE() macros can save you a lot of pain.

Thanks for the correction, Jason and Paul

> 
> > > I didn't say it doesn't refetch the value without the READ_ONCE.
> > > 
> > > What I am saying is READ_ONCE(bitmap_word_bitidx] prevents "refetching"
> > > issue rather than "tearing" issue in specific __get_pfnblock_flags_mask
> > > context because I though there is no load-tearing issue there since
> > > bitmap is word-aligned/accessed. No?
> > 
> > It does both. AFAIK our memory model has no guarentees on what naked C
> > statements will do. Tearing, multi-load, etc - it is all technically
> > permitted. Use the proper accessors.

Seems like there was some misunderstanding here.

I didn't mean not to use READ_ONCE for the bitmap but wanted to have
more concrete comment. Since you guys corrected "even though word-alinged
access could be wrong without READ_ONCE", I would keep the comment John
suggested.

> 
> I am with Jason on this one.
> 
> In fact, I believe that any naked C-language access to mutable shared
> variables should have a comment stating why the compiler cannot mangle
> that access.

Agreed.

Thanks!
