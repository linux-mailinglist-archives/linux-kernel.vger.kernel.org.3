Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA96534918
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbiEZC5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiEZC46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:56:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F08DDED
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:56:55 -0700 (PDT)
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L7sxQ54cTz1JCPp;
        Thu, 26 May 2022 10:55:22 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 10:56:53 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 10:56:53 +0800
Subject: Re: [PATCH v2] coresight: etm4x: Add Support for HiSilicon ETM device
To:     Alexei Budankov <abudankov@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, <gregkh@linuxfoundation.org>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexey Budankov <alexey.budankov@huawei.com>
References: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
 <853b6d52-da86-1c06-3604-3085ece331a4@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <5dd1bd83-232a-07e4-8fde-e4f6cd0e5b8c@huawei.com>
Date:   Thu, 26 May 2022 10:56:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <853b6d52-da86-1c06-3604-3085ece331a4@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexei,

On 2022/5/25 23:10, Alexei Budankov wrote:
> 
> Hi Qi Liu,
> 
> On 13.08.2020 15:59, Qi Liu wrote:
>> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
>> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> Thanks for your patch.
> I would like to test HiSilicon ETM device feature on
> Kunpeng 920 based server.
> I applied the patch and booted the kernel with the changes.
> However I don't see any device files neither here:
> /sys/bus/coresight/devices/

Thanks for your test :)

Kunpeng 920 platform(Non-PG) support tracing CPU instruction, source 
device is coresight ETM, link device is coresight funnel and sink device 
is ultrasoc SMB. So you need to insmod coresight-* driver and SMB 
driver, which patch is :
Add support for UltraSoc System Memory Buffer
https://lore.kernel.org/linux-arm-kernel/20220416083953.52610-1-liuqi115@huawei.com/

by the way, can you help to check /sys/bus/amba/devices/, and make sure 
that the firmware of your board has supported ETM, funnel and SMB devices?

Thanks,
Qi

> nor here:
> /sys/bus/event_source/devices/cs_etm/sinks/
> What should a user expect new in os with this patch added?


> 
> Thanks,
> Alexei
> 


> 
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c 
>> b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 6d7d216..7797a57 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -1587,6 +1587,8 @@ static const struct amba_id etm4_ids[] = {
>>       CS_AMBA_UCI_ID(0x000bb805, uci_id_etm4),/* Qualcomm Kryo 4XX 
>> Cortex-A55 */
>>       CS_AMBA_UCI_ID(0x000bb804, uci_id_etm4),/* Qualcomm Kryo 4XX 
>> Cortex-A76 */
>>       CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
>> +    CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
>> +    CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
>>       {},
>>   };
>>
>> -- 
>> 2.8.1
> .
