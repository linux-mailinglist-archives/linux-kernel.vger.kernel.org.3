Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6264358E8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiHJIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiHJIda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:33:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8557250;
        Wed, 10 Aug 2022 01:33:29 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2jrM3KsSz67Xgw;
        Wed, 10 Aug 2022 16:33:23 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 10 Aug 2022 10:33:27 +0200
Received: from [10.195.247.138] (10.195.247.138) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 09:33:24 +0100
Message-ID: <82dbf4d6-2d43-20ff-22a7-857f9f11a5ce@huawei.com>
Date:   Wed, 10 Aug 2022 09:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        kernel test robot <oliver.sang@intel.com>
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
 <16f03f81-a8c7-bacf-c74c-67231f7f7202@huawei.com>
 <ef84d2dd-84ea-e1c7-05ef-f0a082d4f7d0@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <ef84d2dd-84ea-e1c7-05ef-f0a082d4f7d0@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.138]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On 09/08/2022 15:57, Damien Le Moal wrote:
>>> As far as I can see, this patch should not make a difference unless the
>>> ATA shost driver is setting the max_sectors value unnecessarily low.
>> For __ATA_BASE_SHT, we don't set max_sectors. As such, we default
>> shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS (=1024) in
>> scsi_host_alloc(). I assume no shost dma mapping limit applied.
>>
>> Then - for example - we could select dev->max_sectors =
>> ATA_MAX_SECTORS_LBA48 (=65535) in ata_dev_configure().
>>
>> So with commit 0568e6122574 we would have final max sectors = 1024, as
>> opposed to 65535 previously. I guess that the problem is something like
>> this.
>>
>> If so, it seems that we would need to apply the shost dma mapping limit
>> separately in ata_scsi_dev_config() and not use shost->max_sectors.
> OK. Will have a look at that.
> 

We may need to introduce something like shost->max_hw_sectors, which is 
set according to sht max sectors and dma mapping limits. That could be 
also used in USB scsiglue slave_configure()

Or else set max_sectors value for __ATA_BASE_SHT, but I don't know a 
sane value there considering ATA_MAX_SECTORS_LBA48 gives max_sectors of 
65535.

Damien, please let me know if you need help now. I am just waiting for 
you to test to prove this theory about dev->max_sectors being capped. I 
don't have an AHCI setup readily-available for testing - just SAS cards 
or QEMU.

Thanks,
John
