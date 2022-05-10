Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927F520DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiEJGoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiEJGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:44:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD97321935A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652164812; x=1683700812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nYSTBbKJ5UwtwVRbrqVsql8056l5ynL+ozUldG6Uhgg=;
  b=YSPLQ6qVWesUgWUf7+nIvPbVk87PEhFf8JotBcZ9EBT7ZS4u9U1ca2tv
   +MO7pvTIOHMtVuh1TsIO/u/wm5MC+qsiRpwRNiPRZ8zmRhY+ijJYNWX/R
   DMMHslqp5cVwBdKXJHa6kCeC6mUwCGSX2e8IonoFQuDV8ud0BA5/VBg/p
   Dw2p24O2jNYKsmEPO6GxzUq2qEnyWrSp175FpCBTJ0gzYNWYdwfND9iTA
   aP6JbIb2S5+V2Y9jP7GNUBMDxXJs+dhPQv7cXtDlHU1hPnh2CLcrP4hNM
   P9NwnFF01P7bIJONvVv6YsLSgJbBzUfVWip+AcVBBPRN9qBZDSGiykfIM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251327923"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="251327923"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:40:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="519605030"
Received: from sijieyux-mobl3.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:40:08 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V2 0/3 RESEND] memory tiering: hot page selection
Date:   Tue, 10 May 2022 14:39:55 +0800
Message-Id: <20220510063958.86985-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To optimize page placement in a memory tiering system with NUMA
balancing, the hot pages in the slow memory node need to be
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

Changelog:

v2:

- Added ABI document for promote rate limit per Andrew's comments.  Thanks!

- Added function comments when necessary per Andrew's comments.

- Address other comments from Andrew Morton.

Best Regards,
Huang, Ying
