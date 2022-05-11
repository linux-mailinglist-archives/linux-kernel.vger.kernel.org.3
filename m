Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0759452405C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348844AbiEKWhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348832AbiEKWhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:37:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4EB69726
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:37:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso6189951pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nehdr7PITXzy3bqyFSTIHEYGzvy9BmPaO54SUkuQJus=;
        b=Yt4rmSeljKAy4zVAJt38bsEUP+R/ch5xnFMH1IcPKPcH9fhCkYfitu2Bz7DZr64Zgs
         zS0pxud8f1P0frTY4URR6vlv3jGV2gOh3d2DoucZdDjS4qr2Ga274DQHMeLlYcGIMbIn
         XPEghnlayuephnbpvOaYmlbtLLreK1cfBskDVzqqLxbBiJPmBPOKPyQ63VJRnRRBugWA
         4hnNM8TnPq6TnqkREYiyo66NBdJtZhaV8tqUioqmgbIp4nEUvzcPr/S0Ax+iNvOKKsnL
         YE2/8Lb1fsSmQbLe6bDPxO0Pc2BxY+we5Y4fvoti9aZSjgjwqfd7JrSBugkX4K1Tp87B
         tAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nehdr7PITXzy3bqyFSTIHEYGzvy9BmPaO54SUkuQJus=;
        b=sg/tj03u8OQNudMvB4zgaTf1WgBDh8cboUe7vixa0CJMI4Zle7bEZhWUSfcm8mD1d4
         71wJv+uIqkQCMPeQI97Q8T5/JbCIdfjH40T7IVStS19aX8FlOqWcCuFQxwj9q4iU45AJ
         g/ghK978REG4I2m7ibevfrOdQCZ4zjVkMoSC1SMo49SCa7OBzqUGDeZQwnnoH8TEP6QQ
         wS8Oui1Yz71MpLDC6ordpKLecVh09dT0/2maa4ZcewXY0M6O3rxcc8SolR3SfNuEHKgF
         83ou4SMaI/pjnlWrZjwgTUIIVt4sSChJHk5RcNs2S248atkwoCjxBKPDhgjRIb+X5col
         G18w==
X-Gm-Message-State: AOAM533GxrhbqQaMI+tDOGQPG5L7gXvFPJq+/PL+1Lfl2WnWxbQdzW/f
        B3uY3YwsRrkvxWuMpC4VNPI=
X-Google-Smtp-Source: ABdhPJzyASJ01em+i4TBSflUo8jGKENF4EVaVlb3eN6NoOzTtMFrNN1ofuibrUqvb/9Z2fzC0MC73Q==
X-Received: by 2002:a17:902:bb92:b0:153:4eae:c77e with SMTP id m18-20020a170902bb9200b001534eaec77emr27112543pls.93.1652308635389;
        Wed, 11 May 2022 15:37:15 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b0015e8d4eb2e9sm2469090plg.307.2022.05.11.15.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:37:15 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 15:37:13 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <Ynw6mauQuNhrOAHy@google.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
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

On Wed, May 11, 2022 at 03:25:49PM -0700, John Hubbard wrote:
> On 5/11/22 2:46 PM, Minchan Kim wrote:
> > > I read that, but there was never any real justification there for needing
> > > to prevent a re-read of mt, just a preference: "I'd like to keep use the local
> > > variable mt's value in folloing conditions checks instead of refetching
> > > the value from get_pageblock_migratetype."
> > > 
> > > But I don't believe that there is any combination of values of mt that
> > > will cause a problem here.
> > > 
> > > I also think that once we pull in experts, they will tell us that the
> > > compiler is not going to re-run a non-trivial function to re-fetch a
> > > value, but I'm not one of those experts, so that's still arguable. But
> > > imagine what the kernel code would look like if every time we call
> > > a large function, we have to consider if it actually gets called some
> > > arbitrary number of times, due to (anti-) optimizations by the compiler.
> > > This seems like something that is not really happening.
> > 
> > Maybe, I might be paranoid since I have heard too subtle things
> > about how compiler could changes high level language code so wanted
> > be careful especially when we do lockless-stuff.
> > 
> > Who cares when we change the large(?) function to small(?) function
> > later on? I'd like to hear from experts to decide it.
> > 
> 
> Yes. But one thing that is still unanswered, that I think you can
> answer, is: even if the compiler *did* re-read the mt variable, what
> problems could that cause? I claim "no problems", because there is
> no combination of 0, _CMA, _ISOLATE, _CMA|ISOLATE that will cause
> problems here.

What scenario I am concerning with __READ_ONCE so compiler
inlining get_pageblock_migratetype two times are

        CPU 0                                                       CPU 1
                                                                alloc_contig_range
is_pinnable_page                                                start_isolate_page_range
                                                                  set_pageblock_migratetype(MIGRATE_ISOLATE)
   if (get_pageeblock_migratetype(page) == MIGRATE_CMA)    
       so it's false
                                                                undo:
                                                                  set_pageblock_migratetype(MIGRATE_CMA)
     
   if (get_pageeblock_migratetype(page) == MIGRATE_ISOLATE) 
       so it's false

In the end, CMA memory would be pinned by CPU 0 process
so CMA allocation keep failed until the process release the
refcount.

> 
> Any if that's true, then we can leave the experts alone, because
> the answer is there without knowing what happens exactly to mt.
> 
> thanks,
> 
> -- 
> John Hubbard
> NVIDIA
> 
