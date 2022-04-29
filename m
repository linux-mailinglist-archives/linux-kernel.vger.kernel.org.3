Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A65143F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355582AbiD2IVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiD2IVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:21:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E736B1015;
        Fri, 29 Apr 2022 01:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BC01B83317;
        Fri, 29 Apr 2022 08:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B344FC385A7;
        Fri, 29 Apr 2022 08:18:24 +0000 (UTC)
Message-ID: <20fd8dc0-bcb4-d18b-a143-5e658391474d@xs4all.nl>
Date:   Fri, 29 Apr 2022 10:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 06/13] media: atmel: atmel-isc-base: use mutex to lock
 awb workqueue from streaming
Content-Language: en-US
To:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
 <20220310095202.2701399-7-eugen.hristev@microchip.com>
 <d3858845-ca27-9207-68a9-6d802a7d59fe@xs4all.nl>
 <2510d479-5eef-6ef6-5d32-41f70217eb52@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <2510d479-5eef-6ef6-5d32-41f70217eb52@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 10:08, Eugen.Hristev@microchip.com wrote:
> On 4/29/22 10:41 AM, Hans Verkuil wrote:
>> Hi Eugen,
>>
>> On 10/03/2022 10:51, Eugen Hristev wrote:
>>> The AWB workqueue runs in a kernel thread and needs to be synchronized
>>> w.r.t. the streaming status.
>>> It is possible that streaming is stopped while the AWB workq is running.
>>> In this case it is likely that the check for vb2_start_streaming_called is done
>>> at one point in time, but the AWB computations are done later, including a call
>>> to isc_update_profile, which requires streaming to be started.
>>> Thus , isc_update_profile will fail if during this operation sequence the
>>> streaming was stopped.
>>> To solve this issue, a mutex is added, that will serialize the awb work and
>>> streaming stopping, with the mention that either streaming is stopped
>>> completely including termination of the last frame is done, and after that
>>> the AWB work can check stream status and stop; either first AWB work is
>>> completed and after that the streaming can stop correctly.
>>> The awb spin lock cannot be used since this spinlock is taken in the same
>>> context and using it in the stop streaming will result in a recursion BUG.
>>
>> Please keep the line length in a commit log to no more than 75.
>>
>>>
>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
>>> ---
>>>   drivers/media/platform/atmel/atmel-isc-base.c | 29 ++++++++++++++++---
>>>   drivers/media/platform/atmel/atmel-isc.h      |  2 ++
>>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
>>
>> <snip>
>>
>>> @@ -1548,6 +1564,7 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
>>>                         */
>>>                        v4l2_ctrl_activate(isc->do_wb_ctrl, false);
>>>                }
>>> +             mutex_unlock(&isc->awb_mutex);
>>
>> Huh? What is this unlock doing here? Am I missing something?
> 
> Hello Hans,
> 
> Sorry. It looks like the corresponding mutex_lock was lost when I 
> rebased the series over the patch to use 'is_streaming' instead of 
> 'stop' variable.
> In version 3, the mutex_lock was there :
> 
> https://www.spinics.net/lists/linux-media/msg204059.html
> 
> Somehow a race problem did not occur in this specific critical area in 
> my tests.
> 
> I will resend this patch as a v10 , or the whole series if you have 
> other comments on the other patches? How would you prefer ?

I have more comments (just finished the full review), so a v10 is definitely
needed.

Regards,

	Hans

> 
> Thanks,
> Eugen
> 
>>
>> Regards,
>>
>>          Hans
>>
>>>
>>>                /* if we have autowhitebalance on, start histogram procedure */
>>>                if (ctrls->awb == ISC_WB_AUTO &&
>>> @@ -1740,6 +1757,7 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
>>>   {
>>>        struct isc_device *isc = container_of(notifier->v4l2_dev,
>>>                                              struct isc_device, v4l2_dev);
>>> +     mutex_destroy(&isc->awb_mutex);
>>>        cancel_work_sync(&isc->awb_work);
>>>        video_unregister_device(&isc->video_dev);
>>>        v4l2_ctrl_handler_free(&isc->ctrls.handler);
>>> @@ -1850,6 +1868,8 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>>>        isc->current_subdev = container_of(notifier,
>>>                                           struct isc_subdev_entity, notifier);
>>>        mutex_init(&isc->lock);
>>> +     mutex_init(&isc->awb_mutex);
>>> +
>>>        init_completion(&isc->comp);
>>>
>>>        /* Initialize videobuf2 queue */
>>> @@ -1930,6 +1950,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>>>        video_unregister_device(vdev);
>>>
>>>   isc_async_complete_err:
>>> +     mutex_destroy(&isc->awb_mutex);
>>>        mutex_destroy(&isc->lock);
>>>        return ret;
>>>   }
>>> diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
>>> index 9cc69c3ae26d..f98f25a55e73 100644
>>> --- a/drivers/media/platform/atmel/atmel-isc.h
>>> +++ b/drivers/media/platform/atmel/atmel-isc.h
>>> @@ -229,6 +229,7 @@ enum isc_scaler_pads {
>>>    *
>>>    * @lock:            lock for serializing userspace file operations
>>>    *                   with ISC operations
>>> + * @awb_mutex:               serialize access to streaming status from awb work queue
>>>    * @awb_lock:                lock for serializing awb work queue operations
>>>    *                   with DMA/buffer operations
>>>    *
>>> @@ -307,6 +308,7 @@ struct isc_device {
>>>        struct work_struct      awb_work;
>>>
>>>        struct mutex            lock;
>>> +     struct mutex            awb_mutex;
>>>        spinlock_t              awb_lock;
>>>
>>>        struct regmap_field     *pipeline[ISC_PIPE_LINE_NODE_NUM];
>>
> 

