Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8152B87E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiERLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiERLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:15:49 -0400
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E0B38D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:15:42 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 1C47F1A64
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:15:41 +0100 (IST)
Received: (qmail 4693 invoked from network); 18 May 2022 11:15:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 May 2022 11:15:40 -0000
Date:   Wed, 18 May 2022 12:15:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Adjust imb_numa_nr to a better
 approximation of memory channels
Message-ID: <20220518111539.GP3441@techsingularity.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-5-mgorman@techsingularity.net>
 <20220518094112.GE10117@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220518094112.GE10117@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:41:12AM +0200, Peter Zijlstra wrote:
> On Wed, May 11, 2022 at 03:30:38PM +0100, Mel Gorman wrote:
> > For a single LLC per node, a NUMA imbalance is allowed up until 25%
> > of CPUs sharing a node could be active. One intent of the cut-off is
> > to avoid an imbalance of memory channels but there is no topological
> > information based on active memory channels. Furthermore, there can
> > be differences between nodes depending on the number of populated
> > DIMMs.
> > 
> > A cut-off of 25% was arbitrary but generally worked. It does have a severe
> > corner cases though when an parallel workload is using 25% of all available
> > CPUs over-saturates memory channels. This can happen due to the initial
> > forking of tasks that get pulled more to one node after early wakeups
> > (e.g. a barrier synchronisation) that is not quickly corrected by the
> > load balancer. The LB may fail to act quickly as the parallel tasks are
> > considered to be poor migrate candidates due to locality or cache hotness.
> > 
> > On a range of modern Intel CPUs, 12.5% appears to be a better cut-off
> > assuming all memory channels are populated and is used as the new cut-off
> > point. A minimum of 1 is specified to allow a communicating pair to
> > remain local even for CPUs with low numbers of cores. For modern AMDs,
> > there are multiple LLCs and are not affected.
> 
> Can the hardware tell us about memory channels?

It's in the SMBIOS table somewhere as it's available via dmidecode. For
example, on a 2-socket machine;

$ dmidecode -t memory | grep -E "Size|Bank"
        Size: 8192 MB
        Bank Locator: P0_Node0_Channel0_Dimm0
        Size: No Module Installed
        Bank Locator: P0_Node0_Channel0_Dimm1
        Size: 8192 MB
        Bank Locator: P0_Node0_Channel1_Dimm0
        Size: No Module Installed
        Bank Locator: P0_Node0_Channel1_Dimm1
        Size: 8192 MB
        Bank Locator: P0_Node0_Channel2_Dimm0
        Size: No Module Installed
        Bank Locator: P0_Node0_Channel2_Dimm1
        Size: 8192 MB
        Bank Locator: P0_Node0_Channel3_Dimm0
        Size: No Module Installed
        Bank Locator: P0_Node0_Channel3_Dimm1
        Size: 8192 MB
        Bank Locator: P1_Node1_Channel0_Dimm0
        Size: No Module Installed
        Bank Locator: P1_Node1_Channel0_Dimm1
        Size: 8192 MB
        Bank Locator: P1_Node1_Channel1_Dimm0
        Size: No Module Installed
        Bank Locator: P1_Node1_Channel1_Dimm1
        Size: 8192 MB
        Bank Locator: P1_Node1_Channel2_Dimm0
        Size: No Module Installed
        Bank Locator: P1_Node1_Channel2_Dimm1
        Size: 8192 MB
        Bank Locator: P1_Node1_Channel3_Dimm0
        Size: No Module Installed
        Bank Locator: P1_Node1_Channel3_Dimm1

SMBIOUS contains the information on number of channels and whether they
are populated with at least one DIMM.

I'm not aware of how it can be done in-kernel on a cross architectural
basis. Reading through the arch manual, it states how many channels are
in a given processor family and it's available during memory check errors
(apparently via the EDAC driver). It's sometimes available via PMUs but
I couldn't find a place where it's generically available for topology.c
that would work on all x86-64 machines let alone every other architecture.

It's not even clear if SMBIOS was parsed in early boot whether it's a
good idea. It could result in difference imbalance thresholds for each
NUMA domain or weird corner cases where assymetric NUMA node populations
would result in run-to-run variance that are difficult to analyse.

-- 
Mel Gorman
SUSE Labs
