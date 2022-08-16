Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB55963E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiHPUpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiHPUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:44:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C093696EC;
        Tue, 16 Aug 2022 13:44:36 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6jgf5VMJz67N4d;
        Wed, 17 Aug 2022 04:39:42 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 22:44:34 +0200
Received: from [10.195.244.204] (10.195.244.204) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 21:44:33 +0100
Message-ID: <c93e529d-b688-9910-50c4-779c2f85fbc3@huawei.com>
Date:   Tue, 16 Aug 2022 21:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Oliver Sang <oliver.sang@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        <linux-ide@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
 <05a48c68-33ae-10e2-e565-6c124bad93c5@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <05a48c68-33ae-10e2-e565-6c124bad93c5@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.204]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 21:02, Damien Le Moal wrote:
>> ou confirm this? Thanks!
>>
>> On this basis, it appears that max_hw_sectors_kb is getting capped from
>> scsi default @ 1024 sectors by commit 0568e61225. If it were getting
>> capped by swiotlb mapping limit then that would give us 512 sectors -
>> this value is fixed.
>>
>> So for my SHT change proposal I am just trying to revert to previous
>> behaviour in 5.19 - make max_hw_sectors_kb crazy big again.
> I reread the entire thing and I think I got things reverted here. The perf
> regression happens with the 512/512 settings, while the original 1280/32767
> before your patches was OK.

Right, that's as I read it. It would be useful for Oliver to confirm the 
results.

> So is your patch defining the optimal mapping size
> cause the reduction to 512/512.

The optimal mapping size only affects specifically sas controllers, so I 
think that we can ignore that one for now. The reduction to 512/512 
comes from the change in ata_scsi_dev_config().

> It would mean that for ATA, we need a sane
> default mapping instead of SCSI default 1024 sectors.

Right

> Now I understand your
> proposed change using ATA_MAX_SECTORS_LBA48.
> 
> However, that would be correct only for LBA48 capable drives.
> ata_dev_configure() already sets dev->max_sectors correctly according to the
> drive type, capabilities and eventual quirks. So the problem comes from the
> libata-scsi change:
> 
> dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);
> 
> when sdev->host->max_sectors is 0 (not initialized).

That cannot happen. If sht->max_sectors is 0, then we set 
shost->max_sectors at SCSI default 1024 sectors in scsi_host_alloc()

For my proposed change, dev->max_sectors would still be initialized in 
ata_dev_configure() according to drive type, etc. And it should be <= 
LBA48 max sectors (=65535).

So then in ata_scsi_dev_config():

dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors)

this only has an impact for ahci controllers if sdev->host->max_sectors 
was capped according to host dma dev max mapping size.

I will admit that this is not ideal. An alt approach is to change 
ata_scsi_dev_config() to cap the dev max_sectors only according to shost 
dma dev mapping limit (similar to scsi_add_host_with_dma()), but that 
would not work for a controller like ipr, which does have a geniune 
max_sectors limit (which we should respect).

Thanks,
John


> So maybe simply changing
> this line to:
> 
> dev->max_sectors = min_not_zero(dev->max_sectors, sdev->host->max_sectors);
> 
> would do the trick ? Any particular adapter driver that needs a mapping cap on
> the adpter max mapping size can still set sdev->host->max_sectors as needed, and
> we keep the same defaults as before when it is not set. Thoughts ? Or am I
> missing something else ?
> 
> 
>>> The regression may come not from commands becoming tiny, but from the fact that
>>> after the patch, max_sectors_kb is too large,
>> I don't think it is, but need confirmation.
>>
>>> causing a lot of overhead with
>>> qemu swiotlb mapping and slowing down IO processing.
>>> Above, it can be seen that we ed up with max_sectors_kb being 1280, which is the
>>> default for most scsi disks (including ATA drives). That is normal. But before
>>> that, it was 512, which likely better fits qemu swiotlb and does not generate
>> Again, I don't think this this is the case. Need confirmation.
>>
>>> overhead. So the above fix will not change anything I think...

