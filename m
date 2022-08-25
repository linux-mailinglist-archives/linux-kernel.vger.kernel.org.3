Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA3F5A1CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbiHYWtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiHYWtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:49:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9754C6B7F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661467780; x=1693003780;
  h=from:to:cc:subject:date:message-id;
  bh=tLbNGU4RI2JTJAIEeBbwGScjf3qo7q5qkLaLflr2WFo=;
  b=PZMzS/2ObYERrUH5dxTB/Yf9AYorUMYAW50cr7MCtLnL6+R8hMMC+b4E
   jIMG3r0eseF+mAgRDAB+5BXPkCCqro5P0m91iG/PRVNoxtZCd7GS5RT0d
   qqgUsSBOQjtkMO3cjdnyYvZd7I/GKP3SFARHNBI10lmvFvfGAWrXRRhVf
   B34Jb2+thJSKN4t14IfIOWfVxnyLUSVoW/Tt8gT/Jy1ajlyPSJLrWrN4W
   vXvxzo8OplezW6godfuwlYLjOR2741nSxjSh8HJk8ZyMJQeOM9hrQvlpo
   Rydk9BlHYAJ5DrGZgWUEqAcXujrJBsujYtLpm1hF0IAPpX9/H9015bOny
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295153913"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295153913"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 15:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="678642670"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2022 15:49:40 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/4] sched/fair: Avoid unnecessary migrations within SMT domains
Date:   Thu, 25 Aug 2022 15:55:25 -0700
Message-Id: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel processors that support Intel Turbo Boost Max 3.0 use asym_packing
to assign higher priorities to CPUs with higher maximum frequencies. It
artificially assigns, however, a lower priority to the higher-numbered
SMT siblings to ensure that they are used last.

This results in unnecessary task migrations within the SMT domains.

On processors with a mixture of higher-frequency SMT cores and lower-
frequency non-SMT cores (such as Intel hybrid processors), a lower-
priority CPU pulls tasks from the higher-priority cores if more than one
SMT sibling is busy.

Do not use different priorities for each SMT sibling. Instead, tweak the
asym_packing load balancer to recognize SMT cores with more than one
busy sibling and let lower-priority CPUs pull tasks.

Removing these artificial priorities avoids superfluous migrations and
lets lower-priority cores inspect all SMT siblings for the busiest queue.

Thanks and BR,
Ricardo

Ricardo Neri (4):
  sched/fair: Simplify asym_packing logic for SMT sched groups
  sched/fair: Do not disqualify either runqueues of SMT sched groups
  sched/fair: Let lower-priority CPUs do active balancing
  x86/sched: Avoid unnecessary migrations within SMT domains

 arch/x86/kernel/itmt.c | 23 +++++-----------------
 kernel/sched/fair.c    | 44 ++++++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 41 deletions(-)

-- 
2.25.1

