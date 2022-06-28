Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AC155CC79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbiF1J1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiF1J1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:27:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F251C10F;
        Tue, 28 Jun 2022 02:27:23 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXK1r5H6fz689rg;
        Tue, 28 Jun 2022 17:25:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 28 Jun 2022 11:27:21 +0200
Received: from [10.126.174.22] (10.126.174.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 10:27:20 +0100
Message-ID: <9202083b-6d98-fba3-76eb-78dc78925373@huawei.com>
Date:   Tue, 28 Jun 2022 10:27:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <s.shtylyov@omp.ru>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.174.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
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

On 28/06/2022 09:59, Damien Le Moal wrote:
> On 6/27/22 22:12, John Garry wrote:
>> x86_64 allmodconfig build with W=1 gives these warnings:
>>
>> drivers/ata/pata_cs5535.c: In function ‘cs5535_set_piomode’:
>> drivers/ata/pata_cs5535.c:93:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
>>    u32 reg, dummy;
>>             ^~~~~
>> drivers/ata/pata_cs5535.c: In function ‘cs5535_set_dmamode’:
>> drivers/ata/pata_cs5535.c:132:11: error: variable ‘dummy’ set but not used [-Werror=unused-but-set-variable]
>>    u32 reg, dummy;
>>             ^~~~~
>> cc1: all warnings being treated as errors
>>
>> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
>> stubbed, which is the same as what we already do in pata_cs5536.c .
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Looks good, but I wonder why I am not getting this warning. I always do
> W=1 and C=1 builds. I tried allmodconfig now and I am not getting the
> warning...

eh, I'm not sure why. It's the only driver in drivers/ata/ which gives 
such a problem.

I'm using gcc 9:
gcc version 9.3.1 20200406 [revision 
6db837a5288ee3ca5ec504fbd5a765817e556ac2] (SUSE Linux)

Then I cross-compiled from my arm64 machine (to x86) and still got it:
john@ubuntu:~/kernel-dev$ /usr/bin/x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0

> 
>>
>> diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
>> index 6725931f3c35..c2c3238ff84b 100644
>> --- a/drivers/ata/pata_cs5535.c
>> +++ b/drivers/ata/pata_cs5535.c
>> @@ -90,7 +90,7 @@ static void cs5535_set_piomode(struct ata_port *ap, struct ata_device *adev)
>>   	static const u16 pio_cmd_timings[5] = {
>>   		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
>>   	};
>> -	u32 reg, dummy;
>> +	u32 reg, __maybe_unused dummy;
>>   	struct ata_device *pair = ata_dev_pair(adev);
>>   
>>   	int mode = adev->pio_mode - XFER_PIO_0;
>> @@ -129,7 +129,7 @@ static void cs5535_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>>   	static const u32 mwdma_timings[3] = {
>>   		0x7F0FFFF3, 0x7F035352, 0x7F024241
>>   	};
>> -	u32 reg, dummy;
>> +	u32 reg, __maybe_unused dummy;
>>   	int mode = adev->dma_mode;
>>   
>>   	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);
> 
> 

