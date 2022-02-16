Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8EB4B923B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiBPUZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:25:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBPUZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:25:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93B28BF4A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=grO/dMoMpUx6SZW+WlPgnRedNtvixyyjlGyIa7+DpLY=; b=qhR0RUpLzif19cq8e9e+reWKkV
        m/I73AfgdwMV/4C0xgDVcOJZXrMj8Z+YhRWQ0ju7Ij/4HMeEr4vD3mAfDhRvDEPWCBt4rpWDWXUZM
        uaMJe/43IywbKWYgPotKkfc/QEtJ8EZtD/31rQwXWjiJB+mHuhq7zOHabsQcnemYNl4hmLEwVXBEN
        r41RAA4pi2t2B9QlI09sss1TA91HmI/I1wXr4j9mFtuDUIAhdG4oxe4vEvJUz5te9cSJ1oSjZJ8U3
        n2Hb1n176yep1UskX+COkpTXs/8dgIuTbTcvzGjp6+seSz3ilHaSChHjTjs/4JNqaB5abWCwHGWOo
        VxFZIWJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKQqo-00F17H-Kd; Wed, 16 Feb 2022 20:24:34 +0000
Date:   Wed, 16 Feb 2022 20:24:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <Yg1dgkrrImvQ1GXM@casper.infradead.org>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220216114700.f9473d88144dc59fc4d764fb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216114700.f9473d88144dc59fc4d764fb@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 11:47:00AM -0800, Andrew Morton wrote:
> On Tue, 15 Feb 2022 14:37:44 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> 
> > The maple tree is an RCU-safe range based B-tree designed to use modern
> > processor cache efficiently.  There are a number of places in the kernel
> > that a non-overlapping range-based tree would be beneficial, especially
> > one with a simple interface.  The first user that is covered in this
> > patch set is the vm_area_struct, where three data structures are
> > replaced by the maple tree: the augmented rbtree, the vma cache, and the
> > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > or remove the mmap_sem contention.
> 
> Has a path been chosen which gets us from here to significant reduction
> in mmap_lock overhead?
> 
> If so, what's the plan and what must be done?

I would say there are still competing ideas for how that is to be done.

First, the Maple Tree is independent (to a certain extent) of all the
approaches to reducing mmap_lock overhead.  It's a better data structure
for VMA lookup than the rbtree.  Set against that, it has higher overhead
for modifications.  That means that benchmarks which primarily measure
modification overhead see worse performance.  We believe this is not
representative of real workloads, and indeed we see ~parity on workloads
like git and make -jN.

The advantage to this patch set is that we get rid of the vmacache
entirely, we get rid of the doubly-linked list chaining VMAs together
and we get rid of the rbtree usage.  And we add a new generic data
structure that hopefully I can point people towards instead of using
the XArray inappropriately.

Both of the approaches to avoiding taking the mmap_lock in the fault path
will benefit from using the maple tree for VMAs.  Fewer cache misses and
RCU safety are things we all want.  The maple tree will also benefit
if/when either approach is merged; because modifications to the maple
tree are more heavyweight than the rbtree, they block readers for longer.


The SPF approach is further along.  It has been tested in the past with
the maple tree, but not in the most recent iteration of either.  It
doesn't rely on the maple tree, but it does benefit.

The RCU-freeing-of-VMAs approach that I favour has not received much
attention.  I've been busy with other things ;-)  It offers much more
opportunity for performance improvement, but will take longer to arrive.

