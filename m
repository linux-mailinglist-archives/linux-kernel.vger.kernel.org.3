Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4402E4B3FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiBNDBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:01:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbiBNDBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:01:15 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE1650E19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 19:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807666; x=1676343666;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p2vQ+UAviLd5lnbMwBPi9FpeI0f022As0OZJg61G+20=;
  b=Di9GxmysSAsA3tuYlIwb+knHQjB2AFm44AF3DhTSK46u2iQd8b7gJCDO
   yvyqCBO9cqi+fezbdva3kiUYEG6Ut2FvzbOSDfi7YxgDluStgdjf8L6xV
   CflRh9a2fvpT2vFOmHy5gaT4GPV6rTvvM7GFLGYXAiS9xCqVvuJNO1k14
   hUigUTWXIleDw6KjP/gn+2EGtfLXNqh9R1Z/HiOjgXc2BAez/FGBeSNYN
   c5Mj9fCZi+kWjOigD5PRG4pI+ZGGbd+7F0Ck+s1fG5uGRSQbYFL/7h8ux
   m9BLfbGUQFKb1E36Z6YLJUn0sws356y4g+lHfUpCwkLsUamEJZW4idAIf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310736577"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="310736577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 19:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="680167100"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 19:01:03 -0800
Message-ID: <9d123ace-8e76-2d4d-0802-4ba5f21acfe9@linux.intel.com>
Date:   Mon, 14 Feb 2022 10:59:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] iommu/vt-d: Some Intel IOMMU cleanups
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 2:41 PM, Lu Baolu wrote:
> Hi folks,
> 
> After a long time of evolution, the drivers/iommu/intel/iommu.c becomes
> fat and a bit messy. This series tries to cleanup and refactor the
> driver to make it more concise. Your comments are very appreciated.
> 
> Best regards,
> baolu
> 
> Lu Baolu (10):
>    iommu/vt-d: Move DMAR specific helpers into dmar.c
>    iommu/vt-d: Remove intel_iommu::domains
>    iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
>    iommu/vt-d: Remove iova_cache_get/put()
>    iommu/vt-d: Remove domain and devinfo mempool
>    iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
>    iommu/vt-d: Use an xarray for global device_domain_info
>    iommu/vt-d: Use rculist for dmar_domain::devices
>    iommu/vt-d: Refactor dmar_insert_one_dev_info()
>    iommu/vt-d: Some cleanups in iommu.c
> 
>   include/linux/dmar.h          |   43 +-
>   include/linux/intel-iommu.h   |  220 ++++++-
>   drivers/iommu/intel/debugfs.c |    3 -
>   drivers/iommu/intel/dmar.c    |  216 ++++++-
>   drivers/iommu/intel/iommu.c   | 1109 ++++++---------------------------
>   5 files changed, 650 insertions(+), 941 deletions(-)
> 

Thanks for your review comments. A new version of this series has been
posted.

https://lore.kernel.org/linux-iommu/20220214025704.3184654-1-baolu.lu@linux.intel.com/

Best regards,
baolu
