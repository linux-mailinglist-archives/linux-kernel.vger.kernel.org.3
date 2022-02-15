Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBAC4B630D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiBOFru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:47:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiBOFrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:47:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E680665D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644904059; x=1676440059;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FB4ZrG+H6kHcJlMBI4utm8Pv+AllaomNjuD3vYEkBkw=;
  b=nRC0zS16r33xIh/169umun5mIqiiN9N/M/cVFn2XYgON4cTXmrIc4OxU
   qN6mSI0i4JyaBeaZYRQetxJpQ1Kq7MXAXSdVN01DvpfaGT06d6ROiIeRG
   jf+FDPRp9dRcUnETECT/iVZsWCZ7iqt1R264PGSWeAljdGcWv1XUyQBr9
   5ykGyqrrqbUmDaDvAhhwhtP8Mb8lpgWwcmBXE4uCF0mGWhsuSDcp/o2PA
   VbzqXgRCklI3lNFeXTeBaP0OOZm8L3YvwsD42UdovUg8O768hzXqcsSrj
   s+UAOnLbA/6lT9CvlvT1qmmhuWopEksDdX3mnzAFlVcyy1uHIp97D+R8Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313529375"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="313529375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 21:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680850350"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 21:47:36 -0800
Message-ID: <b8420944-03ec-e426-e1fa-789b17604686@linux.intel.com>
Date:   Tue, 15 Feb 2022 13:46:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] iommu/vt-d: Use xarray for global
 device_domain_info
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-11-baolu.lu@linux.intel.com>
 <20220214140038.GB4160@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220214140038.GB4160@nvidia.com>
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

Hi Jason,

On 2/14/22 10:00 PM, Jason Gunthorpe wrote:
>> +
>> +/* Convert device source ID into the index of device_domain_array. */
>> +static inline unsigned long devi_idx(unsigned long seg, u8 bus, u8 devfn)
>> +{
>> +	return (seg << 16) | PCI_DEVID(bus, devfn);
>> +}
>>   
>>   /*
>> - * Iterate over elements in device_domain_list and call the specified
>> + * Iterate over elements in device_domain_array and call the specified
>>    * callback @fn against each element.
>>    */
>>   int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>>   				     void *data), void *data)
>>   {
>> -	int ret = 0;
>> -	unsigned long flags;
>>   	struct device_domain_info *info;
>> +	unsigned long index;
>> +	int ret = 0;
>>   
>> -	spin_lock_irqsave(&device_domain_lock, flags);
>> -	list_for_each_entry(info, &device_domain_list, global) {
>> +	rcu_read_lock();
>> +	xa_for_each(&device_domain_array, index, info) {
>>   		ret = fn(info, data);
>> -		if (ret) {
>> -			spin_unlock_irqrestore(&device_domain_lock, flags);
>> -			return ret;
>> -		}
>> +		if (ret)
>> +			break;
> And you probably shouldn't try to use RCU. It is really unclear how
> this function can be useful while racing against
> intel_iommu_release_device(), eg today the only user of this function
> does:
> 
> static int search_pasid_table(struct device_domain_info *info, void *opaque)
> {
> 	struct pasid_table_opaque *data = opaque;
> 
> 	if (info->iommu->segment == data->segment &&
> 	    info->bus == data->bus &&
> 	    info->devfn == data->devfn &&
> 
> And even if you kfree_rcu(info) then 'info->iommu->' is still racy
> unlocked.
> 
> RCU is complicated to use, it is not just a drop in replacement for a
> spinlock.

Thanks for your comments. I am going to stop this patch (and the next
11/11) and spend more time figuring them out.

Best regards,
baolu
