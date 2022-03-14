Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9750A4D7E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiCNJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiCNJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:22:19 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EE427F1;
        Mon, 14 Mar 2022 02:21:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07863903|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00699087-0.00170898-0.9913;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.N49gzxq_1647249655;
Received: from 172.30.10.142(mailfrom:michael@allwinnertech.com fp:SMTPD_---.N49gzxq_1647249655)
          by smtp.aliyun-inc.com(33.32.109.194);
          Mon, 14 Mar 2022 17:21:06 +0800
Message-ID: <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
Date:   Mon, 14 Mar 2022 17:20:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Michael Wu <michael@allwinnertech.com>
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
To:     Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        avri.altman@wdc.com, beanhuo@micron.com, porzio@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
Content-Language: en-GB
In-Reply-To: <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 14:54, Adrian Hunter wrote:
> On 12/03/2022 06:43, Michael Wu wrote:
>> The mmc core enable cache on default. But it only enables cache-flushing
>> when host supports cmd23 and eMMC supports reliable write.
>> For hosts which do not support cmd23 or eMMCs which do not support
>> reliable write, the cache can not be flushed by `sync` command.
>> This may leads to cache data lost.
>> This patch enables cache-flushing as long as cache is enabled, no
>> matter host supports cmd23 and/or eMMC supports reliable write or not.
>>
> 
> Fixes tag?
> 

Hi Adrian,
My patch intend to fix the cache problem brought by the following two 
patches:

Fixes: d0c97cfb81ebc ("mmc: core: Use CMD23 for multiblock transfers 
when we can.")
Fixes: e9d5c746246c8 ("mmc/block: switch to using blk_queue_write_cache()")

I'm not sure if this is what you referred to ("Fixes tag"). Please 
correct me if I misunderstood.

>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>> ---
>>   drivers/mmc/core/block.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 689eb9afeeed..1e508c079c1e 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -2279,6 +2279,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>>   	struct mmc_blk_data *md;
>>   	int devidx, ret;
>>   	char cap_str[10];
>> +	bool enable_cache = false;
>> +	bool enable_fua = false;
>>   
>>   	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>>   	if (devidx < 0) {
>> @@ -2375,12 +2377,18 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>>   			md->flags |= MMC_BLK_CMD23;
>>   	}
>>   
>> -	if (mmc_card_mmc(card) &&
>> -	    md->flags & MMC_BLK_CMD23 &&
>> -	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>> -	     card->ext_csd.rel_sectors)) {
>> -		md->flags |= MMC_BLK_REL_WR;
>> -		blk_queue_write_cache(md->queue.queue, true, true);
>> +	if (mmc_card_mmc(card)) {
>> +		if (md->flags & MMC_BLK_CMD23 &&
>> +			((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>> +			card->ext_csd.rel_sectors)) {
>> +			md->flags |= MMC_BLK_REL_WR;
>> +			enable_fua = true;
>> +		}
>> +
>> +		if (mmc_cache_enabled(card->host))
>> +			enable_cache = true;
>> +
>> +		blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua);
>>   	}
> 
> Seems like we should inform block layer about SD card cache also
> 

I saw another mail by Avri Altman, which says few days will be needed to 
ask internally. Shall I wait or make another change here on 'inform 
block layer about SD card cache'?

>>   
>>   	string_get_size((u64)size, 512, STRING_UNITS_2,

-- 
Best Regards,
Michael Wu
