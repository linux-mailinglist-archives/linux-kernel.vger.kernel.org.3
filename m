Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9482D521357
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiEJLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbiEJLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:17:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D52A472C;
        Tue, 10 May 2022 04:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F516B81CC4;
        Tue, 10 May 2022 11:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB68C385C2;
        Tue, 10 May 2022 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652181205;
        bh=WNU4ksjN/LVTrVzbET1InUKC36Ei8bhbRLGGDvnxB/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKuwKInN6cyg3p8dTsDyoNtNUIAwmO24ivvGGZ0aZ5d+HUIhatW76h6J/wOrLIaA6
         zmHRyIkMg8GIzh2IF05y8JetF0nEHbT6y4it+zGUrRjfsOC8nKvC0MaEeNJtjXuTLv
         suErUe8cBgwAmPH23mzDcO1w5nUumSj7FNUzajxecqbmGZzv1FB6cYi+TQBSh7pVkQ
         ifnw+3pNGC4dXmtlirlECzCy7L7cLWiwFhvSnaLaE8tZnDItFrFOgiPBdHyyqM+/ds
         zpJmcQ5iMmtdY+Id2qwqbF/fcKTXRpDUjmjM3VlORmglIBCLcoSSqBKRKWtddJw2wC
         QLKl1nqC6JZBw==
Date:   Tue, 10 May 2022 12:13:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, thanu.rangarajan@arm.com,
        Michael.Williams@arm.com, treding@nvidia.com, jonathanh@nvidia.com,
        vsethi@nvidia.com, Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
Message-ID: <20220510111318.GD27557@willie-the-truck>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
 <20220510110742.ievkihggndpms3fn@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510110742.ievkihggndpms3fn@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:07:42PM +0100, Sudeep Holla wrote:
> On Mon, May 09, 2022 at 11:02:23AM +0100, Suzuki K Poulose wrote:
> > Cc: Mike Williams, Mathieu Poirier
> > On 09/05/2022 10:28, Will Deacon wrote:
> > > On Sun, May 08, 2022 at 07:28:08PM -0500, Besar Wicaksono wrote:
> > > >   arch/arm64/configs/defconfig                  |    1 +
> > > >   drivers/perf/Kconfig                          |    2 +
> > > >   drivers/perf/Makefile                         |    1 +
> > > >   drivers/perf/coresight_pmu/Kconfig            |   10 +
> > > >   drivers/perf/coresight_pmu/Makefile           |    7 +
> > > >   .../perf/coresight_pmu/arm_coresight_pmu.c    | 1317 +++++++++++++++++
> > > >   .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
> > > >   .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  300 ++++
> > > >   .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
> > > >   9 files changed, 1802 insertions(+)
> > > 
> > > How does this interact with all the stuff we have under
> > > drivers/hwtracing/coresight/?
> > 
> > Absolutely zero, except for the name. The standard
> > is named "CoreSight PMU" which is a bit unfortunate,
> > given the only link, AFAIU, with the "CoreSight" architecture
> > is the Lock Access Register(LAR). For reference, the
> > drivers/hwtracing/coresight/ is purely "CoreSight" self-hosted
> > tracing and the PMU is called "cs_etm" (expands to coresight etm).
> > Otherwise the standard doesn't have anything to do with what
> > exists already in the kernel.

That's... a poor naming choice! But good, if it's entirely separate then I
don't have to worry about that. Just wanted to make sure we're not going to
get tangled up in things like ROM tables and Coresight power domains for
these things.

> > One potential recommendation for the name is, "Arm PMU"  (The ACPI table is
> > named Arm PMU Table). But then that could be clashing with the armv8_pmu
> > :-(.
> > 
> > Some of the other options are :
> > 
> > "Arm Generic PMU"
> > "Arm Uncore PMU"
> 
> I wasn't sure on this if there is any restriction on usage of this on Arm
> and hence didn't make the suggestion. But if allowed, this would be my
> choice too.

We'd taken to calling them "System" PMUS in the past, so maybe just stick
with that? I think "Uncore" is Intel terminology so it's probably best to
avoid it for non-Intel parts.

Will
