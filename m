Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470C55405D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355969AbiFVCEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355930AbiFVCEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044CF30570;
        Tue, 21 Jun 2022 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UwYS1fleEkwHqCTxt9TqeynEno6WGfVCt95eWwDoh48=; b=oFz9SwmDa1bZv3chDU5jkQhsSe
        R2iCifbmH+0k99UszZKlaTqKz58dFkoFNW1h/Vp65tW/jrPxxU3Hr22Jj5F1tkcYsdc8TsQYOHRvV
        MC+9Q8HQN4SZ8eBi2OGLnmTAebiFps40BdTLR09HqfvXpe0cdgT/uWQFecL56XK9gnIK0zrPTnyNq
        xECHdmFE9h7xnZGherUDQhlrb4xO1FPm7o5Hoa2BShu+8ATZZ0NckUzLjdGSXKYAZ7dtetfWIWsOL
        eDHO6E0VO38z0cvhSLODmw6H38jfUxJcuV84rvnCyykhVfQJ4HFbtB0Xi3QTgxrVfS1MG/yJ7JL5K
        ch7uuj0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3pjU-006dr4-HF; Wed, 22 Jun 2022 02:04:40 +0000
Date:   Wed, 22 Jun 2022 03:04:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: linux-next: build failures after merge of the mm tree
Message-ID: <YrJ4uPNlIk1QifAL@casper.infradead.org>
References: <20220620164246.0d3f7784@canb.auug.org.au>
 <CAMZfGtWmGOr1LRBnKGVeqP8p47xyaA0ny_rotdHmgLx8DOk6xg@mail.gmail.com>
 <YrB7Vq/WlGK99fxz@casper.infradead.org>
 <20220621152845.16c801b4efd747173dc08559@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621152845.16c801b4efd747173dc08559@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:28:45PM -0700, Andrew Morton wrote:
> On Mon, 20 Jun 2022 14:51:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Mon, Jun 20, 2022 at 03:11:31PM +0800, Muchun Song wrote:
> > > Thanks for your report. It is fixed in thread [1].
> > > 
> > > https://lore.kernel.org/all/20220619133851.68184-3-songmuchun@bytedance.com/ [1]
> > 
> > No, it's a different problem.  I suggest dropping/reverting
> > 
> > https://lore.kernel.org/linux-mm/20220617175020.717127-20-willy@infradead.org/
> 
> Dropping that creates awkwardness.  How about just uninlining it?

Sure!  We can also make compound_page_dtors static and drop the
declaration in linux/mm.h if we do that.  I think there's a pile of
cleanup to be done around freeing pages/folios, partly from accretions
over the decades, and partly from the existence of folios between order
0 and 9.  Not to mention Mel's recent addition of high-order PCP caching.

But I don't want to do that for this merge window.
