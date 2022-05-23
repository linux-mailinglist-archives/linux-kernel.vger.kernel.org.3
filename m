Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670875309E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiEWHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiEWHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:19:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA437028;
        Mon, 23 May 2022 00:11:22 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L67HL5xxcz67Cp9;
        Mon, 23 May 2022 14:49:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 08:53:50 +0200
Received: from [10.47.87.6] (10.47.87.6) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 07:53:49 +0100
Message-ID: <d5a31b82-4134-a7fb-1a51-446e32db2fd0@huawei.com>
Date:   Mon, 23 May 2022 07:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-scsi@vger.kernel.org>, <liyihang6@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-4-git-send-email-john.garry@huawei.com>
 <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.6]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2022 00:30, Damien Le Moal wrote:
>> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
>> index f69b77cbf538..a3ae6345473b 100644
>> --- a/drivers/scsi/hosts.c
>> +++ b/drivers/scsi/hosts.c
>> @@ -225,6 +225,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>>   	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>>   				   shost->can_queue);
>>   

Hi Damien,

>> +	if (dma_dev->dma_mask) {
>> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
>> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
>> +	}
> Nit: you could drop the curly brackets here.

Some people prefer this style - multi-line statements have curly 
brackets, while single-line statements conform to the official coding 
style (and don't use brackets).

I'll just stick with what we have unless there is a consensus to change.

Thanks,
John

> 
>> +
>>   	error = scsi_init_sense_cache(shost);
>>   	if (error)
>>   		goto fail;

