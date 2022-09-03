Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D1E5ABD4F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiICGAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiICGAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8F754A3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 664EE609D1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCCBC433C1;
        Sat,  3 Sep 2022 06:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662184837;
        bh=GBgkfGmfM/oXPv3olWCaRFFkrxlDrMDp9b1OTF8aL5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bq6TctCasHfGP2OBnCjJq1QFHTPLjL2mt8N6mnPFuaMvB97ITehOv9b6ODLza9fsU
         b19TJ77LRvKaQbcJHkqg+rpTGEl/CgjIQ3Z/sVzKxIGswnmKNqIKPu831FSqUOpPn4
         YCKYqsOzXRglN8BTRrEsez2KWyzxhePj70VmJoyQ=
Date:   Sat, 3 Sep 2022 08:00:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, 21cnbao@gmail.com, jonathan.cameron@huawei.com,
        linuxarm@huawei.com, prime.zeng@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v2] arch_topology: Make cluster topology span at least
 SMT CPUs
Message-ID: <YxLtlyIu4hZW+lOo@kroah.com>
References: <20220825092007.8129-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825092007.8129-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 05:20:07PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently cpu_clustergroup_mask() will return CPU mask if cluster span more
> or the same CPUs as cpu_coregroup_mask(). This will result topology borken
> on non-Cluster SMT machines when building with CONFIG_SCHED_CLUSTER=y.
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
>  -nographic \
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
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Fixes: bfcc4397435d ("arch_topology: Limit span of cpu_clustergroup_mask()")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> ---
> Change since v1:
> - mention the kernel config CONFIG_SCHED_CLUSTER=y, per Ionela
> Link:https://lore.kernel.org/lkml/20220823073044.58697-1-yangyicong@huawei.com/
> 
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
> +		return cpu_smt_mask(cpu);

As the kernel-test robot reported, this breaks the build on some
architectures, so I'll go and revert it from my tree now.

thanks,

greg k-h
