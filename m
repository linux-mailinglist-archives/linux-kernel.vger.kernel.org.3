Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94C148BE74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiALGFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:05:47 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:12474 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiALGFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:05:45 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20C5x3q2088074;
        Wed, 12 Jan 2022 13:59:03 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Jan
 2022 14:05:40 +0800
Message-ID: <a779f1c1-e5b0-5d55-bc6c-5f253d03525d@aspeedtech.com>
Date:   Wed, 12 Jan 2022 14:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] media: aspeed: Fix no complete irq for non-64-aligned
 width
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
CC:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211214045348.13702-1-jammy_huang@aspeedtech.com>
 <CACPK8XfkXi6M=gzfkYcuoga6WxnzSm2+mspBt4gjop7Ytm+VCA@mail.gmail.com>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <CACPK8XfkXi6M=gzfkYcuoga6WxnzSm2+mspBt4gjop7Ytm+VCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20C5x3q2088074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

OK, thanks for your review. I will send another updated patch per your 
advice.

On 2022/1/12 上午 08:51, Joel Stanley wrote:
> On Tue, 14 Dec 2021 at 04:53, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>> In ast2500, engine will stop occasionally for 1360x768.
>>
>> This is a bug which has been addressed, but the workaround is specific
>> for 1680 only. Here we make it more complete.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/media/platform/aspeed-video.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index 793b2adaa0f5..4d3e6b105d44 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -1055,18 +1055,20 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>>          /* Set capture/compression frame sizes */
>>          aspeed_video_calc_compressed_size(video, size);
>>
>> -       if (video->active_timings.width == 1680) {
>> +       if (!IS_ALIGNED(act->width, 64)) {
>>                  /*
>>                   * This is a workaround to fix a silicon bug on A1 and A2
> Please add:  "a AST2500 silicon bug" so we know which A1/A2 this is
> referring to.
>
> With that added, you can add:
>
>   Reviewed-by: Joel Stanley <joel@jms.id.au>
>
>>                   * revisions. Since it doesn't break capturing operation of
>>                   * other revisions, use it for all revisions without checking
>> -                * the revision ID. It picked 1728 which is a very next
>> -                * 64-pixels aligned value to 1680 to minimize memory bandwidth
>> +                * the revision ID. It picked new width which is a very next
>> +                * 64-pixels aligned value to minimize memory bandwidth
>>                   * and to get better access speed from video engine.
>>                   */
>> +               u32 width = ALIGN(act->width, 64);
>> +
>>                  aspeed_video_write(video, VE_CAP_WINDOW,
>> -                                  1728 << 16 | act->height);
>> -               size += (1728 - 1680) * video->active_timings.height;
>> +                                  width << 16 | act->height);
>> +               size = width * act->height;
> You could make it clearer by putting the write on one line:
>
>                  aspeed_video_write(video, VE_CAP_WINDOW, width << 16 |
> act->height);

-- 
Best Regards
Jammy

