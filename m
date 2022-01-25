Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232ED49A865
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1318466AbiAYDFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:05:48 -0500
Received: from foss.arm.com ([217.140.110.172]:34126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415843AbiAYBwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:52:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 792F51FB;
        Mon, 24 Jan 2022 17:52:31 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55CAA3F766;
        Mon, 24 Jan 2022 17:52:29 -0800 (PST)
Message-ID: <bafad6f5-43bb-d016-035a-34c8daed059d@arm.com>
Date:   Tue, 25 Jan 2022 01:52:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Content-Language: en-GB
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <20220124173650.GF966497@nvidia.com>
 <BN9PR11MB5276232DDAFC8041D5E795DE8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB5276232DDAFC8041D5E795DE8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 01:11, Tian, Kevin wrote:
>> From: Jason Gunthorpe via iommu
>> Sent: Tuesday, January 25, 2022 1:37 AM
>>> @@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
>>>   			msg->pasid = 0;
>>>   		}
>>>
>>> -		ret = domain->ops->page_response(dev, evt, msg);
>>> +		ret = ops->page_response(dev, evt, msg);
>>>   		list_del(&evt->list);
>>>   		kfree(evt);
>>>   		break;
>>
>> Feels weird that page_response is not connected to a domain, the fault
>> originated from a domain after all. I would say this op should be
>> moved to the domain and the caller should provide the a pointer to the
>> domain that originated the fault.
>>
> 
> In concept yes.

Not even that, really. It's true that the "fault" itself is logically 
associated with the domain, but we never see that - the ATS request and 
response which encapsulate it all happen automatically on the PCI side. 
It's the endpoint that then decides to handle ATS translation failure 
via PRI, so all we actually get is a page request message from a 
RID/PASID, which most definitely represents the "device" (and in fact 
having to work backwards from there to figure out which domain/context 
it is currently attached to can be a bit of a pain). Similarly the 
response is a message directly back to the device itself - an operation 
on a domain may (or may not) have happened off the back of receiving the 
initial request, but even if the content of the response is to reflect 
that, the operation of responding is clearly focused on the device.

I fully agree that it's a weird-looking model, but that's how PCI SIG 
made it - and no IOMMU architecture seems to have tried to wrap it up in 
anything nicer either - so I don't see that we'd gain much from trying 
to pretend otherwise :)

Robin.

> But currently the entire sva path is not associated with domain. This was
> one mistake as we discussed in the cover letter. Before extending iommu
> domain to cover CPU page tables we may have to leave it in iommu_ops
> given this series is just for cleanup...
> 
> Thanks
> Kevin
