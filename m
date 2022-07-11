Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862CF56D6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiGKHhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:36:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7671B787;
        Mon, 11 Jul 2022 00:36:57 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LhFw362hPz686pl;
        Mon, 11 Jul 2022 15:32:35 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 09:36:55 +0200
Received: from [10.195.33.182] (10.195.33.182) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 08:36:53 +0100
Message-ID: <a415e4a1-72ce-53e1-437a-fc7e56e4b913@huawei.com>
Date:   Mon, 11 Jul 2022 08:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/5] DMA mapping changes for SCSI core
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
CC:     <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <b5f80062-e8ef-9597-1b0c-393140950dfb@huawei.com>
 <20220706134447.GA23753@lst.de> <yq1y1x47jgn.fsf@ca-mkp.ca.oracle.com>
 <5fd4814a-81b1-0e71-58e0-57a747eb684e@huawei.com>
 <6367a264-a3d3-8857-9b5a-2afcd25580cb@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <6367a264-a3d3-8857-9b5a-2afcd25580cb@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.33.182]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
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

On 11/07/2022 00:08, Damien Le Moal wrote:
>> Ah, I think that I misunderstood Damien's question. I thought he was
>> asking why not keep shost max_sectors at dma_max_mapping_size() and then
>> init each sdev request queue max hw sectors at dma_opt_mapping_size().
> I was suggesting the reverse:)  Keep the device hard limit
> (max_hw_sectors) to the max dma mapping and set the soft limit
> (max_sectors) to the optimal dma mapping size.

Sure, but as I mentioned below, I only see a small % of requests whose 
mapping size exceeds max_sectors but that still causes a big performance 
hit. So that is why I want to set the hard limit as the optimal dma 
mapping size.

Indeed, the IOMMU IOVA caching limit is already the same as default 
max_sectors for the disks in my system - 128Kb for 4k page size.

> 
>> But he seems that you want to know why not have the request queue max
>> sectors at dma_opt_mapping_size(). The answer is related to meaning of
>> dma_opt_mapping_size(). If we get any mappings which exceed this size
>> then it can have a big dma mapping performance hit. So I set max hw
>> sectors at this ‘opt’ mapping size to ensure that we get no mappings
>> which exceed this size. Indeed, I think max sectors is 128Kb today for
>> my host, which would be same as dma_opt_mapping_size() value with an
>> IOMMU enabled. And I find that only a small % of request size may exceed
>> this 128kb size, but it still has a big performance impact.
>>

Thanks,
John
