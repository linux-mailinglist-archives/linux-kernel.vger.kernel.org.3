Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F5599662
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiHSHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345865AbiHSHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:54:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F0DB04A;
        Fri, 19 Aug 2022 00:54:45 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M8DTw5Pw8z68BVL;
        Fri, 19 Aug 2022 15:51:32 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 09:54:42 +0200
Received: from [10.195.34.98] (10.195.34.98) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 08:54:42 +0100
Message-ID: <4014a51d-0925-c0dc-70dc-1a465dd278e7@huawei.com>
Date:   Fri, 19 Aug 2022 08:54:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
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
References: <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
 <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
 <aabf7ed8-8d4d-dc68-1b8b-c91653701def@huawei.com>
 <43eaa104-5b09-072c-56aa-6289569b0015@opensource.wdc.com>
 <28d6e48b-f52f-9467-8260-262504a1a1ff@huawei.com>
 <YvzyZJUblfqN6Xj3@xsang-OptiPlex-9020>
 <743867a6-b266-58e4-a8a6-542757916f0a@huawei.com>
 <Yv2euLFLjl8bEaeI@xsang-OptiPlex-9020>
 <d1b1d434-059d-4d76-5fc6-092ab9ba6e16@huawei.com>
 <Yv8sg3J8PLD56osY@xsang-OptiPlex-9020>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Yv8sg3J8PLD56osY@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.98]
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

On 19/08/2022 07:24, Oliver Sang wrote:
>> As you probably saw, I sent "[RFT PATCH] ata: libata: Set __ATA_BASE_SHT
>> max_sectors" for testing on top of v6.0-rc1, and I hope that then we can get

Based on result below, I wonder if SAS HBAs (which use libata) should 
not use default SCSI max_sectors also. Any libsas HBA driver does today, 
IIRC.

>> same performance as v5.19
> yeah, our test confirmed your expectation:
> 
> stress-ng.copy-file.ops_per_sec
> v5.19                 - 26.85
> v6.0-rc1              - 23.03
> v6.0-rc1 + your patch - 26.94
> 

great, thanks

Thanks,
John
