Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AB4B8304
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiBPIbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:31:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBPIa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:30:58 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8C221E31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:30:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4cXjy8_1645000243;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V4cXjy8_1645000243)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:30:44 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 0/5] mm/damon: Add NUMA access statistics function support
Date:   Wed, 16 Feb 2022 16:30:36 +0800
Message-Id: <cover.1645024354.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On today's cloud computing service scenario, NUMA (non uniform memory access)
architecture server has been applied on a large scale. Using Damon function,
it can easily and lightweight identify hot and cold memory, but it can not
display the situation of locale and remote NUMA memory access.

The purpose of these serie patches is to identify the situation of NUMA access
in combination with DAMON, especially for remote NUMA access in hot memory.
We hope to detect this situation in the data center and use page migration or
multi backup page technology to optimize the behavior of memory access.

So next, we will further improve Damon NUMA function:
1. Support hugtlbfs NUMA access statistics.
2. Add the DAMO tool to parse NUMA local & remote in "damon_region" support.
3. For hot memory remote NUMA access, support page migration or multi backup page.

About DAMON correctness of numa access statistics
We wrote a test case, allocate about 1G memory, and use numa_alloc(), set 512M in
NUMA node0 and 512M in NUMA node1, and The test case alternately accesses the 1G of memory.

We used "perf record -e damon:damon_aggregated" and "perf script"
cmd to obtain data, like this:
kdamond.0  target_id=0 nr_regions=10 281473056325632-281473127964672:: 12 0 5243 5513
kdamond.0  target_id=0 nr_regions=10 281473127964672-281473238028288: 8 1 5427  5399
...
kdamond.0   target_id=0 nr_regions=10 281473056325632-281473127964672: 9 3 7669 7632
kdamond.0   target_id=0  nr_regions=10 281473127964672-281473238028288: 7 2 7913 7892

And compared with numastat like this:
Per-node process memory usage (in MBs) for PID 111676 (lt-numademo)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.02            0.00            0.00
Stack                        0.01            0.00            0.00
Private                    565.24          564.00            0.00
----------------  --------------- --------------- ---------------
Total                      565.27          564.00            0.00
This comparison can determine the accuracy of Damon NUMA memory access statistics.

About the impact of DAMON NUMA access on Performance
During the  benchmakr test, we found that the MBW benchmark memcpy test item
will cause about 3% performance degradation, and there is no performance degradation
in other benchmarks.
So we added "numa_stat" switch in DAMON dbgfs interface, turn on this switch when NUMA access
statistics is required.


Xin Hao (5):
  mm/damon: Add NUMA local and remote variables in 'damon_region'
  mm/damon: Add 'damon_region' NUMA fault simulation support
  mm/damon: Add 'damon_region' NUMA access statistics core
    implementation
  mm/damon/dbgfs: Add numa simulate switch
  mm/damon/tracepoint: Add 'damon_region' NUMA access statistics support

 include/linux/damon.h        | 25 ++++++++++
 include/trace/events/damon.h |  9 +++-
 mm/damon/core.c              | 94 +++++++++++++++++++++++++++++++++++-
 mm/damon/dbgfs.c             | 70 ++++++++++++++++++++++++---
 mm/damon/paddr.c             | 25 ++++++++--
 mm/damon/prmtv-common.c      | 44 +++++++++++++++++
 mm/damon/prmtv-common.h      |  3 ++
 mm/damon/vaddr.c             | 45 ++++++++++-------
 mm/huge_memory.c             |  5 ++
 mm/memory.c                  |  5 ++
 10 files changed, 292 insertions(+), 33 deletions(-)

--
2.27.0
