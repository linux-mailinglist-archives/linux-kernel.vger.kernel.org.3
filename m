Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910CF5914B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiHLRRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHLRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:17:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D28B1BAF;
        Fri, 12 Aug 2022 10:17:44 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M49H26jFGz67Mkv;
        Sat, 13 Aug 2022 01:13:02 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 19:17:41 +0200
Received: from [10.48.157.254] (10.48.157.254) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 18:17:40 +0100
Message-ID: <fd2b1dbe-8482-cb89-2568-4909db1239b0@huawei.com>
Date:   Fri, 12 Aug 2022 18:17:39 +0100
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
 <4642848c-a386-d6a0-6255-8b16800e0548@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <4642848c-a386-d6a0-6255-8b16800e0548@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.157.254]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On 12/08/2022 16:41, Damien Le Moal wrote:
>>> we noticed the commit is already in mainline now, and in our tests, there is
>>> still similar regression and also on other platforms.
>>> could you guide us how to check "which host driver is being used for this
>>> test"? hope to supply some useful information.
>>>
>> For me, a complete kernel log may help.
> I had a look yesterday with my test rig. I did not see any difference in the
> default max_sectors_kb values for various drives between 5.18 and 5.19 (current
> linus tree). The test machine has 2 AHCI adapters: Intel and Marvell. Both use
> the regular AHCI driver. I have another rig with different ATA adapters but it
> is powered down and I am traveling... So cannot test that right now.
> 

FWIW, on QEMU I get a difference for IDE disk for ata_piix host.

Interestingly ata dev max_sectors kb also gets capped from 32MB (LBA48) 
-> 256KB due to swiotlb max mapping size. (It would be capped by shost 
default max sectors 512KB without that swiotlb limit). I assume capping 
due to swiotlb limit is not occuring on Oliver's machine.

thanks,
John

[    1.497233] ata7: found unknown device (class 0)
[    1.498341] ata7.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    1.499030] ata7.00: 209716 sectors, multi 16: LBA48
[    1.623795] ata2: SATA link down (SStatus 0 SControl 300)
[    1.624633] ata1: SATA link down (SStatus 0 SControl 300)
[    1.633395] ata6: SATA link down (SStatus 0 SControl 300)
[    1.634200] ata5: SATA link down (SStatus 0 SControl 300)
[    1.635094] ata4: SATA link down (SStatus 0 SControl 300)
[    1.635887] ata3: SATA link down (SStatus 0 SControl 300)
[    1.636748] scsi 6:0:0:0: Direct-Access     ATA      QEMU HARDDISK 
  2.5+ PQ: 0 ANSI: 5
[    1.641298] sd 6:0:0:0: [sda] 209716 512-byte logical blocks: (107 
MB/102 MiB)
[    1.642188] sd 6:0:0:0: [sda] Write Protect is off
[    1.642770] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.642783] sd 6:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.644149] sd 6:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    1.645142] sd 6:0:0:0: Attached scsi generic sg0 type 0
[    1.655145] sd 6:0:0:0: [sda] Attached SCSI disk
