Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4247AABE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhLTN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:57:24 -0500
Received: from foss.arm.com ([217.140.110.172]:55256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232475AbhLTN5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:57:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93520D6E;
        Mon, 20 Dec 2021 05:57:23 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D37F3F718;
        Mon, 20 Dec 2021 05:57:21 -0800 (PST)
Message-ID: <85c60ef4-e1af-c947-a2ed-b63c4fef36c3@arm.com>
Date:   Mon, 20 Dec 2021 13:57:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/5] iommu: Separate IOVA rcache memories from iova_domain
 structure
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, baolu.lu@linux.intel.com
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-5-git-send-email-john.garry@huawei.com>
 <2c58036f-d9aa-61f9-ae4b-f6938a135de5@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2c58036f-d9aa-61f9-ae4b-f6938a135de5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2021-12-20 08:49, John Garry wrote:
> On 24/09/2021 11:01, John Garry wrote:
>> Only dma-iommu.c and vdpa actually use the "fast" mode of IOVA alloc and
>> free. As such, it's wasteful that all other IOVA domains hold the rcache
>> memories.
>>
>> In addition, the current IOVA domain init implementation is poor
>> (init_iova_domain()), in that errors are ignored and not passed to the
>> caller. The only errors can come from the IOVA rcache init, and fixing up
>> all the IOVA domain init callsites to handle the errors would take some
>> work.
>>
>> Separate the IOVA rache out of the IOVA domain, and create a new IOVA
>> domain structure, iova_caching_domain.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Hi Robin,
> 
> Do you have any thoughts on this patch? The decision is whether we stick 
> with a single iova domain structure or support this super structure for 
> iova domains which support the rcache. I did not try the former - it 
> would be do-able but I am not sure on how it would look.

TBH I feel inclined to take the simpler approach of just splitting the 
rcache array to a separate allocation, making init_iova_rcaches() public 
(with a proper return value), and tweaking put_iova_domain() to make 
rcache cleanup conditional. A residual overhead of 3 extra pointers in 
iova_domain doesn't seem like *too* much for non-DMA-API users to bear. 
Unless you want to try generalising the rcache mechanism completely away 
from IOVA API specifics, it doesn't seem like there's really enough to 
justify the bother of having its own distinct abstraction layer.

Cheers,
Robin.
