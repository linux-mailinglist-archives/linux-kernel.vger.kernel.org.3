Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671455401E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355442AbiFVBgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiFVBgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:36:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C75FF58F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655861801; x=1687397801;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zqCWDRHMK5Aix9ertSDJIJ+yaJFXeDzuTdpljbqYeik=;
  b=X/vI6DfB+or4sla8wjx0RK0brB1zZYN+x9ld6v5eEnoYCONjw2Avm0gH
   hfrFugpQiGd8AKyTw1opJ0LrPj1VdDf9nGEjgahqohdjPtyRtRL/mAZfD
   kwAEDwabY/R4CbzsoZiF4KjrALC8VE2hGQTsLS6F31p4eVWVReM9mhldX
   6cKwAxrrCjDgoR8pzIC2Gy8DcSpATGlgWNJanmzn+OEYpAk0sRaFWXFsM
   5uVd9uufPc0BJqhraMl838iTEV346mwt/ej7IkI+8oCZgYYPm/W9b19Ik
   hiU/3nx5LOG2BEDmMh5P7FSqSic9zvhmIuGyaLdklpMdQQLeUk8NpJR+N
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="366607050"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="366607050"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 18:36:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="833849548"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26]) ([10.249.172.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 18:36:39 -0700
Message-ID: <59002dbd-d72a-4f9c-7ad8-808ee8d2ff05@linux.intel.com>
Date:   Wed, 22 Jun 2022 09:36:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: Clean up release_device checks
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <02671dbfad7a3343fc25a44222350efcb455fe3c.1655822151.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/21 23:14, Robin Murphy wrote:
> Since .release_device is now called through per-device ops, any call
> which gets as far as a driver definitely*is*  for that driver, for a
> device which has successfully passed .probe_device, so all the checks to
> that effect are now redundant and can be removed. In the same vein we
> can also skip freeing fwspecs which are now managed by core code.

Does this depend on any other series? I didn't see iommu_fwspec_free()
called in the core code. Or I missed anything?

> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---
>   drivers/iommu/apple-dart.c                  |  3 ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  8 +-------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 14 +++-----------
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 11 -----------
>   drivers/iommu/exynos-iommu.c                |  3 ---
>   drivers/iommu/mtk_iommu.c                   |  5 -----
>   drivers/iommu/mtk_iommu_v1.c                |  5 -----
>   drivers/iommu/sprd-iommu.c                  | 11 -----------
>   drivers/iommu/virtio-iommu.c                |  8 +-------
>   9 files changed, 5 insertions(+), 63 deletions(-)

Best regards,
baolu
