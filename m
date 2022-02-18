Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D646C4BB555
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiBRJUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:20:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiBRJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:20:29 -0500
Received: from outbound-smtp30.blacknight.com (outbound-smtp30.blacknight.com [81.17.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2721E00
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:20:10 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 7BD1FBAAF6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:20:08 +0000 (GMT)
Received: (qmail 27521 invoked from network); 18 Feb 2022 09:20:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Feb 2022 09:20:08 -0000
Date:   Fri, 18 Feb 2022 09:20:06 +0000
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
Message-ID: <20220218092006.GX3366@techsingularity.net>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg2qhJyTovY2oQhe@ziqianlu-nuc9qn>
 <20220217093113.GU3366@techsingularity.net>
 <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yg8ec9MLblOkHTY9@ziqianlu-nuc9qn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:20:03PM +0800, Aaron Lu wrote:
> > The baseline looks fine. It's different to what I used but the page_alloc
> > shouldn't have much impact.
> > 
> > When looking at will-it-scale, please pay attention to lower CPU counts
> > as well and take account changes in standard deviation. Looking at the
> 
> I'll also test nr_task=4/16/64 on the 4sockets CooperLake(nr_cpu=144) then.
> 

Thanks.

> > I expect there will be different good/bad points based on looking at
> > Zen1 results (8 nodes, varying distances, 64 cores with 128 CPUs HT
> > enabled)
> > 
> >                                                     5.17.0-rc3                 5.17.0-rc3                 5.17.0-rc3
> >                                                        vanilla        mm-reverthighpcp-v1           mm-highpcpopt-v2
> > Hmean     page_fault1-threads-2          2985366.46 (   0.00%)      2984649.41 (  -0.02%)      3028407.35 (   1.44%)
> > Hmean     page_fault1-threads-5          3491833.63 (   0.00%)      3500237.35 (   0.24%)      3489971.99 (  -0.05%)
> > Hmean     page_fault1-threads-8          3254335.58 (   0.00%)      3277515.51 *   0.71%*      3234275.28 *  -0.62%*
> > Hmean     page_fault1-threads-12         5101504.72 (   0.00%)      5390649.46 *   5.67%*      5162047.68 (   1.19%)
> > Hmean     page_fault1-threads-21         7714265.64 (   0.00%)      7714763.10 (   0.01%)      7854367.65 *   1.82%*
> > Hmean     page_fault1-threads-30        10034561.94 (   0.00%)      9865446.68 (  -1.69%)      9746368.76 *  -2.87%*
> > Hmean     page_fault1-threads-48        12571351.99 (   0.00%)     13257508.23 *   5.46%*     12160897.07 *  -3.27%*
> > Hmean     page_fault1-threads-79        11124387.46 (   0.00%)     10641145.82 *  -4.34%*     10677656.39 *  -4.02%*
> > Hmean     page_fault1-threads-110       11980424.12 (   0.00%)     10778220.84 * -10.03%*     10354249.62 * -13.57%* <-- close to nr_cpus
> > Hmean     page_fault1-threads-141        9727528.73 (   0.00%)      9966965.70 (   2.46%)      9656148.13 (  -0.73%) <-- close to nr_cpus
> 
> I have never tested thread mode, because I think the heavy loaded
> thread mode is more about testing the mmap_sem contention than page
> allocator's performance?

You're right, I meant to paste in the processes figures and used
processes for the stddev

Hmean     page_fault1-processes-2        3087765.27 (   0.00%)      3040255.24 *  -1.54%*      3026943.42 *  -1.97%*
Hmean     page_fault1-processes-5        3630079.14 (   0.00%)      3644005.83 *   0.38%*      3641029.26 *   0.30%*
Hmean     page_fault1-processes-8        3435519.22 (   0.00%)      3440525.39 *   0.15%*      3430091.10 *  -0.16%*
Hmean     page_fault1-processes-12       7060647.54 (   0.00%)      7078730.32 *   0.26%*      7066516.90 (   0.08%)
Hmean     page_fault1-processes-21      10529603.15 (   0.00%)     10543342.71 *   0.13%*     10529619.72 (   0.00%)
Hmean     page_fault1-processes-30      13919518.76 (   0.00%)     13916089.66 (  -0.02%)     13911735.60 *  -0.06%*
Hmean     page_fault1-processes-48      20655910.65 (   0.00%)     20680704.25 *   0.12%*     20634196.53 *  -0.11%*
Hmean     page_fault1-processes-79      27154979.79 (   0.00%)     27200579.85 *   0.17%*     27111810.79 *  -0.16%*
Hmean     page_fault1-processes-110     26456190.23 (   0.00%)     26498119.30 *   0.16%*     26414120.14 *  -0.16%*
Hmean     page_fault1-processes-141     25741741.47 (   0.00%)     25377519.19 (  -1.41%)     26020885.64 (   1.08%)
Hmean     page_fault1-processes-172     26029813.28 (   0.00%)     26107861.43 *   0.30%*     26011987.83 *  -0.07%*
Hmean     page_fault1-processes-203     26005230.37 (   0.00%)     26114882.22 *   0.42%*     25999181.70 (  -0.02%)
Hmean     page_fault1-processes-234     26021903.34 (   0.00%)     26123727.47 *   0.39%*     26000412.62 *  -0.08%*
Hmean     page_fault1-processes-265     26019386.67 (   0.00%)     26139301.80 *   0.46%*     26014073.54 (  -0.02%)
Hmean     page_fault1-processes-296     26014579.15 (   0.00%)     26101018.62 *   0.33%*     26009459.16 (  -0.02%)
Hmean     page_fault1-processes-327     26059483.56 (   0.00%)     26279026.62 (   0.84%)     25990821.88 (  -0.26%)
Hmean     page_fault1-processes-358     19604338.34 (   0.00%)     26115341.28 *  33.21%*     25995281.86 *  32.60%*
Hmean     page_fault1-processes-389     26084730.88 (   0.00%)     26058850.78 (  -0.10%)     26007661.51 *  -0.30%*
Hmean     page_fault1-processes-420     25358929.58 (   0.00%)     25097140.75 (  -1.03%)     26005923.68 (   2.55%)
Hmean     page_fault1-processes-451     26172808.51 (   0.00%)     26439611.24 *   1.02%*     26078355.47 (  -0.36%)
Hmean     page_fault1-processes-482     26848297.49 (   0.00%)     26722385.24 (  -0.47%)     26171033.04 *  -2.52%*

> It's surprising this patch caused a
> performance change.
> 

The figures say it meakes little difference. I wasn't really
concentrating on will-it-scale-pf as such when writing the patch. I
included pf because it was the original justification for deferring
the zone lock acquisition until after pages had been taken off the PCP.

> > Hmean     page_fault1-threads-234       11322381.78 (   0.00%)      9163162.66 ( -19.07%)      9141561.16 ( -19.26%)
> > Hmean     page_fault1-threads-265        7956982.52 (   0.00%)      7774650.20 (  -2.29%)      8292405.57 *   4.22%*
> > Hmean     page_fault1-threads-296        7892153.88 (   0.00%)      8272671.84 *   4.82%*      7907026.20 (   0.19%)
> > Hmean     page_fault1-threads-327        7957124.50 (   0.00%)      8078297.34 (   1.52%)      8129776.79 (   2.17%)
> > Hmean     page_fault1-threads-358        7847563.90 (   0.00%)      8202303.36 (   4.52%)      8139027.38 (   3.71%)
> > Hmean     page_fault1-threads-389        7928386.47 (   0.00%)      8104732.41 (   2.22%)      8022002.73 (   1.18%)
> > Hmean     page_fault1-threads-420        7690107.89 (   0.00%)      7587821.54 (  -1.33%)      7783777.95 (   1.22%)
> > Hmean     page_fault1-threads-451        7683132.29 (   0.00%)      7979578.21 (   3.86%)      7693067.13 (   0.13%)
> > Hmean     page_fault1-threads-482        7720646.31 (   0.00%)      7597453.65 (  -1.60%)      7870063.90 (   1.94%)
> > Hmean     page_fault1-threads-512        7353458.45 (   0.00%)      7584407.14 (   3.14%)      8119539.24 (  10.42%)
> > Stddev    page_fault1-processes-2           4086.39 (   0.00%)         1698.11 (  58.44%)         1488.13 (  63.58%)
> > Stddev    page_fault1-processes-5           1448.69 (   0.00%)         1616.59 ( -11.59%)         1567.37 (  -8.19%)
> > Stddev    page_fault1-processes-8           1828.29 (   0.00%)         2628.59 ( -43.77%)         2701.96 ( -47.79%)
> > Stddev    page_fault1-processes-12         14073.12 (   0.00%)         1575.18 (  88.81%)         4880.93 (  65.32%)
> > Stddev    page_fault1-processes-21          4368.35 (   0.00%)         7865.27 ( -80.05%)         3778.03 (  13.51%)
> > Stddev    page_fault1-processes-30          5348.13 (   0.00%)        11751.43 (-119.73%)         3240.22 (  39.41%)
> > Stddev    page_fault1-processes-48         23687.16 (   0.00%)         7803.01 (  67.06%)         2635.85 (  88.87%)
> > Stddev    page_fault1-processes-79         12779.16 (   0.00%)         4311.60 (  66.26%)        22539.03 ( -76.37%)
> > Stddev    page_fault1-processes-110        21031.04 (   0.00%)        15115.36 (  28.13%)        12136.54 (  42.29%)
> > Stddev    page_fault1-processes-141       589804.99 (   0.00%)      1335519.71 (-126.43%)        19560.01 (  96.68%)
> > Stddev    page_fault1-processes-172         7033.94 (   0.00%)         7147.71 (  -1.62%)        11366.64 ( -61.60%)
> > Stddev    page_fault1-processes-203         6322.20 (   0.00%)         5035.55 (  20.35%)         4043.45 (  36.04%)
> > Stddev    page_fault1-processes-234        12046.53 (   0.00%)        24208.37 (-100.96%)         9159.91 (  23.96%)
> > Stddev    page_fault1-processes-265        11869.43 (   0.00%)        13528.26 ( -13.98%)         8943.99 (  24.65%)
> > Stddev    page_fault1-processes-296         8918.50 (   0.00%)        16130.54 ( -80.87%)         5211.80 (  41.56%)
> > Stddev    page_fault1-processes-327       101102.64 (   0.00%)       845864.70 (-736.64%)        16238.99 (  83.94%)
> > Stddev    page_fault1-processes-358      2102190.38 (   0.00%)        11316.00 (  99.46%)         7508.57 (  99.64%)
> > Stddev    page_fault1-processes-389        61012.79 (   0.00%)       121446.55 ( -99.05%)        18279.64 (  70.04%)
> > Stddev    page_fault1-processes-420      2305208.40 (   0.00%)      2347564.71 (  -1.84%)         3202.77 (  99.86%)
> > Stddev    page_fault1-processes-451        20214.37 (   0.00%)       173800.17 (-759.79%)       492258.35 (-2335.19%)
> > Stddev    page_fault1-processes-482       236881.21 (   0.00%)       330501.32 ( -39.52%)        15307.31 (  93.54%)
> > Stddev    page_fault1-processes-512       201354.82 (   0.00%)       207019.93 (  -2.81%)      4900536.90 (-2333.78%)
> > 
> > This is showing there was a impact around the nr_cpus (110 and 141
> > processes measured) but the standard deviation around 141 was particularly
>   ~~~~~~~~~
> 
>   Did you mean threads?
> 

I meant processes both times and based the reasoning on processes and
pasted the wrong thing. I'm going to split this config into threads
versions and processes versions because they measure different things
and considering them together in the context of the same test is hazardous.

> > If possible, it would be nice if you could add something like
> > configs/config-io-trunc from mmtests to lkp if it doesn't exist already
> > to consider the simple case. As its most basic, all it's doing is
> > 
> > ---8<---
> > #!/bin/bash
> > 
> > for i in {1..10}; do
> >         dd if=/dev/zero of=sparse_file-$i bs=1 count=0 seek=1G &>/dev/null
> >         cat sparse_file-$i > /dev/null
> > done
> > sync
> > 
> > # Primary metric
> > time rm sparse_file*
> > ---8<---
> > 
> > The main difference is that the mmtests will report the time to fault the
> > sparse files (bulk simple allocate inserting into page cache) as well as
> > the bulk truncate (bulk simple release of page cache).
> 
> Thanks for the suggestion.
> 
> vm-scalability has a similar test called case-truncate which LKP already uses:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-truncate
> except in case-truncate, the rm is done concurrently and only the
> truncate time is reported.

This is still a valid test except you may also be measuring LRU lock
contention so it'll be less clear for evaluating this series unless the
scale factor is 1.

> I'll modify the case to make it do the rm in
> sequential mode and also report the fault time.
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
