Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCDD4E6DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiCYFrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiCYFrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:47:41 -0400
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED845AE1;
        Thu, 24 Mar 2022 22:46:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07537643|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.10762-0.0120297-0.88035;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.NC8pT5B_1648187152;
Received: from 172.30.10.142(mailfrom:michael@allwinnertech.com fp:SMTPD_---.NC8pT5B_1648187152)
          by smtp.aliyun-inc.com(33.38.168.42);
          Fri, 25 Mar 2022 13:46:04 +0800
Message-ID: <a39e9f71-7a9c-bf0e-50d0-d45de3c2e132@allwinnertech.com>
Date:   Fri, 25 Mar 2022 13:45:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Content-Language: en-GB
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com>
 <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
 <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com>
 <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
 <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com>
 <CAPDyKFpnR12+nrbiB-Ps-C4vn-WeHneRGJioQ_0b2ikk2CBChw@mail.gmail.com>
 <CAPDyKFqnFVd=mvQMnydT569Y6YFg3zPkttQ=amdzmT_yqYQeTg@mail.gmail.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <CAPDyKFqnFVd=mvQMnydT569Y6YFg3zPkttQ=amdzmT_yqYQeTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 19:27, Ulf Hansson wrote:
> On Thu, 17 Mar 2022 at 10:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Wed, 16 Mar 2022 at 17:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 16.3.2022 16.46, Christian Löhle wrote:
>>>>> So we are not going to let the block layer know about SD cache?
>>>>> Or is it a separate change?
>>>>
>>>> I have some code for this laying around, but as it requires reading, parsing and writing Function Registers,
>>>> in particular PEH, it's a lot of boilerplate code to get the functionality, but I'll clean it up and send a patch in the coming weeks.
>>>>
>>>
>>> We have the sd cache flush.  We would presumably just need to call blk_queue_write_cache()
>>> for the !mmc_card_mmc(card) case e.g.
>>>
>>>          if (mmc_has_reliable_write(card)) {
>>>                  md->flags |= MMC_BLK_REL_WR;
>>>                  enable_fua = true;
>>>          }
>>>
>>>          if (mmc_cache_enabled(card->host))
>>>                  enable_cache = true;
>>>
>>>          blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua);
>>
>> To me, this seems like the most reasonable thing to do.
>>
>> However, I have to admit that it's not clear to me, if there was a
>> good reason to why commit f4c5522b0a88 ("mmc: Reliable write
>> support.") also added support for REQ_FLUSH (write back cache) and why
>> not only REQ_FUA. I assumed this was wrong too, right?
>>

Hi Ulf,

1. I've found the reason. If we only enable REQ_FUA, there won't be any 
effect -- The block layer won't send any request with FUA flag to the 
driver.
If we want REQ_FUA to take effect, we must enable REQ_FLUSH. But on the 
contrary, REQ_FLUSH does not rely on REQ_FUA.
In the previous patch(commit f4c5522b0a88 ("mmc: Reliable write 
support.")), REQ_FLUSH was added to make REQ_FUA effective. I've done 
experiments to prove this.

2. Why block layer requires REQ_FLUSH to make REQ_FUA effective? I did 
not find the reason. Does anyone know about this? Thank you.

>> When it comes to patches for stable kernels. mmc_cache_enabled() was
>> introduced quite recently in v5.13, so for older kernels that call
>> needs to be replaced with something else.
>>
>> In any case, the relevant commits that can be considered as needs to
>> be fixed seems like these:
>> commit f4c5522b0a88 ("mmc: Reliable write support.")
>> commit 881d1c25f765 ("mmc: core: Add cache control for eMMC4.5 device")
>> commit 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards")
>>
>> [...]
> 
> Michael, are you planning to send a v2 for this? Or are there any
> parts that are still unclear to you?

Dear Ulf, Sorry for the delay. I was trying to figure out the SD cache 
stuff, so a few day was taken...

> 
> Kind regards
> Uffe

-- 
Best Regards,
Michael Wu
