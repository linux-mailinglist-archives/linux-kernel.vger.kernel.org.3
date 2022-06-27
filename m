Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452855D9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiF0Khq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiF0Khn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:37:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2C63E3;
        Mon, 27 Jun 2022 03:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E5735CE13B0;
        Mon, 27 Jun 2022 10:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9D9C3411D;
        Mon, 27 Jun 2022 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656326259;
        bh=gVPonoPPVuCVSEsji6A1NjbiecWc5W7N4UZpiOGZZXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqFvUTQmrW5Mc1I2JqUklPlvVsLqD8kPcH7ChI2Ep54Yn2DXkUKcqav50fSVOhO3c
         5Ln5z75cGhQx/lEjkDH44uhIrFX026+9nQdVY6q7NJT7ajzKP6nj99oDKMJLAeScWp
         Ih6HpuStN9tdPgwGipAJsyTJW3VqUV6lCc88yIR9dtx5rTuTRhewBIa7IeHN5PrXLN
         o60PihSLkFmyubxW1zMBxdaZeKrOfDcae6tDkbzS8/L7TL5BqkuiK1zk40yqrEFqao
         cxMkC2CTwrp2lQGXPsizUranYQPLVfikSVOFRVyTHvlBLrLNDApLuDpwEY+XVdufuW
         yb2EsCH11AFFg==
Date:   Mon, 27 Jun 2022 11:37:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     suzuki.poulose@arm.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: Re: [RESEND PATCH v3 2/2] perf: coresight_pmu: Add support for
 NVIDIA SCF and MCF attribute
Message-ID: <20220627103731.GC22095@willie-the-truck>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-3-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621055035.31766-3-bwicaksono@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 12:50:35AM -0500, Besar Wicaksono wrote:
> Add support for NVIDIA System Cache Fabric (SCF) and Memory Control
> Fabric (MCF) PMU attributes for CoreSight PMU implementation in
> NVIDIA devices.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  drivers/perf/coresight_pmu/Makefile           |   3 +-
>  .../perf/coresight_pmu/arm_coresight_pmu.c    |   4 +
>  .../coresight_pmu/arm_coresight_pmu_nvidia.c  | 312 ++++++++++++++++++
>  .../coresight_pmu/arm_coresight_pmu_nvidia.h  |  17 +
>  4 files changed, 335 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
>  create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h

Please can you include some documentation along with this driver? See
Documentation/admin-guide/perf/ for examples of other PMUs.

Will
