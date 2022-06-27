Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23D55DB99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiF0Nmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiF0Nmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:42:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3FB02DCD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:42:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E7A1758;
        Mon, 27 Jun 2022 06:42:43 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29DB43F5A1;
        Mon, 27 Jun 2022 06:42:43 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:42:41 +0100
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
        linux-riscv@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 12/20] arch_topology: Set thread sibling cpumask only
 within the cluster
Message-ID: <Yrmz0ZAUaFCqMt5u@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
 <20220621192034.3332546-13-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621192034.3332546-13-sudeep.holla@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 Jun 2022 at 20:20:26 (+0100), Sudeep Holla wrote:
> Currently the cluster identifier is not set on the DT based platforms.
> The reset or default value is -1 for all the CPUs. Once we assign the
> cluster identifier values correctly that imay result in getting the thread
                                           ^^^^
Nit: 					   may
> siblings wrongs as the core identifiers can be same for 2 different CPUs
Nit:       ^^^^^^
	   wrong


Thanks,
Ionela.

> belonging to 2 different cluster.
> 
> So, in order to get the thread sibling cpumasks correct, we need to
> update them only if the cores they belong are in the same cluster within
> the socket. Let us skip updation of the thread sibling cpumaks if the
> cluster identifier doesn't match.
> 
> This change won't affect even if the cluster identifiers are not set
> currently but will avoid any breakage once we set the same correctly.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index b63cc52e12ce..7a5ff1ea5f00 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -708,15 +708,17 @@ void update_siblings_masks(unsigned int cpuid)
>  		if (cpuid_topo->package_id != cpu_topo->package_id)
>  			continue;
>  
> -		if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> -		    cpuid_topo->cluster_id != -1) {
> +		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
> +		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
> +
> +		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
> +			continue;
> +
> +		if (cpuid_topo->cluster_id != -1) {
>  			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
>  			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
>  		}
>  
> -		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
> -		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
> -
>  		if (cpuid_topo->core_id != cpu_topo->core_id)
>  			continue;
>  
> -- 
> 2.36.1
> 
