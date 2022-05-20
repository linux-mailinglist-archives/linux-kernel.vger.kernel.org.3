Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196ED52E328
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345171AbiETDdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiETDdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:33:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BA012FECB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:33:43 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L4C2p1CNGz1JC7d;
        Fri, 20 May 2022 11:32:18 +0800 (CST)
Received: from [10.174.176.254] (10.174.176.254) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 11:33:41 +0800
Subject: Re: [PATCH] mtd: rawnand: fix drivers probe/remove methods
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <christophe.jaillet@wanadoo.fr>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>
References: <20220517060753.26710-1-wupeng58@huawei.com>
 <20220519172507.4d9872c3@xps-13>
From:   "wupeng (D)" <wupeng58@huawei.com>
Message-ID: <4baeaf4f-0db6-a1cf-23e3-ed7ce521249b@huawei.com>
Date:   Fri, 20 May 2022 11:33:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20220519172507.4d9872c3@xps-13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/19 23:25, Miquel Raynal wrote:
> Hi,
> 
> wupeng58@huawei.com wrote on Tue, 17 May 2022 06:07:53 +0000:
> 
>> Driver should call pci_disable_device() if it returns from
>> cafe_nand_probe() with error.
>>
>> Meanwhile, the driver calls pci_enable_device() in
>> cafe_nand_probe(), but never calls pci_disable_device()
>> during removal.
> 
> Please fix the subject prefix, it should be "mtd: ranwnand: cafe:"
> 
> Also Fixes/Cc: stable tags might be useful.
> 
>> Signed-off-by: Peng Wu <wupeng58@huawei.com>
>> ---
>>   drivers/mtd/nand/raw/cafe_nand.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
>> index 9dbf031716a6..af119e376352 100644
>> --- a/drivers/mtd/nand/raw/cafe_nand.c
>> +++ b/drivers/mtd/nand/raw/cafe_nand.c
>> @@ -679,8 +679,10 @@ static int cafe_nand_probe(struct pci_dev *pdev,
>>   	pci_set_master(pdev);
>>   
>>   	cafe = kzalloc(sizeof(*cafe), GFP_KERNEL);
>> -	if (!cafe)
>> -		return  -ENOMEM;
>> +	if (!cafe) {
>> +		err = -ENOMEM;
>> +		goto out_disable_device;
>> +	}
>>   
>>   	mtd = nand_to_mtd(&cafe->nand);
>>   	mtd->dev.parent = &pdev->dev;
>> @@ -801,6 +803,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
>>   	pci_iounmap(pdev, cafe->mmio);
>>    out_free_mtd:
>>   	kfree(cafe);
>> + out_disable_device:
>> +	pci_disable_device(pdev);
>>    out:
>>   	return err;
>>   }
>> @@ -822,6 +826,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
>>   	pci_iounmap(pdev, cafe->mmio);
>>   	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
>>   	kfree(cafe);
>> +	pci_disable_device(pdev);
>>   }
>>   
>>   static const struct pci_device_id cafe_nand_tbl[] = {
> 
> 
> Thanks,
> Miquèl
> .
> 
Hi，
    Thank you very much for correcting the problem and I will fix the unqualified subject name.

Thanks,
Peng Wu
