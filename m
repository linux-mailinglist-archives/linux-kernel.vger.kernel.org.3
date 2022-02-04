Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E944A9B11
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359351AbiBDOev convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 09:34:51 -0500
Received: from mail3.swissbit.com ([176.95.1.57]:35484 "EHLO
        mail3.swissbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiBDOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:34:48 -0500
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 84CB1462FB5;
        Fri,  4 Feb 2022 15:34:47 +0100 (CET)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7550D462F64;
        Fri,  4 Feb 2022 15:34:47 +0100 (CET)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Fri,  4 Feb 2022 15:34:47 +0100 (CET)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 4 Feb 2022
 15:34:46 +0100
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.015; Fri, 4 Feb 2022 15:34:46 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH] mmc: block: fix read single on recovery logic
Thread-Topic: [PATCH] mmc: block: fix read single on recovery logic
Thread-Index: AQHYAlL02lgrcWpb+EOcEaPCcQdJl6yBx2GngAF7vYCAABt7gIAAP6R0
Date:   Fri, 4 Feb 2022 14:34:46 +0000
Message-ID: <79d44b0c54e048b0a9cc86319a24cc19@hyperstone.com>
References: <5e5f2e45d0a14a55a8b7a9357846114b@hyperstone.com>
 <7c4757cc707740e580c61c39f963a04d@hyperstone.com>
 <CAPDyKFr0YXCwL-8F9M7mkpNzSQpzw6gNUq2zaiJEXj1jNxUbrg@mail.gmail.com>,<5c66833d-4b35-2c76-db54-0306e08843e5@intel.com>
In-Reply-To: <5c66833d-4b35-2c76-db54-0306e08843e5@intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.17]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-8.6.1018-26696.000
X-TMASE-Result: 10--14.327100-10.000000
X-TMASE-MatchedRID: mHCEnrG40p7UL3YCMmnG4o61Z+HJnvsOLnxHrWphhgQ0C8Dp8kkTtXls
        GJXt79WMCQeiUZjdR3+JPOHtG0kzdv4/7++nTNOSiPzlIoC92lsiJN3aXuV/ocK0HkBcZFjbSA5
        hfW+G+AxkMA27L/Pxy2l3bXr8XG4BuVKcazUH+Z0K4MBRf7I7pnFd5+Cf9M1DRu2i7U96I/tGvu
        BXbruwYtnDYS1q+6iC6S2BcTg0br4zPQQUbmWdbwGdJZ3Knh6hEqfa6mOo3hJPQiQvzFiGePIGO
        +HJkWIUIUmekopQkEBFpTspMEQg/sYke508iy7uXUHjCD72l8VPEvlTYRZqW2KuDy0kKGx0k4aZ
        O5jBVFBlFf3Mytp2wUgYjLCuO5t1N68Ooe9V0NvxQg/1zqqUm0+crEA4+nhZnhD4vcFcha517m4
        6SQpgTyGa8xxNbOKO00IQ/OgAa/8TDYs1l+XMYhouoVvF2i0ZF4r8H5YrEqxjLp8Cm8vwF0Ac6D
        yoS2rIj6kCfX0Edc6J5ic0pChsqHePFNs7Zp0FkiSxx29igC0SNknbAcGHqvD2ovoq2qtoW984V
        9dpS5CVR9gps2i41BLm2GUHz1pbaDAi8sBNMoFGONWF/6P/Ckp0ODI8GjvXKrauXd3MZDUHJk9m
        fVhpPytH0ejg1PaqxEguEIEdLCLPqUd2X5in2TuK3WNrgGTB
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f0b606af-d71a-42dc-9d4a-68d734cb8561-0-0-200-0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments Adrian!

>> +               while (retries++ < MMC_READ_SINGLE_RETRIES) {
>
>Because this is now checked at the top of the loop, wouldn't that
>result in one fewer retries than before?  So, maybe:
>
>               while (retries++ <= MMC_READ_SINGLE_RETRIES) {

Yes, you are correct. Will be fixed in v2.

>> +                       if (!mrq->cmd->error && !mrq->data->error)
>
>We weren't retrying for data errors before, and I don't think we want to
>because single block read can be very slow. i.e. just
>
>                        if (!mrq->cmd->error)

That was intentional by me, it was very unintuitive to my you would not retry for data errors.
(Considering a data error is likely how you got into the whole recovery in the first place.)
But yes I see your point, a very large request might block this for quite a while.
Will change in v2, too.


From: Adrian Hunter <adrian.hunter@intel.com>
Sent: Friday, February 4, 2022 12:26 PM
To: Ulf Hansson; Christian Löhle
Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Avri Altman
Subject: Re: [PATCH] mmc: block: fix read single on recovery logic
    
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
>>  drivers/mmc/core/block.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 90e1bcd03b46..d7d880ce0f8a 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1682,31 +1682,31 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>>          struct mmc_card *card = mq->card;
>>          struct mmc_host *host = card->host;
>>          blk_status_t error = BLK_STS_OK;
>> -       int retries = 0;
>>
>>          do {
>>                  u32 status;
>>                  int err;
>> +               int retries = 0;
>>
>> -               mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
>> +               while (retries++ < MMC_READ_SINGLE_RETRIES) {

Because this is now checked at the top of the loop, wouldn't that
result in one fewer retries than before?  So, maybe:

                while (retries++ <= MMC_READ_SINGLE_RETRIES) {

>> +                       mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
>>
>> -               mmc_wait_for_req(host, mrq);
>> +                       mmc_wait_for_req(host, mrq);
>>
>> -               err = mmc_send_status(card, &status);
>> -               if (err)
>> -                       goto error_exit;
>> -
>> -               if (!mmc_host_is_spi(host) &&
>> -                   !mmc_ready_for_data(status)) {
>> -                       err = mmc_blk_fix_state(card, req);
>> +                       err = mmc_send_status(card, &status);
>>                          if (err)
>>                                  goto error_exit;
>> -               }
>>
>> -               if (mrq->cmd->error && retries++ < MMC_READ_SINGLE_RETRIES)
>> -                       continue;
>> +                       if (!mmc_host_is_spi(host) &&
>> +                           !mmc_ready_for_data(status)) {
>> +                               err = mmc_blk_fix_state(card, req);
>> +                               if (err)
>> +                                       goto error_exit;
>> +                       }
>>
>> -               retries = 0;
>> +                       if (!mrq->cmd->error && !mrq->data->error)

We weren't retrying for data errors before, and I don't think we want to
because single block read can be very slow. i.e. just

                        if (!mrq->cmd->error)

>> +                               break;
>> +               }
>>
>>                  if (mrq->cmd->error ||
>>                      mrq->data->error ||
>> --
>> 2.34.1
>>     =
>> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
>> Managing Director: Dr. Jan Peter Berns.
>> Commercial register of local courts: Freiburg HRB381782
>>

    =
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

