Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD450A4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390280AbiDUPuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390238AbiDUPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:50:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD047042
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F5E4B82427
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA43C385A5;
        Thu, 21 Apr 2022 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650556041;
        bh=Uaoqnie8OAKSS5JhtAHDeECBBZtTUrH3geqVgrx+PzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5YXjDbu2F3/EGg/6DRX5jZs5ZSgCDBkRWf65tjojzq7MtYfh3Ic7E+kGBvYz82x3
         DcgvQZTfcm0gVtl9yDOObThYtqYmdKER/5tLxZDVhZXTbQ+yn8PTy0JfCf/WJ4fhn7
         ak2bGUHnqAm5JdxT9E+qoAA4q7XeDD8jnZ7hn1Og=
Date:   Thu, 21 Apr 2022 17:47:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arch_topology: support for describing cache topology
 from DT
Message-ID: <YmF8hjjWUzRMAv5l@kroah.com>
References: <1650552960-60165-1-git-send-email-wangqing@vivo.com>
 <1650552960-60165-2-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650552960-60165-2-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 07:55:57AM -0700, Qing Wang wrote:
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
> cache_topology hold the pointer describing "next-level-cache", 
> it can describe the cache topology of every level.
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
> +staic struct device_node *cache_topology[NR_CPUS][MAX_CACHE_LEVEL];
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
> +}
> +
> +/*
> + * find the maximum level shared cache under giving mask
> + */
> +void find_max_sub_sc(const struct cpumask *giving_mask, int cpu,
> +					  struct cpumask *sc_mask)

This is not a good global function name.  No one will know what this
means when they read it.  Please make it make more sense.

thanks,

greg k-h
