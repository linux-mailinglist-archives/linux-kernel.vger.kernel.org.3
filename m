Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F824570629
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiGKOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiGKOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:49:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136B32449;
        Mon, 11 Jul 2022 07:49:48 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LhRWV2BZ9z67XMQ;
        Mon, 11 Jul 2022 22:45:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 11 Jul 2022 16:49:46 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 15:49:45 +0100
Message-ID: <2b36e407-f053-20cc-1d7f-983a4424665c@huawei.com>
Date:   Mon, 11 Jul 2022 15:49:46 +0100
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
 <a415e4a1-72ce-53e1-437a-fc7e56e4b913@huawei.com>
 <62b801e8-66b6-0af7-b0c9-195823bf9f62@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <62b801e8-66b6-0af7-b0c9-195823bf9f62@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
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

On 11/07/2022 11:40, Damien Le Moal wrote:
> On 7/11/22 16:36, John Garry wrote:
>> On 11/07/2022 00:08, Damien Le Moal wrote:
>>>> Ah, I think that I misunderstood Damien's question. I thought he was
>>>> asking why not keep shost max_sectors at dma_max_mapping_size() and then
>>>> init each sdev request queue max hw sectors at dma_opt_mapping_size().
>>> I was suggesting the reverse:)  Keep the device hard limit
>>> (max_hw_sectors) to the max dma mapping and set the soft limit
>>> (max_sectors) to the optimal dma mapping size.
>>
>> Sure, but as I mentioned below, I only see a small % of requests whose
>> mapping size exceeds max_sectors but that still causes a big performance
>> hit. So that is why I want to set the hard limit as the optimal dma
>> mapping size.
> 
> How can you possibly end-up with requests larger than max_sectors ? BIO
> split is done using this limit, right ? Or is it that request merging is
> allowed up to max_hw_sectors even if the resulting request size exceeds
> max_sectors ?
> 

Ah, I see how I thought that I was seeing requests whose size exceeded 
max_sectors. Somebody must have changed a single disk in my system and 
this odd disk has a higher default max_sectors_kb -- 512 vs 128 for the 
rest.

So ignoring my nonesence that I was seeing oversize requests, as for the 
idea to set default max_sectors at dma_opt_mapping_size(), I see some 
issues:
- for SAS disks I have no common point to impose this limit. Maybe in 
the slave configure callback, but each SAS driver has its own 
implementation generally
- Even if we do config in slave_configure callback the max_sectors value 
is overwritten later in sd_revalidate_disk().

This following change could sort the issue though:

---8<----
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 895b56c8f25e..bb49bea3d161 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3214,6 +3214,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
         sector_t old_capacity = sdkp->capacity;
         unsigned char *buffer;
         unsigned int dev_max, rw_max;
+       struct Scsi_Host *host = sdp->host;
+       struct device *dev = host->dma_dev;

         SCSI_LOG_HLQUEUE(3, sd_printk(KERN_INFO, sdkp,
                                       "sd_revalidate_disk\n"));
@@ -3296,8 +3298,13 @@ static int sd_revalidate_disk(struct gendisk *disk)
                                       (sector_t)BLK_DEF_MAX_SECTORS);
         }

-       /* Do not exceed controller limit */
-       rw_max = min(rw_max, queue_max_hw_sectors(q));
+       if (dev->dma_mask) {
+               /* Do not exceed dma optimal limit */
+               rw_max = min_t(unsigned int, rw_max,
+                               dma_opt_mapping_size(dev) >> SECTOR_SHIFT);
+       } else {
+               rw_max = min(rw_max, queue_max_hw_sectors(q));
+       }

         /*
          * Only update max_sectors if previously unset or if the 
current value

--->8---

Or I could go with the method in this series, which is not preferred. 
Let me know what you think.

Thanks,
John

