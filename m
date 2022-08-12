Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2A591290
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiHLO6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHLO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:58:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB331A7229;
        Fri, 12 Aug 2022 07:58:18 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M46HP5vnJz685Yk;
        Fri, 12 Aug 2022 22:58:09 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 16:58:16 +0200
Received: from [10.48.157.254] (10.48.157.254) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 15:58:15 +0100
Message-ID: <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
Date:   Fri, 12 Aug 2022 15:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
From:   John Garry <john.garry@huawei.com>
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
In-Reply-To: <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.157.254]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On 12/08/2022 12:13, John Garry wrote:
>> On Tue, Aug 09, 2022 at 07:55:53AM -0700, Damien Le Moal wrote:
>>> On 2022/08/09 2:58, John Garry wrote:
>>>> On 08/08/2022 15:52, Damien Le Moal wrote:
>>>>> On 2022/08/05 1:05, kernel test robot wrote:
>>>>>>
>>>>>>
>>>>>> Greeting,
>>>>>>
>>>>>> FYI, we noticed a -15.0% regression of 
>>>>>> stress-ng.copy-file.ops_per_sec due to commit:
>>>>>>
>>>>>>
>>>>>> commit: 0568e6122574dcc1aded2979cd0245038efe22b6 ("ata: 
>>>>>> libata-scsi: cap ata_device->max_sectors according to 
>>>>>> shost->max_sectors")
>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git 
>>>>>> master
>>>>>>
>>>>>> in testcase: stress-ng
>>>>>> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
>>>>>> with following parameters:
>>>>>>
>>>>>>     nr_threads: 10%
>>>>>>     disk: 1HDD
>>>>>>     testtime: 60s
>>>>>>     fs: f2fs
>>>>>>     class: filesystem
>>>>>>     test: copy-file
>>>>>>     cpufreq_governor: performance
>>>>>>     ucode: 0xb000280
>>>>>
>>>>> Without knowing what the device adapter is, hard to say where the 
>>>>> problem is. I
>>>>> suspect that with the patch applied, we may be ending up with a 
>>>>> small default
>>>>> max_sectors value, causing overhead due to more commands than 
>>>>> necessary.
>>>>>
>>>>> Will check what I see with my test rig.
>>>>
>>>> As far as I can see, this patch should not make a difference unless the
>>>> ATA shost driver is setting the max_sectors value unnecessarily low.
>>>
>>> That is my hunch too, hence my question about which host driver is 
>>> being used
>>> for this test... That is not apparent from the problem report.
>>
>> we noticed the commit is already in mainline now, and in our tests, 
>> there is
>> still similar regression and also on other platforms.
>> could you guide us how to check "which host driver is being used for this
>> test"? hope to supply some useful information.
>>
> 
> For me, a complete kernel log may help.

and since only 1HDD, the output of the following would be helpful:

/sys/block/sda/queue/max_sectors_kb
/sys/block/sda/queue/max_hw_sectors_kb

And for 5.19, if possible.

Thanks!

> 
>>>
>>>>

