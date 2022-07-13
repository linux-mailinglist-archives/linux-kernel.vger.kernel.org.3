Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2993357384C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiGMOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiGMOEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:04:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993572FFF9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EBADB81FC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5C2C34114;
        Wed, 13 Jul 2022 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657721039;
        bh=9IGH4MQdi/KGvLaBbSpVE1u3UFTp0yNqx8UIwCBrNzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N41phYccyuE63ABZmUcfr3okC4jpwzGUm6l59osfsReDlNcsLoQqadbj6yYHvKIEc
         CTHf8yXBLNGIsUZbTiOGA9CPSrUtf2EQ/O4BKi9wy8tw++1A3LCCK/1RScJ0nvGRB4
         0iiS5yJURy2dzfKYlYx/pNYrE0vxjZ09F+qdWmTM=
Date:   Wed, 13 Jul 2022 16:03:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Message-ID: <Ys7QzJ14brtz23XY@kroah.com>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713133344.1201247-1-sudeep.holla@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:33:44PM +0100, Sudeep Holla wrote:
> init_cpu_topology() is called only once at the boot and all the cache
> attributes are detected early for all the possible CPUs. However when
> the CPUs are hotplugged out, the cacheinfo gets removed. While the
> attributes are added back when the CPUs are hotplugged back in as part
> of CPU hotplug state machine, it ends up called quite late after the
> update_siblings_masks() are called in the secondary_start_kernel()
> resulting in wrong llc_sibling_masks.
> 
> Move the call to detect_cache_attributes() inside update_siblings_masks()
> to ensure the cacheinfo is updated before the LLC sibling masks are
> updated. This will fix the incorrect LLC sibling masks generated when
> the CPUs are hotplugged out and hotplugged back in again.
> 
> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> Hi Conor,
> 
> Ionela reported an issue with the CPU hotplug and as a fix I need to
> move the call to detect_cache_attributes() which I had thought to keep
> it there from first but for no reason had moved it to init_cpu_topology().
> 
> Wonder if this fixes the -ENOMEM on RISC-V as this one is called on the
> cpu in the secondary CPUs init path while init_cpu_topology executed
> detect_cache_attributes() for all possible CPUs much earlier. I think
> this might help as the percpu memory might be initialised in this case.
> 
> Anyways give this a try, also test the CPU hotplug and check if nothing
> is broken on RISC-V. We noticed this bug only on one platform while
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 441e14ac33a4..0424b59b695e 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -732,7 +732,11 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>  void update_siblings_masks(unsigned int cpuid)
>  {
>  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> -	int cpu;
> +	int cpu, ret;
> +
> +	ret = detect_cache_attributes(cpuid);
> +	if (ret)
> +		pr_info("Early cacheinfo failed, ret = %d\n", ret);

No erroring out?

thanks,

greg k-h
