Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686359DD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357599AbiHWL02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357715AbiHWLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:20:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B1F8C46C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:22:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBB0D113E;
        Tue, 23 Aug 2022 02:22:51 -0700 (PDT)
Received: from bogus (unknown [10.57.44.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A16143F718;
        Tue, 23 Aug 2022 02:22:45 -0700 (PDT)
Date:   Tue, 23 Aug 2022 10:22:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     vincent.guittot@linaro.org, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, 21cnbao@gmail.com, jonathan.cameron@huawei.com,
        linuxarm@huawei.com, prime.zeng@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH] arch_topology: Make cluster topology span at least SMT
 CPUs
Message-ID: <20220823092220.2p4tsq5rvmfk5ne4@bogus>
References: <20220823073044.58697-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823073044.58697-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:30:44PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently cpu_clustergroup_mask() will return CPU mask if cluster span
> more or the same CPUs as cpu_coregroup_mask(). This will result topology
> borken on non-Cluster SMT machines.
> 
> Test with:
> qemu-system-aarch64 -enable-kvm -machine virt \
>  -net none \
>  -cpu host \
>  -bios ./QEMU_EFI.fd \
>  -m 2G \
>  -smp 48,sockets=2,cores=12,threads=2 \
>  -kernel $Image \
>  -initrd $Rootfs \
>  -nographic
>  -append "rdinit=init console=ttyAMA0 sched_verbose loglevel=8"
> 
> We'll get below error:
> [    3.084568] BUG: arch topology borken
> [    3.084570]      the SMT domain not a subset of the CLS domain
> 
> Since cluster is a level higher than SMT, fix this by making cluster
> spans at least SMT CPUs.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Fixes: bfcc4397435d ("arch_topology: Limit span of cpu_clustergroup_mask()")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/base/arch_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 0424b59b695e..0056a1273275 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -724,7 +724,7 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>  	 */
>  	if (cpumask_subset(cpu_coregroup_mask(cpu),
>  			   &cpu_topology[cpu].cluster_sibling))
> -		return get_cpu_mask(cpu);

Sorry for this, for some reason I assumed the get_cpu_mask() will cover
threads too.

-- 
Regards,
Sudeep
