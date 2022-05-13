Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A9525E75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358117AbiEMJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378953AbiEMJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:03:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35062B3F53
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:03:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5899113E;
        Fri, 13 May 2022 02:03:38 -0700 (PDT)
Received: from bogus (unknown [10.57.65.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3FFA3F73D;
        Fri, 13 May 2022 02:03:36 -0700 (PDT)
Date:   Fri, 13 May 2022 10:03:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arch_topology: Use llc_id instead of package_id
Message-ID: <20220513090330.z25fwthekn4rjkwq@bogus>
References: <20220513083400.343706-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513083400.343706-1-dietmar.eggemann@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 10:34:00AM +0200, Dietmar Eggemann wrote:
> package_id should represent socket in DT. Free it for possible socket
> dts parsing and use the so far unused llc_id / llc_sibling cpumask to
> decode 1. level clusters used in pre-DynamIQ big/little systems.
> 
> cpu_coregroup_mask() will return llc_sibling isntead of core_mask in
> this case.
> 
> This will let the cluster_id / cluster_sibling cpumask be available for
> 2. level clusters (e.g. to map L2 sharing in Armv9 A510 complexes).
> 
> The corresponding sched domain CLS is similarly used in ACPI (servers)
> to map e.g. Kunpeng920 L3-tags or Ampere Altra's SCU bounderies.
> 
> Lighlty tested on qemu-system-aarch64 with 1x8 (cluster-x-core) and
> 2x4 cpu-map.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
> 
> Related to: https://lkml.kernel.org/r/1652361692-13196-1-git-send-email-wangqing@vivo.com
> 
>  drivers/base/arch_topology.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index f73b836047cf..ac1488990cc8 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -490,7 +490,7 @@ static int __init get_cpu_for_node(struct device_node *node)
>  	return cpu;
>  }
>  
> -static int __init parse_core(struct device_node *core, int package_id,
> +static int __init parse_core(struct device_node *core, int llc_id,
>  			     int core_id)
>  {
>  	char name[20];
> @@ -506,7 +506,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>  			leaf = false;
>  			cpu = get_cpu_for_node(t);
>  			if (cpu >= 0) {
> -				cpu_topology[cpu].package_id = package_id;
> +				cpu_topology[cpu].package_id = 0;
> +				cpu_topology[cpu].llc_id = llc_id;
>  				cpu_topology[cpu].core_id = core_id;
>  				cpu_topology[cpu].thread_id = i;
>  			} else if (cpu != -ENODEV) {
> @@ -527,7 +528,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>  			return -EINVAL;
>  		}
>  
> -		cpu_topology[cpu].package_id = package_id;
> +		cpu_topology[cpu].package_id = 0;

While the above looks good and matches with what I am attempting to do
as well ...

> +		cpu_topology[cpu].llc_id = llc_id;

This looks wrong for simple reason that this is derived incorrectly from
the cpu-map while there is no guarantee that it matches the last level
cache ID on the system as we didn't parse the cache topology for this.
So I disagree with this change as it might conflict with the actual and
correct llc_id.

-- 
Regards,
Sudeep
