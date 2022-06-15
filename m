Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0C54CBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiFOOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbiFOOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:54:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC327168;
        Wed, 15 Jun 2022 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655304844; x=1686840844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AyHEYASdAXzKDT8EuTX1y0edC0hgS/AoJlSZAmp9yEk=;
  b=IXkl2bnIwOoVDlb4HggkMzh9bq7lEvp9ta7FKylHiXsqT7mBSdOS7Q8I
   J8+Uf+VGEJYBdBWwhQ3xLcFyUKljBPCUrhK24w6D99o16hv8fGQsOwo9h
   hs0ItKg4ycwoj+T5hphDfUlgnTapUaO2Ux1VP4cLJshC2y/Sb+S/jqzfo
   XDCKX1I9TZ8/yHjyIzTPCMDA1KTkfuFHBqkZbN+ipVR9o71KKKR7MNPgG
   5C6XqI6oJ0JKTG3v3tFOlLPi/hmHBkJ7nqu8/nk4qLwABC7w8JqV/qt/o
   Ud3TkMTODvYcTqiziZ4OWaUYNiCTKxamXISVBnh/bpw4PAyOgB9nqSPPK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267676003"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="267676003"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:54:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="583242956"
Received: from iweiny-server.sc.intel.com (HELO localhost) ([172.25.222.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:54:02 -0700
Date:   Wed, 15 Jun 2022 07:54:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Message-ID: <YqnyiuaeQz6aSNUL@iweiny-server>
References: <20220615101509.516520-1-bagasdotme@gmail.com>
 <YqnyJ/5/ZLiNI+5v@iweiny-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqnyJ/5/ZLiNI+5v@iweiny-server>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 07:52:23AM -0700, Ira wrote:
> On Wed, Jun 15, 2022 at 05:15:10PM +0700, Bagas Sanjaya wrote:
> > When building htmldocs on Linus' tree, there are inline emphasis warnings
> > on include/linux/highmem.h:
> > 
> > Documentation/vm/highmem:166: ./include/linux/highmem.h:154: WARNING: Inline emphasis start-string without end-string.
> > Documentation/vm/highmem:166: ./include/linux/highmem.h:157: WARNING: Inline emphasis start-string without end-string.
> > 
> > These warnings above are due to comments in code example of
> > kmap_atomic() inside kernel-doc comment of *kmap_local_folio() are enclosed
> > by double dash (--) instead of prefixed with C comment symbol (//).
> > 
> > Fix these warnings by indenting the code example with literal block
> > indentation and prefixing comments inside the example with C comment
> > symbol.
> > 
> > Fixes: 85a85e7601263f ("Documentation/vm: move "Using kmap-atomic" to highmem.h")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

My bad...

> Tested-by: Ira Weiny <ira.weiny@intel.com>
> 
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  Changes since v1 [1]:
> >    - Point that the code example is for kmap_atomic() (suggested by
> >      Matthew Wilcox)

As Willy pointed out you did not do this.  I was mistaken to believe this
statement.

Ira

> >    - Use C comments instead of Unix shell comments prefix (suggested by
> >      Ira Weiny)
> > 
> >  [1]: https://lore.kernel.org/linux-doc/20220614123115.522131-1-bagasdotme@gmail.com/
> >  
> >  include/linux/highmem.h | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index 3af34de54330cb..56d6a019653489 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -149,19 +149,19 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
> >   * It is used in atomic context when code wants to access the contents of a
> >   * page that might be allocated from high memory (see __GFP_HIGHMEM), for
> >   * example a page in the pagecache.  The API has two functions, and they
> > - * can be used in a manner similar to the following:
> > + * can be used in a manner similar to the following::
> >   *
> > - * -- Find the page of interest. --
> > - * struct page *page = find_get_page(mapping, offset);
> > + *   // Find the page of interest.
> > + *   struct page *page = find_get_page(mapping, offset);
> >   *
> > - * -- Gain access to the contents of that page. --
> > - * void *vaddr = kmap_atomic(page);
> > + *   // Gain access to the contents of that page.
> > + *   void *vaddr = kmap_atomic(page);
> >   *
> > - * -- Do something to the contents of that page. --
> > - * memset(vaddr, 0, PAGE_SIZE);
> > + *   // Do something to the contents of that page.
> > + *   memset(vaddr, 0, PAGE_SIZE);
> >   *
> > - * -- Unmap that page. --
> > - * kunmap_atomic(vaddr);
> > + *   // Unmap that page.
> > + *   kunmap_atomic(vaddr);
> >   *
> >   * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
> >   * call, not the argument.
> > 
> > base-commit: 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
> > -- 
> > An old man doll... just what I always wanted! - Clara
> > 
> 
