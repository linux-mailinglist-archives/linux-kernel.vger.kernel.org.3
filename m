Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5D52D1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbiESLzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiESLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:55:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9EBB82ED
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652961320; x=1684497320;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TKh87fcu8gDUB/G0iIOkwc196gZQ+TKq8cbdTGbs8hs=;
  b=BcVRceX7qeTQJCUKLu/z6mJcP/iIQmbGBRg4tbJOHK0nSYkuf0y7NCdk
   gnrAt5FmcUUX7VEyMrvOPB7uzLnxhw73o3qI9QilCczKxZ8ENjyi+WIWH
   6Gr2jndOkw0DjTNWl/Xx7lLmgOQ7YWuVpUzNGse2xiV/Fqubdxw4+XIdi
   KE314vXWn98IpgmPLjRc3Y4Khw5l+Z/migHTR5ws/BR5lFgORjmHU/sxm
   5I1eADeGyE+epjwHMYmcOoX/zEGW5TaYIR+GSAcP0pvRgmRIUQIGpwOBh
   Qc58FjGehRMG6rKfWcm75PUjnmlnPaAKC9JREyHYd5BSA5FAeaOcpCzKp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="252684648"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="252684648"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 04:55:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="742878697"
Received: from zhongz9x-mobl.ccr.corp.intel.com (HELO [10.255.28.182]) ([10.255.28.182])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 04:55:15 -0700
Message-ID: <dc607792-0285-6a11-83f9-9dafd083bd9b@linux.intel.com>
Date:   Thu, 19 May 2022 19:55:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com> <YoYd43JFXJcqngby@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YoYd43JFXJcqngby@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 2022/5/19 18:37, Jean-Philippe Brucker wrote:
> On Thu, May 19, 2022 at 03:20:38PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 88817a3376ef..6e2cd082c670 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>   	/* SID/SSID sizes */
>>   	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>>   	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
>> +	smmu->iommu.pasids = smmu->ssid_bits;
> This should be 1UL << smmu->ssid_bits

Done. Thank you for the reminding.

Best regards,
baolu
