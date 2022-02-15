Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15014B60B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiBOCDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:03:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiBOCDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:03:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD92A108754
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644890567; x=1676426567;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQx1bi+RZ7llbsZzitox0+KHCY/gJAuQuxLD+34SPaA=;
  b=Ba+t9a4/llBJ743bF5dFLheLd7Cv7IfFQn14tpLY/7RAJyPDaEEdokIn
   46B7DGf3zPf2zH0kHgRXkoses91VmoI6vW8RNXceBdbq0EeFATROXJue9
   UTOIno2fihcQuPTdXB2LQkTfiSdfhLfTvxAIVnUWX3XSfEwdAlzSkRxf5
   zlyflQFoNBtn8676++uNckpTWvflIxSQ2ZwZKkmcUItLdV5PCs5LoQ5Xh
   fMfd7snq6q0aIfHVUfZi4Pu47khq1+7sctlRpXRt6SFa2CAuQ0a547Vcj
   tQ2zcw6vgoE2wwRd5acNCBYw3Zi3uDtzuYVi5K0lX0ntGgL2SqBZulSBn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250435769"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="250435769"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 18:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680793619"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 18:02:43 -0800
Message-ID: <0bf678af-1905-de87-322b-43703992030b@linux.intel.com>
Date:   Tue, 15 Feb 2022 10:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 07/10] iommu: Use right way to retrieve iommu_ops
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-8-baolu.lu@linux.intel.com>
 <YgpP7AhY5hd/DX/C@8bytes.org>
 <0dd0f4c9-37a6-0418-3f19-22c40ccc8265@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <0dd0f4c9-37a6-0418-3f19-22c40ccc8265@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 9:46 AM, Lu Baolu wrote:
> On 2/14/22 8:49 PM, Joerg Roedel wrote:
>> On Mon, Feb 14, 2022 at 09:55:35AM +0800, Lu Baolu wrote:
>>> +static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>>> +{
>>> +    /*
>>> +     * Assume that valid ops must be installed if iommu_probe_device()
>>> +     * has succeeded. The device ops are essentially for internal use
>>> +     * within the IOMMU subsystem itself, so we should be able to trust
>>> +     * ourselves not to misuse the helper.
>>> +     */
>>> +    WARN_ON(!dev || !dev->iommu || !dev->iommu->iommu_dev ||
>>> +        !dev->iommu->iommu_dev->ops);
>>
>> There is no need for this WARN_ON, the code will oops anyway when one of
>> the pointers checked here is NULL.
>>
> 
> We really don't need to WARN_ON intermediate null pointers. But I would
> argue that we could add a WARN() on null dev->iommu->iommu_dev->ops, so
> that callers have no need to check the returned ops.

Oh, sorry! We don't need to check null ops either. That will also result
in a null pointer reference oops in the caller.

So, yes. No need for this WARN_ON().

Best regards,
baolu
