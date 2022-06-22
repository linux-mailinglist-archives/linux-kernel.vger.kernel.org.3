Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030B554EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358966AbiFVPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358934AbiFVPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:06:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70F96393F7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:06:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68EAD12FC;
        Wed, 22 Jun 2022 08:06:31 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67D83F792;
        Wed, 22 Jun 2022 08:06:30 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:06:29 +0100
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
Subject: Re: [PATCH v4 20/20] arch_topology: Warn that topology for nested
 clusters is not supported
Message-ID: <YrMv9eqUrsYS6oO0@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
 <20220621192034.3332546-21-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621192034.3332546-21-sudeep.holla@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed this in a quick test.

On Tuesday 21 Jun 2022 at 20:20:34 (+0100), Sudeep Holla wrote:
> We don't support the topology for clusters of CPU clusters while the
> DT and ACPI bindings theoritcally support the same. Just warn about the
> same so that it is clear to the users of arch_topology that the nested
> clusters are not yet supported.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index ed1cb64a95aa..1c5fa7bbbd00 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -567,6 +567,8 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
>  		if (c) {
>  			leaf = false;
>  			ret = parse_cluster(c, package_id, i, depth + 1);
> +			if (depth > 1)
> +				pr_warn("Topology for clusters of clusters not yet supported\n");

I think the check should be for (depth > 0) or (depth >= 1).

We end up having depth = 2 when we have

cluster 0 {
	//depth is 0
	cluster 0 {
		//depth is 1
		cluster0 {
			//depth is 2
...

I suppose we should warn about nested clusters from depth 1, right?

Thanks,
Ionela.

>  			of_node_put(c);
>  			if (ret != 0)
>  				return ret;
> -- 
> 2.36.1
> 
