Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2650B5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446945AbiDVK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349112AbiDVK6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E78440A0E;
        Fri, 22 Apr 2022 03:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D3261F2A;
        Fri, 22 Apr 2022 10:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6CFC385A4;
        Fri, 22 Apr 2022 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650624943;
        bh=+cKfxQ5Un069trX//5/HF8F2JDcrdgw8jHpxYnApt5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rm7Gq5OECvDvxwFdR7Xj8FjXlfDMY+5Eap+7ELRHNLNNM0V2gx6J8mIgeUyeRUBKF
         fSUqQOo+pWcBKISqrhoO8AkTvzpVynxmnve+BabpE20CoNhLVbYOdvbslVAD88N0bV
         e8AvYHfLwGG8FT6uVh1sh+XR2VApgPYU2sYLYPq7DZHF35+UxKz3bL/BuNpxPwP3oS
         Qqq/9sOp6BndsruFRqVN3PLts74vc0jR876+QwMk/gfLbl05TjX2heREryextp5AMj
         Gi6iHFIdtyzJomG5r1lV4ATpdixmakngvrpyiJYXk0DMQFbsDB+NVGFZz6VMFavWOg
         t41/kd86r+FYg==
From:   Will Deacon <will@kernel.org>
To:     jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, vdumpa@nvidia.com,
        Ashish Mhetre <amhetre@nvidia.com>, joro@8bytes.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, nicolinc@nvidia.com,
        Snikam@nvidia.com, Pritesh Raithatha <praithatha@nvidia.com>
Subject: Re: [Patch v2] iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu
Date:   Fri, 22 Apr 2022 11:55:35 +0100
Message-Id: <165053012237.502660.4418683392126519698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220421081504.24678-1-amhetre@nvidia.com>
References: <20220421081504.24678-1-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 13:45:04 +0530, Ashish Mhetre wrote:
> Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> entries to not be invalidated correctly. The problem is that the walk
> cache index generated for IOVA is not same across translation and
> invalidation requests. This is leading to page faults when PMD entry is
> released during unmap and populated with new PTE table during subsequent
> map request. Disabling large page mappings avoids the release of PMD
> entry and avoid translations seeing stale PMD entry in walk cache.
> Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
> Tegra234 devices. This is recommended fix from Tegra hardware design
> team.
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu
      https://git.kernel.org/will/c/4a25f2ea0e03

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
