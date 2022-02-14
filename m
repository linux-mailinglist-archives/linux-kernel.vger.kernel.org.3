Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2C4B4167
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiBNFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:35:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiBNFfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:35:10 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5AC4E3B9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:35:03 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso18107515oop.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=L7XXqMw0BJqSwPiX8BdrSc7e/KusNkA7RDmHju/xVA8=;
        b=Av/BOZkalXOtnl373o4nXpwwZIQACBb4OcQ+B0AOpUyLR80QEv/C26HewhnAq6N51D
         BYt1ZZn1+T/oPQbvb90t3FnCq+rTG9zhZTBx/aD7qKUtYcmkvMXO0Cdku64o8PRDNp2u
         Rt3N8V9m52xI60oD9qncI93rcNaTBZP9dR3ZiiOPWZlZ9Dtnv2KKUlPaYBU/9SOBQj5I
         +tyO5tsEwGwOPKknhsP9+xGC/HAbE18v7XxM36ThGlDB0+T2+FZC7cafv3sphrDlz4RA
         puUPUAxLwANnO0HXMNM5cKuCjhVLbqiGYlCGMfXFZguGi9ZPc60I8a96hI4A2wJkocLK
         PvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=L7XXqMw0BJqSwPiX8BdrSc7e/KusNkA7RDmHju/xVA8=;
        b=5Q+gtxbeXPciy+IQvDDNz3W9FoLGIDTLXr89V21FwiQHq9jTBieJbrWJ2OPkrm/Nto
         Bj40416/TJOjETL1W9VQ4n2/5YiCgIsf8vHFPmfW5yPlvp9bogsGrS9pLugVplANS1di
         i8JB3VVQPMckJnxRRV6aLZpUW7EihvK7cHrdcITy+cNX2+qBR5fPkK2CByBjd9qXU5ih
         hYKCFfGFbQl6Y/ZgMiw4ZbRQwstzMVfLuAFplLVyfmWiOiiCVbBTahXIQ07X/nw5FMb2
         77WsAzoJBQIMuZpMEOf7/KlI0dPtcigYrAbEZYG1dI4BmhOjyTgAlYlifZBnQQ90Zy/l
         O6+w==
X-Gm-Message-State: AOAM533/r3+57baQwUIXw3tXwiJjc5k5d4HDvczYuAGStoumbQ8GLAn6
        /TK38AQ5D6iJVGfDtKNlU59NdQ==
X-Google-Smtp-Source: ABdhPJycrdUhyCSUHMiEl3AVoXNS8IU5MHQmc97vHR5mkiRNLWftK71zRHgJH8/e1k3HiVWQ63htXw==
X-Received: by 2002:a05:6870:61c4:: with SMTP id b4mr3648778oah.322.1644816903115;
        Sun, 13 Feb 2022 21:35:03 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y15sm12091337oof.37.2022.02.13.21.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 21:35:01 -0800 (PST)
Date:   Sun, 13 Feb 2022 21:34:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 11/13] mm/munlock: page migration needs mlock pagevec
 drained
In-Reply-To: <f9960727-d061-8856-45ce-4e33e8ed1de6@suse.cz>
Message-ID: <d74f2610-2595-cc51-5a35-dc037c23a28@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <90c8962-d188-8687-dc70-628293316343@google.com> <f9960727-d061-8856-45ce-4e33e8ed1de6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Vlastimil Babka wrote:
> On 2/6/22 22:49, Hugh Dickins wrote:
> > 
> > Any new pagevec runs the risk of adding a new way of stranding, and we
> > might discover other corners where mlock_page_drain() or lru_add_drain()
> > would now help.  If the mlock pagevec raises doubts, we can easily add a
> > sysctl to tune its length to 1, which reverts to synchronous operation.
> 
> Not a fan of adding new sysctls like those as that just pushes the failure
> of kernel devs to poor admins :)
> The old pagevec usage deleted by patch 1 was limited to the naturally larger
> munlock_vma_pages_range() operation. The new per-cpu based one is more
> general, which obviously has its advantages, but then it might bring new
> corner cases.
> So if this turns out to be an big problem, I would rather go back to the
> limited scenario pagevec than a sysctl?

Okay, I'll delete that comment proposing a sysctl, which was more as
a possible safety measure for our internal experimentation than for
general use.  I just thought it was an easy way to force synchronous.

I don't expect a big problem.  The flush in this commit deals, I think,
with the only way it was treading on its own toes, using a pagevec at
a level which relied on the unlikelihood of a pagevec reference.

But I can imagine that such-and-such a test will expect Mlocked or
Unevictable to be exact, and this pagevec now delay it becoming exact.
I've not seen any example so far, but it does seem possible.  Maybe
we shall fix the test, maybe we shall add a drain.

I hadn't thought of limiting the use of pagevec to the mass operation
(if a significant problem emerges).  Yes, that might be a better idea,
thanks.  Anyway, we don't need to worry in advance.

A change I also had in this patch, orginally, was for
/proc/sys/vm/stat_refresh to lru_add_drain_all() first.  I'm surprised
that tests see good numbers without it doing so; but since I've not
actually seen the need for it yet, dropped that - we can always add
it later if need emerges.

Hugh
