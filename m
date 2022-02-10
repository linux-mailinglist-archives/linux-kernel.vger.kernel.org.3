Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64714B0205
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiBJBXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:23:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiBJBXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:23:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650931EC7D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456220; x=1675992220;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3TVWAm9LlhlLa2IkCVU8wnRmJGrW+1uk41RrCt4p/Tc=;
  b=nIveuFRjgR54ayuDiKg1FgrmA2M6tKaD/CUQGoG1yYChZZzEqGEfDYzt
   +SnpZkf6dVZMf9lzR7Cp8/V/vsrgKjapPuwNtmneUShkNqkcJZs2WS5Hg
   bi/TT9Nx1iMaCVtcmmYZIjWMXhtyQieE5epfa2CQSMoFgsaWILmB3N2rM
   ILoLDMyib7eF5tH1DclwpLKvnekhLd8GuoT4d1VkyTItTsC+GUM+X5lgr
   MOWAR5gnuqCgfDaCT2PXZu1Wykg7Q0jKiF3KmcIl336oB99QyipfqYWar
   E5BKL3lUIG44ScRU41CUytJpDYz7F1bJWlI1kMGCT6td9UklYhQT+fr8g
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="273923635"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="273923635"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:52:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="678968070"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 16:52:21 -0800
Message-ID: <27fbcb02-4f13-3377-eadd-e689ce063348@linux.intel.com>
Date:   Thu, 10 Feb 2022 08:51:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] iommu: Remove unused argument in
 is_attach_deferred
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-9-baolu.lu@linux.intel.com>
 <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 9:52 PM, Robin Murphy wrote:
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 2b5f4e57a8bb..80f1294be634 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5052,8 +5052,7 @@ intel_iommu_dev_disable_feat(struct device *dev, 
>> enum iommu_dev_features feat)
>>       }
>>   }
>> -static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
>> -                       struct device *dev)
>> +static bool intel_iommu_is_attach_deferred(struct device *dev)
>>   {
>>       return attach_deferred(dev);
> 
> Seems like there's no need to wrap this now?

Yes. It's pointless.

Best regards,
baolu

