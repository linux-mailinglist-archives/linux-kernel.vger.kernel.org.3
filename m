Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B261746E807
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhLIMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:09:41 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.168]:17803 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhLIMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:09:40 -0500
X-KPN-MessageId: 52f93686-58e8-11ec-8862-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 52f93686-58e8-11ec-8862-005056aba152;
        Thu, 09 Dec 2021 13:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=Ogf4qPFDpILI8srWVyRxWxfGiXgWfw2eLqbmuPPtebs=;
        b=i4u2r+wYSfRWubJofx8JVWzA/cIncDuA3LEbXwbo/tC/ReD6/wWiZXBWmaBIcpCTGBLHEW/D+i6ET
         Qc2/vOqtnELfdCBh5dtcKlPcHw9+BW1qfmidQ8qExG6z5hl1T8STEm3o4eC3TaveRgUo7iU51TD5D4
         TUnddgrkQ/mJ91zMLv8yr8QPdwRlaUXOCkwOvZhaLTKwT/PYnsGoriQHMwzsRk2skQo7aO1tTFjDOa
         isFZbXvy+sBCqWC119W+jZalnSRkTiMHVHWeev5Gn5T3wEDiQFrNET9Hfu7cV1HEkJs3VOsqOm8cPc
         1llnDRZ5i6++jDe5XKD87BEE6oefqZw==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|yjxbYxNyYZHtPZkMlzosYrLcAeUa9rqBtDr1SKN6PKtP3fQXLILk8DzHsfJ24Ax
 vdve64I6zbiv3k0ejnIA3cw==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 62d29ed9-58e8-11ec-b76f-005056ab7584;
        Thu, 09 Dec 2021 13:06:06 +0100 (CET)
Message-ID: <899b2f8c-14de-ae68-2b16-cb9a16c310ca@xs4all.nl>
Date:   Thu, 9 Dec 2021 13:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH] media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP
 buffers across ioctls
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209062926.991516-2-wenst@chromium.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20211209062926.991516-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 07:29, Chen-Yu Tsai wrote:
> DST_QUEUE_OFF_BASE is applied to offset/mem_offset on MMAP capture buffers
> only for the VIDIOC_QUERYBUF ioctl, while the userspace fields (including
> offset/mem_offset) are filled in for VIDIOC_{QUERY,PREPARE,Q,DQ}BUF
> ioctls. This leads to differences in the values presented to userspace.
> If userspace attempts to mmap the capture buffer directly using values
> from DQBUF, it will fail.
> 
> Move the code that applies the magic offset into a helper, and call
> that helper from all four ioctl entry points.
> 
> Fixes: 7f98639def42 ("V4L/DVB: add memory-to-memory device helper framework for videobuf")
> Fixes: 908a0d7c588e ("[media] v4l: mem2mem: port to videobuf2")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This was tested on RK3399 with
> 
>     gst-launch-1.0 videotestsrc num-buffers=2 ! v4l2jpegenc ! fakesink
> 
> and verifying the values using the V4L2 debug messages:
> 
>     video2: VIDIOC_QUERYBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004000, field=any, sequence=0, memory=mmap
>     plane 0: bytesused=0, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
>     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
>     video2: VIDIOC_QUERYBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004000, field=any, sequence=0, memory=mmap
>     plane 0: bytesused=0, data_offset=0x00000000, offset/userptr=0x0, length=153600
>     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> 
>     video2: VIDIOC_QBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004003, field=any, sequence=0, memory=mmap
>     plane 0: bytesused=2097152, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
>     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
>     video2: VIDIOC_QBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004003, field=none, sequence=0, memory=mmap
>     plane 0: bytesused=153600, data_offset=0x00000000, offset/userptr=0x0, length=153600
>     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> 
>     video2: VIDIOC_DQBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004001, field=none, sequence=0, memory=mmap
>     plane 0: bytesused=6324, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
>     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
>     video2: VIDIOC_DQBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004001, field=none, sequence=0, memory=mmap
>     plane 0: bytesused=153600, data_offset=0x00000000, offset/userptr=0x0, length=153600
>     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> 
> Gstreamer doesn't do PREPAREBUF calls, so that path was not verified.
> However the code changes are exactly the same, so I'm quite confident
> about them.
> 
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 46 ++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index e2654b422334..b47f25297c43 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -585,19 +585,14 @@ int v4l2_m2m_reqbufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_reqbufs);
>  
> -int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> -		      struct v4l2_buffer *buf)
> +static void v4l2_m2m_adjust_mem_offset(struct vb2_queue *vq,
> +				       struct v4l2_buffer *buf)
>  {
> -	struct vb2_queue *vq;
> -	int ret = 0;
> -	unsigned int i;
> -
> -	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> -	ret = vb2_querybuf(vq, buf);
> -
>  	/* Adjust MMAP memory offsets for the CAPTURE queue */
>  	if (buf->memory == V4L2_MEMORY_MMAP && V4L2_TYPE_IS_CAPTURE(vq->type)) {
>  		if (V4L2_TYPE_IS_MULTIPLANAR(vq->type)) {
> +			unsigned int i;
> +
>  			for (i = 0; i < buf->length; ++i)
>  				buf->m.planes[i].m.mem_offset
>  					+= DST_QUEUE_OFF_BASE;
> @@ -605,6 +600,19 @@ int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  			buf->m.offset += DST_QUEUE_OFF_BASE;
>  		}
>  	}
> +}
> +
> +int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> +		      struct v4l2_buffer *buf)
> +{
> +	struct vb2_queue *vq;
> +	int ret = 0;
> +
> +	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> +	ret = vb2_querybuf(vq, buf);
> +
> +	/* Adjust MMAP memory offsets for the CAPTURE queue */
> +	v4l2_m2m_adjust_mem_offset(vq, buf);
>  
>  	return ret;
>  }
> @@ -760,6 +768,10 @@ int v4l2_m2m_qbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  	}
>  
>  	ret = vb2_qbuf(vq, vdev->v4l2_dev->mdev, buf);
> +
> +	/* Adjust MMAP memory offsets for the CAPTURE queue */
> +	v4l2_m2m_adjust_mem_offset(vq, buf);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -784,9 +796,15 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  		   struct v4l2_buffer *buf)
>  {
>  	struct vb2_queue *vq;
> +	int ret;
>  
>  	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> -	return vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
> +	ret = vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
> +
> +	/* Adjust MMAP memory offsets for the CAPTURE queue */
> +	v4l2_m2m_adjust_mem_offset(vq, buf);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_dqbuf);
>  
> @@ -795,9 +813,15 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  {
>  	struct video_device *vdev = video_devdata(file);
>  	struct vb2_queue *vq;
> +	int ret;
>  
>  	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> -	return vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
> +	ret = vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
> +
> +	/* Adjust MMAP memory offsets for the CAPTURE queue */
> +	v4l2_m2m_adjust_mem_offset(vq, buf);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
>  
> 

For all these functions you should only call v4l2_m2m_adjust_mem_offset() if !ret.
If the vb2_* function returned an error, then the offset fields aren't filled in,
so it makes no sense to update them. And besides, the struct isn't copied back to
userspace anyway on error.

Regards,

	Hans

