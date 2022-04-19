Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5D45070D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352030AbiDSOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351049AbiDSOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:43:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4978E21273
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC6EAB81A31
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7148C385A7;
        Tue, 19 Apr 2022 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650379249;
        bh=Odi8T0lKvsQl0jnz2foSSFYzVl+S20L3qwLS1xH/7sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSnqvlxlX/BIuR7YrwvP9faodWrQ4zMTWlogOqkPjoxlSyX+YWrngYqr5os6Op2Oo
         QssVb/+81BkFtPjkdzMQX49Ws48Qm6LvwpgrHBxsW7kyu5cAaMSwfoNGK8M3B4ZqKM
         8igvaSFwZ8u9Fj+8QqLEQ2gGxCqPeUIiSdh+LvNSpdt7YRHVQKNmzDRUao6hh0cjoe
         /3ExFvfm2U/MRwGMRsc9JVuIqk6HGgfJ4D0DRQQIfGk12CenNIiebP1vDGC2m0XhSK
         3dOVdOi9jd8GKR71avgLQ1AImPdYIHVLlwVEYtv1rGQBc5oOCg62H4Y3cGL5WmNVs7
         8eowSPCNLadxg==
Date:   Tue, 19 Apr 2022 15:40:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] iommu/arm-smmu: Clean up bus_set_iommu()
Message-ID: <20220419144042.GA6186@willie-the-truck>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
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

On Thu, Apr 14, 2022 at 01:42:33PM +0100, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary. With device
> probes now replayed for every IOMMU instance registration, the whole
> sorry ordering workaround for legacy DT bindings goes too, hooray!

Ha, I hope you tested this!

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 84 +--------------------------
>  1 file changed, 2 insertions(+), 82 deletions(-)

Assuming it works,

Acked-by: Will Deacon <will@kernel.org>

Will
