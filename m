Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99106562D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiGAIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiGAIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:02:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC86F35D;
        Fri,  1 Jul 2022 01:02:28 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZ6yN5ZSQz67y8S;
        Fri,  1 Jul 2022 15:58:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 10:02:25 +0200
Received: from [10.126.173.51] (10.126.173.51) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 09:02:24 +0100
Message-ID: <17c90e55-4560-fa37-398a-4de3838704ca@huawei.com>
Date:   Fri, 1 Jul 2022 09:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 3/5] scsi: core: Cap shost max_sectors according to DMA
 limits only once
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <iommu@lists.linux.dev>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <1656590892-42307-4-git-send-email-john.garry@huawei.com>
 <5f79d8e7-0035-cfb0-d612-3e1c7f243f22@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <5f79d8e7-0035-cfb0-d612-3e1c7f243f22@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.51]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
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

On 01/07/2022 00:41, Damien Le Moal wrote:
>>   
>>   	shost->dma_dev = dma_dev;
>>   
>> +	if (dma_dev->dma_mask) {
>> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
>> +				dma_max_mapping_size(dma_dev) >> SECTOR_SHIFT);
>> +	}
> Nit: you could remove the curly brackets... But it being a multi-line
> statement, having them is OK too I think.
> 

tglx seems to think that they are ok, and I generally agree (now):

https://lore.kernel.org/linux-arm-kernel/877djwdorz.ffs@nanos.tec.linutronix.de/

AFAICT coding-style.rst is ok with them in this scenario too

Cheers,
John
