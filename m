Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C44E2440
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346293AbiCUKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbiCUKYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:24:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE04635DCA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647858192; x=1679394192;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y8pIweaAMyTCi93qGcfIHb2ZdfwxCLpe+KI0+IDSZLM=;
  b=WhTkGhnwfL6galtD5r3rVfT9kgqDUop1QvwwS+710I8jlOG1xt4d1g0z
   hMTdFGH/R10YBAxOtZZC4QedtHByowKBetZB4OW0Y7P9wkywhDA8KM2yr
   f2IQESvmbJHGqmXpuiOjP7tBVBxpuUbKTGKQdCwfpe276rqPPBo9qSCH5
   5nt6yG3K/mA0X177lJkmlFoaIuuuYpePwGOkoEdNrSRJJE6aBe4Nnvgct
   R5aljzynlM/B2tfgP99RYUciv0XCsRkIv+W69iHDwMKpzoOVkLZP3P1NV
   xl+ofxNnIoXK0LGqTElFBsiQad6XMgpeGn7Uqg6qmVb18A8tzSRCYlMKZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257707602"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257707602"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:23:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="559805481"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169]) ([10.254.213.169])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:23:08 -0700
Message-ID: <4f9d5857-c16d-8201-00ea-28f0cb6bbaf8@linux.intel.com>
Date:   Mon, 21 Mar 2022 18:23:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271E3ACDCB85F1CD92797B38C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271E3ACDCB85F1CD92797B38C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 15:06, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>>
>> Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O
>> page
>> table which is shared from CPU host VA. Add a sva_cookie field in the
>> iommu_domain structure to save the mm_struct which represent the CPU
>> memory page table.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 36f43af0af53..3e179b853380 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity
>> mapped   */
>>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses
>> flush queue    */
>>
>> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from
>> CPU  */
>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual
>> address */
> suppose the SHARED bit will be also used for KVM page table sharing and
> HOST_VA bit is to differentiate mm sharing from the latter?
> 

Yes, that's my intention.

Best regards,
baolu
