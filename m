Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FF55A154
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiFXSrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiFXSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:47:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB481707
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QR+nifWaJ4UF5IaBqn3DWa9vzF87dPVKtCb+08H2uZA=; b=iDGZrrX8g5o5JDPxxBqIqo/DoF
        JE07AoUkxnNArMhjxqm5fVdIFFt425RkLHWTzxrx0AmeVlc7SnUrY8e+7pFKozJege+9CvgYoDg+d
        90aCEZ+tO1b9dQFN4GKebYwrg97l7hqqk9AgcYXZlYOR/CuFkjLOFuIEoprG5lz9x0vYEJT8ktTci
        lmMcqwG4gi1bvQq0cT1Hi+SCduelEKW3vUJDS9bTOQ5uwMvioENHBJs+CVUye0Jx+0g5x3+BX0DGR
        ezB7KhwtezZBTOvnEs/zSXq4C+kgbLib0h3ev6vsZ7No5QJTW9+87kUw1acI+eQHjXh5s0yugvT6t
        C69AplGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4oL3-0099kP-9L; Fri, 24 Jun 2022 18:47:29 +0000
Date:   Fri, 24 Jun 2022 19:47:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <YrYGwVf8qbbBA62z@casper.infradead.org>
References: <20220624173656.2033256-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:36:30PM +0000, James Houghton wrote:
> - Page table walking and manipulation
> A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
> high-granularity mappings. Eventually, it's possible to merge
> hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.
> 
> We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
> This is because we generally need to know the "size" of a PTE (previously
> always just huge_page_size(hstate)).
> 
> For every page table manipulation function that has a huge version (e.g.
> huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
> hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
> PTE really is "huge".

I'm disappointed to hear that page table walking is going to become even
more special.  I'd much prefer it if hugetlb walking were exactly the
same as THP walking.  This seems like a good time to do at least some
of that work.

Was there a reason you chose the "more complexity" direction?
