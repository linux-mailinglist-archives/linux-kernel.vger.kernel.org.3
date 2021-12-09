Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2346E9E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhLIO1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:27:18 -0500
Received: from foss.arm.com ([217.140.110.172]:57458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhLIO1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:27:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D881D1FB;
        Thu,  9 Dec 2021 06:23:43 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8667B3F73B;
        Thu,  9 Dec 2021 06:23:42 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs
In-Reply-To: <20211206151206.GH3366@techsingularity.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net> <20211201151844.20488-3-mgorman@techsingularity.net> <20211204104056.GR16608@worktop.programming.kicks-ass.net> <20211206151206.GH3366@techsingularity.net>
Date:   Thu, 09 Dec 2021 14:23:40 +0000
Message-ID: <87y24t97rn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/21 15:12, Mel Gorman wrote:
> Gautham had similar reasoning to calculate the imbalance at each
> higher-level domain instead of using a static value throughout and
> it does make sense. For each level and splitting the imbalance between
> two domains, this works out as
>
>
>       /*
>        * Calculate an allowed NUMA imbalance such that LLCs do not get
>        * imbalanced.
>        */
>       for_each_cpu(i, cpu_map) {
>               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
>                       struct sched_domain *child = sd->child;
>
>                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
>                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
>                               struct sched_domain *top = sd;
>                               unsigned int llc_sq;
>
>                               /*
>                                * nr_llcs = (top->span_weight / llc_weight);
>                                * imb = (child_weight / nr_llcs) >> 1
>                                *
>                                * is equivalent to
>                                *
>                                * imb = (llc_weight^2 / top->span_weight) >> 1
>                                *
>                                */
>                               llc_sq = child->span_weight * child->span_weight;
>                               while (top) {
>                                       top->imb_numa_nr = max(1U,
>                                               (llc_sq / top->span_weight) >> 1);
>                                       top = top->parent;
>                               }
>
>                               break;
>                       }
>               }
>       }
>

IIRC Peter suggested punting that logic to before domains get degenerated,
but I don't see how that helps here. If you just want to grab the LLC
domain (aka highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES)) and compare
its span with that of its parents, that can happen after the degeneration,
no?

> I'll test this and should have results tomorrow.
>
> --
> Mel Gorman
> SUSE Labs
