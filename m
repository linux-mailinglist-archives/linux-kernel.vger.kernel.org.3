Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5556215F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbiF3Rgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiF3Rg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:36:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FD093FBF9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:36:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B62B01063;
        Thu, 30 Jun 2022 10:36:27 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADF4D3F792;
        Thu, 30 Jun 2022 10:36:24 -0700 (PDT)
Date:   Thu, 30 Jun 2022 18:35:13 +0100
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
Message-ID: <20220630173513.dyrrmjbpxzi3e6fe@bogus>
References: <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
 <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
 <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
 <20220630103958.tcear5oz3orsqwg6@bogus>
 <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 04:37:50PM +0000, Conor.Dooley@microchip.com wrote:
> On 30/06/2022 11:39, Sudeep Holla wrote:
> >
> > I can't think of any reason for that to happen unless detect_cache_attributes
> > is failing from init_cpu_topology and we are ignoring that.
> >
> > Are all RISC-V platforms failing on -next or is it just this platform ?
>
> I don't know. I only have SoCs with this core complex & one that does not
> work with upstream. I can try my other board with this SoC - but I am on
> leave at the moment w/ a computer or internet during the day so it may be
> a few days before I can try it.
>

Sure, no worries.

> However, Niklas Cassel has tried to use the Canaan K210 on next-20220630
> but had issues with RCU stalling:
> https://lore.kernel.org/linux-riscv/Yr3PKR0Uj1bE5Y6O@x1-carbon/T/#m52016996fcf5fa0501066d73352ed8e806803e06
> Not going to claim any relation, but that's minus 1 to the platforms that
> can be used to test this on upstream RISC-V.
>

Ah OK, will check and ask full logs to see if there is any relation.

> > We may have to try with some logs in detect_cache_attributes,
> > last_level_cache_is_valid and last_level_cache_is_shared to check where it
> > is going wrong.
> >
> > It must be crashing in smp_callin->update_siblings_masks->last_level_cache_is_shared
>
> Yeah, I was playing around last night for a while but didn't figure out the
> root cause. I'll try again tonight.
>

OK, thanks for that. I tried qemu, but doesn't have any cache info in DT
provided by qemu itself. The other sifive_u machine didn't work on qemu,
only virt booted with mainline as well.

> In the meantime, would you mind taking the patches out of -next?

I don't want to take out as we will loose all the test coverage.
I would like to know if any other RISC-V platform is affected or not
before removing it.

> FWIW I repro'd the failure on next-20220630.

Yes, nothing has changed yet.

--
Regards,
Sudeep
