Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4B46DF4F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbhLIAP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:15:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:3143 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241385AbhLIAP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:15:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="301365748"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="301365748"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:12:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="503279210"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.146.48]) ([10.209.146.48])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:12:24 -0800
Message-ID: <5fec4e7e-be37-193b-b4ab-dd1bbdb589d1@intel.com>
Date:   Wed, 8 Dec 2021 17:12:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com> <20211208115516.1d36fed9@jacob-builder>
 <20211208203022.GF6385@nvidia.com> <20211208135945.6d0a3b69@jacob-builder>
 <20211208233936.GI6385@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20211208233936.GI6385@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/2021 4:39 PM, Jason Gunthorpe wrote:
> On Wed, Dec 08, 2021 at 01:59:45PM -0800, Jacob Pan wrote:
>> Hi Jason,
>>
>> On Wed, 8 Dec 2021 16:30:22 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>>> On Wed, Dec 08, 2021 at 11:55:16AM -0800, Jacob Pan wrote:
>>>> Hi Jason,
>>>>
>>>> On Wed, 8 Dec 2021 09:13:58 -0400, Jason Gunthorpe <jgg@nvidia.com>
>>>> wrote:
>>>>>> This patch utilizes iommu_enable_pasid_dma() to enable DSA to
>>>>>> perform DMA requests with PASID under the same mapping managed by
>>>>>> DMA mapping API. In addition, SVA-related bits for kernel DMA are
>>>>>> removed. As a result, DSA users shall use DMA mapping API to obtain
>>>>>> DMA handles instead of using kernel virtual addresses.
>>>>> Er, shouldn't this be adding dma_map/etc type calls?
>>>>>
>>>>> You can't really say a driver is using the DMA API without actually
>>>>> calling the DMA API..
>>>> The IDXD driver is not aware of addressing mode, it is up to the user of
>>>> dmaengine API to prepare the buffer mappings. Here we only set up the
>>>> PASID such that it can be picked up during DMA work submission. I
>>>> tested with /drivers/dma/dmatest.c which does dma_map_page(),
>>>> map_single etc. also tested with other pieces under development.
>>> Ignoring the work, doesn't IDXD prepare the DMA queues itself, don't
>>> those need the DMA API?
>>>
>> Do you mean wq completion record address? It is already using DMA API.
>> 	wq->compls = dma_alloc_coherent(dev, wq->compls_size,
>> &wq->compls_addr, GFP_KERNEL);
>> 	desc->compl_dma = wq->compls_addr + idxd->data->compl_size * i;
> I would have expected something on the queue submission side too?

DSA is different than typical DMA devices in the past. Instead of a 
software descriptor ring where the device DMA to fetch the descriptors 
after the software ringing a doorbell or writing a head index, the 
descriptors are submitted directly to the device via a CPU instruction 
(i.e. MOVDIR64B or ENQCMD(S)). The CPU takes the KVA of the 64B 
descriptor and writes to the device atomically. No DMA mapping is 
necessary in this case.


>
>>> the same thing, they do not use the same IOVA's. Did you test this
>>> with bypass mode off?
>> Yes with dmatest. IOVA is the default, I separated out the SATC patch which
>> will put internal accelerators in bypass mode. It can also be verified by
>> iommu debugfs dump of DMA PASID (2) and PASID 0 (RIDPASID) are pointing to
>> he same default domain. e.g
> Well, OK then..
>
> Jason
