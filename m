Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A20A573150
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiGMIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiGMIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:40:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E52E193A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657701629; x=1689237629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3XlJdFKMMXZ/3uT7ErsQxlftSciCG/DfbQ0W2TTX/o=;
  b=ZKXLpEou6xznJFqGW0VbbNoeJPLGWtqUDLgHtp5NN4/zrEl4cySDVPxi
   5xaL56kR1/bZoK0KHYlWtZnHzokQGuZpJANVg5j2Fs1VFTsJlr/FfNrIV
   94u4wGIK+fmhhhQuYr3i2z0qQbej/PBFGRGNIYuUz9eQQk2Z1DO3ERmcW
   WJ+o6jpu3gaRu9k/dnDB1qTcrfhVGLwm4f0OF8eWWd+SE3hNEj/Q7kN0F
   vrBRa1R+qp7tp6tzxx43ga0Z3cjOVi2e/+NJQJRgJrA6y++tksWl1dNWy
   2Pg0SMauhkPKSxnOJXzNA9tUlFBIVHLo/YrOtkolCCt3uCbr+6BvOs22f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265563051"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="265563051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:40:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="653284442"
Received: from yijunwa1-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:40:25 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V4 RESEND 0/3] memory tiering: hot page selection
Date:   Wed, 13 Jul 2022 16:39:50 +0800
Message-Id: <20220713083954.34196-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To optimize page placement in a memory tiering system with NUMA
balancing, the hot pages in the slow memory nodes need to be
identified.  Essentially, the original NUMA balancing implementation
selects the mostly recently accessed (MRU) pages to promote.  But this
isn't a perfect algorithm to identify the hot pages.  Because the
pages with quite low access frequency may be accessed eventually given
the NUMA balancing page table scanning period could be quite long
(e.g. 60 seconds).  So in this patchset, we implement a new hot page
identification algorithm based on the latency between NUMA balancing
page table scanning and hint page fault.  Which is a kind of mostly
frequently accessed (MFU) algorithm.

In NUMA balancing memory tiering mode, if there are hot pages in slow
memory node and cold pages in fast memory node, we need to
promote/demote hot/cold pages between the fast and cold memory nodes.

A choice is to promote/demote as fast as possible.  But the CPU cycles
and memory bandwidth consumed by the high promoting/demoting
throughput will hurt the latency of some workload because of accessing
inflating and slow memory bandwidth contention.

A way to resolve this issue is to restrict the max promoting/demoting
throughput.  It will take longer to finish the promoting/demoting.
But the workload latency will be better.  This is implemented in this
patchset as the page promotion rate limit mechanism.

The promotion hot threshold is workload and system configuration
dependent.  So in this patchset, a method to adjust the hot threshold
automatically is implemented.  The basic idea is to control the number
of the candidate promotion pages to match the promotion rate limit.

We used the pmbench memory accessing benchmark tested the patchset on
a 2-socket server system with DRAM and PMEM installed.  The test
results are as follows,

		pmbench score		promote rate
		 (accesses/s)			MB/s
		-------------		------------
base		  146887704.1		       725.6
hot selection     165695601.2		       544.0
rate limit	  162814569.8		       165.2
auto adjustment	  170495294.0                  136.9

From the results above,

With hot page selection patch [1/3], the pmbench score increases about
12.8%, and promote rate (overhead) decreases about 25.0%, compared with
base kernel.

With rate limit patch [2/3], pmbench score decreases about 1.7%, and
promote rate decreases about 69.6%, compared with hot page selection
patch.

With threshold auto adjustment patch [3/3], pmbench score increases
about 4.7%, and promote rate decrease about 17.1%, compared with rate
limit patch.

Baolin helped to test the patchset with MySQL on a machine which
contains 1 DRAM node (30G) and 1 PMEM node (126G).

sysbench /usr/share/sysbench/oltp_read_write.lua \
......
--tables=200 \
--table-size=1000000 \
--report-interval=10 \
--threads=16 \
--time=120

The tps can be improved about 5%.

Changelogs:

v4:

- Rebased on v5.19-rc3

- Collected reviewed-by and tested-by.

v3:

- Rebased on v5.19-rc1

- Renamed newly-added fields in struct pglist_data.

v2:

- Added ABI document for promote rate limit per Andrew's comments.  Thanks!

- Added function comments when necessary per Andrew's comments.

- Address other comments from Andrew Morton.

Best Regards,
Huang, Ying
