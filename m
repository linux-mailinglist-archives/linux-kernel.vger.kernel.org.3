Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE258D446
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiHIHM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiHIHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:12:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFD1F617;
        Tue,  9 Aug 2022 00:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 365A9B811B2;
        Tue,  9 Aug 2022 07:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DDEC433C1;
        Tue,  9 Aug 2022 07:12:47 +0000 (UTC)
Message-ID: <5d766333-fe91-fc12-16ee-1415983ba818@xs4all.nl>
Date:   Tue, 9 Aug 2022 09:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] media: videobuf2: Add a transfer error event
Content-Language: en-US
To:     Michael Rodin <mrodin@de.adit-jv.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, michael@rodin.online,
        erosca@de.adit-jv.com,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
References: <YqEO3/KekkZhVjW+@oden.dyn.berto.se>
 <20220628180024.451258-1-mrodin@de.adit-jv.com>
 <20220628180024.451258-2-mrodin@de.adit-jv.com>
 <5e8c50cdc031bffd96b19929508f034d1263c8b7.camel@ndufresne.ca>
 <20220715161346.GA1116690@vmlxhi-182>
 <f035cdea-934c-3bd9-f685-47e5e9ff3f49@xs4all.nl>
 <20220808170353.GA2536032@vmlxhi-182>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220808170353.GA2536032@vmlxhi-182>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 08/08/2022 19:03, Michael Rodin wrote:
