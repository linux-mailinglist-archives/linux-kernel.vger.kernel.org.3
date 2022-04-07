Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F34F89E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiDGUfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiDGUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:35:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D65B2A3DBD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:20:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F47112FC;
        Thu,  7 Apr 2022 12:42:55 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB223F718;
        Thu,  7 Apr 2022 12:42:53 -0700 (PDT)
Message-ID: <84bd8d25-979b-42d7-a809-379454537806@arm.com>
Date:   Thu, 7 Apr 2022 21:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arch_topology: support parsing cache topology from DT
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     wangqing <11112896@bbktel.com>
References: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 11:18, Qing Wang wrote:
> From: wangqing <11112896@bbktel.com>

[...]

> +void init_cpu_cache_topology(void)
> +{
> +	struct device_node *node_cpu, *node_cache;
> +	int cpu;
> +	int level = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		node_cpu = of_get_cpu_node(cpu, NULL);
> +		if (!node_cpu)
> +			continue;
> +
> +		level = 0;
> +		node_cache = node_cpu;
> +		while (level < MAX_CACHE_LEVEL) {
> +			node_cache = of_parse_phandle(node_cache, "next-level-cache", 0);
> +			if (!node_cache)
> +				break;
> +
> +			cache_topology[cpu][level++] = node_cache;
> +		}
> +		of_node_put(node_cpu);
> +	}
> +}

From where is init_cpu_cache_topology() called?

> +bool cpu_share_llc(int cpu1, int cpu2)
> +{
> +	int cache_level;
> +
> +	for (cache_level = MAX_CACHE_LEVEL - 1; cache_level > 0; cache_level--) {
> +		if (!cache_topology[cpu1][cache_level])
> +			continue;
> +
> +		if (cache_topology[cpu1][cache_level] == cache_topology[cpu2][cache_level])
> +			return true;
> +
> +		return false;
> +	}
> +
> +	return false;
> +}

Like I mentioned in:

https://lkml.kernel.org/r/73b491fe-b5e8-ebca-081e-fa339cc903e1@arm.com

the correct setting in DT's cpu-map node (only core nodes in your case
(One DynamIQ cluster) will give you the correct LLC (highest
SD_SHARE_PKG_RESOURCES) setting.

https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/topology.txt

> +
> +bool cpu_share_l2c(int cpu1, int cpu2)
> +{
> +	if (!cache_topology[cpu1][0])
> +		return false;
> +
> +	if (cache_topology[cpu1][0] == cache_topology[cpu2][0])
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * cpu topology table
>   */
> @@ -662,7 +720,7 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>  		/* not numa in package, lets use the package siblings */
>  		core_mask = &cpu_topology[cpu].core_sibling;
>  	}
> -	if (cpu_topology[cpu].llc_id != -1) {
> +	if (cpu_topology[cpu].llc_id != -1 || cache_topology[cpu][0]) {
>  		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
>  			core_mask = &cpu_topology[cpu].llc_sibling;
>  	}
> @@ -684,7 +742,8 @@ void update_siblings_masks(unsigned int cpuid)
>  	for_each_online_cpu(cpu) {
>  		cpu_topo = &cpu_topology[cpu];
>  
> -		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
> +		if ((cpuid_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id)
> +			|| (cpuid_topo->llc_id == -1 && cpu_share_llc(cpu, cpuid))) {

Assuming a:

      .---------------.
CPU   |0 1 2 3 4 5 6 7|
      +---------------+
uarch |l l l l m m m b| (so called tri-gear: little, medium, big)
      +---------------+
  L2  |   |   | | | | |
      +---------------+
  L3  |<--         -->|
      +---------------+
      |<-- cluster -->|
      +---------------+
      |<--   DSU   -->|
      '---------------'

system, I guess you would get (w/ Phantom SD and L2/L3 cache info in DT):

CPU0 .. 3:

MC	   SD_SHARE_PKG_RESOURCES
DIE     no SD_SHARE_PKG_RESOURCES

CPU 4...7:

DIE     no SD_SHARE_PKG_RESOURCES

I can't see how this would make any sense ...

Reason is cpu_share_llc(). You don't check cache_level=0 and w/

CPU0 .. 3:
cache_topology[CPUX][0] == L2
cache_topology[CPUX][1] == L3

CPU4...7:
cache_topology[CPUX][0] == L3

there is, except for CPU0-1 and CPU2-3, no LLC match.

[...]
