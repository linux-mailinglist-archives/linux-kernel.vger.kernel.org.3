Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252AA4A86E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351446AbiBCOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:47:14 -0500
Received: from outbound-smtp58.blacknight.com ([46.22.136.242]:45599 "EHLO
        outbound-smtp58.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351433AbiBCOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:47:05 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id 0943AFA96F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 14:47:04 +0000 (GMT)
Received: (qmail 1203 invoked from network); 3 Feb 2022 14:47:03 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 3 Feb 2022 14:47:03 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v5 0/2] Adjust NUMA imbalance for multiple LLCs
Date:   Thu,  3 Feb 2022 14:46:50 +0000
Message-Id: <20220203144652.12540-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since V4
o Scale imbalance based on the top domain that prefers siblings
o Keep allowed imbalance as 2 up to the point where LLCs can be overloaded

Changelog since V3
o Calculate imb_numa_nr for multiple SD_NUMA domains
o Restore behaviour where communicating pairs remain on the same node

Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
nodes") allowed an imbalance between NUMA nodes such that communicating
tasks would not be pulled apart by the load balancer. This works fine when
there is a 1:1 relationship between LLC and node but can be suboptimal
for multiple LLCs if independent tasks prematurely use CPUs sharing cache.

The series addresses two problems -- inconsistent logic when allowing a
NUMA imbalance and sub-optimal performance when there are many LLCs per
NUMA node.

 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 30 ++++++++++---------
 kernel/sched/topology.c        | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 13 deletions(-)

-- 
2.31.1

Mel Gorman (2):
  sched/fair: Improve consistency of allowed NUMA balance calculations
  sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans
    multiple LLCs

 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 30 ++++++++++---------
 kernel/sched/topology.c        | 53 ++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 13 deletions(-)

-- 
2.31.1

