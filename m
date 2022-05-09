Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703DB51F8D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiEIJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEIJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971A92218FC;
        Mon,  9 May 2022 02:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 258D6614BB;
        Mon,  9 May 2022 09:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15903C385AC;
        Mon,  9 May 2022 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652088530;
        bh=3iTqXEKUOS/eqYT5xmR3rSnyJdIWdYq46LxP+sQuJpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BICeC5sQ707kdEq4a9WRgFtwUBmZVnQYKm/9UM+6cbO0vwlKRG5+j1HUmWQxGhvfw
         D8LyU/SzBNjV6TJdWk78kSbPwmfUn1xn0b0HR3zGHswQVW20XU+tEiUbQtWoNQVdYa
         P++wJwIOoY/bJF2yq0JCQSjiVvhqh0FZZDHmFjtrRkFaShr9MGFQSjiLwSUq0bt8I8
         /6YuDD/d5N7kJvqV4J0fI7dD+r18NuUS4LFZoB1z4Qcap4s9PT5LagrOWQfSXZuXfo
         n1E4UXBFUKjpq5ei5sg/E6vouI2CBI57Ygh22zsXwKtrgp435QvoOx+mvwLKasSa6j
         0xoP6TZC6DCTQ==
Date:   Mon, 9 May 2022 10:28:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        suzuki.poulose@arm.com, treding@nvidia.com, jonathanh@nvidia.com,
        vsethi@nvidia.com
Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
Message-ID: <20220509092843.GB26264@willie-the-truck>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509002810.12412-1-bwicaksono@nvidia.com>
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

On Sun, May 08, 2022 at 07:28:08PM -0500, Besar Wicaksono wrote:
> Add driver support for ARM CoreSight PMU device and event attributes for NVIDIA
> implementation. The code is based on ARM Coresight PMU architecture and ACPI ARM
> Performance Monitoring Unit table (APMT) specification below:
>  * ARM Coresight PMU:
>         https://developer.arm.com/documentation/ihi0091/latest
>  * APMT: https://developer.arm.com/documentation/den0117/latest
> 
> Notes:
>  * There is a concern on the naming of the PMU device.
>    Currently the driver is probing "arm-coresight-pmu" device, however the APMT
>    spec supports different kinds of CoreSight PMU based implementation. So it is
>    open for discussion if the name can stay or a "generic" name is required.
>    Please see the following thread:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2022-May/740485.html
> 
> Besar Wicaksono (2):
>   perf: coresight_pmu: Add support for ARM CoreSight PMU driver
>   perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
> 
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/perf/Kconfig                          |    2 +
>  drivers/perf/Makefile                         |    1 +
>  drivers/perf/coresight_pmu/Kconfig            |   10 +
>  drivers/perf/coresight_pmu/Makefile           |    7 +
>  .../perf/coresight_pmu/arm_coresight_pmu.c    | 1317 +++++++++++++++++
>  .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  300 ++++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
>  9 files changed, 1802 insertions(+)

How does this interact with all the stuff we have under
drivers/hwtracing/coresight/?

Will
