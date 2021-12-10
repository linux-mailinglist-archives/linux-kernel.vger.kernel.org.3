Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0A46FDCF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbhLJJgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:36:54 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:59477 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhLJJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:36:53 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 22A601C3E4E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:33:18 +0000 (GMT)
Received: (qmail 8451 invoked from network); 10 Dec 2021 09:33:17 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPA; 10 Dec 2021 09:33:17 -0000
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
Subject: [PATCH v4 0/2] Adjust NUMA imbalance for multiple LLCs
Date:   Fri, 10 Dec 2021 09:33:05 +0000
Message-Id: <20211210093307.31701-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since V3
o Calculate imb_numa_nr for multiple SD_NUMA domains
o Restore behaviour where communicating pairs remain on the same node

Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
nodes") allowed an imbalance between NUMA nodes such that communicating
tasks would not be pulled apart by the load balancer. This works fine when
there is a 1:1 relationship between LLC and node but can be suboptimal
for multiple LLCs if independent tasks prematurely use CPUs sharing cache.

The series addresses two problems -- inconsistent use of scheduler domain
weights and sub-optimal performance when there are many LLCs per NUMA node.

 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 36 ++++++++++++++++---------------
 kernel/sched/topology.c        | 39 ++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 17 deletions(-)

-- 
2.31.1

Mel Gorman (2):
  sched/fair: Use weight of SD_NUMA domain in find_busiest_group
  sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans
    multiple LLCs

 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 36 +++++++++++++++++----------------
 kernel/sched/topology.c        | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 17 deletions(-)

-- 
2.31.1

