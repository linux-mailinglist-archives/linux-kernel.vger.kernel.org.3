Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC584B9B05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiBQIaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:30:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiBQIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:30:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3831F3F01
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC3CB820B5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29214C340E8;
        Thu, 17 Feb 2022 08:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645086587;
        bh=pFXuwcJm7//HhEXzDW7lpJV/4fd6XEE4L4ff3z1Dul4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=QchUlpy9gKt0rhH5+W2pHsV1P3orQg5OrhTE1mOOoC9pgJ7gypjGdBeBAv92a091E
         IEpOz1Mi64wu/Kq/G1xbyMDHO00oYyR14+C0Xctbq5bB/+qTeB5Bidh/qiXK2TrqZh
         kijJLc7iP4ARDl+WcE2opTxP/hnvjyiZFlGiUdTrRdbbaGDoK6mv4yyctvX5jaYv11
         BLy82RvfAENbQGoORHX5RBlGLVBnlOKvOinMfSov/F4TAyziuI+2+qUlW6WMrIXKwZ
         hu+o1wDMJEV2PEFEJzNrUud2upR28cbuz5RhfRZZxYjolxz4itchjr1/iSfJieD4e2
         rl5iINQlLcSaQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        linux-damon@amazon.com
Subject: Re: [RFC PATCH V1 0/5] mm/damon: Add NUMA access statistics function support
Date:   Thu, 17 Feb 2022 08:29:39 +0000
Message-Id: <20220217082939.2850-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1645024354.git.xhao@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ David Rientjes, who has shown interest[1] in this topic.

[1] https://lore.kernel.org/linux-mm/bcc8d9a0-81d-5f34-5e4-fcc28eb7ce@google.com/

---

Hi Xin,


Thank you always for great patches!

On Wed, 16 Feb 2022 16:30:36 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> On today's cloud computing service scenario, NUMA (non uniform memory access)
> architecture server has been applied on a large scale. Using Damon function,
> it can easily and lightweight identify hot and cold memory, but it can not
> display the situation of locale and remote NUMA memory access.
> 
> The purpose of these serie patches is to identify the situation of NUMA access
> in combination with DAMON, especially for remote NUMA access in hot memory.
> We hope to detect this situation in the data center and use page migration or
> multi backup page technology to optimize the behavior of memory access.
> 
> So next, we will further improve Damon NUMA function:
> 1. Support hugtlbfs NUMA access statistics.
> 2. Add the DAMO tool to parse NUMA local & remote in "damon_region" support.
> 3. For hot memory remote NUMA access, support page migration or multi backup page.
> 
> About DAMON correctness of numa access statistics
> We wrote a test case, allocate about 1G memory, and use numa_alloc(), set 512M in
> NUMA node0 and 512M in NUMA node1, and The test case alternately accesses the 1G of memory.
> 
> We used "perf record -e damon:damon_aggregated" and "perf script"
> cmd to obtain data, like this:
> kdamond.0  target_id=0 nr_regions=10 281473056325632-281473127964672:: 12 0 5243 5513
> kdamond.0  target_id=0 nr_regions=10 281473127964672-281473238028288: 8 1 5427  5399
> ...
> kdamond.0   target_id=0 nr_regions=10 281473056325632-281473127964672: 9 3 7669 7632
> kdamond.0   target_id=0  nr_regions=10 281473127964672-281473238028288: 7 2 7913 7892
> 
> And compared with numastat like this:
> Per-node process memory usage (in MBs) for PID 111676 (lt-numademo)
>                            Node 0          Node 1          Node 2
>                   --------------- --------------- ---------------
> Huge                         0.00            0.00            0.00
> Heap                         0.02            0.00            0.00
> Stack                        0.01            0.00            0.00
> Private                    565.24          564.00            0.00
> ----------------  --------------- --------------- ---------------
> Total                      565.27          564.00            0.00
> This comparison can determine the accuracy of Damon NUMA memory access statistics.
> 
> About the impact of DAMON NUMA access on Performance
> During the  benchmakr test, we found that the MBW benchmark memcpy test item
> will cause about 3% performance degradation, and there is no performance degradation
> in other benchmarks.
> So we added "numa_stat" switch in DAMON dbgfs interface, turn on this switch when NUMA access
> statistics is required.
> 
> 
> Xin Hao (5):
>   mm/damon: Add NUMA local and remote variables in 'damon_region'
>   mm/damon: Add 'damon_region' NUMA fault simulation support
>   mm/damon: Add 'damon_region' NUMA access statistics core
>     implementation
>   mm/damon/dbgfs: Add numa simulate switch
>   mm/damon/tracepoint: Add 'damon_region' NUMA access statistics support
> 
>  include/linux/damon.h        | 25 ++++++++++
>  include/trace/events/damon.h |  9 +++-
>  mm/damon/core.c              | 94 +++++++++++++++++++++++++++++++++++-
>  mm/damon/dbgfs.c             | 70 ++++++++++++++++++++++++---
>  mm/damon/paddr.c             | 25 ++++++++--
>  mm/damon/prmtv-common.c      | 44 +++++++++++++++++
>  mm/damon/prmtv-common.h      |  3 ++
>  mm/damon/vaddr.c             | 45 ++++++++++-------
>  mm/huge_memory.c             |  5 ++
>  mm/memory.c                  |  5 ++
>  10 files changed, 292 insertions(+), 33 deletions(-)

I'd like to comment on the high level design at the moment.  To my
understanding, this patchset extends DAMON core and monitoring operations for
virtual address spaces (vaddr) and the physical address space (paddr) to
monitor NUMA-local/remote accesses via PROT_NONE and page faults mechanism.

The underlying mechanism for NUMA-local/remote accesses (PROT_NONE and page
fault) looks ok to me.  But, changes to the core and vaddr/paddr operations
looks unnecessary, to me.  That's also not for general use cases.

I think it would be simpler to implment more monitoring operations for NUMA
monitoring use case (one for NUMA-local accesses accounting and another one for
NUMA-remote accesses accounting), alongside vaddr and paddr.  Then, users could
configure DAMON to have three monitoring contexts (one with vaddr ops, second
one with numa-local ops, and third one with numa-remote ops), run those
concurrently, then show the three results and make some decisions like
migrations.

One additional advantage of this approach is that the accuracy for
NUMA-local/remote accessed could be better, because the contexts configured to
use NUMA-local/remote monitoring ops will do the regions adjustment with
NUMA-local/remote accesses (to my understanding, this patchset let regions have
NUMA-local/remote accesses counter in addition to the total one, but still use
only the total one for the regions adjustment).

If I'm missing something, please let me know.


Thanks,
SJ

> 
> --
> 2.27.0
