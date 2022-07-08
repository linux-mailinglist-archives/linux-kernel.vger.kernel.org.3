Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6C56B545
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiGHJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbiGHJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:22:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17F912CC8E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:22:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2469D106F;
        Fri,  8 Jul 2022 02:22:18 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A44A93F66F;
        Fri,  8 Jul 2022 02:22:11 -0700 (PDT)
Date:   Fri, 8 Jul 2022 10:21:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daire.McNamara@microchip.com, niklas.cassel@wdc.com,
        damien.lemoal@opensource.wdc.com, geert@linux-m68k.org,
        zong.li@sifive.com, kernel@esmil.dk, hahnjo@hahnjo.de,
        guoren@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
        changbin.du@intel.com, heiko@sntech.de, philipp.tomsich@vrull.eu,
        robh@kernel.org, maz@kernel.org, viresh.kumar@linaro.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Brice.Goglin@inria.fr
Subject: Re: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Message-ID: <20220708092100.c6mgmnt7e2k7u634@bogus>
References: <20220707220436.4105443-1-mail@conchuod.ie>
 <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus>
 <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 08:35:57AM +0000, Conor.Dooley@microchip.com wrote:
> On 08/07/2022 09:24, Sudeep Holla wrote:
> > On Thu, Jul 07, 2022 at 11:04:35PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> RISC-V & arm64 both use an almost identical method of filling in
> >> default vales for arch topology. Create a weakly defined default
> >> implementation with the intent of migrating both archs to use it.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>   drivers/base/arch_topology.c  | 19 +++++++++++++++++++
> >>   include/linux/arch_topology.h |  1 +
> >>   2 files changed, 20 insertions(+)
> >>
> >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> >> index 441e14ac33a4..07e84c6ac5c2 100644
> >> --- a/drivers/base/arch_topology.c
> >> +++ b/drivers/base/arch_topology.c
> >> @@ -765,6 +765,25 @@ void update_siblings_masks(unsigned int cpuid)
> >>   	}
> >>   }
> >>   
> >> +void __weak store_cpu_topology(unsigned int cpuid)
> 
> Does using __weak here make sense to you?
>

I don't want any weak definition and arch to override as we know only
arm64 and RISC-V are the only users and they are aligned to have same
implementation. So weak definition doesn't make sense to me.

> > 
> > I prefer to have this as default implementation. So just get the risc-v
> > one pushed to upstream first(for v5.20) and get all the backports if required.
> > Next cycle(i.e. v5.21), you can move both RISC-V and arm64.
> > 
> 
> Yeah, that was my intention. I meant to label patch 1/4 as "PATCH"
> and (2,3,4)/4 as RFC but forgot. I talked with Palmer about doing
> the risc-v impl. and then migrate both on IRC & he seemed happy with
> it.
>

Ah OK, good.

> If you're okay with patch 1/4, I'll resubmit it as a standalone v2.
>

That would be great, thanks. You can most the code to move to generic from
both arm64 and risc-v once we have this in v5.20-rc1

-- 
Regards,
Sudeep
