Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E85497CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiAXKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:22:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33646 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiAXKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:22:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CF436CE106E;
        Mon, 24 Jan 2022 10:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB2EC340E1;
        Mon, 24 Jan 2022 10:22:48 +0000 (UTC)
Message-ID: <2ddda01a-3f1f-eff6-6ce1-a5b9354f2993@xs4all.nl>
Date:   Mon, 24 Jan 2022 11:22:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/4] media: aspeed: Fix timing polarity incorrect
Content-Language: en-US
To:     Jammy Huang <jammy_huang@aspeedtech.com>, eajames@linux.ibm.com,
        mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211222082139.26933-1-jammy_huang@aspeedtech.com>
 <20211222082139.26933-5-jammy_huang@aspeedtech.com>
 <418fc1b2-ddbe-24e3-82cc-aa8ce74f4507@xs4all.nl>
 <b8707885-c10c-ca19-3f2c-f19f567e1f92@aspeedtech.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <b8707885-c10c-ca19-3f2c-f19f567e1f92@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 03:29, Jammy Huang wrote:
> 
> On 2022/1/21 下午 03:30, Hans Verkuil wrote:
>> On 12/22/21 09:21, Jammy Huang wrote:
>>> This is a workaround for sync polarity unstable.
>>> Sync value get by VR09C counts from sync's rising edge, which means
>>> sync's polarity is negative if sync value is bigger than total/2.
>> Do you have an example of such a format, or is this mostly theoretical?
>>
>> Either provide the example or make a note that it is theoretical.
> 
> OK, I will update an example in next patch. Let me explain first.
> 
> This is a must-be result. Please refer to the graph below as I sent in 3/4 of this
> series. For negative sync, sync width equals to back porch + data enable + front porch.
> Thus, sync would be bigger than 90% of total in most cases.

Right, I suspected that might be the case.

I think it would be better to combine patches 3 and 4 into a single
patch, since they are closely related and it is actually easier to
understand if it's just a single patch.

Regards,

	Hans

> 
>                   +-------------------+
>                   |    v i d e o      |
>       +--+  +-----+                   +-----+  +---+
>          |  |                               |  |
>          +--+                               +--+
>        vsync+-------------------------------+
>    frame_top+-----+
> frame_bottom+-------------------------+
> 
> 
> Following registers are what I got for 1920x1200@60.
> 
> 1e700090: 07ee206f 04c9001a c4d3efff 04cc001f
> 
> 1e7000a0: 0000081f 00000000 00000000 00000000
> 
> vertical total = 0x4D3 (VR098[27:16]) = 1235
> vertical sync = 0x4CC (VR09C[27:16]) = 1228
> 
>>
>> Regards,
>>
>>     Hans
>>
>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>> ---
>>>   v2:
>>>    - Use 'total/2' rather than 'total<<1'
>>>    - Update comment
>>> ---
>>>   drivers/media/platform/aspeed-video.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>>> index 7c50567f5ab0..c3e3343d91e1 100644
>>> --- a/drivers/media/platform/aspeed-video.c
>>> +++ b/drivers/media/platform/aspeed-video.c
>>> @@ -989,6 +989,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>>>             video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
>>>           video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
>>> +
>>> +        /*
>>> +         * This is a workaround for polarity detection when the sync
>>> +         * value is larger than half.
>>> +         */
>>> +        if (vsync > (vtotal / 2))
>>> +            det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
>>> +        else
>>> +            det->polarities |= V4L2_DV_VSYNC_POS_POL;
>>> +
>>>           if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
>>>               det->vbackporch = video->frame_top - vsync;
>>>               det->vfrontporch = vtotal - video->frame_bottom;
>>> @@ -1003,6 +1013,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>>>             video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
>>>           video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
>>> +
>>> +        /*
>>> +         * This is a workaround for polarity detection when the sync
>>> +         * value is larger than half.
>>> +         */
>>> +        if (hsync > (htotal / 2))
>>> +            det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
>>> +        else
>>> +            det->polarities |= V4L2_DV_HSYNC_POS_POL;
>>> +
>>>           if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
>>>               det->hbackporch = video->frame_left - hsync;
>>>               det->hfrontporch = htotal - video->frame_right;
> 

