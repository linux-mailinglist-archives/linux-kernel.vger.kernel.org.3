Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA447BEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhLULcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:32:33 -0500
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:59954 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237139AbhLULcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:32:31 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 45382BAB0E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:32:30 +0000 (GMT)
Received: (qmail 18383 invoked from network); 21 Dec 2021 11:32:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Dec 2021 11:32:29 -0000
Date:   Tue, 21 Dec 2021 11:32:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Use weight of SD_NUMA domain in
 find_busiest_group
Message-ID: <20211221113227.GT3366@techsingularity.net>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-2-mgorman@techsingularity.net>
 <CAKfTPtDPu6r3dsSmY-ZDB0k4muoSk1a2J3=NKqoBG1y8aEwNYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDPu6r3dsSmY-ZDB0k4muoSk1a2J3=NKqoBG1y8aEwNYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 11:53:50AM +0100, Vincent Guittot wrote:
> On Fri, 10 Dec 2021 at 10:33, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > find_busiest_group uses the child domain's group weight instead of
> > the sched_domain's weight that has SD_NUMA set when calculating the
> > allowed imbalance between NUMA nodes. This is wrong and inconsistent
> > with find_idlest_group.
> 
> I agree that find_busiest_group and find_idlest_group should be
> consistent and use the same parameters but I wonder if sched_domain's
> weight is the right one to use instead of the target group's weight.
> 

Ok

> IIRC, the goal of adjust_numa_imbalance is to keep some threads on the
> same node as long as we consider that there is no performance impact
> because of sharing  resources as they can even take advantage of
> locality if they interact.

Yes.

> So we consider that tasks will not be
> impacted by sharing resources if they use less than 25% of the CPUs of
> a node. If we use the sd->span_weight instead, we consider that we can
> pack threads in the same node as long as it uses less than 25% of the
> CPUs in all nodes.
> 

I assume you mean the target group weight instead of the node. The
primary resource we are concerned with is memory bandwidth and it's a
guess because we do not know for sure where memory channels are or how
they are configured in this context and it may or may not be correlated
with groups. I think using the group instead would deserve a series on
its own after settling on an imbalance number when there are multiple
LLCs per node.

-- 
Mel Gorman
SUSE Labs
