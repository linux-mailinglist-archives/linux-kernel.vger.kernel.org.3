Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4122254C4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbiFOJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347835AbiFOJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:33:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64621902F;
        Wed, 15 Jun 2022 02:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6056FB81D2C;
        Wed, 15 Jun 2022 09:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056B6C34115;
        Wed, 15 Jun 2022 09:33:20 +0000 (UTC)
Message-ID: <63052d74-d3c7-a9cc-cb18-a58f8937ec06@xs4all.nl>
Date:   Wed, 15 Jun 2022 11:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 01/17] videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com>
 <20220614083614.240641-2-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220614083614.240641-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 6/14/22 10:35, Benjamin Gaignard wrote:
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
> Add a new flag that indicates that this control is a dynamically sized
> array. Also document this flag.
> 
> Currently dynamically sized arrays are limited to one dimensional arrays,
> but that might change in the future if there is a need for it.
> 
> The initial use-case of dynamic arrays are stateless codecs. A frame
> can be divided in many slices, so you want to provide an array containing
> slice information for each slice. Typically the number of slices is small,
> but the standard allow for hundreds or thousands of slices. Dynamic arrays
> are a good solution since sizing the array for the worst case would waste
> substantial amounts of memory.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../userspace-api/media/v4l/vidioc-queryctrl.rst          | 8 ++++++++
>  include/uapi/linux/videodev2.h                            | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> index 88f630252d98..a20dfa2a933b 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
> @@ -625,6 +625,14 @@ See also the examples in :ref:`control`.
>  	``V4L2_CTRL_FLAG_GRABBED`` flag when buffers are allocated or
>  	streaming is in progress since most drivers do not support changing
>  	the format in that case.
> +    * - ``V4L2_CTRL_FLAG_DYNAMIC_ARRAY``
> +      - 0x0800
> +      - This control is a dynamically sized 1-dimensional array. It
> +        behaves the same as a regular array, except that the number
> +	of elements as reported by the ``elems`` field is between 1 and
> +	``dims[0]``. So setting the control with a differently sized
> +	array will change the ``elems`` field when the control is
> +	queried afterwards.

I am proposing a change to the dynamic array implementation: initially
dynamic array controls start off as empty arrays (0 elements). This also
allows userspace to set a dynamic array control to an empty array.

It probably would also make sense to add a min_dyn_elems to set the minimum
allowed number of elements for a dynamic array. This would most likely be
either 0 or 1.

In the context of this HEVC series, does it help to allow empty dynamic arrays?

For V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS in particular it looks like
it would make sense since I think (correct me if I am wrong) there can be 0
entry point offsets. So with empty arrays supported would the field
num_entry_point_offsets still be needed?

If you want to test, then let me know and I mail a very simple patch adding
support for empty arrays (not yet min_dyn_elems, though).

Regards,

	Hans

>  
>  Return Value
>  ============
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 5311ac4fde35..9018aa984db3 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -1890,6 +1890,7 @@ struct v4l2_querymenu {
>  #define V4L2_CTRL_FLAG_HAS_PAYLOAD	0x0100
>  #define V4L2_CTRL_FLAG_EXECUTE_ON_WRITE	0x0200
>  #define V4L2_CTRL_FLAG_MODIFY_LAYOUT	0x0400
> +#define V4L2_CTRL_FLAG_DYNAMIC_ARRAY	0x0800
>  
>  /*  Query flags, to be ORed with the control ID */
>  #define V4L2_CTRL_FLAG_NEXT_CTRL	0x80000000
