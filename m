Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653AD4E7C67
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiCYXxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCYXxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:53:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3926F10782B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648252326; x=1679788326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=77IUHLSyPMt7K3a2k8emt6dcESsi45dDNViiOz+hWtM=;
  b=gu6vyRKCLdXBl/RwbIWacyvvqR0mE/zdAL0LXz1zo9bosOeqvMbxNiAN
   5wOkyKWHhbzPTvf9ggc1eguRslAfIHk4/BqvbXOfpfKGXrL22/y1b3D5Y
   bWXUk+/SBKgjifFzYDQkvjfZBeG6Sumf0iAiFEbfDeK5uNsih6soFxv+T
   xqrOf2YCDliqNsfRvXpkwo4IBtVLDKyphGZqV7/kUTZT28nutCr9hwVf5
   npS9i/14Eal1tC+T1MXNuY2BRps5Hi4E7fz2TNCgbL52GWRq0XdkjZAgy
   AD2Vjmk3o8N+IMCpbZKXg7gmfevwC95+YONY1ASEwoaqYnIKj5i+lTifa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="321930136"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="321930136"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="648425289"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2022 16:52:05 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@elte.hu>, Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sched/fair: Fix starvation caused by task migration 
Date:   Fri, 25 Mar 2022 15:54:15 -0700
Message-Id: <cover.1648228023.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Walter Mack noticed during stress testing on 2 socket Sapphire Rapids
system, there were anomalies where tasks were starved for more
than 70 secs before getting scheduled.

The stress test scenario is an extreme case where about 50 threads
per CPU are started on each core.  Then each thread hops from
one core to another continuously.

We discussed this issue with Peter Z., who narrowed
things down to problem with vruntime setting of a migrated
task being too out of sync with the tasks on the target run queue.

Peter suggested the following two patches that did fix
the starvation anomalies that Walter saw.

Yu Chen also kicked the patches into our 0-day test infrastructure to
check for regressions.  The performance changes of note are below:

5.15        Throughput    5.15+patchest  Test
	    Changes       
4634070      -7.5%        4285823        stress-ng.sigsuspend.ops_per_sec
  29934     +37.0%          41006        aim7.jobs-per-min

Stress-ng sigsuspend is the worst affected.  But for most workloads,
they are not negatively impacted.  In fact, we saw 37% improvement
in Aim7 due to these patches.

Tim

Peter Zijlstra (1):
  sched/fair: Don't rely on ->exec_start for migration

Peter Zijlstra (Intel) (1):
  sched/fair: Simple runqueue order on migrate

 include/linux/sched.h   |  1 +
 kernel/sched/fair.c     | 37 +++++++++++++++++++++++++++++++++----
 kernel/sched/features.h |  2 ++
 3 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.32.0

