Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6489E487A14
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbiAGQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:02:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiAGQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:02:45 -0500
Received: from [IPv6:2a01:e0a:120:3210:21c7:4f13:8afa:4f9f] (unknown [IPv6:2a01:e0a:120:3210:21c7:4f13:8afa:4f9f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7F42B1F4654B;
        Fri,  7 Jan 2022 16:02:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641571363;
        bh=82iQizbllLUiJnSZ0KgoTJ5nL7tu9HnbfQNsu6IOb7Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ltlx5Bhib0ENtTQhrAzGB82bBtC4tkIYMRrCj8Vrhow05nZya/dIt4H8Wj9w1Qig1
         9RLIscX2KkZc7nHarBXeZ31CRw1SL3qKTmNEbXkFS5xqC3bxXa8F8RRw3mtbP24WD+
         kMAkITOLamoY6pPUvFfsZM6NRwUDaqZ3lnlV7sE3AXIHAr1yho/VK0ZPRtBzpdmnSa
         LrqmquOpKeH8lPUqbbcGqc0n2bSPvA5WRBPaaZl4Lm6dD7/HttaMXqaovJ9oiCNoXv
         hMkR4sAkuO+YshRUqYg/W62jZOPVXw6Uhe+3frDWWrNT8ZpU4KX7pERFEomX1huChd
         A8WywpNLYTYYg==
Subject: Re: [PATCH v4 1/2] media: hevc: Remove RPS named flags
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     mchehab@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        jernej.skrabec@gmail.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
References: <20220104073842.1791639-1-benjamin.gaignard@collabora.com>
 <20220104073842.1791639-2-benjamin.gaignard@collabora.com>
 <YdWOecbZHO+Skbnn@eze-laptop>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <a8b2640b-35e3-7e4c-c1ac-4d8651470d2b@collabora.com>
Date:   Fri, 7 Jan 2022 17:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YdWOecbZHO+Skbnn@eze-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 05/01/2022 à 13:26, Ezequiel Garcia a écrit :
> Hi Benjamin,
>
> On Tue, Jan 04, 2022 at 08:38:41AM +0100, Benjamin Gaignard wrote:
>> Marking a picture as long-term reference is valid for DPB but not for RPS.
>> Change flag name to match with it description in HEVC spec chapiter
>> "8.3.2 Decoding process for reference picture set".
>> Remove the other unused RPS flags.
>>
> A change like this, which is affecting a kernel interface and has impact
> on userspace and drivers, requires a lot more attention in the commit description.
>
> If I understand correctly, this change is related to how HEVC was first
> introduced and how the DPB was originally represented in V4L2.
>
> Originally, a DPB entry struct v4l2_hevc_dpb_entry had an rps field
> which can be:
>
>    V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_BEFORE
>    V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_AFTER
>    V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR
>
> Perhaps this idea followed libva, where a VAPictureHEVC has flags field
> which can be:
>
>    VA_PICTURE_HEVC_RPS_ST_CURR_BEFORE,
>    VA_PICTURE_HEVC_RPS_ST_CURR_AFTER,
>    VA_PICTURE_HEVC_RPS_LT_CURR,
>    VA_PICTURE_HEVC_LONG_TERM_REFERENCE
>
> In this representation, the sets PocStCurrBefore, PocStCurrAfter,
> PocLtCurr are implicit, and must be built by the kernel from the DPB
> entries struct v4l2_hevc_dpb_entry, using the information in the rps field.
>
> Last year, we changed this with your commit:
>
> commit d395a78db9eabd12633b39e05c80e803543b6590
> Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Date:   Thu Jun 3 13:49:57 2021 +0200
>
>      media: hevc: Add decode params control
>
> Which added the control v4l2_ctrl_hevc_decode_params, which includes
> the sets PocStCurrBefore, PocStCurrAfter, PocLtCurr explicitly and therefore
> moved the responsability of creating and maintaining the sets to userspace.
>
> This effectively made the rps field in the struct v4l2_hevc_dpb_entry
> useless. The longterm flag is still needed though for a DPB entry.
>
> With this in mind, you could even say this commit is doing actually two
> things:
>
> 1. Removes the unused rps field.
> 2. Adds a flag field, for the longterm DPB entry boolean.
>
> Do you think a single byte of flags will be OK for a DPB entry?
> I think so, but I'd love yours/others input here.

In ITU HEVC spec it is said that:
"When a picture is referred to as being marked as "used for reference",
this collectively refers to the picture being marked as "used
  for
short-term reference" or "used for long-term reference" (but not both)."

So I believe that a single if enough for DPB entry.

>
> If the above is more or less accurate then, and provided you
> submit a new version with a more detailed commit description:

I will follow your suggestions and improve it in v5

>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> Also, a small question:
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> version 4:
>> - check flags with & and not ==
>>
>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 8 +++-----
>>   drivers/staging/media/hantro/hantro_g2_hevc_dec.c         | 2 +-
>>   drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
>>   include/media/hevc-ctrls.h                                | 6 ++----
>>   4 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index e141f0e4eec9..38da33e61c3d 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -3166,11 +3166,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>   	:c:func:`v4l2_timeval_to_ns()` function to convert the struct
>>   	:c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
>>       * - __u8
>> -      - ``rps``
>> -      - The reference set for the reference frame
>> -        (V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_BEFORE,
>> -        V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_AFTER or
>> -        V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR)
>> +      - ``flags``
>> +      - Long term flag for the reference frame
>> +        (V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE)
> Is this longterm flag associated in any way to a syntax element
> or an HEVC process? If so, please document that.

done in v5.

Thanks for your review.

Benjamin

>
> Thanks,
> Ezequiel
