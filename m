Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D847D152
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhLVLxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:53:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4319 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbhLVLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:53:15 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJs9S1wfNz67s22;
        Wed, 22 Dec 2021 19:51:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 12:53:13 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 11:53:12 +0000
Subject: Re: [PATCH 4/5] iommu: Separate IOVA rcache memories from iova_domain
 structure
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>
CC:     <xieyongji@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-5-git-send-email-john.garry@huawei.com>
 <2c58036f-d9aa-61f9-ae4b-f6938a135de5@huawei.com>
 <85c60ef4-e1af-c947-a2ed-b63c4fef36c3@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <045030ed-0151-6259-e336-4235d6456223@huawei.com>
Date:   Wed, 22 Dec 2021 11:53:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <85c60ef4-e1af-c947-a2ed-b63c4fef36c3@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2021 13:57, Robin Murphy wrote:
>> Do you have any thoughts on this patch? The decision is whether we 
>> stick with a single iova domain structure or support this super 
>> structure for iova domains which support the rcache. I did not try the 
>> former - it would be do-able but I am not sure on how it would look.
> 
> TBH I feel inclined to take the simpler approach of just splitting the 
> rcache array to a separate allocation, making init_iova_rcaches() public 
> (with a proper return value), and tweaking put_iova_domain() to make 
> rcache cleanup conditional. A residual overhead of 3 extra pointers in 
> iova_domain doesn't seem like *too* much for non-DMA-API users to bear. 

OK, fine. So I tried as you suggested and it looks ok to me.

I'll send something out at rc1.

> Unless you want to try generalising the rcache mechanism completely away 
> from IOVA API specifics, it doesn't seem like there's really enough to 
> justify the bother of having its own distinct abstraction layer.

Yeah, I don't see that as necessary.

However something which could be useful is to separate the magazine code 
out for other possible users.

Thanks!
John
