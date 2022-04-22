Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF350B756
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447523AbiDVMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447548AbiDVMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A85714A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F7262016
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95024C385A4;
        Fri, 22 Apr 2022 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650630629;
        bh=l/UThzJt7EIh5W2gfH2rbyMyEURpsdabio8nxJX2/N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6+ZXnG4VO5fCl1Ebfighwz76rxZODtuBiM9HyI8n5LXwm2fvI9pn9cD3zGtogan8
         JC2XS1g4Drt9bmofls+4vWo1uygB7PcbG70TGUaK9aO/3LVa2XddVq47dUXmO30BYB
         NvmPSPoSi1AE59bfThsi+ZtMaCe+ZHe8ZMqNf7S0=
Date:   Fri, 22 Apr 2022 14:30:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 1/2] arch_topology: support for parsing cache topology
 from DT
Message-ID: <YmKf4rv7+NhhS1CY@kroah.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
 <1650628289-67716-2-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650628289-67716-2-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:51:25AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> When ACPI is not enabled, we can get cache topolopy from DT like:
> *		cpu0: cpu@000 {
> *			next-level-cache = <&L2_1>;
> *			L2_1: l2-cache {
> * 				compatible = "cache";
> *				next-level-cache = <&L3_1>;
> * 			};
> *			L3_1: l3-cache {
> * 				compatible = "cache";
> * 			};
> *		};
> *
> *		cpu1: cpu@001 {
> *			next-level-cache = <&L2_1>;
> *		};
> *		...
> *		};
> cache_topology[] hold the pointer describing by "next-level-cache", 
> which can describe the cache topology of every level.
> 
> MAX_CACHE_LEVEL is strictly corresponding to the cache level from L2.

I have no idea what this changelog means at all.

What are you trying to do?  What problem are you solving?  Why are you
doing any of this?


> 
> V2:
> make function name more sense

As per the documentation this goes below the --- line, right?


> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/base/arch_topology.c  | 47 ++++++++++++++++++++++++++++++++++-
>  include/linux/arch_topology.h |  3 +++
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1d6636ebaac5..46e84ce2ec0c 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -480,8 +480,10 @@ static int __init get_cpu_for_node(struct device_node *node)
>  		return -1;
>  
>  	cpu = of_cpu_node_to_id(cpu_node);
> -	if (cpu >= 0)
> +	if (cpu >= 0) {
>  		topology_parse_cpu_capacity(cpu_node, cpu);
> +		topology_parse_cpu_caches(cpu_node, cpu);
> +	}
>  	else
>  		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
>  			cpu_node, cpumask_pr_args(cpu_possible_mask));
> @@ -647,6 +649,49 @@ static int __init parse_dt_topology(void)
>  }
>  #endif
>  
> +/*
> + * cpu cache topology table
> + */
> +#define MAX_CACHE_LEVEL 7
> +static struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];

So for a normal big system of 4k cpus * 7 levels, that's a lot of
memory?  are you sure?

How big of a box did you test this on?

> +
> +void topology_parse_cpu_caches(struct device_node *cpu_node, int cpu)
> +{
> +	struct device_node *node_cache = cpu_node;
> +	int level = 0;
> +
> +	while (level < MAX_CACHE_LEVEL) {
> +		node_cache = of_parse_phandle(node_cache, "next-level-cache", 0);
> +		if (!node_cache)
> +			break;
> +
> +		cache_topology[cpu][level++] = node_cache;
> +	}

No locking anywhere?  What could go wrong :(

> +}
> +
> +/*
> + * find the largest subset of the shared cache in the range of cpu_mask
> + */
> +void find_subset_of_share_cache(const struct cpumask *cpu_mask, int cpu,
> +								 struct cpumask *sc_mask)

Again, horrid global function name.

And no kernel documentation for how this works?



> +{
> +	int cache_level, cpu_id;
> +
> +	for (cache_level = MAX_CACHE_LEVEL - 1; cache_level >= 0; cache_level--) {
> +		if (!cache_topology[cpu][cache_level])
> +			continue;

No locking???


> +
> +		cpumask_clear(sc_mask);
> +		for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
> +			if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level])
> +				cpumask_set_cpu(cpu_id, sc_mask);
> +		}
> +
> +		if (cpumask_subset(sc_mask, cpu_mask))
> +			break;
> +	}
> +}
> +
>  /*
>   * cpu topology table
>   */
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 58cbe18d825c..c6ed727e453c 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -93,6 +93,9 @@ void update_siblings_masks(unsigned int cpu);
>  void remove_cpu_topology(unsigned int cpuid);
>  void reset_cpu_topology(void);
>  int parse_acpi_topology(void);
> +void topology_parse_cpu_caches(struct device_node *cpu_node, int cpu);
> +void find_subset_of_share_cache(const struct cpumask *cpu_mask, int cpu,
> +								 struct cpumask *sc_mask);

I still have no idea what this last function is supposed to do.

And very odd indentation, did you run checkpatch on this?

totally confused,

greg k-h
