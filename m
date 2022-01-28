Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B149F741
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347863AbiA1KXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:23:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41914 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiA1KXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:23:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C7B2B82513;
        Fri, 28 Jan 2022 10:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9541C340E0;
        Fri, 28 Jan 2022 10:23:44 +0000 (UTC)
Message-ID: <c68b0bb1-2d27-cff0-d8fe-efe441adc73e@xs4all.nl>
Date:   Fri, 28 Jan 2022 11:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] media: videobuf2: use dmabuf size for length
Content-Language: en-US
To:     linux-media@vger.kernel.org,
        Helen Fornazier <helen.fornazier@gmail.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        jc@kynesim.co.uk, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.org, tfiga@chromium.org
References: <20210325001712.197837-1-helen.koike@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20210325001712.197837-1-helen.koike@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helen & others,

I'm going through a bunch of (very) old patches in my patchwork TODO list
that for one reason or another I never processed. This patch series is one
of them. Given the discussion that followed the post of this series I've
decided not to merge this. I'll mark the series as 'Changes Requested'.

If someone wants to continue work on this (Helen left Collabora), then
please do so!

Regards,

	Hans


On 25/03/2021 01:17, Helen Koike wrote:
> Always use dmabuf size when considering the length of the buffer.
> Discard userspace provided length.
> Fix length check error in _verify_length(), which was handling single and
> multiplanar diferently, and also not catching the case where userspace
> provides a bigger length and bytesused then the underlying buffer.
> 
> Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
> 
> Hello,
> 
> As discussed on
> https://patchwork.linuxtv.org/project/linux-media/patch/gh5kef5bkeel3o6b2dkgc2dfagu9klj4c0@4ax.com/
> 
> This patch also helps the conversion layer of the Ext API patchset,
> where we are not exposing the length field.
> 
> It was discussed that userspace might use a smaller length field to
> limit the usage of the underlying buffer, but I'm not sure if this is
> really usefull and just complicates things.
> 
> If this is usefull, then we should also expose a length field in the Ext
> API, and document this feature properly.
> 
> What do you think?
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 21 ++++++++++++++++---
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  8 +++----
>  include/uapi/linux/videodev2.h                |  7 +++++--
>  3 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 02281d13505f..2cbde14af051 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -1205,6 +1205,7 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
>  
>  	for (plane = 0; plane < vb->num_planes; ++plane) {
>  		struct dma_buf *dbuf = dma_buf_get(planes[plane].m.fd);
> +		unsigned int bytesused;
>  
>  		if (IS_ERR_OR_NULL(dbuf)) {
>  			dprintk(q, 1, "invalid dmabuf fd for plane %d\n",
> @@ -1213,9 +1214,23 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
>  			goto err;
>  		}
>  
> -		/* use DMABUF size if length is not provided */
> -		if (planes[plane].length == 0)
> -			planes[plane].length = dbuf->size;
> +		planes[plane].length = dbuf->size;
> +		bytesused = planes[plane].bytesused ?
> +			    planes[plane].bytesused : dbuf->size;
> +
> +		if (planes[plane].bytesused > planes[plane].length) {
> +			dprintk(q, 1, "bytesused is bigger then dmabuf length for plane %d\n",
> +				plane);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		if (planes[plane].data_offset >= bytesused) {
> +			dprintk(q, 1, "data_offset >= bytesused for plane %d\n",
> +				plane);
> +			ret = -EINVAL;
> +			goto err;
> +		}
>  
>  		if (planes[plane].length < vb->planes[plane].min_length) {
>  			dprintk(q, 1, "invalid dmabuf length %u for plane %d, minimum length %u\n",
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 7e96f67c60ba..ffc7ed46f74a 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -98,14 +98,14 @@ static int __verify_length(struct vb2_buffer *vb, const struct v4l2_buffer *b)
>  	unsigned int bytesused;
>  	unsigned int plane;
>  
> -	if (V4L2_TYPE_IS_CAPTURE(b->type))
> +	/* length check for dmabuf is performed in _prepare_dmabuf() */
> +	if (V4L2_TYPE_IS_CAPTURE(b->type) || b->memory == VB2_MEMORY_DMABUF)
>  		return 0;
>  
>  	if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
>  		for (plane = 0; plane < vb->num_planes; ++plane) {
> -			length = (b->memory == VB2_MEMORY_USERPTR ||
> -				  b->memory == VB2_MEMORY_DMABUF)
> -			       ? b->m.planes[plane].length
> +			length = b->memory == VB2_MEMORY_USERPTR
> +				? b->m.planes[plane].length
>  				: vb->planes[plane].length;
>  			bytesused = b->m.planes[plane].bytesused
>  				  ? b->m.planes[plane].bytesused : length;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 8d15f6ccc4b4..79b3b2893513 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -968,7 +968,9 @@ struct v4l2_requestbuffers {
>  /**
>   * struct v4l2_plane - plane info for multi-planar buffers
>   * @bytesused:		number of bytes occupied by data in the plane (payload)
> - * @length:		size of this plane (NOT the payload) in bytes
> + * @length:		size of this plane (NOT the payload) in bytes. Filled
> + *			by userspace for USERPTR and by the driver for DMABUF
> + *			and MMAP.
>   * @mem_offset:		when memory in the associated struct v4l2_buffer is
>   *			V4L2_MEMORY_MMAP, equals the offset from the start of
>   *			the device memory for this plane (or is a "cookie" that
> @@ -1025,7 +1027,8 @@ struct v4l2_plane {
>   * @m:		union of @offset, @userptr, @planes and @fd
>   * @length:	size in bytes of the buffer (NOT its payload) for single-plane
>   *		buffers (when type != *_MPLANE); number of elements in the
> - *		planes array for multi-plane buffers
> + *		planes array for multi-plane buffers. Filled by userspace for
> + *		USERPTR and by the driver for DMABUF and MMAP.
>   * @reserved2:	drivers and applications must zero this field
>   * @request_fd: fd of the request that this buffer should use
>   * @reserved:	for backwards compatibility with applications that do not know

