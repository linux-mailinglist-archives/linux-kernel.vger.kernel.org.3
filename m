Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA547CCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbhLVGKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:10:41 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:55989 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhLVGKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:10:39 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BM65Bfb064928;
        Wed, 22 Dec 2021 14:05:11 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Dec
 2021 14:10:37 +0800
Message-ID: <aa3cae53-38bb-e8a8-62df-aeda0272f1f4@aspeedtech.com>
Date:   Wed, 22 Dec 2021 14:10:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] media: aspeed: Fix timing polarity incorrect
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
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com>
 <20211217095403.2618-5-jammy_huang@aspeedtech.com>
 <CACPK8Xf7rsjgCv=Honyf8gwDWbG67dPVjE+z_tXD4yEu1WaE5w@mail.gmail.com>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <CACPK8Xf7rsjgCv=Honyf8gwDWbG67dPVjE+z_tXD4yEu1WaE5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BM65Bfb064928
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

OK, I will update in next patch as you advised.
Thanks for your review.

On 2021/12/22 上午 09:22, Joel Stanley wrote:
> On Fri, 17 Dec 2021 at 09:54, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>> This is a workaround for polarity unstable.
>> Sync value get by VR09C counts from sync's rising edge, which means
>> sync's polarity is negative if sync value is bigger than total/2.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/media/platform/aspeed-video.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index 5ad3a20c5bac..f628f69bb7dd 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -989,6 +989,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>>                  video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
>>                                               src_tb_edge);
>>                  det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
>> +               /*
>> +                * Workaround for polarity detection
>> +                * Use sync(VR098) counts from sync's rising edge till falling
>> +                * edge to tell sync polarity.
>> +                */
>> +               if (det->vsync > (FIELD_GET(VE_MODE_DETECT_V_LINES, mds) >> 1))
> Are you right shifting as this is the value / 2? I think it's clearer
> to write / 2 instead of >> 1.
>
> Mention in the comment that this is a workaround for when the sync
> value is larger than half.
>
>> +                       det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
>> +               else
>> +                       det->polarities |= V4L2_DV_VSYNC_POS_POL;
>>                  if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
>>                          det->vbackporch = video->frame_top - det->vsync;
>>                          det->vfrontporch =
>> @@ -1010,6 +1019,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>>                  video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
>>                                                src_lr_edge);
>>                  det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
>> +               /*
>> +                * Workaround for polarity detection
>> +                * Use sync(VR098) counts from sync's rising edge till falling
>> +                * edge to tell sync polarity.
>> +                */
>> +               if (det->hsync > (htotal >> 1))
>> +                       det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
>> +               else
>> +                       det->polarities |= V4L2_DV_HSYNC_POS_POL;
>>                  if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
>>                          det->hbackporch = video->frame_left - det->hsync;
>>                          det->hfrontporch = htotal - video->frame_right;
>> --
>> 2.25.1
>>
-- 
Best Regards
Jammy

