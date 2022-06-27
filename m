Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF61F55C389
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbiF0QbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiF0QbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:31:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5723AB7CC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:31:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54AEA1758;
        Mon, 27 Jun 2022 09:31:21 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 438F13F66F;
        Mon, 27 Jun 2022 09:31:19 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:30:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
Subject: Re: [PATCH v4 16/20] arch_topology: Drop unnecessary check for
 uninitialised package_id
Message-ID: <20220627163008.qnyx27arpxmihpya@bogus>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
 <20220621192034.3332546-17-sudeep.holla@arm.com>
 <Yrms1OMuSZ2GhmT7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrms1OMuSZ2GhmT7@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:12:52PM +0100, Ionela Voinescu wrote:
> On Tuesday 21 Jun 2022 at 20:20:30 (+0100), Sudeep Holla wrote:
> > With the support of socket node parsing from the device tree and
> > assigning 0 as package_id in absence of socket nodes, there is no need
> > to check for invalid package_id. It is always initialised to 0 or values
> > from the device tree socket nodes.
> > 
> > Just drop that now redundant check for uninitialised package_id.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/base/arch_topology.c | 11 -----------
> >  1 file changed, 11 deletions(-)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 46fa1b70b02b..42448a5a9412 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -611,7 +611,6 @@ static int __init parse_dt_topology(void)
> >  {
> >  	struct device_node *cn, *map;
> >  	int ret = 0;
> > -	int cpu;
> >  
> >  	cn = of_find_node_by_path("/cpus");
> >  	if (!cn) {
> > @@ -633,16 +632,6 @@ static int __init parse_dt_topology(void)
> >  
> >  	topology_normalize_cpu_scale();
> >  
> > -	/*
> > -	 * Check that all cores are in the topology; the SMP code will
> > -	 * only mark cores described in the DT as possible.
> > -	 */
> > -	for_each_possible_cpu(cpu)
> > -		if (cpu_topology[cpu].package_id < 0) {
> > -			ret = -EINVAL;
> > -			break;
> > -		}
> > -
> 
> Maybe it would still be good to keep this for systems with potential
> errors in DT, where one forgets to add a core in cpu-map.
>

Though I would ideally prefer to catch such DT issues with schema, I know
we are no there yet. So I agree to retain this.

> For example, if I modify juno.dts as follows:
> 
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -51,12 +51,9 @@ core0 {
>                                         cpu = <&A53_0>;
>                                 };
>                                 core1 {
> -                                       cpu = <&A53_1>;
> -                               };
> -                               core2 {
>                                         cpu = <&A53_2>;
>                                 };
> -                               core3 {
> +                               core2 {
>                                         cpu = <&A53_3>;
>                                 };
>                         };
> 
> and miss a little core in cluster1, I would end up with an incomplete
> topology: core3 would have cluster_id as -1, while all other CPUs would
> have a valid value; also, core3 would have package_id = -1.
> 

Indeed. I didn't consider the case where DT would have issues when I dropped
this check. I will drop this patch. Thanks again.

-- 
Regards,
Sudeep
