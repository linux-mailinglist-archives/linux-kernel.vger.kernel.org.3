Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F76151BEF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376300AbiEEMQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359849AbiEEMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:16:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1789864C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651752750; x=1683288750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2DhPSKq1r7S3sDZ7dC36QkPcIiYnpBlQkC9n0su6nWA=;
  b=AsvY5a+si04NRTl0EiIu4c3xx4/xbf5aACiBkXrmzE3zAMvwTVgcmST5
   PIwW74aB0YaaLk8k1arjd/pnCZaQDTXLYV0SGiin1bwjcd/HFO5tSB6CR
   ackoBDM54XkxwBMsho4mUVIIHy8QTBYmT6Ti1PTM7Gx5wtEoTsQm7COeO
   0yWV6QW7A9mHjIvCiZUbvXCM0/nEioE4YYXkw31/9W5TP6farap/Ay8M2
   IJ9KzU6qeKM/rxsDtXdCiAW2VIoJKkyJi9J+MW14sbXJZM5qIUbu4eQ3y
   KKApGvQqIhSRrzfJ5hXeIZmOIfZkwQgZF11djHSt2MZiTZ2b9Y6JSdNhy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268240484"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="268240484"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 05:12:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="563215563"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 05:12:26 -0700
Message-ID: <22359719-15c8-5215-fdf3-7eec60f2c106@linux.intel.com>
Date:   Thu, 5 May 2022 20:12:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F768185B4CB64C2D027E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F768185B4CB64C2D027E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/5 16:43, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 5, 2022 9:07 AM
>>
>> As domain->force_snooping only impacts the devices attached with the
>> domain, there's no need to check against all IOMMU units. At the same
>> time, for a brand new domain (hasn't been attached to any device), the
>> force_snooping field could be set, but the attach_dev callback will
>> return failure if it wants to attach to a device which IOMMU has no
>> snoop control capability.
> 
> The description about brand new domain is not very clear. I think the
> point here is that force_snooping could be set on a domain no matter
> whether it has been attached or not and once set it is an immutable
> flag. If no device attached the operation always succeeds then this
> empty domain can be only attached to a device of which the IOMMU
> supports snoop control.

Exactly. Will update this description.

> 
>>   static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
>> *domain)
>>   {
>>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>
>> -	if (!domain_update_iommu_snooping(NULL))
>> +	if (dmar_domain->force_snooping)
>> +		return true;
>> +
>> +	if (!domain_support_force_snooping(dmar_domain))
>>   		return false;
>> +
> 
> Who guarantees that domain->devices won't change between
> above condition check and following set operation?

Good catch. Should lift the lock up here.

> 
>> +	domain_set_force_snooping(dmar_domain);
>>   	dmar_domain->force_snooping = true;
>> +
>>   	return true;
>>   }
>>
> 
> Thanks
> Kevin

Best regards,
baolu
