Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C048C1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiALJwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:52:23 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:44016 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiALJwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:52:19 -0500
X-KPN-MessageId: 25afc66f-738d-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 25afc66f-738d-11ec-8a6e-005056ab378f;
        Wed, 12 Jan 2022 10:51:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=JWV9gpnOFZc5xqMt+Kp1anWOuCekvScaCFHfyCKDtJ4=;
        b=aKmLJTiY/rzEC8L6ExjRdR9TmpFTd+HlQrLDLWRiFI7ckQwyn9zPH0oFNGg9/P4GhbKZGojBaQ89U
         A4/pPJRNcgjtS4nV298zVqq09YwJHjHV4Iz3iC3VKBycBzcY11t7RhqqYQowwmwKr6X1i+LdCJoOlK
         LT0Axb8NYnyFL3kcLcD6n2HLHp0cK4tFchrlOWZkwLH9A97cba29cVuLf70fMKX3ZCS8JPAPUop8Oe
         HudyOpuoYqKCUjtaapqYHUrmtBixpiuSsOqLOuh2Wo3jMPtBY3NNPmzaeHrAXgO2E+ZHm/Nvmo1x2P
         OQk0Cjzku1Pqdvhl0VPGgS9OsgezGcQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RLFpkIQPsU3qAFZRoqXIb9KHg5nVlp/BoYgvbV+K8SrPJ2k9g7x+BVKOIX7aW3X
 CqRvmVOypiPVvIeAstMxE9g==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 5352fe80-738d-11ec-b76f-005056ab7584;
        Wed, 12 Jan 2022 10:52:17 +0100 (CET)
Message-ID: <aaa692f7-174a-83a9-8aae-64cda91044cb@xs4all.nl>
Date:   Wed, 12 Jan 2022 10:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH v3 07/23] media: atmel: atmel-isc-base: use streaming
 status when queueing buffers
Content-Language: en-US
To:     Eugen.Hristev@microchip.com, jacopo@jmondi.org,
        laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, robh+dt@kernel.org,
        sakari.ailus@iki.fi, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Nicolas.Ferre@microchip.com
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
 <20211213134940.324266-8-eugen.hristev@microchip.com>
 <c6adb59e-4554-dc08-3772-148eb22c29ba@xs4all.nl>
 <5e4f591b-9105-9de0-5067-2bd82dc04983@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <5e4f591b-9105-9de0-5067-2bd82dc04983@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 17:38, Eugen.Hristev@microchip.com wrote:
> On 1/11/22 5:53 PM, Hans Verkuil wrote:
>> On 13/12/2021 14:49, Eugen Hristev wrote:
>>> During experiments with libcamera, it looks like vb2_is_streaming returns
>>> true before our start streaming is called.
>>> Order of operations is streamon -> queue -> start_streaming
>>> ISC would have started the DMA immediately when a buffer is being added
>>> to the vbqueue if the queue is streaming.
>>> It is more safe to start the DMA after the start streaming of the driver is
>>> called.
>>> Thus, even if vb2queue is streaming, add the buffer to the dma queue of the
>>> driver instead of actually starting the DMA process, if the start streaming
>>> has not been called yet.
>>>
>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>> ---
>>>   drivers/media/platform/atmel/atmel-isc-base.c | 17 ++++++++++-------
>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
>>> index 26a6090f056c..e6c9071c04f0 100644
>>> --- a/drivers/media/platform/atmel/atmel-isc-base.c
>>> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
>>> @@ -441,12 +441,14 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
>>>        unsigned long flags;
>>>
>>>        spin_lock_irqsave(&isc->dma_queue_lock, flags);
>>> -     if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
>>> -             vb2_is_streaming(vb->vb2_queue)) {
>>> +
>>> +     if (!isc->cur_frm && list_empty(&isc->dma_queue) && !isc->stop) {
>>>                isc->cur_frm = buf;
>>>                isc_start_dma(isc);
>>> -     } else
>>> +     } else {
>>>                list_add_tail(&buf->list, &isc->dma_queue);
>>> +     }
>>> +
>>>        spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
>>>   }
>>
>> Both the old and new code doesn't make a lot of sense.
> 
> Hello Hans,
> 
> I debated this a bit with Laurent when I initially wrote the patch.
> 
> The problem with the current code, or the current way things are 
> working, is the fact that vb2_is_streaming returns true from the moment 
> of streamon.
> The DMA engine of the ISC is being started at the moment of 
> start_streaming, and if buffers are being sent earlier/later, they are 
> just added to the queue and DMA engine is restarted if it finished 
> previously.
> However if frames are added beforehand, like, first streamon, then add 

