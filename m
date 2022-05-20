Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F7A52EF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350847AbiETP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345085AbiETP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:27:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A95EE3C706
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:27:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5549B1477;
        Fri, 20 May 2022 08:27:11 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E43C3F73D;
        Fri, 20 May 2022 08:27:09 -0700 (PDT)
Date:   Fri, 20 May 2022 16:27:02 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/8] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
Message-ID: <20220520152702.ge3uxmizwljsg6mr@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-4-sudeep.holla@arm.com>
 <YoZ2gjjS3rbRaJZm@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YoZ2gjjS3rbRaJZm@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:55:30PM +0100, Ionela Voinescu wrote:
> Hi,
> 
> As said before, this creates trouble for CONFIG_SCHED_CLUSTER=y.
> The output below is obtained from Juno.
> 
> When cluster_id is populated, a new CLS level is created by the scheduler
> topology code. In this case the clusters in DT determine that the cluster
> siblings and llc siblings are the same so the MC scheduler domain will
> be removed and, for Juno, only CLS and DIE will be kept.
>

Yes I have seen that. 

1. Will that differ with ACPI on juno ?

2. Is that a problem ? I mean we are fixing those masks that are user
visible with this series and if using them as is in sched domain is
incorrect or not sufficient, we need to fix that. We can't change these
masks.

> root@debian-arm64-buster:/sys/kernel/debug/sched/domains/cpu1# grep . */*
> domain0/busy_factor:16
> domain0/cache_nice_tries:1
> domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
> domain0/imbalance_pct:117
> domain0/max_interval:4
> domain0/max_newidle_lb_cost:14907
> domain0/min_interval:2
> domain0/name:CLS
> domain1/busy_factor:16
> domain1/cache_nice_tries:1
> domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_ASYM_CPUCAPACITY SD_ASYM_CPUCAPACITY_FULL SD_PREFER_SIBLING
> domain1/imbalance_pct:117
> domain1/max_interval:12
> domain1/max_newidle_lb_cost:11858
> domain1/min_interval:6
> domain1/name:DIE
> 
> To be noted that we also get a new flag SD_PREFER_SIBLING for the CLS
> level that is not appropriate. We usually remove it for the child of a
> SD_ASYM_CPUCAPACITY domain, but we don't currently redo this after some
> levels are degenerated. This is a fixable issue.
>

OK good.

> But looking at the bigger picture, a good question is what is the best
> thing to do when cluster domains and llc domains span the same CPUs?
>

Indeed, I will leave that to scheduler experts 😉. My main goal is to get
the topology masks that are user visible right and keeping current behavior
intact.

> Possibly it would be best to restrict clusters (which are almost an
> arbitrary concept) to always span a subset of CPUs of the llc domain,
> if llc siblings can be obtained? If those clusters are not properly set
> up in DT to respect this condition, cluster_siblings would need to be
> cleared (or set to the current CPU) so the CLS domain is not created at
> all.
>

Yes, we already have all these complex conditions in cpu_coregroup_mask.
Why not do something similar in cpu_clustergroup_mask ?

> Additionally, should we use cluster information from DT (cluster_id) to
> create an MC level if we don't have llc information, even if
> CONFIG_SCHED_CLUSTER=n?
>

I don't know. We have all the topology and llc info now, we need to decide
how to present them to scheduler.

> I currently don't have a very clear picture of how cluster domains and
> llc domains would "live" together in a variety of topologies. I'll try
> other DT topologies to see if there are others that can lead to trouble.
>

Me neither. I avoided these changes for years because of such complex
questions but that is wrong reason to, as the user visible topology has
now diverged from ACPI once(people who complained about user space breakage
cared only about ACPI) and we need to bring them in parity soon IMO.

-- 
Regards,
Sudeep
