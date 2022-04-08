Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7534F8F46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiDHHO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiDHHOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:14:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A6420A395
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649401966; x=1680937966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p9Vyinh/bxnpuA3ME5EXESNvBi6g7SL/nHb8H8N/Zz8=;
  b=ePexQnROL3G4KQQ3B15Ff9kELllKmc28Ipba+tahoGmZ0xwrfFsrzZ+Z
   Lq08Zsb5rs8P7xVLW5ogTM6xZ9U5uQ55lMRv0ygiDTcjFptdZZ7Mt1FAp
   FdDI+Zbe5WdoKwv73K4r/lONH4JW4AxBg8nYT1Uw6ybw66yZGiHRaqEui
   UkQYmWh/DKfeQSH3kkTITQlpRX5o0urNb9LBNLQqP9O7BNh1v3qpvgZRE
   InDnq+3lJjgqmOMlX9wzRU1+M4ZybA9MEXEAnvvHro96nYxwICTe6CmGr
   2NXZf5ZWNoZWYSyfMiy/k4IgXHm2PVGTaYjCGGcGLaobNkQZhg9c02dKz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261524670"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261524670"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:12:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="550403934"
Received: from fangyaxu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.214.217])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:12:42 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH 0/3] memory tiering: hot page selection
Date:   Fri,  8 Apr 2022 15:12:19 +0800
Message-Id: <20220408071222.219689-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To optimize page placement in a memory tiering system with NUMA
balancing, the hot pages in the slow memory node need to be
identified.  Essentially, the original NUMA balancing implementation
selects and promote the mostly recently accessed (MRU) pages.  But the
recently accessed pages may be cold.  So in this patchset, we
implement a new hot page identification algorithm based on the latency
between NUMA balancing page table scanning and hint page fault.

And the hot page promotion can incur some overhead in the system.  To
control the overhead a simple promotion rate limit mechanism is
implemented.

The hot threshold used to identify the hot pages is workload dependent
usually.  So we also implemented a hot threshold automatic adjustment
algorithm.  The basic idea is to increase/decrease the hot threshold
to make the number of pages that pass the hot threshold (promote
candidate) near the rate limit.

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

Best Regards,
Huang, Ying
