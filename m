Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F8521342
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiEJLMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiEJLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:11:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C401A1116F1;
        Tue, 10 May 2022 04:07:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2C111FB;
        Tue, 10 May 2022 04:07:51 -0700 (PDT)
Received: from bogus (unknown [10.57.0.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70A193F66F;
        Tue, 10 May 2022 04:07:48 -0700 (PDT)
Date:   Tue, 10 May 2022 12:07:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
Message-ID: <20220510110742.ievkihggndpms3fn@bogus>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:02:23AM +0100, Suzuki K Poulose wrote:
> Cc: Mike Williams, Mathieu Poirier
> 
> On 09/05/2022 10:28, Will Deacon wrote:
> > On Sun, May 08, 2022 at 07:28:08PM -0500, Besar Wicaksono wrote:
> > > Add driver support for ARM CoreSight PMU device and event attributes for NVIDIA
> > > implementation. The code is based on ARM Coresight PMU architecture and ACPI ARM
> > > Performance Monitoring Unit table (APMT) specification below:
> > >   * ARM Coresight PMU:
> > >          https://developer.arm.com/documentation/ihi0091/latest
> > >   * APMT: https://developer.arm.com/documentation/den0117/latest
> > > 
> > > Notes:
> > >   * There is a concern on the naming of the PMU device.
> > >     Currently the driver is probing "arm-coresight-pmu" device, however the APMT
> > >     spec supports different kinds of CoreSight PMU based implementation. So it is
> > >     open for discussion if the name can stay or a "generic" name is required.
> > >     Please see the following thread:
> > >     http://lists.infradead.org/pipermail/linux-arm-kernel/2022-May/740485.html
> > > 
> > > Besar Wicaksono (2):
> > >    perf: coresight_pmu: Add support for ARM CoreSight PMU driver
> > >    perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
> > > 
> > >   arch/arm64/configs/defconfig                  |    1 +
> > >   drivers/perf/Kconfig                          |    2 +
> > >   drivers/perf/Makefile                         |    1 +
> > >   drivers/perf/coresight_pmu/Kconfig            |   10 +
> > >   drivers/perf/coresight_pmu/Makefile           |    7 +
> > >   .../perf/coresight_pmu/arm_coresight_pmu.c    | 1317 +++++++++++++++++
> > >   .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
> > >   .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  300 ++++
> > >   .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
> > >   9 files changed, 1802 insertions(+)
> > 
> > How does this interact with all the stuff we have under
> > drivers/hwtracing/coresight/?
> 
> Absolutely zero, except for the name. The standard
> is named "CoreSight PMU" which is a bit unfortunate,
> given the only link, AFAIU, with the "CoreSight" architecture
> is the Lock Access Register(LAR). For reference, the
> drivers/hwtracing/coresight/ is purely "CoreSight" self-hosted
> tracing and the PMU is called "cs_etm" (expands to coresight etm).
> Otherwise the standard doesn't have anything to do with what
> exists already in the kernel.
> 
> That said, I am concerned that the "coresight_pmu" is easily confused
> with what exists today. Given that this is more of a "PMU" standard
> for the IPs in the Arm world, it would be better to name it as such
> avoiding any confusion with the existing PMUs.
> 

Thanks Suzuki. I did suggest something similar[1] but asked to retain it
so that it can be discussed in the bigger and right forum.

> One potential recommendation for the name is, "Arm PMU"  (The ACPI table is
> named Arm PMU Table). But then that could be clashing with the armv8_pmu
> :-(.
> 
> Some of the other options are :
> 
> "Arm Generic PMU"
> "Arm Uncore PMU"

I wasn't sure on this if there is any restriction on usage of this on Arm
and hence didn't make the suggestion. But if allowed, this would be my
choice too.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20220504182633.a3mwuiohfqtjvpep@bogus
