Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33CE59606A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiHPQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiHPQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:38:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B0F77EB8;
        Tue, 16 Aug 2022 09:38:45 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6cD02PJ1z67lT9;
        Wed, 17 Aug 2022 00:33:52 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 16 Aug 2022 18:38:43 +0200
Received: from [10.48.154.245] (10.48.154.245) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 17:38:42 +0100
Message-ID: <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
Date:   Tue, 16 Aug 2022 17:38:43 +0100
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
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.154.245]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On 16/08/2022 16:42, Damien Le Moal wrote:
> On 2022/08/16 3:35, John Garry wrote:
>> On 16/08/2022 07:57, Oliver Sang wrote:
>>>>> For me, a complete kernel log may help.
>>>> and since only 1HDD, the output of the following would be helpful:
>>>>
>>>> /sys/block/sda/queue/max_sectors_kb
>>>> /sys/block/sda/queue/max_hw_sectors_kb
>>>>
>>>> And for 5.19, if possible.
>>> for commit
>>> 0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
>>>
>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
>>> 512
>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
>>> 512
>>>
>>> for both commit
>>> 4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
>>> and v5.19
>>>
>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
>>> 1280
>>> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
>>> 32767
>>>
>>
>> thanks, I appreciate this.
>>
>>   From the dmesg, I see 2x SATA disks - I was under the impression that
>> the system only has 1x.
>>
>> Anyway, both drives show LBA48, which means the large max hw sectors at
>> 32767KB:
>> [   31.129629][ T1146] ata6.00: 1562824368 sectors, multi 1: LBA48 NCQ
>> (depth 32)
>>
>> So this is what I suspected: we are capped from the default shost max
>> sectors (1024 sectors).
>>
>> This seems like the simplest fix for you:
>>
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -1382,7 +1382,8 @@ extern const struct attribute_group
>> *ata_common_sdev_groups[];
>>          .proc_name              = drv_name,                     \
>>          .slave_destroy          = ata_scsi_slave_destroy,       \
>>          .bios_param             = ata_std_bios_param,           \
>> -       .unlock_native_capacity = ata_scsi_unlock_native_capacity
>> +       .unlock_native_capacity = ata_scsi_unlock_native_capacity,\
>> +       .max_sectors = ATA_MAX_SECTORS_LBA48
> 
> This is crazy large (65535 x 512 B sectors) and never result in that being
> exposed as the actual max_sectors_kb since other limits will apply first
> (mapping size).

Here is how I read values from above for max_sectors_kb and 
max_hw_sectors_kb:

v5.19 + 0568e61225 : 512/512
v5.19 + 0568e61225 + 4cbfca5f77 : 512/512
v5.19: 1280/32767

They are want makes sense to me, at least.

Oliver, can you confirm this? Thanks!

On this basis, it appears that max_hw_sectors_kb is getting capped from 
scsi default @ 1024 sectors by commit 0568e61225. If it were getting 
capped by swiotlb mapping limit then that would give us 512 sectors - 
this value is fixed.

So for my SHT change proposal I am just trying to revert to previous 
behaviour in 5.19 - make max_hw_sectors_kb crazy big again.

> 
> The regression may come not from commands becoming tiny, but from the fact that
> after the patch, max_sectors_kb is too large, 

I don't think it is, but need confirmation.

>causing a lot of overhead with
> qemu swiotlb mapping and slowing down IO processing.

> 
> Above, it can be seen that we ed up with max_sectors_kb being 1280, which is the
> default for most scsi disks (including ATA drives). That is normal. But before
> that, it was 512, which likely better fits qemu swiotlb and does not generate

Again, I don't think this this is the case. Need confirmation.

> overhead. So the above fix will not change anything I think...


Thanks,
John
