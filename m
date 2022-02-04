Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73F4A985E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358347AbiBDL0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:26:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:60004 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235838AbiBDL0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643973972; x=1675509972;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zOiOeg3TVAJfReAk+ZzPsbdrjm9uWUHKiDyGZw8xRIM=;
  b=dI5mwMdYKLuzqHLSXWZ3CGsugML1MSENybODW2nLAgb9jG/wtA0rhOLZ
   G2l+aIDJHvwEa3vDoxAabJn0qvSfXqnEEZlzst1VldjMMhYfTM3H5AntK
   Uq3HCHynreBxvzyvBRTEcH1fCXBUmzyBorqq2E7KfXeMgh8U6PcPVnHRy
   EdGJs0SzZMjlmWgechv8sM5dgoYtrT9nKe/L1jEl2B7Yc1c2qFe3jAHaZ
   B6I0lWoH8CMheONDF72Z+b9nuGasAf/PAs84LVpzc2t90B2l6PdSo6PkI
   mWyCJs5gq1D9Z/dHtclXggBgLubSZ3tNsdohEWqgMMWVUf0qOX1dshNDy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248565680"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248565680"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 03:26:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="631673031"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 04 Feb 2022 03:26:10 -0800
Subject: Re: [PATCH] mmc: block: fix read single on recovery logic
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
References: <5e5f2e45d0a14a55a8b7a9357846114b@hyperstone.com>
 <7c4757cc707740e580c61c39f963a04d@hyperstone.com>
 <CAPDyKFr0YXCwL-8F9M7mkpNzSQpzw6gNUq2zaiJEXj1jNxUbrg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5c66833d-4b35-2c76-db54-0306e08843e5@intel.com>
Date:   Fri, 4 Feb 2022 13:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr0YXCwL-8F9M7mkpNzSQpzw6gNUq2zaiJEXj1jNxUbrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 11:47, Ulf Hansson wrote:
> + Adrian
> 
> On Thu, 3 Feb 2022 at 11:09, Christian Löhle <CLoehle@hyperstone.com> wrote:
>>
>> So could anyone take a long at this so far?
>>
> 
> Thanks for pinging. Apologize for the delay, it's on top of my "to-review" list.
> 
> I have added Adrian too, who knows this code very well too.
> 
> Kind regards
> Uffe
> 
>>
>>
>> From: Christian Löhle
>> Sent: Wednesday, January 5, 2022 5:43 PM
>> To: ulf.hansson@linaro.org; Christian Löhle; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Avri Altman
>> Subject: [PATCH] mmc: block: fix read single on recovery logic
>>
>> On reads with MMC_READ_MULTIPLE_BLOCK that fail,
>> the recovery handler will use MMC_READ_SINGLE_BLOCK for
>> each of the blocks, up to MMC_READ_SINGLE_RETRIES times each.
>> The logic for this is fixed to never report unsuccessful reads
>> as success to the block layer.
>>
>> On command error with retries remaining, blk_update_request was
>> called with whatever value error was set last to.
>> In case it was last set to BLK_STS_OK (default), the read will be
>> reported as success, even though there was no data read from the device.
>> This could happen on a CRC mismatch for the response,
>> a card rejecting the command (e.g. again due to a CRC mismatch).
>> In case it was last set to BLK_STS_IOERR, the error is reported correctly,
>> but no retries will be attempted.
>>
>> The patch now will count both command and data errors as retries and
>> send BLK_STS_IOERR if there are no retries remaining,
>> or BLK_STS_OK if the single read was successful in the meantime.
>>
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Thanks for the patch.

Looks OK, although a couple of comments below, plus it needs
a Fixes tag, and Cc for stable.

Fixes: 81196976ed946c ("mmc: block: Add blk-mq support")
Cc: stable@vger.kernel.org

>> ---
>>  drivers/mmc/core/block.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 90e1bcd03b46..d7d880ce0f8a 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1682,31 +1682,31 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>>          struct mmc_card *card = mq->card;
>>          struct mmc_host *host = card->host;
>>          blk_status_t error = BLK_STS_OK;
>> -       int retries = 0;
>>
>>          do {
>>                  u32 status;
>>                  int err;
>> +               int retries = 0;
>>
>> -               mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
>> +               while (retries++ < MMC_READ_SINGLE_RETRIES) {

Because this is now checked at the top of the loop, wouldn't that
result in one fewer retries than before?  So, maybe:

		while (retries++ <= MMC_READ_SINGLE_RETRIES) {

>> +                       mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
>>
>> -               mmc_wait_for_req(host, mrq);
>> +                       mmc_wait_for_req(host, mrq);
>>
>> -               err = mmc_send_status(card, &status);
>> -               if (err)
>> -                       goto error_exit;
>> -
>> -               if (!mmc_host_is_spi(host) &&
>> -                   !mmc_ready_for_data(status)) {
>> -                       err = mmc_blk_fix_state(card, req);
>> +                       err = mmc_send_status(card, &status);
>>                          if (err)
>>                                  goto error_exit;
>> -               }
>>
>> -               if (mrq->cmd->error && retries++ < MMC_READ_SINGLE_RETRIES)
>> -                       continue;
>> +                       if (!mmc_host_is_spi(host) &&
>> +                           !mmc_ready_for_data(status)) {
>> +                               err = mmc_blk_fix_state(card, req);
>> +                               if (err)
>> +                                       goto error_exit;
>> +                       }
>>
>> -               retries = 0;
>> +                       if (!mrq->cmd->error && !mrq->data->error)

We weren't retrying for data errors before, and I don't think we want to
because single block read can be very slow. i.e. just

			if (!mrq->cmd->error)

>> +                               break;
>> +               }
>>
>>                  if (mrq->cmd->error ||
>>                      mrq->data->error ||
>> --
>> 2.34.1
>>     =
>> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
>> Managing Director: Dr. Jan Peter Berns.
>> Commercial register of local courts: Freiburg HRB381782
>>

