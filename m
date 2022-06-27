Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A943655D34B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiF0Nnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiF0Nnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:43:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1389F2722
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:43:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17BF6175A;
        Mon, 27 Jun 2022 06:43:50 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DD093F5A1;
        Mon, 27 Jun 2022 06:43:49 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:43:47 +0100
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
Subject: Re: [PATCH v4 15/20] arch_topology: Don't set cluster identifier as
 physical package identifier
Message-ID: <Yrm0E3mFHvJ5Nkgt@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
 <20220621192034.3332546-16-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621192034.3332546-16-sudeep.holla@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 Jun 2022 at 20:20:29 (+0100), Sudeep Holla wrote:
> Currently as we parse the CPU topology from /cpu-map node from the
> device tree, we assign generated cluster count as the physical package
> identifier for each CPU which is wrong.
> 
> The device tree bindings for CPU topology supports sockets to infer
> the socket or physical package identifier for a given CPU. Since it is
> fairly new and not support on most of the old and existing systems, we
                     ^^^^^^^
Nit:		     supported
> can assume all such systems have single socket/physical package.
> 
> Fix the physical package identifier to 0 by removing the assignment of
> cluster identifier to the same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>

Thanks,
Ionela.

> ---
>  drivers/base/arch_topology.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 7a569aefe313..46fa1b70b02b 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -549,7 +549,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  	bool leaf = true;
>  	bool has_cores = false;
>  	struct device_node *c;
> -	static int package_id __initdata;
>  	int core_id = 0;
>  	int i, ret;
>  
> @@ -588,7 +587,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  			}
>  
>  			if (leaf) {
> -				ret = parse_core(c, package_id, core_id++);
> +				ret = parse_core(c, 0, core_id++);
>  			} else {
>  				pr_err("%pOF: Non-leaf cluster with core %s\n",
>  				       cluster, name);
> @@ -605,9 +604,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  	if (leaf && !has_cores)
>  		pr_warn("%pOF: empty cluster\n", cluster);
>  
> -	if (leaf)
> -		package_id++;
> -
>  	return 0;
>  }
>  
> -- 
> 2.36.1
> 
