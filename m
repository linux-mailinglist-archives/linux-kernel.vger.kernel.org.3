Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF57955DD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiF1LNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiF1LNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:13:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8052CDFC;
        Tue, 28 Jun 2022 04:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656414821; x=1687950821;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=w2smDjFDSnaWaF8DZXAccU3orfE582qzoDzr3rq7nFo=;
  b=CwaEV0TNKZ5KumfWffqVpg0qgRICVLhkfTRKSFvtkKfPWy58J//hY9Yl
   AZU+zoZolFNebmOi7qVCzrhRvLehRskDvRtfBX3VQfWywJFirKf/xphwh
   HZxuEn3U9jbdzL+1kfGTY1YRWhULacu8MD4xFUWiOXQXgExjD/b2AOKdq
   uMQDOSf91vTc0aaSUBs914eq/bfSPkt6IThgofMwvO0ry6I/Mg5gZTc33
   oWM5mWsiCa6UcjIv3i1PhRzXQGEWGVU6Y4F6u50GngpefgyLUyZCtulmz
   OFmUI/qeMiB28CtyoOXUNDvo070GQaVjnbbMSnZmuFntzFptMwcs5NTlc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="368025223"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="368025223"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:13:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646871058"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.204])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:13:39 -0700
Message-ID: <e7ebb779-9938-d5f7-d900-dbea55b4ac72@intel.com>
Date:   Tue, 28 Jun 2022 14:13:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCHv2] mmc: block: Add single read for 4k sector cards
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e0cce326393645d3b4a163ce65c89fb9@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <e0cce326393645d3b4a163ce65c89fb9@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/22 12:08, Christian Löhle wrote:
>> Cards with 4k native sector size may only be read 4k-aligned,
>>> accommodate for this in the single read recovery and use it.
>>
>> Thanks for the patch.
>>
>>>
>>> Fixes: 81196976ed946 (mmc: block: Add blk-mq support)
>>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>>
>> FYI checkpatch says:
>>
>> WARNING: From:/Signed-off-by: email name mismatch: 'From: "Christian Löhle" <CLoehle@hyperstone.com>' != 'Signed-off-by: Christian Loehle <cloehle@hyperstone.com>'
> 
> Will be fixed in my future patches, thanks for the hint.
> 
>>
>>> ---
>>>  drivers/mmc/core/block.c | 25 ++++++++++++-------------
>>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>> index f4a1281658db..a75a208ce203 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -176,7 +176,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
>>>  				      unsigned int part_type);
>>>  static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>>  			       struct mmc_card *card,
>>> -			       int disable_multi,
>>> +			       int recovery_mode,
>>>  			       struct mmc_queue *mq);
>>>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>>>  
>>> @@ -1302,7 +1302,7 @@ static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
>>>  }
>>>  
>>>  static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>>> -			      int disable_multi, bool *do_rel_wr_p,
>>> +			      int recovery_mode, bool *do_rel_wr_p,
>>>  			      bool *do_data_tag_p)
>>>  {
>>>  	struct mmc_blk_data *md = mq->blkdata;
>>> @@ -1372,8 +1372,8 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>>>  		 * at a time in order to accurately determine which
>>>  		 * sectors can be read successfully.
>>>  		 */
>>> -		if (disable_multi)
>>> -			brq->data.blocks = 1;
>>> +		if (recovery_mode)
>>> +			brq->data.blocks = mmc_large_sector(card) ? 8 : 1;
>>
>> I suggest changing to use queue_physical_block_size() here and further below
> 
> This part I'm impartial about, not sure if it makes it more readable, hopefully we never have to support another "native sector size" apart from the two.
> Anyway I will send the next patch with queue_physical_block_size()
> 
>>
>> 			brq->data.blocks = queue_physical_block_size(req->q) >> SECTOR_SHIFT;
> 
> Do we want to switch to SECTOR_SHIFT instead of 9? So far SECTOR_SHIFT is not used at all in mmc core.

I guess '9' is more consistent

> If so I would go ahead and change all the others in another patch:
> queue.c:187:	q->limits.discard_granularity = card->pref_erase << 9;
> core.c:103:	data->bytes_xfered = (prandom_u32() % (data->bytes_xfered >> 9)) << 9;
> mmc.c:792:MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
> mmc.c:793:MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
> mmc_test.c:1557:	sz = (unsigned long)test->card->pref_erase << 9;
> mmc_test.c:1570:		t->max_tfr = test->card->host->max_blk_count << 9;
> mmc_test.c:2461:	if (repeat_cmd && (t->blocks + 1) << 9 > t->max_tfr)
> sd.c:707:MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
> sd.c:708:MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
> block.c:1417:		int i, data_size = brq->data.blocks << 9;
> block.c:1851:			brq->data.bytes_xfered = blocks << 9;
> 
> 
> 
> 
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

