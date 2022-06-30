Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7985623EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiF3UIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiF3UIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:08:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA32745539
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:08:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 998032B;
        Thu, 30 Jun 2022 13:08:31 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9753F5A1;
        Thu, 30 Jun 2022 13:08:27 -0700 (PDT)
Date:   Thu, 30 Jun 2022 21:07:17 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        atishp@atishpatra.org, atishp@rivosinc.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, gshan@redhat.com,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Message-ID: <20220630200717.zlc6z6zcqbsw7euk@bogus>
References: <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
 <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
 <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
 <20220630103958.tcear5oz3orsqwg6@bogus>
 <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
 <20220630173513.dyrrmjbpxzi3e6fe@bogus>
 <3840dbf7-ca18-b7ab-4d7a-92c9305476fa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3840dbf7-ca18-b7ab-4d7a-92c9305476fa@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 07:20:04PM +0000, Conor.Dooley@microchip.com wrote:
> 
> 
> On 30/06/2022 18:35, Sudeep Holla wrote:
> > On Thu, Jun 30, 2022 at 04:37:50PM +0000, Conor.Dooley@microchip.com wrote:
> >> On 30/06/2022 11:39, Sudeep Holla wrote:
> >>>
> >>> I can't think of any reason for that to happen unless detect_cache_attributes
> >>> is failing from init_cpu_topology and we are ignoring that.
> >>>
> >>> Are all RISC-V platforms failing on -next or is it just this platform ?
> >>
> >> I don't know. I only have SoCs with this core complex & one that does not
> >> work with upstream. I can try my other board with this SoC - but I am on
> >> leave at the moment w/ a computer or internet during the day so it may be
> >> a few days before I can try it.
> >>
> > 
> > Sure, no worries.
> > 
> >> However, Niklas Cassel has tried to use the Canaan K210 on next-20220630
> >> but had issues with RCU stalling:
> >> https://lore.kernel.org/linux-riscv/Yr3PKR0Uj1bE5Y6O@x1-carbon/T/#m52016996fcf5fa0501066d73352ed8e806803e06
> >> Not going to claim any relation, but that's minus 1 to the platforms that
> >> can be used to test this on upstream RISC-V.
> >>
> > 
> > Ah OK, will check and ask full logs to see if there is any relation.
> > 
> >>> We may have to try with some logs in detect_cache_attributes,
> >>> last_level_cache_is_valid and last_level_cache_is_shared to check where it
> >>> is going wrong.
> >>>
> >>> It must be crashing in smp_callin->update_siblings_masks->last_level_cache_is_shared
> 
> 
> So, looks like there's a problem in cache_leaves_are_shared() which is hit
> by the above path. Both of the if clauses are false, and the function falls
> through to return sib_leaf->fw_token == this_leaf->fw_token;

Both if() failing is expected and that statement
	return sib_leaf->fw_token == this_leaf->fw_token;
execution is correct.

> Both sib_leaf & this_leaf seem to be null.
>

But this is wrong as last_level_cache_is_shared checks for
last_level_cache_is_valid which must return false if the fw_token = NULL
So we must not hit the above return statement with NULL fw_token.

> static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
> 					   struct cacheinfo *sib_leaf)
> {
> 	/*
> 	 * For non DT/ACPI systems, assume unique level 1 caches,
> 	 * system-wide shared caches for all other levels. This will be used
> 	 * only if arch specific code has not populated shared_cpu_map
> 	 */
> 	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))
> 		return !(this_leaf->level == 1);
> 
> 	if ((sib_leaf->attributes & CACHE_ID) &&
> 	    (this_leaf->attributes & CACHE_ID))
> 		return sib_leaf->id == this_leaf->id;
> 
> 	return sib_leaf->fw_token == this_leaf->fw_token;
> }
> 
> Any ideas what to look at next?

I wonder how did we not get last_level_cache_is_valid as false if the
fw_node is NULL. But it should not be NULL at the first place.

-- 
Regards,
Sudeep
