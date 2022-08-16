Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC65958F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiHPKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiHPKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:50:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0C59D8F4;
        Tue, 16 Aug 2022 03:35:16 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6SBg6djFz67bbZ;
        Tue, 16 Aug 2022 18:32:11 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 12:35:13 +0200
Received: from [10.48.156.171] (10.48.156.171) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 11:35:12 +0100
Message-ID: <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
Date:   Tue, 16 Aug 2022 11:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
To:     Oliver Sang <oliver.sang@intel.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
In-Reply-To: <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.156.171]
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

On 16/08/2022 07:57, Oliver Sang wrote:
>>> For me, a complete kernel log may help.
>> and since only 1HDD, the output of the following would be helpful:
>>
>> /sys/block/sda/queue/max_sectors_kb
>> /sys/block/sda/queue/max_hw_sectors_kb
>>
>> And for 5.19, if possible.
> for commit
> 0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
> 
> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
> 512
> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
> 512
> 
> for both commit
> 4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
> and v5.19
> 
> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
> 1280
> root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
> 32767
> 

thanks, I appreciate this.

 From the dmesg, I see 2x SATA disks - I was under the impression that 
the system only has 1x.

Anyway, both drives show LBA48, which means the large max hw sectors at 
32767KB:
[   31.129629][ T1146] ata6.00: 1562824368 sectors, multi 1: LBA48 NCQ 
(depth 32)

So this is what I suspected: we are capped from the default shost max 
sectors (1024 sectors).

This seems like the simplest fix for you:

--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1382,7 +1382,8 @@ extern const struct attribute_group 
*ata_common_sdev_groups[];
        .proc_name              = drv_name,                     \
        .slave_destroy          = ata_scsi_slave_destroy,       \
        .bios_param             = ata_std_bios_param,           \
-       .unlock_native_capacity = ata_scsi_unlock_native_capacity
+       .unlock_native_capacity = ata_scsi_unlock_native_capacity,\
+       .max_sectors = ATA_MAX_SECTORS_LBA48


A concern is that other drivers which use libata may have similar 
issues, as they use default in SCSI_DEFAULT_MAX_SECTORS for max_sectors:
hisi_sas
pm8001
aic9xxx
mvsas
isci

So they may be needlessly hobbled for some SATA disks. However I have a 
system with hisi_sas controller and attached LBA48 disk. I tested 
performance for v5.19 vs 6.0 and it was about the same for fio rw=read @ 
~120K IOPS. I can test this further.

Thanks,
John
