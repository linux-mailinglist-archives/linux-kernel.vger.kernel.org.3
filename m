Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A8A4B81C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiBPHk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:40:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBPHkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:40:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7F15135C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644997194; x=1676533194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HqDf70TozgE/3I3FqJ3BcObqEF3HqQcEJeAkAhehEk=;
  b=HllbwrX3D9IVuSkNDKAtk6u6Yrhpm24PRH3YBfqOIPiXhR97JxN6r1QQ
   f9UaqERLCL2M4ujrPc/r6JEtZ5u2CAhsXluWGKyYvi/geOEDKWEa27D+d
   VrBJMR89paJnE4atyZHPGa3+DYHuDZ1DACFk4gjDw0kXjPmq9mlP9Mc3y
   aQf6sWKIxr8kmANCw85st6HAozJK13PrZOFuU6INjHvnGm48WPc71ONWN
   z0zmLBEwYjzDtIxCuw4kR8kUXVkjtbB/n55PK6iO5CSb2mcuM2JhypcN9
   FzCbfaxklU8r7dVQBQxjE46lg7pBOaKl6qY8AkBJ1o/tmfE1oH2i96Dyu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250487360"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250487360"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:38:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="498414830"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:38:27 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH -V12 0/3] NUMA balancing: optimize memory placement for memory tiering system
Date:   Wed, 16 Feb 2022 15:38:12 +0800
Message-Id: <20220216073815.2505536-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes since the last post are as follows,

- Rebased on v5.17-rc4

- Change promotion watermark implementation per Johannes' comments

- Fixes several sysctl ABI document bugs, Thanks Andrew.

--

With the advent of various new memory types, some machines will have
multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
memory subsystem of these machines can be called memory tiering
system, because the performance of the different types of memory are
different.

After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
for use like normal RAM"), the PMEM could be used as the
cost-effective volatile memory in separate NUMA nodes.  In a typical
memory tiering system, there are CPUs, DRAM and PMEM in each physical
NUMA node.  The CPUs and the DRAM will be put in one logical node,
while the PMEM will be put in another (faked) logical node.

To optimize the system overall performance, the hot pages should be
placed in DRAM node.  To do that, we need to identify the hot pages in
the PMEM node and migrate them to DRAM node via NUMA migration.

In the original NUMA balancing, there are already a set of existing
mechanisms to identify the pages recently accessed by the CPUs in a
node and migrate the pages to the node.  So we can reuse these
mechanisms to build the mechanisms to optimize the page placement in
the memory tiering system.  This is implemented in this patchset.

At the other hand, the cold pages should be placed in PMEM node.  So,
we also need to identify the cold pages in the DRAM node and migrate
them to PMEM node.

In commit 26aa2d199d6f ("mm/migrate: demote pages during reclaim"), a
mechanism to demote the cold DRAM pages to PMEM node under memory
pressure is implemented.  Based on that, the cold DRAM pages can be
demoted to PMEM node proactively to free some memory space on DRAM
node to accommodate the promoted hot PMEM pages.  This is implemented
in this patchset too.

We have tested the solution with the pmbench memory accessing
benchmark with the 80:20 read/write ratio and the Gauss access address
distribution on a 2 socket Intel server with Optane DC Persistent
Memory Model.  The test results shows that the pmbench score can
improve up to 95.9%.

Changelog:

v12:

- Rebased on v5.17-rc4

- Change promotion watermark implementation per Johannes' comments

- Fixes several sysctl ABI document bugs, Thanks Andrew.

v11:

- Rebased on v5.17-rc1

- Remove [4-6] from the original patchset to make it easier to be
  reviewed.

- Change the additional promotion watermark to be the high watermark / 4.

v10:

- Rebased on v5.16-rc1

- Revise error processing for [1/6] (promotion counter) per Yang's comments

- Add sysctl document for [2/6] (optimize page placement)

- Reset threshold adjustment state when disable/enable tiering mode

- Reset threshold when workload transition is detected.

v9:

- Rebased on v5.15-rc4

- Make "add promotion counter" the first patch per Yang's comments

v8:

- Rebased on v5.15-rc1

- Make user-specified threshold take effect sooner

v7:

- Rebased on the mmots tree of 2021-07-15.

- Some minor fixes.

v6:

- Rebased on the latest page demotion patchset. (which bases on v5.11)

v5:

- Rebased on the latest page demotion patchset. (which bases on v5.10)

v4:

- Rebased on the latest page demotion patchset. (which bases on v5.9-rc6)

- Add page promotion counter.

v3:

- Move the rate limit control as late as possible per Mel Gorman's
  comments.

- Revise the hot page selection implementation to store page scan time
  in struct page.

- Code cleanup.

- Rebased on the latest page demotion patchset.

v2:

- Addressed comments for V1.

- Rebased on v5.5.

Best Regards,
Huang, Ying
