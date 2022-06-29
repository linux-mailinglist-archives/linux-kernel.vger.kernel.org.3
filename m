Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD02560A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiF2Toy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiF2Tow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:44:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EC122A94F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:44:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4A51480;
        Wed, 29 Jun 2022 12:44:51 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D0A83F792;
        Wed, 29 Jun 2022 12:44:48 -0700 (PDT)
Date:   Wed, 29 Jun 2022 20:43:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        atishp@atishpatra.org, atishp@rivosinc.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, gshan@redhat.com,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Message-ID: <20220629194337.3cmrqed2xbalihif@bogus>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184708.x5exgjoy4sblyqml@bogus>
 <88ef07ea-fbde-b997-6c0c-99f5fb7be201@microchip.com>
 <20220629191250.mg3dybgl6hnlnqee@bogus>
 <f569aff9-fbe1-66f1-d308-cec428aa5886@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f569aff9-fbe1-66f1-d308-cec428aa5886@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:25:41PM +0000, Conor.Dooley@microchip.com wrote:
> 
> 
> On 29/06/2022 20:12, Sudeep Holla wrote:
> > On Wed, Jun 29, 2022 at 06:56:29PM +0000, Conor.Dooley@microchip.com wrote:
> >> On 29/06/2022 19:47, Sudeep Holla wrote:
> >>> On Wed, Jun 29, 2022 at 06:18:25PM +0000, Conor.Dooley@microchip.com wrote:
> >>>> On 29/06/2022 18:49, Conor.Dooley@microchip.com wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>
> >>>>> On 27/06/2022 17:50, Sudeep Holla wrote:
> >>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>>
> >>>>>> The cacheinfo is now initialised early along with the CPU topology
> >>>>>> initialisation. Instead of relying on the LLC ID information parsed
> >>>>>> separately only with ACPI PPTT elsewhere, migrate to use the similar
> >>>>>> information from the cacheinfo.
> >>>>>>
> >>>>>> This is generic for both DT and ACPI systems. The ACPI LLC ID information
> >>>>>> parsed separately can now be removed from arch specific code.
> >>>>>
> >>>>> Hey Sudeep,
> >>>>> I bisected broken boot on PolarFire SoC to this patch in next-20220629 :/
> >>>>> I suspect the issue is a missing "next-level-cache" in the the dt:
> >>>>> arch/riscv/boot/dts/microchip/mpfs.dtsi
> >>>
> >>> Good that I included this in -next, I had not received any feedback from
> >>> RISC-V even after 5 iterations.
> >>
> >> I'll be honest, I saw the titles and CC list and made some incorrect
> >> assumptions as to whether looking at it was worthwhile! I am not at
> >> this all too long and what is/isn't important to look at often is not
> >> obvious to me.
> > 
> > No worries, that's why I thought better to include in -next to get some
> > attention and I did get it this time, hurray! 😄
> > 
> >> But hey, our CI boots -next every day for a reason ;)
> >>
> > 
> > Good to know and that is really great. Anyways let me know if the diff I sent
> > helps. I strongly suspect that is the reason, but I may be wrong.
> 
> Aye, I'll get back to you on that one in a moment or two
>

Sure, take your time.

> > 
> >>> I also see this DTS is very odd. It also
> >>> states CPU0 doesn't have L1-D$ while the other 4 CPUs have L1-D$. Is that
> >>> a mistake or is it the reality ?
> >>
> >> AFAIK, reality. It's the same for the SiFive fu540 (with which this shares
> >> a core complex. See page 12:
> >> https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> >>
> >>> Another breakage in userspace cacheinfo
> >>> sysfs entry of cpu0 has both I$ and D$.
> >>
> >> Could you clarify what this means please?
> > 
> > Ignore me if the cpu0 really doesn't have L1-D$. However the userspace
> > sysfs cacheinfo is incomplete without linking L2, so it can be considered
> > as wrong info presented to the user.
> 
> Yeah, I'll send a patch hooking up the L2.
> It wasn't in the initial fu540 dtsi so I guess it was added after the
> initial dts for my stuff was created based on that.
>

Thanks!

> > 
> > Check /sys/devices/system/cpu/cpu<n>/cache/index<i>/*.
> > L2 won't be present there as the link with next-level-cache is missing.
> > So userspace can interpret this as absence of L2.
> > 
> 
> # cat /sys/devices/system/cpu/cpu0/cache/index0/
> coherency_line_size    shared_cpu_list        type
> level                  shared_cpu_map         uevent
> number_of_sets         size                   ways_of_associativity
> # ls /sys/devices/system/cpu/cpu0/cache/
> index0  index1  uevent
> # cat /sys/devices/system/cpu/cpu0/cache/index0/level 
> 1
> # cat /sys/devices/system/cpu/cpu0/cache/index1/level 
> 1
>
Ideally there must /sys/devices/system/cpu/cpu*/cache/index2/level
which reads 2 once you link it in the DT.

> cpu0 is /not/ the one with only instruction cache, that is not
> running Linux.

Ah, so there Linux runs only on cpu 1-4 ?

-- 
Regards,
Sudeep
