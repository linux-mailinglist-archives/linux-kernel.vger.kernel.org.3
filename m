Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFCC4F7BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiDGJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiDGJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:43:27 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B3AE9978
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:41:27 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id i186so3071471vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7zJJ3dVoUtJLqxQIGYbqRajy422RRa0RyqoMndHc4s=;
        b=JkMq8F+3HtqO81NBb1mkbEohTJ6kSw94E2HbJldlJImgri78wn/U3VLQp5g3pt4vwu
         Oe3axNLegualBV2dfsFabBMvpDHS11gaY2Qw29J7JTL8Oa104iEKUtNyybRoQJ2sZ65U
         HyDQybd4LaFvI+CJyrfhdiDxb7yqzjdImxYove6PUfT25p/HG9P3Pmf5Evcb0ODwU+jS
         V/WwpuTXm4hM1VYORFumSwU3lEzCPKr+NA2oGfAc0U7FiEiP7MgWSFP9EzlHssjpgL+P
         pm+hgBbIrLJFdgk1fC7jOMsY4OnDdgy+B2/j8ina8ycxYobiXaeWtaw0biULRtVwzBDw
         3WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7zJJ3dVoUtJLqxQIGYbqRajy422RRa0RyqoMndHc4s=;
        b=bX2iztkQz1bTOnoAnkFlXdgRCSIdObHfzyRQ1nlrqEiIZpWhNKwn70VeAqNozAIhQW
         qztgjNy7VWAMzaLbVXaEOKfCMMTSiO4pVXmo44esRaalDV5LAh9tYHN0IL4NXO9zhGAO
         ZRBKSQDPevUhnglsJMlWPKB8gBX3HpsniNJD3Oi4LPMXFFJ0Ew3tKjAB7GCIlIIkg2Ky
         2oF3+IkoSnVc5UPf4GWobIyi5EkZ1cd520o5SvYiR4YO+viO6TvgGv0dkrhYQgZnJA2u
         Gifeng2rJ2/Y6OP6kIrt5xD7m/J/DqDwmjNsMLUBiYtcLZzurwZGWNZhxKbUXyJ02nDT
         BG6w==
X-Gm-Message-State: AOAM531zgv/XzuUhXqI7llwTdyzQDjkghHEniJkn5stS0a5afNAzUP/w
        Wb+eIftQ9t4fyNRVg57jRZ4wZ1uNVKtDhAmkRB2y8g==
X-Google-Smtp-Source: ABdhPJznbN/TbVfynuU05EKXVCH2yRC1wZVWoNNxhWpZNDl5eLfDeRuTca6WXDt0On9YhbPtyNMup3nQhkj5pv50cFM=
X-Received: by 2002:a05:6102:3753:b0:325:c20e:4b1c with SMTP id
 u19-20020a056102375300b00325c20e4b1cmr4264725vst.84.1649324486928; Thu, 07
 Apr 2022 02:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <CAOUHufZ8x5B-e+Wwgrh+qWryf8dAbfMWVEE0s-AfwZ-H7DouQg@mail.gmail.com>
 <20220407183112.2cb5b627@canb.auug.org.au>
In-Reply-To: <20220407183112.2cb5b627@canb.auug.org.au>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 7 Apr 2022 03:41:15 -0600
Message-ID: <CAOUHufbaPR3H2KcYywCf0ycFWh=2Nf1PwiO4t8tO6TXB9U1MwA@mail.gmail.com>
Subject: Re: [PATCH v10 00/14] Multi-Gen LRU Framework
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 2:31 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Yu,
>
> On Wed, 6 Apr 2022 21:24:27 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > Can you please include this patchset in linux-next? Git repo for you to fetch:
> >
> > https://linux-mm.googlesource.com/mglru for-linux-next
>
> I get a message saying "This repository is empty. Push to it to show
> branches and history." :-(

Sorry about this. It should work now.

> > My goal is to get additional test coverage before I send a pull
> > request for 5.19 to Linus.
>
> Good idea :-)
>
> > I've explored all avenues, but ultimately I've failed to rally
> > substantial support from the MM stakeholders [1]. There are no pending
> > technical issues against this patchset [2]. What is more concerning
> > are the fundamental disagreements on priorities, methodologies, etc.
> > that are not specific to this patchset and have been hindering our
> > progress as a collective. (Cheers to the mutual dissatisfaction.)
>
> I have not been following the discussion as I am not an mm person, but
> this is not a good sign.
>
> > While we plan to discuss those issues during the LSFMM next month, it
> > doesn't seem reasonable to leave this patchset hanging in the air,
> > since it has reached its maturity a while ago and there are strong
> > demands from downstream kernels as well as a large user base. Thus I
> > sent that pull request to Linus a couple of weeks ago, implying that
> > he would have to make the final decision soon.
> >
> > I hope this gives enough background about what's been going on with
> > this patchset. If you decide to take it and it causes you any
> > troubles, please feel free to yell at me.
> >
> > Thanks!
> >
> > [1] https://lore.kernel.org/r/20220104202227.2903605-1-yuzhao@google.com/
> > [2] https://lore.kernel.org/r/20220326010003.3155137-1-yuzhao@google.com/
>
> I had a look at those threads and I guess things are better that your
> comment above implies.
>
> So, a couple of questions:
>
> Have you done a trial merge with a current linux-next tree to see what
> sort of mess/pain we may already be in?

Yes, the repo I prepared for you is based on the latest linux-next.
There shouldn't be any conflicts.

> Is it all stable enough now that it could be sent as a patch series for
> Andrew to include in mmotm (with perhaps just smallish followup patches)?

Yes, on multiple occasions, e.g., [1][2][3], I've claimed this
patchset has an unprecedented test coverage and nobody has proven
otherwise so far.

Andrew suggested a cycle in linux-next [4]. So here we are :)

[1] https://lore.kernel.org/all/YdSuSHa%2FVjl6bPkg@google.com/
[2] https://lore.kernel.org/r/YdiKVJlClB3h1Kmg@google.com/
[3] https://lore.kernel.org/r/YgR+MfXjpg82QyBT@google.com/
[4] https://lore.kernel.org/r/20220326134928.ad739eeecd5d0855dbdc6257@linux-foundation.org/
