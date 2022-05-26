Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70F534AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346359AbiEZHYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbiEZHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:24:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB058B0B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:24:12 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L7zpp2hbGz6GD9Q;
        Thu, 26 May 2022 15:20:02 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 26 May 2022 09:24:09 +0200
Received: from [10.81.194.226] (10.81.194.226) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 08:23:57 +0100
Message-ID: <93b92859-2229-8766-09d2-df16e1ebd4e8@huawei.com>
Date:   Thu, 26 May 2022 10:23:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] coresight: etm4x: Add Support for HiSilicon ETM device
Content-Language: en-US
To:     "liuqi (BA)" <liuqi115@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexey Budankov <alexey.budankov@huawei.com>,
        <abudankov@huawei.com>
References: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
 <853b6d52-da86-1c06-3604-3085ece331a4@huawei.com>
 <5dd1bd83-232a-07e4-8fde-e4f6cd0e5b8c@huawei.com>
From:   Alexei Budankov <abudankov@huawei.com>
In-Reply-To: <5dd1bd83-232a-07e4-8fde-e4f6cd0e5b8c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.81.194.226]
X-ClientProxiedBy: saopeml500001.china.huawei.com (7.184.65.104) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

On 26.05.2022 5:56, liuqi (BA) wrote:
> 
> Hi Alexei,
> 
> On 2022/5/25 23:10, Alexei Budankov wrote:
>>
>> Hi Qi Liu,
>>
>> On 13.08.2020 15:59, Qi Liu wrote:
>>> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
>>> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.
>>>
>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>
>> Thanks for your patch.
>> I would like to test HiSilicon ETM device feature on
>> Kunpeng 920 based server.
>> I applied the patch and booted the kernel with the changes.
>> However I don't see any device files neither here:
>> /sys/bus/coresight/devices/
> 
> Thanks for your test :)

Thanks for quick reply. Appreciate it much. :)

> 
> Kunpeng 920 platform(Non-PG) support tracing CPU instruction, source device is coresight ETM, link device is coresight funnel and sink device is ultrasoc SMB. So you need to insmod coresight-* driver and SMB driver, which patch is :
> Add support for UltraSoc System Memory Buffer
> https://lore.kernel.org/linux-arm-kernel/20220416083953.52610-1-liuqi115@huawei.com/

I will try it shortly and let you know.

> 
> by the way, can you help to check /sys/bus/amba/devices/, and make sure that the firmware of your board has supported ETM, funnel and SMB devices?

Here we go:

huawei@armubuntu:~$ pwd
/home/huawei
huawei@armubuntu:~$ ls /sys/bus/amba/devices/
huawei@armubuntu:~$ 

Look like our server firmware should be upgraded, right?
Your help and support is greatly appreciated.

Thanks,
Alexei

> 
> Thanks,
> Qi
> 
>> nor here:
>> /sys/bus/event_source/devices/cs_etm/sinks/
>> What should a user expect new in os with this patch added?
> 
> 
>>
>> Thanks,
>> Alexei
>>
> 
> 
>>
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>>> index 6d7d216..7797a57 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>>> @@ -1587,6 +1587,8 @@ static const struct amba_id etm4_ids[] = {
>>>       CS_AMBA_UCI_ID(0x000bb805, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A55 */
>>>       CS_AMBA_UCI_ID(0x000bb804, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A76 */
>>>       CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
>>> +    CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
>>> +    CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
>>>       {},
>>>   };
>>>
>>> -- 
>>> 2.8.1
>> .
> .
