Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CB512C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbiD1HH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243043AbiD1HH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:07:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1743A98F50;
        Thu, 28 Apr 2022 00:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 535C0B82BC4;
        Thu, 28 Apr 2022 07:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B788C385A0;
        Thu, 28 Apr 2022 07:04:07 +0000 (UTC)
Message-ID: <fd81ba16-9772-3f45-dca6-50a0284abd86@xs4all.nl>
Date:   Thu, 28 Apr 2022 09:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation/media: Try to make enum usage clearer
Content-Language: en-US
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
References: <20220422092542.1333177-1-dorota.czaplejewicz@puri.sm>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220422092542.1333177-1-dorota.czaplejewicz@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

On 22/04/2022 11:30, Dorota Czaplejewicz wrote:
> Fixed: typo "format" -> "frame size" in enum-frame-size
> Added: mbus codes must not repeat
> Added: no holes in the array
> Added: arrays per what?
> Added: who fills in what (questionable naming: caller/driver. caller/callee could be confusing for beginners, they look similar)
> Changed: "zero" -> "0"
> Changed: "given" -> "selected". "given to me by the driver?" dunno feels like "selected" or "chosen" are the words to indicate agency to the consumer

I'm missing a 'Signed-off-by' here, please add this in a v2.

> 
> ---
> Hello,
> 
> I encountered some difficulties trying to implement a media-api driver, and I traced the problems to not understanding the documentation. Here I try to make the API usage clearer, after consulting with libcamera authors.
> 
> Still unclear how it works so I didn't touch it: "which". What is a "try format" vs "active format"?
> 
> Cheers,
> Dorota Czaplejewicz
> 
> 
>  .../v4l/vidioc-subdev-enum-frame-size.rst     | 44 ++++++++++++-------
>  .../v4l/vidioc-subdev-enum-mbus-code.rst      | 39 +++++++++++-----
>  2 files changed, 55 insertions(+), 28 deletions(-)

Split this patch up into two separate patches, one for each .rst file.

> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
> index c25a9896df0e..c7afeffb6269 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
> @@ -31,18 +31,29 @@ Arguments
>  Description
>  ===========
>  
> -This ioctl allows applications to enumerate all frame sizes supported by
> -a sub-device on the given pad for the given media bus format. Supported
> -formats can be retrieved with the
> +This ioctl allows applications to access the array of frame sizes supported by

As I mentioned on, I think, irc, I disagree with calling this an array.
I prefer the original phrase 'enumerate all frame sizes'. This is consistent
as well with other ENUM ioctls. This applies to the other 'array' references
below as well. Just keep the original text.

> +a sub-device on the selected pad for the selected media bus format.

I'd use 'specified' instead of 'selected' or 'given' since the application
specifies this information.

