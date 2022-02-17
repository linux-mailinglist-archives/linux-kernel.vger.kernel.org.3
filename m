Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF604B9C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiBQJbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:31:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiBQJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:31:32 -0500
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EAE296937
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:31:17 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id BC7832201
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:31:15 +0000 (GMT)
Received: (qmail 1378 invoked from network); 17 Feb 2022 09:31:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Feb 2022 09:31:15 -0000
Date:   Thu, 17 Feb 2022 09:31:13 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Message-ID: <20220217093113.GU3366@techsingularity.net>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 09:53:08AM +0800, Aaron Lu wrote:
> > 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
> >                                                     5.17.0-rc3                 5.17.0-rc3
> >                                                        vanilla           mm-highpcpopt-v2
> > Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
> > Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
> > Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
> > Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
> > Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
> > Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
> > Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
> > Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
> > Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
> > Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
> > Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
> > Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
> > Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
> > Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
> > Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
> > Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)
> > 
> > The differences are mostly within the noise and the difference close to
> > $nr_cpus is negligible.
> 
> I have queued will-it-scale/page_fault1/processes/$nr_cpu on 2 4-sockets
> servers: CascadeLake and CooperLaker and will let you know the result
> once it's out.
> 

Thanks, 4 sockets and a later generation would be nice to cover.

> I'm using 'https://github.com/hnaz/linux-mm master' and doing the
> comparison with commit c000d687ce22("mm/page_alloc: simplify how many
> pages are selected per pcp list during bulk free") and commit 8391e0a7e172
> ("mm/page_alloc: free pages in a single pass during bulk free") there.
> 

The baseline looks fine. It's different to what I used but the page_alloc
shouldn't have much impact.

When looking at will-it-scale, please pay attention to lower CPU counts
as well and take account changes in standard deviation. Looking at the
old commit (which I acked so I've no excuse), I think it's important to
look at cases other than the fully utilised case because it's the best
case for something like will-it-scale pf but it's also an unlikely case
(all CPUs all faulting continuously).

I expect there will be different good/bad points based on looking at
Zen1 results (8 nodes, varying distances, 64 cores with 128 CPUs HT
enabled)

                                                    5.17.0-rc3                 5.17.0-rc3                 5.17.0-rc3
                                                       vanilla        mm-reverthighpcp-v1           mm-highpcpopt-v2
Hmean     page_fault1-threads-2          2985366.46 (   0.00%)      2984649.41 (  -0.02%)      3028407.35 (   1.44%)
Hmean     page_fault1-threads-5          3491833.63 (   0.00%)      3500237.35 (   0.24%)      3489971.99 (  -0.05%)
Hmean     page_fault1-threads-8          3254335.58 (   0.00%)      3277515.51 *   0.71%*      3234275.28 *  -0.62%*
Hmean     page_fault1-threads-12         5101504.72 (   0.00%)      5390649.46 *   5.67%*      5162047.68 (   1.19%)
Hmean     page_fault1-threads-21         7714265.64 (   0.00%)      7714763.10 (   0.01%)      7854367.65 *   1.82%*
Hmean     page_fault1-threads-30        10034561.94 (   0.00%)      9865446.68 (  -1.69%)      9746368.76 *  -2.87%*
Hmean     page_fault1-threads-48        12571351.99 (   0.00%)     13257508.23 *   5.46%*     12160897.07 *  -3.27%*
Hmean     page_fault1-threads-79        11124387.46 (   0.00%)     10641145.82 *  -4.34%*     10677656.39 *  -4.02%*
Hmean     page_fault1-threads-110       11980424.12 (   0.00%)     10778220.84 * -10.03%*     10354249.62 * -13.57%* <-- close to nr_cpus
Hmean     page_fault1-threads-141        9727528.73 (   0.00%)      9966965.70 (   2.46%)      9656148.13 (  -0.73%) <-- close to nr_cpus
Hmean     page_fault1-threads-172       11807964.92 (   0.00%)     10335576.64 * -12.47%*     10443310.45 * -11.56%*
Hmean     page_fault1-threads-203        9471961.29 (   0.00%)      9749857.24 *   2.93%*     11890019.87 *  25.53%*
Hmean     page_fault1-threads-234       11322381.78 (   0.00%)      9163162.66 ( -19.07%)      9141561.16 ( -19.26%)
Hmean     page_fault1-threads-265        7956982.52 (   0.00%)      7774650.20 (  -2.29%)      8292405.57 *   4.22%*
Hmean     page_fault1-threads-296        7892153.88 (   0.00%)      8272671.84 *   4.82%*      7907026.20 (   0.19%)
Hmean     page_fault1-threads-327        7957124.50 (   0.00%)      8078297.34 (   1.52%)      8129776.79 (   2.17%)
Hmean     page_fault1-threads-358        7847563.90 (   0.00%)      8202303.36 (   4.52%)      8139027.38 (   3.71%)
Hmean     page_fault1-threads-389        7928386.47 (   0.00%)      8104732.41 (   2.22%)      8022002.73 (   1.18%)
Hmean     page_fault1-threads-420        7690107.89 (   0.00%)      7587821.54 (  -1.33%)      7783777.95 (   1.22%)
Hmean     page_fault1-threads-451        7683132.29 (   0.00%)      7979578.21 (   3.86%)      7693067.13 (   0.13%)
Hmean     page_fault1-threads-482        7720646.31 (   0.00%)      7597453.65 (  -1.60%)      7870063.90 (   1.94%)
Hmean     page_fault1-threads-512        7353458.45 (   0.00%)      7584407.14 (   3.14%)      8119539.24 (  10.42%)
Stddev    page_fault1-processes-2           4086.39 (   0.00%)         1698.11 (  58.44%)         1488.13 (  63.58%)
Stddev    page_fault1-processes-5           1448.69 (   0.00%)         1616.59 ( -11.59%)         1567.37 (  -8.19%)
Stddev    page_fault1-processes-8           1828.29 (   0.00%)         2628.59 ( -43.77%)         2701.96 ( -47.79%)
Stddev    page_fault1-processes-12         14073.12 (   0.00%)         1575.18 (  88.81%)         4880.93 (  65.32%)
Stddev    page_fault1-processes-21          4368.35 (   0.00%)         7865.27 ( -80.05%)         3778.03 (  13.51%)
Stddev    page_fault1-processes-30          5348.13 (   0.00%)        11751.43 (-119.73%)         3240.22 (  39.41%)
Stddev    page_fault1-processes-48         23687.16 (   0.00%)         7803.01 (  67.06%)         2635.85 (  88.87%)
Stddev    page_fault1-processes-79         12779.16 (   0.00%)         4311.60 (  66.26%)        22539.03 ( -76.37%)
Stddev    page_fault1-processes-110        21031.04 (   0.00%)        15115.36 (  28.13%)        12136.54 (  42.29%)
Stddev    page_fault1-processes-141       589804.99 (   0.00%)      1335519.71 (-126.43%)        19560.01 (  96.68%)
Stddev    page_fault1-processes-172         7033.94 (   0.00%)         7147.71 (  -1.62%)        11366.64 ( -61.60%)
Stddev    page_fault1-processes-203         6322.20 (   0.00%)         5035.55 (  20.35%)         4043.45 (  36.04%)
Stddev    page_fault1-processes-234        12046.53 (   0.00%)        24208.37 (-100.96%)         9159.91 (  23.96%)
Stddev    page_fault1-processes-265        11869.43 (   0.00%)        13528.26 ( -13.98%)         8943.99 (  24.65%)
Stddev    page_fault1-processes-296         8918.50 (   0.00%)        16130.54 ( -80.87%)         5211.80 (  41.56%)
Stddev    page_fault1-processes-327       101102.64 (   0.00%)       845864.70 (-736.64%)        16238.99 (  83.94%)
Stddev    page_fault1-processes-358      2102190.38 (   0.00%)        11316.00 (  99.46%)         7508.57 (  99.64%)
Stddev    page_fault1-processes-389        61012.79 (   0.00%)       121446.55 ( -99.05%)        18279.64 (  70.04%)
Stddev    page_fault1-processes-420      2305208.40 (   0.00%)      2347564.71 (  -1.84%)         3202.77 (  99.86%)
Stddev    page_fault1-processes-451        20214.37 (   0.00%)       173800.17 (-759.79%)       492258.35 (-2335.19%)
Stddev    page_fault1-processes-482       236881.21 (   0.00%)       330501.32 ( -39.52%)        15307.31 (  93.54%)
Stddev    page_fault1-processes-512       201354.82 (   0.00%)       207019.93 (  -2.81%)      4900536.90 (-2333.78%)

This is showing there was a impact around the nr_cpus (110 and 141
processes measured) but the standard deviation around 141 was particularly
high in the baseline case taking two passes through lists. It's also
interesting to note that in most cases that standard deviation is reduced
by the series even though it's not universally true.

As a side-note, there is also a fair amount of NUMA balancing that takes
place during this test which further muddies the waters. This is a slightly
surprising result and I suspect what's happening is that processes are
getting migrated cross-node as the number of processes exceed a local
nodes capacity due to load balancing. It might be highlighting a weakness
in the test itself where it ends up measuring more than one thing (not
just fault capacity but load balancing effects as individual nodes CPU
capacity approaches fully busy).

My main concern when writing this patch was the basic case of one CPU doing
a lot of frees (exiting, large truncate, large unmap, anything hammering
on release_pages for a large region etc) suffered from taking two loops
through lists with all the associated cost of the list manipulations. I
worried that by trying to optimise for a corner case (all CPUs allocating
simultaneously), we missed a basic case (one CPU doing a large amount
of allocating/freeing).

If possible, it would be nice if you could add something like
configs/config-io-trunc from mmtests to lkp if it doesn't exist already
to consider the simple case. As its most basic, all it's doing is

---8<---
#!/bin/bash

for i in {1..10}; do
        dd if=/dev/zero of=sparse_file-$i bs=1 count=0 seek=1G &>/dev/null
        cat sparse_file-$i > /dev/null
done
sync

# Primary metric
time rm sparse_file*
---8<---

The main difference is that the mmtests will report the time to fault the
sparse files (bulk simple allocate inserting into page cache) as well as
the bulk truncate (bulk simple release of page cache).

Thanks.

-- 
Mel Gorman
SUSE Labs
