Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ABC59D0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbiHWFna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiHWFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:43:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360662FA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NO0ifbcV0JwASDPMSKWX+lMLGTRG9S57tYDVHubceXI=; b=gKwRG50A+WPdWpJeXxK3pKfxZo
        7WsKMgwaAweHTy0ymgj2pGxd6vGAs3zFuUawRp0u4d8rZriJ5O1meyLjdnbvogEIIJGeJPHdtqlXi
        T9otdL11/aNnHlzSP4txvEroFQ/yDUNJLMJ9+YzWZuk8GWTvV3RYnB7LMx/ySopVM0+moxnr5dWtt
        sk442+kbqvhw03tSc0i4BlWhhwwwxbnXW0kGZk97ZbrltZOX+ivT8pyEghhvLn4CXVXdo/sk9H4lO
        CZo3624uz86u9Ebo511wwZsHaayvSg/hSY+rpO+T5AUeIVSmzSqldpjy93xupvsuhxo22+bBqGBte
        VIXMEIAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQMgo-00EziM-0e; Tue, 23 Aug 2022 05:43:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2851898049D; Tue, 23 Aug 2022 07:42:59 +0200 (CEST)
Date:   Tue, 23 Aug 2022 07:42:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Song Liu <song@kernel.org>
Subject: Re: [RFC 0/5] vmalloc_exec for modules and BPF programs
Message-ID: <YwRo43EBIWh7++Qn@worktop.programming.kicks-ass.net>
References: <20220818224218.2399791-1-song@kernel.org>
 <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
 <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
 <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 04:56:47PM +0000, Song Liu wrote:
> 
> 
> > On Aug 22, 2022, at 9:34 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Mon, Aug 22, 2022 at 03:46:38PM +0000, Song Liu wrote:
> >> Could you please share your feedback on this? 
> > 
> > I've looked at it all of 5 minutes, so perhaps I've missed something.
> > 
> > However, I'm a little surprised you went with a second tree instead of
> > doing the top-down thing for data. The way you did it makes it hard to
> > have guard pages between text and data.
> 
> I didn't realize the importance of the guard pages. But it is not too

I'm not sure how important it is, just seems like a good idea to trap
anybody trying to cross that divide. Also, to me it seems like a good
idea to have a single large contiguous text region instead of splintered
2M pages.

> hard to do it with this approach. For each 2MB text page, we can reserve
> 4kB on the beginning and end of it. Would this work?

Typically a guard page has different protections (as in none what so
ever) so that every access goes *splat*.
