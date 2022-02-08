Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D194AD64A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiBHLXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355737AbiBHJxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:53:01 -0500
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 01:52:59 PST
Received: from outbound-smtp30.blacknight.com (outbound-smtp30.blacknight.com [81.17.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA07BC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:52:59 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 9BB69BAFE4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:43:45 +0000 (GMT)
Received: (qmail 1402 invoked from network); 8 Feb 2022 09:43:45 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 8 Feb 2022 09:43:45 -0000
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
        K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v6 0/2] Adjust NUMA imbalance for multiple LLCs
Date:   Tue,  8 Feb 2022 09:43:32 +0000
Message-Id: <20220208094334.16379-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog sinve v5
o Fix off-by-one error

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

