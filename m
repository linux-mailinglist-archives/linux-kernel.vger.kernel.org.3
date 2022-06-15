Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32E654C5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbiFOKS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFOKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:18:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3193DDCF;
        Wed, 15 Jun 2022 03:18:24 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:7d5:f5ba:f463:c8a9] (unknown [IPv6:2a01:e0a:120:3210:7d5:f5ba:f463:c8a9])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E9F066016CE;
        Wed, 15 Jun 2022 11:18:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655288303;
        bh=V7WoLBoKSld8AcdjidjXLlEz+rIIWI1rpx4mYKHlf0g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ReXebInobCF2yiDjK2XUuvUxqMFi01BFGPAMRXga+6F4dbs8pKr5KXz9HRgMFlvZs
         KKEBFogBRSo26pAUM5uPDye7G6ZZETtdx+Y5Vt4myNkWt/FaHCBNbjvNk1dqNFHBHI
         mixs+XsKD6hGCPYITzZlHhpPTXxtHQD40fz7KPae+UUTwUy7TFMOaFLZXAfKkqUg15
         cQg+2/qDifBjQfH+F1VTh4XB8tWlZxl5SVYtzeGmXOqC30GIHzqUksRn1LUR5gdQXs
         r0yXGhvjcgNNnu24HvFsUy5pvlead/dHqNXnwJfW4qgDoIin4Y3D7rTIgAl7TRt1k4
         LpcPKqQ+D2MOw==
Message-ID: <6cb4ab4f-1132-f386-6dd0-bf4eeab4433c@collabora.com>
Date:   Wed, 15 Jun 2022 12:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 01/17] videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com>
 <20220614083614.240641-2-benjamin.gaignard@collabora.com>
 <63052d74-d3c7-a9cc-cb18-a58f8937ec06@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <63052d74-d3c7-a9cc-cb18-a58f8937ec06@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 15/06/2022 à 11:33, Hans Verkuil a écrit :
> Hi Benjamin,
>
> On 6/14/22 10:35, Benjamin Gaignard wrote:
>> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>>
>> Add a new flag that indicates that this control is a dynamically sized
>> array. Also document this flag.
>>
>> Currently dynamically sized arrays are limited to one dimensional arrays,
>> but that might change in the future if there is a need for it.
>>
>> The initial use-case of dynamic arrays are stateless codecs. A frame
>> can be divided in many slices, so you want to provide an array containing
>> slice information for each slice. Typically the number of slices is small,
>> but the standard allow for hundreds or thousands of slices. Dynamic arrays
>> are a good solution since sizing the array for the worst case would waste
>> substantial amounts of memory.
>>
>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> ---
>>   .../userspace-api/media/v4l/vidioc-queryctrl.rst          | 8 ++++++++
>>   include/uapi/linux/videodev2.h                            | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
>> index 88f630252d98..a20dfa2a933b 100644
>> --- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
>> +++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
>> @@ -625,6 +625,14 @@ See also the examples in :ref:`control`.
>>   	``V4L2_CTRL_FLAG_GRABBED`` flag when buffers are allocated or
>>   	streaming is in progress since most drivers do not support changing
>>   	the format in that case.
>> +    * - ``V4L2_CTRL_FLAG_DYNAMIC_ARRAY``
>> +      - 0x0800
>> +      - This control is a dynamically sized 1-dimensional array. It
>> +        behaves the same as a regular array, except that the number
>> +	of elements as reported by the ``elems`` field is between 1 and
>> +	``dims[0]``. So setting the control with a differently sized
>> +	array will change the ``elems`` field when the control is
>> +	queried afterwards.
> I am proposing a change to the dynamic array implementation: initially
> dynamic array controls start off as empty arrays (0 elements). This also
> allows userspace to set a dynamic array control to an empty array.
>
> It probably would also make sense to add a min_dyn_elems to set the minimum
> allowed number of elements for a dynamic array. This would most likely be
> either 0 or 1.
>
> In the context of this HEVC series, does it help to allow empty dynamic arrays?
>
> For V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS in particular it looks like
> it would make sense since I think (correct me if I am wrong) there can be 0
> entry point offsets. So with empty arrays supported would the field
> num_entry_point_offsets still be needed?

yes it possible to have 0 entry point offsets in bitstream but in this case
I think the stack won't use V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS because
it have not data to send.
I have introduce num_entry_point_offsets field because most of the drivers
only need this information and not the full offsets array so I think it is needed.
For now none of the drivers use V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
control, it is here to be future proof.

Regards,
Benjamin

>
> If you want to test, then let me know and I mail a very simple patch adding
> support for empty arrays (not yet min_dyn_elems, though).
>
> Regards,
>
> 	Hans
>
>>   
>>   Return Value
>>   ============
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 5311ac4fde35..9018aa984db3 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -1890,6 +1890,7 @@ struct v4l2_querymenu {
>>   #define V4L2_CTRL_FLAG_HAS_PAYLOAD	0x0100
>>   #define V4L2_CTRL_FLAG_EXECUTE_ON_WRITE	0x0200
>>   #define V4L2_CTRL_FLAG_MODIFY_LAYOUT	0x0400
>> +#define V4L2_CTRL_FLAG_DYNAMIC_ARRAY	0x0800
>>   
>>   /*  Query flags, to be ORed with the control ID */
>>   #define V4L2_CTRL_FLAG_NEXT_CTRL	0x80000000
