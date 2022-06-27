Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0555E179
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiF0NrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbiF0NrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:47:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C301A5FE6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:47:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E7C175A;
        Mon, 27 Jun 2022 06:47:19 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251923F5A1;
        Mon, 27 Jun 2022 06:47:19 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:47:17 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 18/20] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
Message-ID: <Yrm05bAzu6c29XXB@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
 <20220621192034.3332546-19-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621192034.3332546-19-sudeep.holla@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 Jun 2022 at 20:20:32 (+0100), Sudeep Holla wrote:
> Let us set the cluster identifier as parsed from the device tree
> cluster nodes within /cpu-map.
> 
> We don't support nesting of clusters yet as there are no real hardware
> to support clusters of clusters.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 39be5dbaf4da..75604f783bfc 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -497,7 +497,7 @@ static int __init get_cpu_for_node(struct device_node *node)
>  }
>  
>  static int __init parse_core(struct device_node *core, int package_id,
> -			     int core_id)
> +			     int cluster_id, int core_id)
>  {
>  	char name[20];
>  	bool leaf = true;
> @@ -513,6 +513,7 @@ static int __init parse_core(struct device_node *core, int package_id,
>  			cpu = get_cpu_for_node(t);
>  			if (cpu >= 0) {
>  				cpu_topology[cpu].package_id = package_id;
> +				cpu_topology[cpu].cluster_id = cluster_id;
>  				cpu_topology[cpu].core_id = core_id;
>  				cpu_topology[cpu].thread_id = i;
>  			} else if (cpu != -ENODEV) {
> @@ -534,6 +535,7 @@ static int __init parse_core(struct device_node *core, int package_id,
>  		}
>  
>  		cpu_topology[cpu].package_id = package_id;
> +		cpu_topology[cpu].cluster_id = cluster_id;
>  		cpu_topology[cpu].core_id = core_id;
>  	} else if (leaf && cpu != -ENODEV) {
>  		pr_err("%pOF: Can't get CPU for leaf core\n", core);
> @@ -543,7 +545,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>  	return 0;
>  }
>  
> -static int __init parse_cluster(struct device_node *cluster, int depth)
> +static int __init
> +parse_cluster(struct device_node *cluster, int cluster_id, int depth)
>  {
>  	char name[20];
>  	bool leaf = true;
> @@ -563,7 +566,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  		c = of_get_child_by_name(cluster, name);
>  		if (c) {
>  			leaf = false;
> -			ret = parse_cluster(c, depth + 1);
> +			ret = parse_cluster(c, i, depth + 1);
>  			of_node_put(c);
>  			if (ret != 0)
>  				return ret;
> @@ -587,7 +590,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  			}
>  
>  			if (leaf) {
> -				ret = parse_core(c, 0, core_id++);
> +				ret = parse_core(c, 0, cluster_id, core_id++);
>  			} else {
>  				pr_err("%pOF: Non-leaf cluster with core %s\n",
>  				       cluster, name);
> @@ -626,7 +629,7 @@ static int __init parse_dt_topology(void)
>  	if (!map)
>  		goto out;
>  
> -	ret = parse_cluster(map, 0);
> +	ret = parse_cluster(map, -1, 0);
>  	if (ret != 0)
>  		goto out_map;
>  
> -- 
> 2.36.1
> 

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks,
Ionela.
