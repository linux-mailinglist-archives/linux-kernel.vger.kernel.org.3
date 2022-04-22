Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FFC50B75D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447541AbiDVMeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447540AbiDVMeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:34:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03254BC3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7EB8B82CD3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C5C385A0;
        Fri, 22 Apr 2022 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650630678;
        bh=B0FfGg08Iiv7pykm+jqHRmeXsu0/oIWa+m7eEXoWwkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2nERJK9AIVns/WkGlmLNC2c0DHBsR2l7dmulew/h50tXqj/il0W9O8w3l6g4D8eu
         rw3FJgrMlX1iTWHTgTi2Rq6ZenQTltxBlddZ1j8kakP4r2acTqS5MzsX4n1sVDiQi0
         /8bu0EvNgrs1wWyh1Q18lCgHHMWUsEEHiZ0PR40Y=
Date:   Fri, 22 Apr 2022 14:31:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 2/2] arm64: Add complex scheduler level for arm64
Message-ID: <YmKgEmna8PNF9xlG@kroah.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
 <1650628289-67716-3-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1650628289-67716-3-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:51:26AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> The DSU-110 DynamIQ™ cluster supports blocks that are called complexes
> which contain up to two cores of the same type and some shared logic.
> Sharing some logic between the cores can make a complex area efficient.
> 
> This patch adds complex level for complexs and automatically enables
> the load balance among complexs. It will directly benefit a lot of
> workload which loves more resources such as memory bandwidth, caches.
> 
> Testing has been done with Stream benchmark:
> 8threads stream (2 little cores * 2(complex) + 3 medium cores + 1 big core)
>                 stream                 stream
>                 w/o patch              w/ patch
> MB/sec copy     37579.2 (   0.00%)    39127.3 (   4.12%)
> MB/sec scale    38261.1 (   0.00%)    39195.4 (   2.44%)
> MB/sec add      39497.0 (   0.00%)    41101.5 (   4.06%)
> MB/sec triad    39885.6 (   0.00%)    40772.7 (   2.22%)
> 
> And in order to support this features, we defined arm64_topology.
> 
> V2:
> fix commit log and loop more
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  arch/arm64/Kconfig      | 13 +++++++++++
>  arch/arm64/kernel/smp.c | 48 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index edbe035cb0e3..4063de8c6153 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1207,6 +1207,19 @@ config SCHED_CLUSTER
>  	  by sharing mid-level caches, last-level cache tags or internal
>  	  busses.
>  
> +config SCHED_COMPLEX
> +	bool "Complex scheduler support"
> +	help
> +	  DSU supports blocks that are called complexes which contain up to
> +	  two cores of the same type and some shared logic. Sharing some logic
> +	  between the cores can make a complex area efficient.
> +
> +	  Complex also can be considered as a shared cache group smaller
> +	  than cluster.
> +
> +	  Complex scheduler support improves the CPU scheduler's decision
> +	  making when dealing with machines that have complexs of CPUs.
> +
>  config SCHED_SMT
>  	bool "SMT scheduler support"
>  	help
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3b46041f2b97..526765112146 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sched/hotplug.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/sched/topology.h>
>  #include <linux/interrupt.h>
>  #include <linux/cache.h>
>  #include <linux/profile.h>
> @@ -57,6 +58,10 @@
>  DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
>  EXPORT_PER_CPU_SYMBOL(cpu_number);
>  
> +#ifdef SCHED_COMPLEX
> +DEFINE_PER_CPU_READ_MOSTLY(cpumask_t, cpu_complex_map);
> +#endif

ifdefs should not be in .c files.


> +
>  /*
>   * as from 2.5, kernels no longer have an init_tasks structure
>   * so we need some other way of telling a new secondary core
> @@ -715,6 +720,47 @@ void __init smp_init_cpus(void)
>  	}
>  }
>  
> +#ifdef SCHED_COMPLEX

same here.

> +static int arm64_complex_flags(void)
> +{
> +	return SD_SHARE_PKG_RESOURCES;
> +}
> +
> +const struct cpumask *arm64_complex_mask(int cpu)
> +{
> +	const struct cpumask *core_mask = cpu_cpu_mask(cpu);
> +
> +	/* Find the smaller shared cache level than clustergroup and coregroup*/
> +#ifdef CONFIG_SCHED_MC
> +	core_mask = cpu_coregroup_mask(cpu);
> +#endif
> +#ifdef CONFIG_SCHED_CLUSTER
> +	core_mask = cpu_clustergroup_mask(cpu);
> +#endif

See, same here.  This is a mess and unmaintainable.

thanks,

greg k-h
