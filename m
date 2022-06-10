Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4940545C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbiFJGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiFJGd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:33:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6266A278983
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654842834; x=1686378834;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VxhgqNYf0SKS4PuZWQHuLi3Er748VOZpshJSXAdV+8A=;
  b=i1W3QokokkXMWa/m7j6pp5k5OXPhQX8bUAdVgNMdFyRCU3Bfpm52Rz3j
   nC/zQ1z8hgzuV4v6REUxuUmEu+935VuhzIlhAyi5WpVReK0q85MiTUV2A
   +w1D0M1O2VqH5iZeEUE8/o6PbEZ9HGeT++yRn3OV8HY4+DFjRAw1Oy+Ab
   S1Ij4Bqy/K7mxFZWKGjLW/ON4MI1AGOGO9WSj0w0FdchVD21KTAPL/3kv
   D2dIBD7jdKSzVWn2eVsp/Jcd9nesOw4X/TCyAzU7IqmSeYXD30DR7+ufT
   zyHggYQexkQpPnh5A9PdcUulc2qmDC0oABH4XlQsW7Ja2/Lz8a483IVse
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341597100"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341597100"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:33:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637967680"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148]) ([10.249.169.148])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:33:49 -0700
Message-ID: <3923e5ab-a108-b82f-28ab-584ab0d562e4@linux.intel.com>
Date:   Fri, 10 Jun 2022 14:33:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v8 01/11] iommu: Add max_pasids field in struct
 iommu_device
Content-Language: en-US
To:     "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-2-baolu.lu@linux.intel.com>
 <20220609172542.GB33363@araj-dh-work>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609172542.GB33363@araj-dh-work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/10 01:25, Raj, Ashok wrote:
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 4f29139bbfc3..e065cbe3c857 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -479,7 +479,6 @@ enum {
>>   #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
>>   #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>>   
>> -extern int intel_iommu_sm;
>>   extern spinlock_t device_domain_lock;
>>   
>>   #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
>> @@ -786,6 +785,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>>   extern const struct iommu_ops intel_iommu_ops;
>>   
>>   #ifdef CONFIG_INTEL_IOMMU
>> +extern int intel_iommu_sm;
>>   extern int iommu_calculate_agaw(struct intel_iommu *iommu);
>>   extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>>   extern int dmar_disabled;
>> @@ -802,6 +802,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
>>   }
>>   #define dmar_disabled	(1)
>>   #define intel_iommu_enabled (0)
>> +#define intel_iommu_sm (0)
> Is the above part of this patch? Or should be moved up somewhere?

This is to make pasid_supported() usable in dmar.c. It's only needed by
the change in this patch. I should make this clear in the commit
message. :-)

Best regards,
baolu
