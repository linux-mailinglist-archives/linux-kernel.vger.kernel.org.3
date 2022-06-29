Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7F55FF26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiF2L6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiF2L55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:57:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2E8387B1;
        Wed, 29 Jun 2022 04:57:56 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY0Lr1xbbz67yhs;
        Wed, 29 Jun 2022 19:57:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 13:57:53 +0200
Received: from [10.195.245.77] (10.195.245.77) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 12:57:52 +0100
Message-ID: <416ebe33-28ed-eef0-0001-83efd83a9d0f@huawei.com>
Date:   Wed, 29 Jun 2022 12:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/5] dma-mapping: Add dma_opt_mapping_size()
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linuxarm@huawei.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <m.szyprowski@samsung.com>,
        <joro@8bytes.org>, <hch@lst.de>, <will@kernel.org>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-2-git-send-email-john.garry@huawei.com>
 <bbca5df5-8681-d6d9-201d-3d48b34e3001@arm.com>
 <a2e717d0-c3e2-ea98-9d8b-cee1fd37c117@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <a2e717d0-c3e2-ea98-9d8b-cee1fd37c117@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.77]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 12:27, John Garry via iommu wrote:
> On 28/06/2022 12:23, Robin Murphy wrote:
>>> +
>>> +    size_t
>>> +    dma_opt_mapping_size(struct device *dev);
>>> +
>>> +Returns the maximum optimal size of a mapping for the device. 
>>> Mapping large
>>> +buffers may take longer so device drivers are advised to limit total 
>>> DMA
>>> +streaming mappings length to the returned value.
>>
>> Nit: I'm not sure "advised" is necessarily the right thing to say in 
>> general - that's only really true for a caller who cares about 
>> throughput of churning through short-lived mappings more than anything 
>> else, and doesn't take a significant hit overall from splitting up 
>> larger requests. I do think it's good to clarify the exact context of 
>> "optimal" here, but I'd prefer to be objectively clear that it's for 
>> workloads where the up-front mapping overhead dominates.
> 
I'm going to go with something like this:

size_t
dma_opt_mapping_size(struct device *dev);

Returns the maximum optimal size of a mapping for the device.

Mapping larger buffers may take much longer in certain scenarios. In 
addition, for high-rate short-lived streaming mappings the upfront time 
spent on the mapping may account for an appreciable part of the total 
request lifetime. As such, if splitting larger requests incurs no 
significant performance penalty, then device drivers are advised to 
limit total DMA streaming mappings length to the returned value.

Let me know if you would like it further amended.

Cheers,
John