beforehand -> afterwards?

> some frames, and then later call the start_streaming, ISC will crash. 
> (as I said, DMA engine is prepared at start_streaming).
> To avoid this, I changed the vb2_is_streaming calls to keeping an 
> internal state of the streaming.
> Do you think I should try another different approach to solve this ?
> Perhaps do not prepare the ISC dma engine at start_streaming, but at 
> another place ?
> 
> Laurent do you remember the talk we had about this problem a while back ?
> 
>>
>> buf_queue is only called by vb2 if start_streaming has already been called or is
>> about to be called.
> 
> That's a huge difference for ISC driver as it is today. start_streaming 
> being called afterwards, means the ISC DMA engine is not started (not 
> started streaming), hence a crash.

The start_streaming op is called when streamon is called and if there are
sufficient buffers (>= q->min_buffers_needed). If there are insufficient
buffers at streamon time, then start_streaming is only called when the number
of queued buffers reaches the minimum.

vb2 has three different state checks that you can use:

vb2_is_busy() is true if buffers are allocated. Typically this means that you
can no longer do format changes or anything that might change the buffer
sizes or layout.

vb2_is_streaming() is true if streamon was called. If this is true, then vb2_is_busy()
is also true.

And finally vb2_start_streaming_called() is true if the start_streaming op
was called (i.e. DMA is in progress). If this is true, then vb2_is_streaming is
also true.

Basically vb2_is_streaming() reports the streaming state that userspace sees,
while vb2_start_streaming_called() reports the internal DMA streaming state.

The confusion is probably that you were using vb2_is_streaming instead of
vb2_start_streaming_called.

> 
>>
>> Typically all that the buf_queue op does is to call list_add_tail(&buf->list, &isc->dma_queue);
>> inside the spinlock.
>>
>>>
>>> @@ -1014,7 +1016,7 @@ static int isc_s_fmt_vid_cap(struct file *file, void *priv,
>>>   {
>>>        struct isc_device *isc = video_drvdata(file);
>>>
>>> -     if (vb2_is_streaming(&isc->vb2_vidq))
>>> +     if (!isc->stop)
>>
>> This is weird as well. Normally this calls vb2_is_busy to check if the
>> queue is busy (that really means that buffers are already allocated, so
>> changing the format isn't allowed anymore).
> 
> You think the query to the streaming status makes no sense here hence it 
> should be removed completely ?

Right. And instead check vb2_is_busy().

I actually think that this is something that would fail with v4l2-compliance.

Do you still run v4l2-compliance?

> I can do that with a prequel patch if it's the case.

Probably wise.

Regards,

	Hans

> 
> Thanks for reviewing,
> 
> Eugen
> 
>>
>>>                return -EBUSY;
>>>
>>>        return isc_set_fmt(isc, f);
>>> @@ -1536,7 +1538,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>>>
>>>                isc_update_awb_ctrls(isc);
>>>
>>> -             if (vb2_is_streaming(&isc->vb2_vidq)) {
>>> +             if (!isc->stop) {
>>
>> Ditto.
>>
>>>                        /*
>>>                         * If we are streaming, we can update profile to
>>>                         * have the new settings in place.
>>> @@ -1552,8 +1554,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>>>                }
>>>
>>>                /* if we have autowhitebalance on, start histogram procedure */
>>> -             if (ctrls->awb == ISC_WB_AUTO &&
>>> -                 vb2_is_streaming(&isc->vb2_vidq) &&
>>> +             if (ctrls->awb == ISC_WB_AUTO && !isc->stop &&
>>>                    ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
>>>                        isc_set_histogram(isc, true);
>>>
>>> @@ -1829,6 +1830,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>>>        struct vb2_queue *q = &isc->vb2_vidq;
>>>        int ret = 0;
>>>
>>> +     isc->stop = true;
>>> +
>>
>> I'm really not sure that you need the stop bool at all.
>>
>>>        INIT_WORK(&isc->awb_work, isc_awb_work);
>>>
>>>        ret = v4l2_device_register_subdev_nodes(&isc->v4l2_dev);
>>
>> Regards,
>>
>>          Hans
>>
> 

