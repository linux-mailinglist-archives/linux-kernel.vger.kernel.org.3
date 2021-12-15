Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28E14750A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhLOCA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:00:56 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:50665 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhLOCAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:00:52 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BF1Y3pH022113;
        Wed, 15 Dec 2021 09:34:03 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Dec
 2021 09:59:26 +0800
Message-ID: <8bc81b12-795e-b7a1-64dd-a15f30c5f19d@aspeedtech.com>
Date:   Wed, 15 Dec 2021 09:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] media: aspeed: move err-handling together to the
 bottom
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211206004811.1118-1-jammy_huang@aspeedtech.com>
 <20211214155300.0132946e@coco.lan>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <20211214155300.0132946e@coco.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BF1Y3pH022113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Because I saw similar error-handling in aspeed_video_init(), I just want 
to make it clear and identical.
It's ok if not applied. Just style problem, as you said.

On 2021/12/14 下午 10:53, Mauro Carvalho Chehab wrote:
> Em Mon, 6 Dec 2021 08:48:11 +0800
> Jammy Huang <jammy_huang@aspeedtech.com> escreveu:
>
>> refine aspeed_video_setup_video() flow.
> Why? It makes no difference where the error handling code is. Let's
> keep it as preferred by the driver's author ;-)
>
> Regards,
> Mauro
>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>> v2:
>>   - remove change-id in comment
>> ---
>>   drivers/media/platform/aspeed-video.c | 24 +++++++++++-------------
>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index fea5e4d0927e..f5c40d6b4ece 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -1641,11 +1641,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>   
>>   	rc = video->ctrl_handler.error;
>>   	if (rc) {
>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>> -		v4l2_device_unregister(v4l2_dev);
>> -
>>   		dev_err(video->dev, "Failed to init controls: %d\n", rc);
>> -		return rc;
>> +		goto err_ctrl_init;
>>   	}
>>   
>>   	v4l2_dev->ctrl_handler = &video->ctrl_handler;
>> @@ -1663,11 +1660,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>   
>>   	rc = vb2_queue_init(vbq);
>>   	if (rc) {
>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>> -		v4l2_device_unregister(v4l2_dev);
>> -
>>   		dev_err(video->dev, "Failed to init vb2 queue\n");
>> -		return rc;
>> +		goto err_vb2_init;
>>   	}
>>   
>>   	vdev->queue = vbq;
>> @@ -1685,15 +1679,19 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>>   	video_set_drvdata(vdev, video);
>>   	rc = video_register_device(vdev, VFL_TYPE_GRABBER, 0);
>>   	if (rc) {
>> -		vb2_queue_release(vbq);
>> -		v4l2_ctrl_handler_free(&video->ctrl_handler);
>> -		v4l2_device_unregister(v4l2_dev);
>> -
>>   		dev_err(video->dev, "Failed to register video device\n");
>> -		return rc;
>> +		goto err_video_reg;
>>   	}
>>   
>>   	return 0;
>> +
>> +err_video_reg:
>> +	vb2_queue_release(vbq);
>> +err_vb2_init:
>> +err_ctrl_init:
>> +	v4l2_ctrl_handler_free(&video->ctrl_handler);
>> +	v4l2_device_unregister(v4l2_dev);
>> +	return rc;
>>   }
>>   
>>   static int aspeed_video_init(struct aspeed_video *video)
>
>
> Thanks,
> Mauro

-- 
Best Regards
Jammy

