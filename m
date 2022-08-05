Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF958B061
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiHETZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbiHETZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:25:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413717D797
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RKUUIUL1iHAOgJ7936O2ZK1JZMqC/oeNpBXr/pO1c2M=; b=XJonR3uwtW+WFiDJvcdgEOl5Kg
        L664nZw2YIp6hE1O6Qa+MmAJJ4n0YqnRjJBba1/WsTLd9MgOcskgoMdSRVSB2JbQm1LVodaeCXU+q
        7iHdF1eiEah4flMBuDP7zr50XS1sGdOl1hrQD/cGRypY011bkx1UCICnW09y2C+Pppfp9+5F3+iYY
        jUy6BGqiw16FGVBSikLW2qXTeGZJ14+ksYukXsbdKqTPnMHt829lbOqZhcHf8GwbO3n8ZlOFAGRqv
        weBjofOa+m4GgZLBgWKRsxY8yWv4FOzwuIyso3BHJO1mhGCUmzJVz6/Nfb8+FHUMLGb7lKjKsrnJR
        jUP1fpVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oK2vp-00BVNL-VE; Fri, 05 Aug 2022 19:24:26 +0000
Date:   Fri, 5 Aug 2022 20:24:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rik van Riel <riel@fb.com>
Cc:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Message-ID: <Yu1uabedm+NYnnAj@casper.infradead.org>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
 <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 07:04:30PM +0000, Rik van Riel wrote:
> On Fri, 2022-08-05 at 19:50 +0100, Matthew Wilcox wrote:
> > > 
> > > This change introduces a tool that scans through all of physical
> > > memory for anonymous THPs and groups them into buckets based
> > > on utilization. It also includes an interface under
> > > /proc/thp_utilization.
> > 
> > OK, so I understand why we want to do the scanning, but why do we
> > want to
> > report it to userspace at all?  And if we do, why do we want to do it
> > in
> > this format?  AFAIK, there's nothing userspace can do with the
> > information
> > "93% of your THPs are underutilised".  If there was something
> > userspace
> > could do about it, wouldn't it need to know which ones?
> > 
> > Isn't the real solution here entirely in-kernel?  This scanning
> > thread
> > you've created should be the one splitting the THPs.  And anyway,
> > isn't
> > this exactly the kind of thing that DAMON was invented for?
> 
> Alex does have an (in kernel) shrinker that can reclaim
> underutilized THPs in order to free memory.

Ah!  So when that exists, this interface tells us "how well" we're doing.

> This is a regular shrinker called from kswapd. I am not
> sure a shrinker going through the DAMON infrastructure
> would be any smaller, faster, or better. OTOH, DAMON
> does allow for more flexible policy...
> 
> Getting some info on the effectiveness of the shrinker
> seems useful, though. Could debugfs be a better place?
> Should this be resubmitted together with the shrinker
> code that makes this more useful?

Yeah, debugfs seems like a better place.  And I'd love to see the shrinker
code.  Before you mentioned that I was having all kinds of peculiar
feelings about this code.  For example, suppose you have incredibly hot
256kB of data, but the other 1792kB of data are never touched ... that
could cause us to do entirely the wrong thing and break up this THP.
Having it as a shrinker makes sense because the hot 256kB will keep the
THP from reaching the end of the list and being reclaimed.