> Hi Hans,
> 
> On Tue, Aug 02, 2022 at 11:32:03AM +0200, Hans Verkuil wrote:
>> Hi Michael,
>>
>> Apologies for the late reply...
> 
> Thank you very much for your feedback, very appreciated!
> 
>> On 7/15/22 18:15, Michael Rodin wrote:
>>> Hi Nicolas,
>>>
>>> On Mon, Jul 04, 2022 at 11:59:58AM -0400, Nicolas Dufresne wrote:
>>>> Hi Micheal,
>>>>
>>>> thanks for your work, I have some questions below ...
>>>
>>> Thank you for your feedback!
>>>
>>>> Le mardi 28 juin 2022 à 20:00 +0200, Michael Rodin a écrit :
>>>>> From: Niklas Söderlund <https://urldefense.proofpoint.com/v2/url?u=http-3A__niklas.soderlund-2Brenesas-40ragnatech.se&d=DwIFaQ&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=sWsgk3pKkv5GeIDM2RZlPY8TjNFU2D0oBeOj6QNBadE&m=7ktiIpDjee6bMSPLXXR7KVvJ_y234VytWEydKF2TWEo&s=-GUWUbGDkkrTAXiF_75xnL13cn3HYL2r2ZN0XwlG41U&e=>
>>>>>
>>>>> Add a new V4L2_EVENT_XFER_ERROR event to signal if an error happens during
>>>>> video transfer.
>>>>>
>>>>> The use-case that sparked this new event is to signal to the video
>>>>> device driver that an error has happen on the CSI-2 bus from the CSI-2
>>>>> receiver subdevice.
>>>>>
>>>>> Signed-off-by: Niklas Söderlund <https://urldefense.proofpoint.com/v2/url?u=http-3A__niklas.soderlund-2Brenesas-40ragnatech.se&d=DwIFaQ&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=sWsgk3pKkv5GeIDM2RZlPY8TjNFU2D0oBeOj6QNBadE&m=7ktiIpDjee6bMSPLXXR7KVvJ_y234VytWEydKF2TWEo&s=-GUWUbGDkkrTAXiF_75xnL13cn3HYL2r2ZN0XwlG41U&e=>
>>>>> [mrodin@de.adit-jv.com: adapted information what to do if this new event is received]
>>>>> Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
>>>>> ---
>>>>>  .../userspace-api/media/v4l/vidioc-dqevent.rst         | 10 ++++++++++
>>>>>  .../userspace-api/media/videodev2.h.rst.exceptions     |  1 +
>>>>>  include/uapi/linux/videodev2.h                         |  1 +
>>>>>  3 files changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
>>>>> index 6eb40073c906..3cf0b4859784 100644
>>>>> --- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
>>>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
>>>>> @@ -182,6 +182,16 @@ call.
>>>>>  	the regions changes. This event has a struct
>>>>>  	:c:type:`v4l2_event_motion_det`
>>>>>  	associated with it.
>>>>> +    * - ``V4L2_EVENT_XFER_ERROR``
>>>>
>>>> I'm not sure why this event is specific to XFER. Is there uses cases were a
>>>> future implementation would have both XFER and RECEIVER error ?
>>>
>>> I am not sure whether I understand you correctly, do you mean that there is
>>> already a method to signal a receiver error? Or that we should name it
>>> V4L2_EVENT_RECEIVER_ERROR? I think that "transfer error" is a good name for
>>> this event, because it could be sent by receiver or by transmitter drivers,
>>> depending on their hardware error detection capabilities. We could have
>>> e.g. a video transmitter which can detect an error coupled with a video
>>> receiver which can not detect any errors.
>>>
>>>>> +      - 7
>>>>> +      - This event is triggered when an transfer error is detected while
>>>>> +	streaming. For example if an error is detected on a video bus in
>>>>> +	the pipeline. If a driver receives this event from an upstream
>>>>> +	subdevice, it has to forward the event to userspace. The streaming
>>>>> +	application has to check if the transfer error is unrecoverable,
>>>>> +	i.e. no new buffers can be dequeued from the kernel after the
>>>>> +	expected time. If the error is unrecoverable, the streaming
>>>>> +	application should restart streaming if it wants to continue.
>>>>
>>>> The process to determine if an error is recoverable or not isn't clear to me. As
>>>> an application developer, I would not know what to do here. Recoverable error
>>>> already have a designed mechanism, it consist of marking done a buffer with the
>>>> flag V4L2_BUF_FLAG_ERROR. I would like to understand what the existing mechanism
>>>> needed to be replaced, and the placement should be documented.
>>>
>>> "Recoverable" means in this context that kernel space continues to capture
>>> video buffers (which do not necessarily have the flag V4L2_BUF_FLAG_ERROR).
>>> So probably we should not say "recoverable" or "unrecoverable" in the
>>> context of this event to avoid confusion. V4L2_EVENT_XFER_ERROR just tells
>>> userspace that it should restart streaming if the buffer flow stops after
>>> this event. So would it be sufficient for an application developer if we
>>> drop all statements about "recoverability" from the event description?
>>
>> Here you touch on the core problem of this patch: you are basically saying
>> that userspace has to 1) subscribe to this event, 2) poll for it, 3) if it
>> arrives start a timer, 4) if the timer triggers and no new buffers have been
>> received in the meantime, then 5) restart streaming.
>>
>> So in other words, you are just too lazy to do this in the driver and want
>> to hand it off to userspace.
>>
>> That's not how it works. Usually the driver will know if the error is
>> recoverable or not (i.e. if an HDMI receiver loses signal, that's definitely
>> unrecoverable, and it's something the driver can know and call vb2_queue_error).
>>
>> If it is really unknown, then you indeed need some monitoring thread. And
>> that's fine. Even better if you can make some helper things in the V4L2 core.
>>
>> But you can't just kick that to userspace IMHO. I can guarantee that almost
>> no userspace application will do this and it is really not the job of userspace
>> to deal with such issues.
> 
> From my understanding this means that my previous patch [1] already went in
> the right direction by implementing a monitoring thread in rcar-vin. But on
> the other hand Niklas has pointed out that it's not good to have this in a
> driver [2]. Therefore it sounds like the only acceptable solution would be to
> move this monitoring thread to the V4L2/VB2 core, which would then monitor
> capture drivers for frame timeouts and maybe also notify userspace based
> on this. What do you think? If you already have a solution in mind, I would
> very appreciate if you could give me a few hints for an implementation!
> 
> [1] https://lore.kernel.org/lkml/1652983210-1194-4-git-send-email-mrodin@de.adit-jv.com/
> [2] https://lore.kernel.org/lkml/YqEO3%2FKekkZhVjW+@oden.dyn.berto.se/

Yes, [1] goes in the right direction. The V4L2_EVENT_XFER_ERROR addition can
be dropped, since a call to vb2_queue_error() is sufficient for non-recoverable
transfer errors.

BTW, I think a timer might work better than a workqueue here: no need to cancel
and reschedule the workqueue in interrupt context, instead the isr can just call
mod_timer. Calling vb2_queue_error can be done from interrupt context as well,
so that can safely be called from the timer function.

I would not be opposed to keep this as driver-specific functionality: it's really
not much code. But if you do want to add this to vb2, then that can be done, of
course. I think vb2_queue needs a new field: watchdog_timeout. If 0, there is no
watchdog running, if non-0 vb2 would start a timer after start_streaming (and
stop it in stop_streaming), and a new vb2_watchdog_reset() is added that calls
mod_timer and that the driver has to call from the interrupt.

Finally, the timer function would call vb2_queue_error().

Eventually, a vb2_queue op can be added as well (e.g. watchdog_timeout) to do
driver specific stuff. It doesn't seem to be needed for rcar-vin, though.

Regards,

	Hans

> 
>> Regards,
>>
>> 	Hans
>>
>>>
>>>> Nicolas
>>>>
>>>>>      * - ``V4L2_EVENT_PRIVATE_START``
>>>>>        - 0x08000000
>>>>>        - Base event number for driver-private events.
>>>>> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>>>>> index 9cbb7a0c354a..25bde61a1519 100644
>>>>> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>>>>> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
>>>>> @@ -500,6 +500,7 @@ replace define V4L2_EVENT_CTRL event-type
>>>>>  replace define V4L2_EVENT_FRAME_SYNC event-type
>>>>>  replace define V4L2_EVENT_SOURCE_CHANGE event-type
>>>>>  replace define V4L2_EVENT_MOTION_DET event-type
>>>>> +replace define V4L2_EVENT_XFER_ERROR event-type
>>>>>  replace define V4L2_EVENT_PRIVATE_START event-type
>>>>>  
>>>>>  replace define V4L2_EVENT_CTRL_CH_VALUE ctrl-changes-flags
>>>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>>>> index 5311ac4fde35..44db724d4541 100644
>>>>> --- a/include/uapi/linux/videodev2.h
>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>> @@ -2385,6 +2385,7 @@ struct v4l2_streamparm {
>>>>>  #define V4L2_EVENT_FRAME_SYNC			4
>>>>>  #define V4L2_EVENT_SOURCE_CHANGE		5
>>>>>  #define V4L2_EVENT_MOTION_DET			6
>>>>> +#define V4L2_EVENT_XFER_ERROR			7
>>>>>  #define V4L2_EVENT_PRIVATE_START		0x08000000
>>>>>  
>>>>>  /* Payload for V4L2_EVENT_VSYNC */
>>>>
>>>
>>
> 
