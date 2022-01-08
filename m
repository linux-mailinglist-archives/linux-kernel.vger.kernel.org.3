Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715E448800F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiAHAuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiAHAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:50:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eUv3q0GNQyMCM3aaZjusm8wlJcTIDvHI/q+X9aUjFH4=; b=SJgTCDMS8b3BwoNM4hS4iRhEL6
        C4QZljs9ObpUUWkp3iHgx67sLYngrh4NtN8nAi80gaDvwVHnGauEPfTKl8QCm8B3lkiiBeVcAoBPa
        ErNs24afNWNFk/gXjJq2p8A0hDGG4KXYk1qJ1g+iZBNEB5RKcg5jJ4sXLkQ9SdxZhiM8BD1RqojiM
        EfyNxTc3zGD5+n0CDxYVhbVJ/KvX2nlqMtAMNMll4Vhw5qTftA6YiQKIrTweNaw3zt70Xi2h6/Utq
        i/WdtEmAWsbaXpOvJ8LT2xbrkLHr7hITtYVlEZx7aT9o+jqjBBNtCKuzmId2qlUfA6Q7+oHEPpVk6
        nDz/kG4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5zvd-000ItP-Vt; Sat, 08 Jan 2022 00:49:54 +0000
Date:   Sat, 8 Jan 2022 00:49:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, peterz@infradead.org,
        vbabka@suse.cz, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <YdjfsbAR0UlwyC6b@casper.infradead.org>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
> On Fri, 7 Jan 2022 22:11:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Jan 07, 2022 at 01:40:59PM +0000, Wei Yang wrote:
> > > On Fri, Jan 07, 2022 at 03:59:01AM +0000, Matthew Wilcox wrote:
> > > >On Thu, Jan 06, 2022 at 11:52:54PM +0000, Wei Yang wrote:
> > > >> FOLIO_MATCH() is used to make sure struct page and folio has identical
> > > >> layout for the first several words.
> > > >> 
> > > >> The comparison of offset between page->compound_head and folio->lru is
> > > >> more like an internal check in struct page.
> > > >> 
> > > >> This patch just removes it.
> > > >> 
> > > >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > > >
> > > >No.
> > > 
> > > Hi, Matthew
> > > 
> > > Would you mind sharing some insight on this check?
> > 
> > It's right there in the comments.
> 
> Well I can't figure out which comment you're referring to?

         * WARNING: bit 0 of the first word is used for PageTail(). That
         * means the other users of this union MUST NOT use the bit to
         * avoid collision and false-positive PageTail().

> > If you can't be bothered to read, why should I write?
> 
> I don't think the punishment comes close to fitting the crime here :(

I felt I had to NACk it as quickly as possible so you didn't apply it.
Otherwise I'd've waited until I was back from holiday before replying
to the earlier patch.  But you applied that lickety-split, so clearly
I'm not allowed to take a week off.
