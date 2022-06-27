Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1555C7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiF0Nsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiF0Nr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:47:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA4B26315
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:47:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95BE1758;
        Mon, 27 Jun 2022 06:47:55 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B5263F5A1;
        Mon, 27 Jun 2022 06:47:55 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:47:53 +0100
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
Subject: Re: [PATCH v4 19/20] arch_topology: Add support for parsing sockets
 in /cpu-map
Message-ID: <Yrm1CbXzgj4uowOV@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
 <20220621192034.3332546-20-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621192034.3332546-20-sudeep.holla@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 Jun 2022 at 20:20:33 (+0100), Sudeep Holla wrote:
> Finally let us add support for socket nodes in /cpu-map in the device
> tree. Since this may not be present in all the old platforms and even
> most of the existing platforms, we need to assume absence of the socket
> node indicates that it is a single socket system and handle appropriately.
> 
> Also it is likely that most single socket systems skip to as the node
> since it is optional.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 37 +++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 75604f783bfc..ed1cb64a95aa 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -545,8 +545,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>  	return 0;
>  }
>  
> -static int __init
> -parse_cluster(struct device_node *cluster, int cluster_id, int depth)
> +static int __init parse_cluster(struct device_node *cluster, int package_id,
> +				int cluster_id, int depth)
>  {
>  	char name[20];
>  	bool leaf = true;
> @@ -566,7 +566,7 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
>  		c = of_get_child_by_name(cluster, name);
>  		if (c) {
>  			leaf = false;
> -			ret = parse_cluster(c, i, depth + 1);
> +			ret = parse_cluster(c, package_id, i, depth + 1);
>  			of_node_put(c);
>  			if (ret != 0)
>  				return ret;
> @@ -590,7 +590,8 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
>  			}
>  
>  			if (leaf) {
> -				ret = parse_core(c, 0, cluster_id, core_id++);
> +				ret = parse_core(c, package_id, cluster_id,
> +						 core_id++);
>  			} else {
>  				pr_err("%pOF: Non-leaf cluster with core %s\n",
>  				       cluster, name);
> @@ -610,6 +611,32 @@ parse_cluster(struct device_node *cluster, int cluster_id, int depth)
>  	return 0;
>  }
>  
> +static int __init parse_socket(struct device_node *socket)
> +{
> +	char name[20];
> +	struct device_node *c;
> +	bool has_socket = false;
> +	int package_id = 0, ret;
> +
> +	do {
> +		snprintf(name, sizeof(name), "socket%d", package_id);
> +		c = of_get_child_by_name(socket, name);
> +		if (c) {
> +			has_socket = true;
> +			ret = parse_cluster(c, package_id, -1, 0);
> +			of_node_put(c);
> +			if (ret != 0)
> +				return ret;
> +		}
> +		package_id++;
> +	} while (c);
> +
> +	if (!has_socket)
> +		ret = parse_cluster(socket, 0, -1, 0);
> +
> +	return ret;
> +}
> +
>  static int __init parse_dt_topology(void)
>  {
>  	struct device_node *cn, *map;
> @@ -629,7 +656,7 @@ static int __init parse_dt_topology(void)
>  	if (!map)
>  		goto out;
>  
> -	ret = parse_cluster(map, -1, 0);
> +	ret = parse_socket(map);
>  	if (ret != 0)
>  		goto out_map;
>  
> -- 
> 2.36.1
> 

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks,
Ionela.
