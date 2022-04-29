Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E12514665
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357266AbiD2KRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiD2KRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14718E3B;
        Fri, 29 Apr 2022 03:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D7262310;
        Fri, 29 Apr 2022 10:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B50C385A4;
        Fri, 29 Apr 2022 10:13:47 +0000 (UTC)
Message-ID: <a10a255c-e3b7-4c5f-2a7e-9474e0526a61@xs4all.nl>
Date:   Fri, 29 Apr 2022 12:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 08/13] media: atmel: atmel-isc: change format
 propagation to subdev into only verification
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
 <20220310095202.2701399-9-eugen.hristev@microchip.com>
 <39f541ec-313f-fe15-b93f-dd78469b2366@xs4all.nl>
 <b6630c65-0720-3633-d5ed-aadf4716f206@microchip.com>
 <dabbff36-a10c-0a8a-94e8-ce7c2d896403@xs4all.nl>
 <20220429095848.ec4xnul6tin6n7sf@uno.localdomain>
 <Ymu4ywjEvX5HbE/W@pendragon.ideasonboard.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <Ymu4ywjEvX5HbE/W@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 12:07, Laurent Pinchart wrote:
> On Fri, Apr 29, 2022 at 11:58:48AM +0200, Jacopo Mondi wrote:
>> On Fri, Apr 29, 2022 at 10:43:09AM +0200, Hans Verkuil wrote:
>>> On 29/04/2022 10:28, Eugen.Hristev@microchip.com wrote:
>>>> On 4/29/22 11:17 AM, Hans Verkuil wrote:
>>>>> On 10/03/2022 10:51, Eugen Hristev wrote:
>>>>>> As a top MC video driver, the atmel-isc should not propagate the format to the
>>>>>> subdevice, it should rather check at start_streaming() time if the subdev is properly
>>>>>> configured with a compatible format.
>>>>>> Removed the whole format finding logic, and reworked the format verification
>>>>>> at start_streaming time, such that the ISC will return an error if the subdevice
>>>>>> is not properly configured. To achieve this, media_pipeline_start
>>>>>> is called and a link_validate callback is created to check the formats.
>>>>>> With this being done, the module parameter 'sensor_preferred' makes no sense
>>>>>> anymore. The ISC should not decide which format the sensor is using. The
>>>>>> ISC should only cope with the situation and inform userspace if the streaming
>>>>>> is possible in the current configuration.
>>>>>> The redesign of the format propagation has also risen the question of the
>>>>>> enumfmt callback. If enumfmt is called with an mbus_code, the enumfmt handler
>>>>>> should only return the formats that are supported for this mbus_code.
>>>>>> Otherwise, the enumfmt will report all the formats that the ISC could output.
>>>>>> With this rework, the dynamic list of user formats is removed. It makes no
>>>>>> more sense to identify at complete time which formats the sensor could emit,
>>>>>> and add those into a separate dynamic list.
>>>>>> The ISC will start with a simple preconfigured default format, and at
>>>>>> link validate time, decide whether it can use the format that is configured
>>>>>> on the sink or not.
>>>>>>
>>>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>>>>> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
>>>>>> ---
>>>>>> Changes in v9:
>>>>>> - isc_link_validate now static
>>>>>>
>>>>>> Changes in v7:
>>>>>> - minor typos as suggested by Jacopo
>>>>>> - small changes, reduce some indentation, modified an index, as suggested by
>>>>>> Jacopo
>>>>>>
>>>>>> Changes in v6:
>>>>>> - reworked a bit enum_fmt as suggested by Jacopo
>>>>>>
>>>>>> Changes in v5:
>>>>>> - removed user_formats dynamic list as it is now pointless
>>>>>> - greatly simplified the enum_fmt function
>>>>>> - removed some init code that was useless now
>>>>>>
>>>>>> Changes in v4:
>>>>>> - moved validation code into link_validate and used media_pipeline_start
>>>>>> - merged this patch with the enum_fmt patch which was previously in v3 of
>>>>>> the series
>>>>>>
>>>>>> Changes in v3:
>>>>>> - clamp to maximum resolution once the frame size from the subdev is found
>>>>>>   drivers/media/platform/atmel/atmel-isc-base.c | 412 ++++++++----------
>>>>>>   .../media/platform/atmel/atmel-isc-scaler.c   |   5 +
>>>>>>   drivers/media/platform/atmel/atmel-isc.h      |  13 +-
>>>>>>   .../media/platform/atmel/atmel-sama5d2-isc.c  |  20 +
>>>>>>   .../media/platform/atmel/atmel-sama7g5-isc.c  |  20 +
>>>>>>   5 files changed, 236 insertions(+), 234 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
>>>>>> index ee1dda6707a0..fe2c0af58060 100644
>>>>>> --- a/drivers/media/platform/atmel/atmel-isc-base.c
>>>>>> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
>>>>>> @@ -36,11 +36,6 @@ static unsigned int debug;
>>>>>>   module_param(debug, int, 0644);
>>>>>>   MODULE_PARM_DESC(debug, "debug level (0-2)");
>>>>>>
>>>>>> -static unsigned int sensor_preferred = 1;
>>>>>> -module_param(sensor_preferred, uint, 0644);
>>>>>> -MODULE_PARM_DESC(sensor_preferred,
>>>>>> -              "Sensor is preferred to output the specified format (1-on 0-off), default 1");
>>>>>> -
>>>>>>   #define ISC_IS_FORMAT_RAW(mbus_code) \
>>>>>>        (((mbus_code) & 0xf000) == 0x3000)
>>>>>>
>>>>>> @@ -337,6 +332,10 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>>>>>>        unsigned long flags;
>>>>>>        int ret;
>>>>>>
>>>>>> +     ret = media_pipeline_start(&isc->video_dev.entity, &isc->mpipe);
>>>>>
>>>>> The pipeline validation is done in start_streaming, but I don't think that
>>>>> is the best place: if STREAMON is called before buffers are queued, then
>>>>> an invalid pipeline isn't discovered until enough buffers are queued to
>>>>> kick off start_streaming.
>>>>>
>>>>> Drivers like vsp1, omap3isp and the samsung drivers all do this in streamon().
>>>>>
>>>>> I think that is the correct time to do this.
>>>>
>>>> Hello Hans,
>>>>
>>>> Initially (v2, v3) I had this in streamon(). The problem that I faced at
>>>> that time was that streamoff was never called, so I could not call
>>>> media_pipeline_stop(). Then Jacopo told me to move it to start_streaming
>>>> (see change log for v4) , and I did not face any more problems.
>>
>> Yes indeed, seems I suggested to use media_pipeline_handler in a
>> comment on your v3
>>
>> "at s_stream time your top driver calls media_pipeline_start()"
>>
>> sorry about that, I should have looked around a bit more carefully and
>> notice most drivers do so at vb2 streamon
>>
>> However I don't see media_pipeline_start being called at all in v3 of
>> the patch
>>
>>> It's a mess. Looking at some drivers I see that omap3isp calls media_pipeline_stop
>>> in streamoff (so will have the same problem as you described if VIDIOC_STREAMOFF
>>> isn't called), exynos4-is does the same, but it also checks the streaming state in
>>> the release() fop callback, so that would fix this problem. And vimc does this
>>> in stop_streaming.
>>>
>>> I'm in favor of fixing this in vb2, that framework knows exactly when this needs
>>> to be called.
>>
>> Are you suggesting to have vb2 to call media_pipeline_start() or is it
>> more complex than this ?
> 
> I think Hans meant adding a .validate() operation to vb2.
> 
> vb2 is already quite complex, I don't think adding more features is a
> good idea. I'd rather have vb2 focus on buffer management only
> (.start_streaming() and .stop_streaming() shouldn't have been in there
> in my opinion), and handle validation in the .streamon() handler. I'd
> expect most drivers that deal with media pipelines to do more work in
> .streamon() anyway.

I disagree with that :-)

It's vb2 that keeps track of the streaming state and when what actions
need to be taken. Drivers really shouldn't need to care about the ioctls
themselves, and just implement the relevant vb2 callbacks. Relying on
drivers to handle any of the streaming ioctls is asking for problems,
as this shows: most drivers implement this wrong today.

The vb2 framework knows when e.g. the pipeline needs to be started or
stopped, and can do this at the best time, without drivers needing to
keep track of when streamon/off/release is called. Keep that logic in
vb2.

Regards,

	Hans
