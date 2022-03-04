Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9199A4CD497
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiCDM5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:57:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6CA81567B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:56:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E072143D;
        Fri,  4 Mar 2022 04:56:52 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30EEE3F70D;
        Fri,  4 Mar 2022 04:56:51 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>, peterz@infradead.org
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/topology: Remove redundant variable and fix incorrect type in build_sched_domains
In-Reply-To: <20220218162743.1134-1-kprateek.nayak@amd.com>
References: <20220218162743.1134-1-kprateek.nayak@amd.com>
Date:   Fri, 04 Mar 2022 12:56:44 +0000
Message-ID: <87k0d9510z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/22 21:57, K Prateek Nayak wrote:
> While investigating the sparse warning reported by the LKP bot [1],
> observed that we have a redundant variable "top" in the function
> build_sched_domains that was introduced in the recent commit
> e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when
> SD_NUMA spans multiple LLCs")
>
> The existing variable "sd" suffices which allows us to remove the
> redundant variable "top" while annotating the other variable "top_p"
> with the "__rcu" annotation to silence the sparse warning.
>
> [1] https://lore.kernel.org/lkml/202202170853.9vofgC3O-lkp@intel.com/
>
> Fixes: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/topology.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index e6cd55951304..4b757fb8f661 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2255,7 +2255,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>
>                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
>                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> -				struct sched_domain *top, *top_p;
> +				struct sched_domain __rcu *top_p;
>                               unsigned int nr_llcs;
>
>                               /*
> @@ -2280,11 +2280,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>                               sd->imb_numa_nr = imb;
>
>                               /* Set span based on the first NUMA domain. */
> -				top = sd;
> -				top_p = top->parent;
> +				top_p = sd->parent;
>                               while (top_p && !(top_p->flags & SD_NUMA)) {
> -					top = top->parent;
> -					top_p = top->parent;
> +					top_p = top_p->parent;
>                               }
>                               imb_span = top_p ? top_p->span_weight : sd->span_weight;


So sd starts as the first domain without SD_SHARE_PKG_RESOURCES (but its
direct child has it), and the loop searches upward for a NUMA domain. This
indeed shouldn't require two variables.

I was going to say that while you're at it, you could init top_p to sd
rather than sd->parent in case someone runs a non-default
sched_domain_topology[], but NODE should have neither
SD_SHARE_PKG_RESOURCES nor SD_NUMA, so that doesn't seem required.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>                       } else {
> --
> 2.25.1
