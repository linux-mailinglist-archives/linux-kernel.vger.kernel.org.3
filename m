Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5AC4B60D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiBOCKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:10:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiBOCKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:10:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB5E141444
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644891009; x=1676427009;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KarI2KGIBoMIjz9i6cuv3KYdqwF8kbc+NTQdpXJE3+M=;
  b=FsNlWmjhyOZDi489WZsUe3KBGfldmrfMgr77atLkI7gpSRsxl8D0a7FK
   1UCkHJPwl98H/LYi6GO7zFUMWdYT4df42sws1JxyCEzJM+MJXk4IJSdXI
   5+Kvxw+OINR2yyU74HAsZjuvv8wh64LtbxArJjzQNyn6n2amx7dvPU2EU
   jNE0/2qEftIV6GVq73yBav1p92fAvujwZ2Uyw49634VBdkuCQ7o7iw0rO
   IqO0K7uWASzshFfT7DAYJeWEDTypFC6hdbPv9D7vlClmjn06jqJxOQ+87
   6gA09mnmwfZF5tsJNPikQe8DUeEeBvvCeFU5Zpx2dN4z4TrmaH614scKL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336657705"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="336657705"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 18:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680795973"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 18:10:04 -0800
Message-ID: <a663613f-c417-715b-7071-1a992adb8c68@linux.intel.com>
Date:   Tue, 15 Feb 2022 10:08:46 +0800
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
Subject: Re: [PATCH v3 06/10] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-7-baolu.lu@linux.intel.com>
 <YgpQjJPZnnOJUepv@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpQjJPZnnOJUepv@8bytes.org>
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

On 2/14/22 8:52 PM, Joerg Roedel wrote:
> On Mon, Feb 14, 2022 at 09:55:34AM +0800, Lu Baolu wrote:
>> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
>> field. Retrieve the value from the right place.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> I guess this is picked up by the DRM maintainers?
> 

I would like this patch to go through the iommu tree. This series could
not be compiled without this change.

Best regards,
baolu