> +Supported formats can be retrieved with the
>  :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE`
>  ioctl.
>  
> -To enumerate frame sizes applications initialize the ``pad``, ``which``
> -, ``code`` and ``index`` fields of the struct
> -:c:type:`v4l2_subdev_mbus_code_enum` and
> -call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to the
> -structure. Drivers fill the minimum and maximum frame sizes or return an
> -EINVAL error code if one of the input parameters is invalid.
> +The arrays are defined by the driver, and indexed using the ``index`` field
> +of the struct :c:type:`v4l2_subdev_mbus_code_enum`.
> +Each pair of ``pad`` and ``code`` correspond to a separate array.
> +Each array starts with the ``index`` of 0, and
> +the first invalid index marks the end of array.
> +
> +Therefore, to enumerate frame sizes allowed on the selected pad
> +and using the selected mbus format, initialize the
> +``pad``, ``which``, and ``code`` fields to desired values,
> +and set ``index`` to 0.
> +Then call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to the
> +structure.
> +
> +A successful call will return with minimum and maximum frame sizes filled in.
> +Repeat with increasing ``index`` until ``EINVAL`` is received.
> +``EINVAL`` means that either no more entries are available in the array,
> +or that an input parameter was invalid.
>  
>  Sub-devices that only support discrete frame sizes (such as most
>  sensors) will return one or more frame sizes with identical minimum and
> @@ -72,26 +83,27 @@ information about try formats.
>  
>      * - __u32
>        - ``index``
> -      - Number of the format in the enumeration, set by the application.
> +      - Index of the frame size in the enumeration
> +    belonging to the given pad and format. Filled in by the caller.

Stick to 'application' instead of 'caller'. That's the terminology used elsewhere
in the documentation as well, changing what it is called is just more confusing.

>      * - __u32
>        - ``pad``
> -      - Pad number as reported by the media controller API.
> +      - Pad number as reported by the media controller API. Filled in by the caller.
>      * - __u32
>        - ``code``
>        - The media bus format code, as defined in
> -	:ref:`v4l2-mbus-format`.
> +	:ref:`v4l2-mbus-format`. Filled in by the caller.
>      * - __u32
>        - ``min_width``
> -      - Minimum frame width, in pixels.
> +      - Minimum frame width, in pixels. Filled in by the driver.
>      * - __u32
>        - ``max_width``
> -      - Maximum frame width, in pixels.
> +      - Maximum frame width, in pixels. Filled in by the driver.
>      * - __u32
>        - ``min_height``
> -      - Minimum frame height, in pixels.
> +      - Minimum frame height, in pixels. Filled in by the driver.
>      * - __u32
>        - ``max_height``
> -      - Maximum frame height, in pixels.
> +      - Maximum frame height, in pixels. Filled in by the driver.
>      * - __u32
>        - ``which``
>        - Frame sizes to be enumerated, from enum
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> index 417f1a19bcc4..22d046dd09c2 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> @@ -31,15 +31,29 @@ Arguments
>  Description
>  ===========
>  
> -To enumerate media bus formats available at a given sub-device pad
> -applications initialize the ``pad``, ``which`` and ``index`` fields of
> -struct
> -:c:type:`v4l2_subdev_mbus_code_enum` and
> -call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this
> -structure. Drivers fill the rest of the structure or return an ``EINVAL``
> -error code if either the ``pad`` or ``index`` are invalid. All media bus
> -formats are enumerable by beginning at index zero and incrementing by
> -one until ``EINVAL`` is returned.
> +This call is used by the application to access the array of bus formats
> +for the selected pad.
> +
> +The arrays are defined by the driver, and indexed using the ``index`` field
> +of struct :c:type:`v4l2_subdev_mbus_code_enum`.
> +Each value of ``pad`` corresponds to a separate array.
> +Each array starts with the ``index`` of 0, and
> +the first invalid index marks the end of array.
> +
> +Therefore, to enumerate media bus formats available at a given sub-device pad,
> +initialize the ``pad``, and ``which`` fields to desired values,
> +and set ``index`` to 0.
> +Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
> +with a pointer to this structure.
> +
> +A successful call will return with the ``code`` field filled in
> +with a mbus format value.
> +Repeat with increasing ``index`` until ``EINVAL`` is received.
> +``EINVAL`` means that either ``pad`` is invalid,
> +or that there are no more codes available at this pad.
> +
> +The driver must not return the same value of ``code`` for different indices
> +at the same pad.
>  
>  Available media bus formats may depend on the current 'try' formats at
>  other pads of the sub-device, as well as on the current active links.
> @@ -57,14 +71,15 @@ information about the try formats.
>  
>      * - __u32
>        - ``pad``
> -      - Pad number as reported by the media controller API.
> +      - Pad number as reported by the media controller API. Filled in by the caller.
>      * - __u32
>        - ``index``
> -      - Number of the format in the enumeration, set by the application.
> +      - Index of the mbus code in the enumeration belonging to the given pad.
> +    Filled in by the caller.
>      * - __u32
>        - ``code``
>        - The media bus format code, as defined in
> -	:ref:`v4l2-mbus-format`.
> +	:ref:`v4l2-mbus-format`. Filled in by the driver.
>      * - __u32
>        - ``which``
>        - Media bus format codes to be enumerated, from enum

I'll take another, closer look at this once v2 is posted. The documentation certainly
can be better, but changing terminology inconsistent with what is used elsewhere in
the media documentation is not helping.

You should also consider changing vidioc-subdev-enum-frame-interval.rst which is
closely related to these two documentation files. If changes are made, then it
should probably be done to all three.

Regards,

	Hans
