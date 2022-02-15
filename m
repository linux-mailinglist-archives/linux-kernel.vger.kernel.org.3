Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791EA4B6014
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiBOBky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:40:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiBOBkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:40:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FEA1405CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644889244; x=1676425244;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KYWNub4KIGvtKYUBq0gCFrcp5xgJGm+OQNdJMARo9G8=;
  b=XSvi/c4fFlhBzrrBBDvS8nfT4Tz2HMh6A8cxJAYh2W862nqvV9XJQXA2
   zeh5OCRzgxZrFTBI3pmiSqlFxtU+NJ4cE1mvG9OlR69quvTu1P7es+4KU
   2OjJkP/BGesxVuI6hySpfbt64VtsrnGCfyAzMfltF9fNFto4ZCccz5XIE
   BsEsdcQ2S1L+G8L8+mQYYLRBFYPHjakRkaeDzrWWrfKFtbh6vvsPFInjz
   TFiB3Jexu4EGv+7WGKxGqQKPhQT5xJqFsX9Cfc+KEaBBtaw6pRaSwLufr
   nKCa13DUepnvUhPqF/3cPIdkcGyfabPz6eL9oU+5USDto80vEwFZBGNOd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="274799501"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="274799501"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680788159"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:40:39 -0800
Message-ID: <43855d9f-f60a-0bb0-088d-cf0b12defb79@linux.intel.com>
Date:   Tue, 15 Feb 2022 09:39:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] iommu: Use dev_iommu_ops() helper
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-10-baolu.lu@linux.intel.com>
 <20220214132608.GA4160@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220214132608.GA4160@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 9:26 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 09:55:37AM +0800, Lu Baolu wrote:
>> This converts all the feasible instances of dev->bus->iommu_ops to
>> dev_iommu_ops() in order to make the operation of obtaining iommu_ops
>> from a device consistent. The dev_iommu_ops() warns on NULL ops, so
>> we don't need to keep the confusing ops check.
>>
>> Suggested-by: Robin Murphy<robin.murphy@arm.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 30 ++++++++++++++----------------
>>   1 file changed, 14 insertions(+), 16 deletions(-)
> I thought you were going to squish this into the prior patch?

I will merge this two patches in the next version. I made them separated
in this series just for ease of review.

Best regards,
baolu
