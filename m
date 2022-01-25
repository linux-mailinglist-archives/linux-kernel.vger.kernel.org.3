Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7043249AB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S254759AbiAYEqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:46:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:65395 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1326570AbiAYDld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643082093; x=1674618093;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wOB58ZPoueIj6QpOzMFfqSKsRaOTihrM6SenjvkBkNM=;
  b=WjD2jRySJj6QcPC7JBb0EEHsjLOH+CqymOK+fRUW1NvElb2/q0DGO+/o
   1xPNwKiMZHpjKrQne2fkJ9cWIQ9On2OwW6Axcq27qdrVxYkj0VqQSm67Q
   0hYDWD2NNl5NBJRgWiPPfNm7spsr4lu9jiNSPHJkkWvJ2DKdnpyMneI3J
   RjwLAERkniP51oPRZXo0w2GQZKLUAJXV2T/1l3YnX56SKkdHQ7Yz1RfFV
   lSXqRRO+lnmR8aLUZ7U/VkHDS7WjaAcLQcb8XjoTfEDFbpIapzq4Fgb8C
   9LmFcWWAXrhjPrBi202X3rNrTPsbceA9WeqcE1m2twJODjZz7jjdOh8UI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246154342"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="246154342"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534540041"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:32:50 -0800
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <20220124173650.GF966497@nvidia.com>
 <BN9PR11MB5276232DDAFC8041D5E795DE8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bafad6f5-43bb-d016-035a-34c8daed059d@arm.com>
 <BN9PR11MB5276004DA74B04B95D6A3CBB8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <07ecce72-1904-d695-6ae9-bfaa2fcfe0cc@linux.intel.com>
Date:   Tue, 25 Jan 2022 11:31:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5276004DA74B04B95D6A3CBB8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 10:08 AM, Tian, Kevin wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Tuesday, January 25, 2022 9:52 AM
>>
>> On 2022-01-25 01:11, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe via iommu
>>>> Sent: Tuesday, January 25, 2022 1:37 AM
>>>>> @@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
>>>>>    			msg->pasid = 0;
>>>>>    		}
>>>>>
>>>>> -		ret = domain->ops->page_response(dev, evt, msg);
>>>>> +		ret = ops->page_response(dev, evt, msg);
>>>>>    		list_del(&evt->list);
>>>>>    		kfree(evt);
>>>>>    		break;
>>>>
>>>> Feels weird that page_response is not connected to a domain, the fault
>>>> originated from a domain after all. I would say this op should be
>>>> moved to the domain and the caller should provide the a pointer to the
>>>> domain that originated the fault.
>>>>
>>>
>>> In concept yes.
>>
>> Not even that, really. It's true that the "fault" itself is logically
>> associated with the domain, but we never see that - the ATS request and
>> response which encapsulate it all happen automatically on the PCI side.
>> It's the endpoint that then decides to handle ATS translation failure
>> via PRI, so all we actually get is a page request message from a
>> RID/PASID, which most definitely represents the "device" (and in fact
>> having to work backwards from there to figure out which domain/context
>> it is currently attached to can be a bit of a pain). Similarly the
>> response is a message directly back to the device itself - an operation
>> on a domain may (or may not) have happened off the back of receiving the
>> initial request, but even if the content of the response is to reflect
>> that, the operation of responding is clearly focused on the device.
>>
>> I fully agree that it's a weird-looking model, but that's how PCI SIG
>> made it - and no IOMMU architecture seems to have tried to wrap it up in
>> anything nicer either - so I don't see that we'd gain much from trying
>> to pretend otherwise :)
>>
> 
> I think the point here is that although page requests are received
> per device from the wire the low level iommu driver should convert
> those requests into domain-wide requests (with RID/PASID recorded
> as private data in the request) which then can be handled by domain
> ops in iommu core. Once a domain-wide request is completed by
> the iommu core, the low level iommu driver then retrieves RID/PASID
> information from private data of the completed request and triggers
> page response per RID/PASID in bus specific way.

I also have a pending series to associate the sva with an iommu domain
and make the existing I/O page fault framework generic (vs. sva
specific). Perhaps we can discuss the page fault handle/response there
with the real code.

> 
> Does it sound reasonable?
> 
> Thanks
> Kevin
> 

Best regards,
baolu
