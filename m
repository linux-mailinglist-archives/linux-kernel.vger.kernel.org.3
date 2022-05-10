Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308F522255
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347986AbiEJR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347964AbiEJRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:25:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE3FF4616F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:21:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 299B212FC;
        Tue, 10 May 2022 10:21:58 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27B933F73D;
        Tue, 10 May 2022 10:21:56 -0700 (PDT)
Message-ID: <f7d6d1ec-e95d-9c7a-db7c-e1445f6ff8fe@arm.com>
Date:   Tue, 10 May 2022 19:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arch_topology: support parsing cluster_id from DT
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1651739735-51884-1-git-send-email-wangqing@vivo.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <1651739735-51884-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2022 10:35, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Use nested cluster structures in DT to support describing multi-level
> cluster topologies.
> 
> Notice: the clusters describing in DT currently are not physical
> boundaries, since changing "cluster" to "socket" is too involved and error
> prone, this patch will not have any effect on one-level cluster topo, but
> can support the mutil-level cluster topo to support CLUSTER_SCHED.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/base/arch_topology.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1d6636ebaac5..f2ea8113d619 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -491,7 +491,7 @@ static int __init get_cpu_for_node(struct device_node *node)
>  }
>  
>  static int __init parse_core(struct device_node *core, int package_id,
> -			     int core_id)
> +			     int cluster_id, int core_id)
>  {
>  	char name[20];
>  	bool leaf = true;
> @@ -507,6 +507,7 @@ static int __init parse_core(struct device_node *core, int package_id,
>  			cpu = get_cpu_for_node(t);
>  			if (cpu >= 0) {
>  				cpu_topology[cpu].package_id = package_id;
> +				cpu_topology[cpu].cluster_id = cluster_id;
>  				cpu_topology[cpu].core_id = core_id;
>  				cpu_topology[cpu].thread_id = i;
>  			} else if (cpu != -ENODEV) {
> @@ -528,6 +529,7 @@ static int __init parse_core(struct device_node *core, int package_id,
>  		}
>  
>  		cpu_topology[cpu].package_id = package_id;
> +		cpu_topology[cpu].cluster_id = cluster_id;
>  		cpu_topology[cpu].core_id = core_id;
>  	} else if (leaf && cpu != -ENODEV) {
>  		pr_err("%pOF: Can't get CPU for leaf core\n", core);
> @@ -544,13 +546,15 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  	bool has_cores = false;
>  	struct device_node *c;
>  	static int package_id __initdata;
> +	static int cluster_id __initdata;

Starting with cluster_id = 0 breaks existing platforms like
./arch/arm64/boot/dts/arm/juno.dts. For them it has to be still set to -1.

You get e.g.:

# cat /sys/kernel/debug/sched/domains/cpu1/domain*/name
CLS
DIE

instead of:

# cat /sys/kernel/debug/sched/domains/cpu1/domain*/name
MC
DIE


>  	int core_id = 0;
>  	int i, ret;
>  
>  	/*
> -	 * First check for child clusters; we currently ignore any
> -	 * information about the nesting of clusters and present the
> -	 * scheduler with a flat list of them.
> +	 * nesting of clusters :
> +	 * level 1:  package_id
> +	 * level 2:  cluster_id
> +	 * level 3+: ignore
>  	 */
>  	i = 0;
>  	do {
> @@ -559,6 +563,14 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  		if (c) {
>  			leaf = false;
>  			ret = parse_cluster(c, depth + 1);
> +			if (depth == 0) {
> +				package_id++;
> +				cluster_id = 0;

-                               cluster_id = 0;
+                               cluster_id = -1;

Would have to be cluster_id = -1. 0 is a valid 2. level cluster.
Otherwise you're not removing the CLS data from CPU4 to CPU7 in the
`Armv9 with L2 complexes` cpu-map example I used for testing:

                cpu-map {
                        cluster0 {
                                cluster0 {
                                        core0 {
                                                cpu = <&cpu0>;
                                        };
                                        core1 {
                                                cpu = <&cpu1>;
                                        };
                                };
                                cluster1 {
                                        core0 {
                                                cpu = <&cpu2>;
                                        };
                                        core1 {
                                                cpu = <&cpu3>;
                                        };
                                };
                        };
                        cluster1 {
                                core0 {
                                        cpu = <&cpu4>;
                                };
                                core1 {
                                        cpu = <&cpu5>;
                                };
                                core2 {
                                        cpu = <&cpu6>;
                                };
                        };
                        cluster2 {
                                core0 {
                                        cpu = <&cpu7>;
                                };
                        };
                };

> +			} else if (depth == 1)
> +				cluster_id++;
> +			else
> +				pr_err("Ignore nested clusters with more than two levels!\n");
> +
>  			of_node_put(c);
>  			if (ret != 0)
>  				return ret;
> @@ -582,7 +594,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  			}
>  
>  			if (leaf) {
> -				ret = parse_core(c, package_id, core_id++);
> +				ret = parse_core(c, package_id, cluster_id, core_id++);
>  			} else {
>  				pr_err("%pOF: Non-leaf cluster with core %s\n",
>  				       cluster, name);
> @@ -599,9 +611,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  	if (leaf && !has_cores)
>  		pr_warn("%pOF: empty cluster\n", cluster);
>  
> -	if (leaf)
> -		package_id++;
> -
>  	return 0;
>  }

Looks like you also need to adapt update_siblings_masks() to only set
cpu in &cpu_topo->thread_sibling and &cpuid_topo->thread_sibling when
`cpu_topo->thread_id != -1`.

@@ -723,11 +723,11 @@ void update_siblings_masks(unsigned int cpuid)
                cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
                cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);

-               if (cpuid_topo->core_id != cpu_topo->core_id)
-                       continue;
-
-               cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
-               cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
+               if (cpu_topo->thread_id != -1 &&
+                   cpuid_topo->core_id == cpu_topo->core_id) {
+                       cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
+                       cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
+
