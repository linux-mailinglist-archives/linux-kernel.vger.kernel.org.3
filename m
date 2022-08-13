Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9572859193A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiHMHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiHMHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 03:23:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E836FA11;
        Sat, 13 Aug 2022 00:23:39 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M4X350TN8z67TNp;
        Sat, 13 Aug 2022 15:18:57 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Sat, 13 Aug 2022 09:23:37 +0200
Received: from [10.48.145.22] (10.48.145.22) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 13 Aug
 2022 08:23:36 +0100
Message-ID: <2b900d3b-9b52-5bc3-4ba8-24249f3c2e42@huawei.com>
Date:   Sat, 13 Aug 2022 08:23:36 +0100
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
 <fd2b1dbe-8482-cb89-2568-4909db1239b0@huawei.com>
 <840a5f98-a53c-ce08-2833-f41d8c9a015b@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <840a5f98-a53c-ce08-2833-f41d8c9a015b@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.22]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On 12/08/2022 19:27, Damien Le Moal wrote:
>> Interestingly ata dev max_sectors kb also gets capped from 32MB (LBA48)
>> -> 256KB due to swiotlb max mapping size. (It would be capped by shost
>> default max sectors 512KB without that swiotlb limit). I assume capping
>> due to swiotlb limit is not occuring on Oliver's machine.
> Yes, I was suspecting that we may be seeing a difference for anything that is
> not AHCI, e.g. with other drivers.
> 
> But that seems to be the correct thing to do, no ? 
Yes, this should be the correct thing to do.

 > How was this working before
 > without applying the swiotlb limit ?
 >
Not sure. I would need to check the libata code for how it handles DMA 
mapping errors, which I assume would occur for when we exceed the 
swiotlb limit.

Having said this, from limited testing, whenever I check megaraid sas or 
mpt3sas for performance, the length of request data never/rarely comes 
close to max sectors. That why I am surprised with the regression which 
Oliver reports.

Thanks,
John

