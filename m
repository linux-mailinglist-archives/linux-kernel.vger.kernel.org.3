Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2633C568775
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiGFL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGFL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C692872D;
        Wed,  6 Jul 2022 04:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A2F61EF0;
        Wed,  6 Jul 2022 11:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBF2C341C0;
        Wed,  6 Jul 2022 11:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657108605;
        bh=JhfNIBk6QV+You43ySQJl94/5cn2lk5MAMXG7si7Ar4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/XQDNnHedixbjgH5tLXVkiiS6yP2P29RGmNN5aGNS9kjcwJYBr1jfoklSS6NGgNs
         UZzlaIe/sNXx963pZsvf1uWRgJjTKF+ZbzRgEkiBVQvumbK6D2cdTdxMMdZoapsNM0
         Hs8iTTrk1RmrS0fcpA6hWUbba/aGm+wtnLj+YFKoOE9B9LoNTWcCARJV5eujMdtMD+
         F41ha2s2HXU9wR02GaG7zMoJcoIOiBLUcMVLimqybrXgeD7zKGClr/BNsw++YsLTlG
         2pTjEfRCzdxoJa1nrxwuw9IQM9wK8Z4cZKRYXCNkPmNndi+1VTHcqn5vkRcVMtRoTV
         EMvD8ncAdj7bA==
Date:   Wed, 6 Jul 2022 12:56:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_guptap@quicinc.com,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Message-ID: <20220706115638.GD2403@willie-the-truck>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526041403.9984-1-quic_saipraka@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:44:03AM +0530, Sai Prakash Ranjan wrote:
> TLB sync timeouts can be due to various reasons such as TBU power down
> or pending TCU/TBU invalidation/sync and so on. Debugging these often
> require dumping of some implementation defined registers to know the
> status of TBU/TCU operations and some of these registers are not
> accessible in non-secure world such as from kernel and requires SMC
> calls to read them in the secure world. So, add this debug support
> to dump implementation defined registers for TLB sync timeout issues.
> 
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
> 
> Changes in v2:
>  * Use scm call consistently so that it works on older chipsets where
>    some of these regs are secure registers.
>  * Add device specific data to get the implementation defined register
>    offsets.
> 
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
>  3 files changed, 146 insertions(+), 18 deletions(-)

If this is useful to you, then I suppose it's something we could support,
however I'm pretty worried about our ability to maintain/scale this stuff
as it is extended to support additional SoCs and other custom debugging
features.

Perhaps you could stick it all in arm-smmu-qcom-debug.c and have a new
config option for that, so at least it's even further out of the way?

Will
