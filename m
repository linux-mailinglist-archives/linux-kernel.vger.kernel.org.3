Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162F24750A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbhLOCAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:00:52 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:5592 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhLOCAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:00:52 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BF1YZNM022130;
        Wed, 15 Dec 2021 09:34:35 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Dec
 2021 09:59:58 +0800
Message-ID: <851a6a45-f132-463a-2d4b-1248202aa60b@aspeedtech.com>
Date:   Wed, 15 Dec 2021 09:59:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] media: aspeed: move err-handling together to the
 bottom
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
References: <20211206004811.1118-1-jammy_huang@aspeedtech.com>
 <20211214155300.0132946e@coco.lan> <YbjjMDQ+V6ilbQvj@paasikivi.fi.intel.com>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <YbjjMDQ+V6ilbQvj@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BF1YZNM022130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thanks for your review.

On 2021/12/15 上午 02:32, Sakari Ailus wrote:
> Hi Mauro,
>
> On Tue, Dec 14, 2021 at 03:53:00PM +0100, Mauro Carvalho Chehab wrote:
>> Em Mon, 6 Dec 2021 08:48:11 +0800
>> Jammy Huang <jammy_huang@aspeedtech.com> escreveu:
>>
>>> refine aspeed_video_setup_video() flow.
>> Why? It makes no difference where the error handling code is. Let's
>> keep it as preferred by the driver's author ;-)
> Doing error handling can be done in different ways of course, but I think
> it's easier to see it's right as it's done by this patch. Of course the
> original author's --- like anyone else's --- review wouldn't hurt. But I
> see he hasn't reviewed other recent patches to the driver either.
>
> A better description would be nice though, including capital letter
> beginning a sentence.
>
>> Regards,
>> Mauro
>>
>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>> ---
>>> v2:
>>>   - remove change-id in comment
>>> ---
>>>   drivers/media/platform/aspeed-video.c | 24 +++++++++++-------------
>>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>>> index fea5e4d0927e..f5c40d6b4ece 100644
>>> --- a/drivers/media/platform/aspeed-video.c
>>> +++ b/drivers/media/platform/aspeed-video.c
>>> @@ -1641,11 +1641,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>>   
>>>   	rc = video->ctrl_handler.error;
>>>   	if (rc) {
>>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>>> -		v4l2_device_unregister(v4l2_dev);
>>> -
>>>   		dev_err(video->dev, "Failed to init controls: %d\n", rc);
>>> -		return rc;
>>> +		goto err_ctrl_init;
>>>   	}
>>>   
>>>   	v4l2_dev->ctrl_handler = &video->ctrl_handler;
>>> @@ -1663,11 +1660,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>>   
>>>   	rc = vb2_queue_init(vbq);
>>>   	if (rc) {
>>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>>> -		v4l2_device_unregister(v4l2_dev);
>>> -
>>>   		dev_err(video->dev, "Failed to init vb2 queue\n");
>>> -		return rc;
>>> +		goto err_vb2_init;
>>>   	}
>>>   
>>>   	vdev->queue = vbq;
>>> @@ -1685,15 +1679,19 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>>   	video_set_drvdata(vdev, video);
>>>   	rc = video_register_device(vdev, VFL_TYPE_GRABBER, 0);
>>>   	if (rc) {
>>> -		vb2_queue_release(vbq);
>>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>>> -		v4l2_device_unregister(v4l2_dev);
>>> -
>>>   		dev_err(video->dev, "Failed to register video device\n");
>>> -		return rc;
>>> +		goto err_video_reg;
>>>   	}
>>>   
>>>   	return 0;
>>> +
>>> +err_video_reg:
>>> +	vb2_queue_release(vbq);
>>> +err_vb2_init:
>>> +err_ctrl_init:
>>> +	v4l2_ctrl_handler_free(&video->ctrl_handler);
>>> +	v4l2_device_unregister(v4l2_dev);
>>> +	return rc;
>>>   }
>>>   
>>>   static int aspeed_video_init(struct aspeed_video *video)
>>
>>
>> Thanks,
>> Mauro

-- 
Best Regards
Jammy

