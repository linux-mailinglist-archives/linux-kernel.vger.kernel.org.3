Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C74D9864
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346953AbiCOKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiCOKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:09:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB6212604
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 03:08:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21DC71474;
        Tue, 15 Mar 2022 03:08:32 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A1DA3F66F;
        Tue, 15 Mar 2022 03:08:30 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:08:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] arch_topology: Correct CPU capacity scaling
Message-ID: <YjBlnMvcagdbKnEz@bogus>
References: <20220313055512.248571-1-leo.yan@linaro.org>
 <Yi+FMrG9NyBnMX0i@arm.com>
 <20220315032919.GA217475@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315032919.GA217475@leoy-ThinkPad-X240s>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:29:19AM +0800, Leo Yan wrote:
> Hi Ionela,
> 
> On Mon, Mar 14, 2022 at 06:10:58PM +0000, Ionela Voinescu wrote:
> 
> [...]
> 
> > > Patch 03 is to handle the case for absenting "capacity-dmips-mhz"
> > > property in CPU nodes, the patch proceeds to do CPU capacity scaling based
> > > on CPU maximum capacity.  Thus it can reflect the correct CPU capacity for
> > > Arm platforms with "fast" and "slow" clusters (CPUs in two clusters have
> > > the same raw capacity but with different maximum frequencies).
> > > 
> > 
> > In my opinion it's difficult to handle absent "capacity-dmips-mhz"
> > properties, as they can be a result of 3 scenarios: potential..
> >  1. bug in DT
> >  2. unwillingness to fill this information in DT
> >  3. suggestion that we're dealing with CPUs with same u-arch
> >     (same capacity-dmips-mhz)
> 
> For absent "capacity-dmips-mhz" properties, I think we could divide into
> two sub classes:
> 
> For all CPU nodes are absent "capacity-dmips-mhz" properties, it's
> likely all CPUs have the same micro architecture, thus developers are
> not necessarily to explictly set the property.
>

I completely disagree and NACK to deal with absence of the property in DT.
The binding clearly states:

"CPU capacity is a number that provides the scheduler information about CPUs
heterogeneity. Such heterogeneity can come from micro-architectural differences
(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
context is about differing performance characteristics; this binding tries to
capture a first-order approximation of the relative performance of CPUs."

So it is clear that using same uarch can't be an excuse to miss this property.
So if you need the scheduler to be aware of this heterogeneity, better update
the DT with property. Absence will always means scheduler need not be aware
of this heterogeneity.

> For partial CPUs absent "capacity-dmips-mhz" properties, this is an
> usage issue in DT and kernel should handle this as an error and report
> it.
>

That makes sense. As I mentioned in my earlier email, we can always flag
up error in the kernel, but it would be good to catch these much earlier
in DT via schema if possible.

> > I'm not sure it's up to us to interpret suggestions in the code so I
> > believe treating missing information as error is the right choice, which
> > is how we're handling this now.
> 
> Yes, current kernel means to treat missing info as error, whatever if
> all CPUs or partial CPUs are absent "capacity-dmips-mhz" properties.
>

OK, so no change needed ? I am confused as what is missing today.

> > For 3. (and patch 03), isn't it easier to populate capacity-dmips-mhz to
> > the same value (say 1024) in DT? That is a clear message that we're
> > dealing with CPUs with the same u-arch.
>
> "capacity-dmips-mhz" is defined as a _optional_ property in the DT
> document (see devicetree/bindings/arm/cpu-capacity.txt).
>

That means that the kernel can operate without the info and nothing more
than that. We are not providing guarantee that the same performance is
possible with or without this optional property.

> Current kernel rolls back every CPU raw capacity to 1024 if DT doesn't
> bind "capacity-dmips-mhz" properties, given many SoCs with same CPU
> u-arch this is right thing to do; here I think kernel should proceed to
> scale CPU capacity with its maximum frequency.
>

As stated above, I completely disagree and once again NACK.

> When I worked on a platform with a fast and a slow clusters (two clusters
> have different max frequencies and with the same CPU u-arch), it's a bit
> puzzle when I saw all CPU's capacities are always 1024.  In this case,
> since a platform have no CPU capacity modeling, and "capacity-dmips-mhz"
> property is not needed to populate in DT, but at the end the kernel
> should can reflect the scaled CPU capacity correctly.
>

Fix the broken DT with respect to this feature. I mean DT is not broken, but
if once needs this feature then they should teach the kernel the hardware
difference with this property.

Another possible issue I can see if this is dealt within the kernel is if
on some platform for thermal or any valid hardware errata reasons, one set
of CPUs can run at max one frequency while the other is restricted at a
suitable lower frequency, it may not be good idea to mark that as difference
in cpu capacity as they are SMP CPUs just in different perf domains with
different limits. I assume the scale invariance must deal with that.
I may be wrong here but that's my understanding, happy to be corrected.

--
Regards,
Sudeep
