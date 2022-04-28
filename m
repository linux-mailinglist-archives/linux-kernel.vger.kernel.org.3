Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8E512B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbiD1GP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiD1GP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:15:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506FD20F7F;
        Wed, 27 Apr 2022 23:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04ABFB82B2B;
        Thu, 28 Apr 2022 06:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A50BC385A9;
        Thu, 28 Apr 2022 06:12:39 +0000 (UTC)
Message-ID: <4b7a3d71-629b-56d6-fdc7-d07682390fd2@xs4all.nl>
Date:   Thu, 28 Apr 2022 08:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 03/24] media: videobuf2-v4l2: Warn on holding buffers
 without support
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
 <20220426125751.108293-4-nicolas.dufresne@collabora.com>
 <CAAFQd5C6qmxmn4y=cx5Mtb3p8vcTAFm6Jfc1vMAE8+x9iwhDZg@mail.gmail.com>
 <a78920881b2ffaf1fba04bc9ebeda591ec0dfd87.camel@ndufresne.ca>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <a78920881b2ffaf1fba04bc9ebeda591ec0dfd87.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 17:08, Nicolas Dufresne wrote:
> Le mercredi 27 avril 2022 à 13:31 +0900, Tomasz Figa a écrit :
>> Hi Nicolas, Sebastian,
>>
>> On Tue, Apr 26, 2022 at 9:58 PM Nicolas Dufresne
>> <nicolas.dufresne@collabora.com> wrote:
>>>
>>> From: Sebastian Fricke <sebastian.fricke@collabora.com>
>>>
>>> Using V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF flag without specifying the
>>> subsystem flag VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF, results in
>>> silently ignoring it.
>>> Warn the user via a debug print when the flag is requested but ignored
>>> by the videobuf2 framework.
>>>
>>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>>> ---
>>>  drivers/media/common/videobuf2/videobuf2-v4l2.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>
>> Thanks for the patch. Please see my comments inline.
>>
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> index 6edf4508c636..812c8d1962e0 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>> @@ -329,8 +329,13 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
>>>                  */
>>>                 vbuf->flags &= ~V4L2_BUF_FLAG_TIMECODE;
>>>                 vbuf->field = b->field;
>>> -               if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF))
>>> +               if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF)) {
>>> +                       if (vbuf->flags & V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF)
>>> +                               dprintk(q, 1,
>>> +                                       "Request holding buffer (%d), unsupported on output queue\n",
>>> +                                       b->index);
>>
>> I wonder if we shouldn't just fail such a QBUF operation. Otherwise
>> the application would get unexpected behavior from the kernel.
>> Although it might be too late to do it now if there are applications
>> that rely on this implicit ignore...
> 
> In the context of this patchset, the statu quo seems to be the logical thing to
> do. We can raise this up in a separate thread. The side effect is of course
> confusing for developers, but it is hard for me to tell if a hard failure may
> break an existing software.

I am leaning towards returning an error as well. It makes no sense to try
to hold on to a buffer when this is not supported.

I also thought that it should be enough to rely on the core to clear the
flag upon return if it isn't supported, but looking through the vb2 core code
it looks like we're not clearing unknown flags at all, so running this for
older kernels that do not support holding at all will not clear the flag
either.

The handling for flags in vb2 can be improved, I think I'll take a look at
that myself.

I plan to merge this series soon, but will skip this patch for now.

Regards,

	Hans

> 
> regards,
> Nicolas
> 
>>
>> Best regards,
>> Tomasz
> 

