Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D714B54AB90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiFNIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiFNIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:17:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F223FD94
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655194629; x=1686730629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OrVbnJdhn7FtUc03iOArEa+ZxjCDWhYe5bfK90Mzuxg=;
  b=QXNALCReS17M3dbn9UdQSwnbH1HTkwwOLxd5W1FmSODRi9cJaOosOTPk
   zM6nYAVxP3rsOKtB8Hi+ozalVpeHEN2KxR+9pQBDnXqPpkXS3HuLQdu5Y
   bVNyw0UXIJ0cZ/ukTIz+nwuRA4JfcVtJKm1lsELx4gTBUGREwUI3jclOq
   /dev6gWI9TykPoo7BWaPgWre1NaIXcYpEK6YxEZUdlSvt3xTZhgH0lrp5
   wU29YdwkQTHK5Ch+M4LUYk8a1lN43Tob7P8pnroBgsS5THfs9VJq55umC
   KWf354Q2Vbj0tnWBcHj7J+2PtUvPfxy7qmVIi7ayawFiQ9k6SmgMrhf2L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261579534"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261579534"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:17:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="830274859"
Received: from unknown (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.153])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:17:05 -0700
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
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V3 0/3] memory tiering: hot page selection
Date:   Tue, 14 Jun 2022 16:16:32 +0800
Message-Id: <20220614081635.194014-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Changelogs:

v3:

- Rebased on v5.19-rc1

- Renamed newly-added fields in struct pglist_data.

v2:

- Added ABI document for promote rate limit per Andrew's comments.  Thanks!

- Added function comments when necessary per Andrew's comments.

- Address other comments from Andrew Morton.

Best Regards,
Huang, Ying
