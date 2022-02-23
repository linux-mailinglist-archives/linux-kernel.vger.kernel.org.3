Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D370A4C18AD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiBWQfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiBWQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:35:40 -0500
Received: from outbound-smtp58.blacknight.com (outbound-smtp58.blacknight.com [46.22.136.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590A53E1B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:35:12 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id 1E7BBFABB0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:35:11 +0000 (GMT)
Received: (qmail 7943 invoked from network); 23 Feb 2022 16:35:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Feb 2022 16:35:10 -0000
Date:   Wed, 23 Feb 2022 16:35:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <20220223163509.GH4423@techsingularity.net>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220216114700.f9473d88144dc59fc4d764fb@linux-foundation.org>
 <Yg1dgkrrImvQ1GXM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yg1dgkrrImvQ1GXM@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 08:24:34PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 16, 2022 at 11:47:00AM -0800, Andrew Morton wrote:
> > On Tue, 15 Feb 2022 14:37:44 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > 
> > > The maple tree is an RCU-safe range based B-tree designed to use modern
> > > processor cache efficiently.  There are a number of places in the kernel
> > > that a non-overlapping range-based tree would be beneficial, especially
> > > one with a simple interface.  The first user that is covered in this
> > > patch set is the vm_area_struct, where three data structures are
> > > replaced by the maple tree: the augmented rbtree, the vma cache, and the
> > > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > > or remove the mmap_sem contention.
> > 
> > Has a path been chosen which gets us from here to significant reduction
> > in mmap_lock overhead?
> > 
> > If so, what's the plan and what must be done?
> 
> I would say there are still competing ideas for how that is to be done.
> 
> First, the Maple Tree is independent (to a certain extent) of all the
> approaches to reducing mmap_lock overhead.  It's a better data structure
> for VMA lookup than the rbtree.  Set against that, it has higher overhead
> for modifications.  That means that benchmarks which primarily measure
> modification overhead see worse performance.  We believe this is not
> representative of real workloads, and indeed we see ~parity on workloads
> like git and make -jN.
> 

I'm way behind and only got around to looking at SPF properly today. Maple
is working its way up my list and I need to gather new data but I did
have old data queued from a time when I thought I would get around to
maple tree soon.  The big result that stood was was brk performance from
will-it-scale but for processes specifically

wis-malloc
                                                5.17.0-rc3                 5.17.0-rc3
                                                   vanilla           mm-maplevma-v5r1
Hmean     brk1-processes-2           5265361.84 (   0.00%)      3489097.63 * -33.73%*
Hmean     brk1-processes-5          12270382.36 (   0.00%)      8136542.13 * -33.69%*
Hmean     brk1-processes-8          19560585.95 (   0.00%)     12941094.22 * -33.84%*
Hmean     brk1-processes-12         27328267.18 (   0.00%)     18148145.64 * -33.59%*
Hmean     brk1-processes-21         39599378.04 (   0.00%)     26188063.96 * -33.87%*
Hmean     brk1-processes-30         59880571.20 (   0.00%)     39653658.00 * -33.78%*
Hmean     brk1-processes-48         72900335.59 (   0.00%)     49044880.84 * -32.72%*
Hmean     brk1-processes-79         72388042.42 (   0.00%)     48416196.93 * -33.12%*
Hmean     brk1-processes-110        72333206.18 (   0.00%)     48437222.12 * -33.04%*
Hmean     brk1-processes-141        72443841.68 (   0.00%)     48490158.48 * -33.07%*
Hmean     brk1-processes-172        72187451.54 (   0.00%)     48480696.77 * -32.84%*
Hmean     brk1-processes-203        72575945.95 (   0.00%)     48503896.03 * -33.17%*
Hmean     brk1-processes-234        67509812.97 (   0.00%)     48466347.95 * -28.21%*
Hmean     brk1-processes-265        72379447.48 (   0.00%)     48449330.06 * -33.06%*
Hmean     brk1-processes-296        72241861.59 (   0.00%)     48303854.85 * -33.14%*
Hmean     brk1-processes-320        72183320.07 (   0.00%)     48253708.21 * -33.15%*
Hmean     brk1-threads-2             1352297.67 (   0.00%)      2963406.42 * 119.14%*
Hmean     brk1-threads-5              814358.55 (   0.00%)      1233604.84 *  51.48%*
Hmean     brk1-threads-8              849900.52 (   0.00%)      1241170.76 *  46.04%*
Hmean     brk1-threads-12             804143.24 (   0.00%)      1232451.60 *  53.26%*
Hmean     brk1-threads-21             672680.28 (   0.00%)      1001257.38 *  48.85%*
Hmean     brk1-threads-30             443221.73 (   0.00%)       713592.66 *  61.00%*
Hmean     brk1-threads-48             397283.95 (   0.00%)       591349.83 *  48.85%*
Hmean     brk1-threads-79             167479.04 (   0.00%)       548681.03 * 227.61%*
Hmean     brk1-threads-110            154108.98 (   0.00%)       207349.67 *  34.55%*
Hmean     brk1-threads-141            166712.91 (   0.00%)       217314.50 *  30.35%*
Hmean     brk1-threads-172            155023.61 (   0.00%)       210318.59 *  35.67%*
Hmean     brk1-threads-203            166943.60 (   0.00%)       227892.26 *  36.51%*

The mmtests configuration this was based on no longer exists but the
equivalent should be

configs/config-workload-will-it-scale-pf-processes
configs/config-workload-will-it-scale-pf-threads

It shouldn't be too hard to pull out the brk1 test on its own and see
what it's doing in profiles.

brk_test from aim9 also suffers so may be brk-specific.

Other workloads looked ok, kernel building took a small -1.5%
performance hit on some machines but not enough that I would scream.
Others looked mostly neutral but it was only a provisional sniff test
before I even considered looking at 70 patches :O

-- 
Mel Gorman
SUSE Labs
