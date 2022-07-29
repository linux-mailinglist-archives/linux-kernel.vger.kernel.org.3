Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43686584E93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiG2KSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiG2KR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:17:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5645C964;
        Fri, 29 Jul 2022 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659089878; x=1690625878;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=u2/cqnaHvoGbJJZCNxjqCbp0kChp8nWHc3WCCSFVg6o=;
  b=X15FPIbWTIFk9lRplX1SoBRRusEqOJ9P1cTLMUp69iKwFIjouhQpWgcn
   DkwGWNCjBMCBGkv16eqq94DosZGwnv6uLe+C7LuF23eNAlgwcuOZVgH6o
   83BPOQibw/u5N0eAene86ImCnRvYn0KrdJPO/7DxOtATSZsI534xHDoMQ
   eYqXpPEezl+fDMmNag58ggXJdyBRYF72I82u+1wZKIH7g7pqm3G15SpmQ
   PxGzLaC/5sxnoRzboj8jfEBNR+DcI3R+Ths4COjz2bDVHKOQ8HJXnmwil
   E0PL9/X6YBZ6ZLZ5MbzoZ81KBOHAThHBjmPgjrFm3HdPISDgMqK+lgXOa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="375040781"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="375040781"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 03:17:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="660178010"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.142])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 03:17:54 -0700
Message-ID: <95116fcd-a374-d0c7-47f3-10921325e331@intel.com>
Date:   Fri, 29 Jul 2022 13:17:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: block: Dont report successful writes with errors
Content-Language: en-US
To:     Christian Loehle <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ca06b94aa48a484d965744e64e17a4ef@hyperstone.com>
 <992cc198-6c7c-977a-1af8-56665e939cc9@intel.com>
 <a66fe29560f545e18b91af57f4d0dddb@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <a66fe29560f545e18b91af57f4d0dddb@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/22 18:08, Christian Loehle wrote:
>> On 19/07/22 18:34, Christian Loehle wrote:
>>> Be as conservative about successful write reporting to the block layer 
>>> for SPI as with normal SD and MMC.
>>> That means on any errors bytes_xfered is ignored and the whole write 
>>> must be repeated.
>>>
>>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>>> ---
>>>  drivers/mmc/core/block.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index 
>>> f4a1281658db..63d1c05582a9 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -1765,8 +1765,12 @@ static bool mmc_blk_status_error(struct request *req, u32 status)
>>>  	struct mmc_queue *mq = req->q->queuedata;
>>>  	u32 stop_err_bits;
>>>  
>>> +	/*
>>> +	 * Either write timed out during busy and data->error is set
>>> +	 * or we actually received a valid R2 and check for error bits.
>>> +	 */
>>>  	if (mmc_host_is_spi(mq->card->host))
>>> -		return false;
>>> +		return brq->data.error || !!status;
>>
>> This function is for checking status, so brq->data.error does not belong here.  Also it would be more readable to use a define e.g.
>>
>> 		return status & SPI_R2_ERRORS;
>>
>> I think clearing bytes_xfered for SPI brq->data.error should be a separate patch, and you would need to explain a bit more for that case too.
> 
> I understand that, but there is no way of checking status in SPI mode.
> The behavior of mmc block is only changed in a minor way here anyway, that is, checking for status is done one more time than before.
> If brq->data.error is set directly after a write e.g. then bytes_xfered is already 0.

The expectation is that the driver sets bytes_xfered correctly,
based controller errors.  The driver is not expected to check for
status errors, hence in that case the bytes_xfered is set to 0 by
error recovery.

> My intention was mostly to improve on the flow of the recovery and get the mmc_is_host_spi out of there for the most part with future patches.
> After all it feels weird to do a single step read retry before ensuring a fix_state, and I ran into that quite often.
> Unfortunately, I now realized that fix_state cannot properly be implemented within the spec or even real-world card's behavior and I won't be taking this further.
> The best attempt I came up with is doing a loop of CMD12 and CMD13 in SPI and if CMD12 was ILLEGAL and CMD12 has no bits set, state is fixed.
> But CMD12 is only defined for multiple block transfers in SPI and cards treat it differently on e.g. CMD17 transfers.
> Instead I would just do a soft reset for SPI and retry and maybe increase the read timeout of 100ms which larger SD cards can fail sometimes.
> Anyway since SPI initialization is quite fast, especially for soft resets there is likely no recovery to beat that performance-wise.
> I will send an RFC for the soft reset in the coming days.

That sounds like it would be a good improvement to have.

> If not I would at least add the !mmc_is_host_spi condition for calling mmc_blk_status_error to make it a bit more clear that this function does do what is intended for SPI cards.

I am not sure what you mean.  Isn't it OK to check CMD13 response for SPI?
