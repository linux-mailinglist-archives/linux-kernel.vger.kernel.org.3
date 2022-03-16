Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648624DADE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355019AbiCPJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355006AbiCPJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:55:49 -0400
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5B33880;
        Wed, 16 Mar 2022 02:54:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436528|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0161911-0.00387286-0.979936;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.N5pKMoy_1647424463;
Received: from 172.30.10.142(mailfrom:michael@allwinnertech.com fp:SMTPD_---.N5pKMoy_1647424463)
          by smtp.aliyun-inc.com(33.13.195.200);
          Wed, 16 Mar 2022 17:54:31 +0800
Message-ID: <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com>
Date:   Wed, 16 Mar 2022 17:54:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Content-Language: en-GB
To:     Avri Altman <Avri.Altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 17:37, Avri Altman wrote:
>> On 14/03/2022 14:54, Adrian Hunter wrote:
>>> On 12/03/2022 06:43, Michael Wu wrote:
>>>> The mmc core enable cache on default. But it only enables
>>>> cache-flushing when host supports cmd23 and eMMC supports reliable
>> write.
>>>> For hosts which do not support cmd23 or eMMCs which do not support
>>>> reliable write, the cache can not be flushed by `sync` command.
>>>> This may leads to cache data lost.
>>>> This patch enables cache-flushing as long as cache is enabled, no
>>>> matter host supports cmd23 and/or eMMC supports reliable write or not.
>>>>
>>>
>>> Fixes tag?
>>>
>>
>> Hi Adrian,
>> My patch intend to fix the cache problem brought by the following two
>> patches:
>>
>> Fixes: d0c97cfb81ebc ("mmc: core: Use CMD23 for multiblock transfers when
>> we can.")
>> Fixes: e9d5c746246c8 ("mmc/block: switch to using blk_queue_write_cache()")
>>
>> I'm not sure if this is what you referred to ("Fixes tag"). Please correct me if I
>> misunderstood.
>>
>>>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>>>> ---
>>>>    drivers/mmc/core/block.c | 20 ++++++++++++++------
>>>>    1 file changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>>> index 689eb9afeeed..1e508c079c1e 100644
>>>> --- a/drivers/mmc/core/block.c
>>>> +++ b/drivers/mmc/core/block.c
>>>> @@ -2279,6 +2279,8 @@ static struct mmc_blk_data
>> *mmc_blk_alloc_req(struct mmc_card *card,
>>>>       struct mmc_blk_data *md;
>>>>       int devidx, ret;
>>>>       char cap_str[10];
>>>> +    bool enable_cache = false;
>>>> +    bool enable_fua = false;
>>>>
>>>>       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>>>>       if (devidx < 0) {
>>>> @@ -2375,12 +2377,18 @@ static struct mmc_blk_data
>> *mmc_blk_alloc_req(struct mmc_card *card,
>>>>                       md->flags |= MMC_BLK_CMD23;
>>>>       }
>>>>
>>>> -    if (mmc_card_mmc(card) &&
>>>> -        md->flags & MMC_BLK_CMD23 &&
>>>> -        ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>>>> -         card->ext_csd.rel_sectors)) {
>>>> -            md->flags |= MMC_BLK_REL_WR;
>>>> -            blk_queue_write_cache(md->queue.queue, true, true);
>>>> +    if (mmc_card_mmc(card)) {
>>>> +            if (md->flags & MMC_BLK_CMD23 &&
>>>> +                    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN)
>> ||
>>>> +                    card->ext_csd.rel_sectors)) {
>>>> +                    md->flags |= MMC_BLK_REL_WR;
>>>> +                    enable_fua = true;
>>>> +            }
>>>> +
>>>> +            if (mmc_cache_enabled(card->host))
>>>> +                    enable_cache = true;
>>>> +
>>>> +            blk_queue_write_cache(md->queue.queue, enable_cache,
>>>> + enable_fua);
>>>>       }
>>>
>>> Seems like we should inform block layer about SD card cache also
>>>
>>
>> I saw another mail by Avri Altman, which says few days will be needed to ask
>> internally. Shall I wait or make another change here on 'inform block layer
>> about SD card cache'?
> Please don't wait.
> 
> Thanks,
> Avri
> 
>>
>>>>
>>>>       string_get_size((u64)size, 512, STRING_UNITS_2,
>>
>> --
>> Best Regards,
>> Michael Wu
Hi Avril & Adrian,
Thanks for your efforts. Could we have an agreement now --

1. enabling-cache and cmd23/reliable-write should be independent;

 > On 14/03/2022 18:32, Adrian Hunter wrote:
 >> On 14/03/2022 09:26, Avri Altman wrote:
 >>> Hi,
 >>>> The mmc core enable cache on default. But it only enables 
cache-flushing
 >>>> when host supports cmd23 and eMMC supports reliable write.
 >>>> For hosts which do not support cmd23 or eMMCs which do not support
 >>>> reliable write, the cache can not be flushed by `sync` command.
 >>>> This may leads to cache data lost.
 >>>> This patch enables cache-flushing as long as cache is enabled, no
 >>>> matter host supports cmd23 and/or eMMC supports reliable write or
 >>>> not.
 >>> I looked in the spec and indeed couldn't find why enabling cache is
 >>> dependent of cmd23/reliable write.
 >>> Nor I was able to find the original commit log.
 >>
 >> Reliable write was added first, so it might have been an oversight:
 >>
 >> commit 881d1c25f765938a95def5afe39486ce39f9fc96
 >> Author: Seungwon Jeon <tgih.jun@samsung.com>
 >> Date:   Fri Oct 14 14:03:21 2011 +0900
 >>
 >>      mmc: core: Add cache control for eMMC4.5 device
 >>
 >>      This patch adds cache feature of eMMC4.5 Spec.
 >>      If device supports cache capability, host can utilize some
 >>      specific operations.
 >>
 >>      Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
 >>      Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
 >>      Signed-off-by: Chris Ball <cjb@laptop.org>

Here's what I found in the spec JESD84-B51:
 > 6.6.31 Cache
 > Caching of data shall apply only for the single block
 > read/write(CMD17/24), pre-defined multiple block
 > read/write(CMD23+CMD18/25) and open ended multiple block
 > read/write(CMD18/25+CMD12) commands and excludes any other access
 > e.g., to the register space(e.g., CMD6).
Which means with CMD18/25+CMD12 (without using CMD23), the cache can 
also be enabled. Maybe this could be an evidence of the independence 
between enabling-cache and cmd23/reliable-write?

2. We don't consider supporting SD in this change.

 > On 14/03/2022 19:10, Avri Altman wrote:
 >> Here is what our SD system guys wrote:
 >> " In SD we don’t support reliable write and this eMMC driver may not 
 >>    be utilizing the cache feature we added in SD5.0.
 >>   The method of cache flush is different between SD and eMMC."
 >>
 >> So adding SD seems to be out of scope of this change.

Is there anything else I can do about this patch? Thanks again.

-- 
Best Regards,
Michael Wu
