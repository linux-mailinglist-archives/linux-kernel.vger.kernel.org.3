Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5A46ECE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhLIQTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhLIQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:19:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FDC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 08:15:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id k37so13013878lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKWctY/ImQJ/Co2fu0orle+OQPiAfbqvz5osA8Vcy5c=;
        b=fAhjeVyj7+JfQv4aPjWjHEYPdV5HBad8b2v+iIv1+4t0gLkf7kylGWdtZ5bcfoc4dJ
         7QARGisrf3IEU2J/pFNTN9cdbqFV4DwaofnJFae78sxReV9LahlY7L3+VRA1yctBFrl9
         JALU8ZRWpaLC9ybAOFMUITqOcCo+n3Q/duQ8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKWctY/ImQJ/Co2fu0orle+OQPiAfbqvz5osA8Vcy5c=;
        b=huINEp55zL/tyY02vrbWJnr9T5B8vaOlgQ/qg1XS8AAjwduHfduER0flltTO1BYfzT
         CivRqtQx5HQQmNoim3zsaPUE/YimsM0B0aZb93aTSNYZwocdxretLX7LYzHzsMo8ANWD
         HvFNyQQGuYj7NwFQbK/elO/Vora5PXxiYNxc2LZ0E0j3uxaWk7iBzNGNTc00Y9PQI5dZ
         Nkmc8a+NNOSHE/Gic98Wr1Y7S1/fyGRf1kaEvL/OieiZvRTW13fgq0ECFFyY6AFbNWkc
         T1PmNxSN3mEqhlaGItVmI5bWXJU/09TVHNyC7lZxkQg427snYnszLigyZg+oEhZvQZR9
         61bA==
X-Gm-Message-State: AOAM533SdOemEgh0jf1wSEiSefR7PtGYph4EDcwzoFayZwSw/DPOJ7V3
        AWFqQ+Q2QQHZ15KBgm5ockZNKljrvoRLkEwDxyJ8Uw==
X-Google-Smtp-Source: ABdhPJzBTEvcDTWHve6RtKvVugU5puJCmr0RSPzeM0/vwBq1CTyw8u5b37KIRkKQlCdtNZ0iRl1RXDG6+jXROA/UOj8=
X-Received: by 2002:a05:6512:2506:: with SMTP id be6mr6838636lfb.597.1639066543167;
 Thu, 09 Dec 2021 08:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20211209062926.991516-2-wenst@chromium.org> <899b2f8c-14de-ae68-2b16-cb9a16c310ca@xs4all.nl>
In-Reply-To: <899b2f8c-14de-ae68-2b16-cb9a16c310ca@xs4all.nl>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 10 Dec 2021 00:15:31 +0800
Message-ID: <CAGXv+5FbUJnvErTRuLQFJV-ec0Q88dQpa=JFJV2Ru6LumJV8sw@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP
 buffers across ioctls
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 8:06 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 09/12/2021 07:29, Chen-Yu Tsai wrote:
> > DST_QUEUE_OFF_BASE is applied to offset/mem_offset on MMAP capture buffers
> > only for the VIDIOC_QUERYBUF ioctl, while the userspace fields (including
> > offset/mem_offset) are filled in for VIDIOC_{QUERY,PREPARE,Q,DQ}BUF
> > ioctls. This leads to differences in the values presented to userspace.
> > If userspace attempts to mmap the capture buffer directly using values
> > from DQBUF, it will fail.
> >
> > Move the code that applies the magic offset into a helper, and call
> > that helper from all four ioctl entry points.
> >
> > Fixes: 7f98639def42 ("V4L/DVB: add memory-to-memory device helper framework for videobuf")
> > Fixes: 908a0d7c588e ("[media] v4l: mem2mem: port to videobuf2")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This was tested on RK3399 with
> >
> >     gst-launch-1.0 videotestsrc num-buffers=2 ! v4l2jpegenc ! fakesink
> >
> > and verifying the values using the V4L2 debug messages:
> >
> >     video2: VIDIOC_QUERYBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004000, field=any, sequence=0, memory=mmap
> >     plane 0: bytesused=0, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
> >     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> >     video2: VIDIOC_QUERYBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004000, field=any, sequence=0, memory=mmap
> >     plane 0: bytesused=0, data_offset=0x00000000, offset/userptr=0x0, length=153600
> >     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> >
> >     video2: VIDIOC_QBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004003, field=any, sequence=0, memory=mmap
> >     plane 0: bytesused=2097152, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
> >     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> >     video2: VIDIOC_QBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004003, field=none, sequence=0, memory=mmap
> >     plane 0: bytesused=153600, data_offset=0x00000000, offset/userptr=0x0, length=153600
> >     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> >
> >     video2: VIDIOC_DQBUF: 00:00:00.000000 index=0, type=vid-cap-mplane, request_fd=0, flags=0x00004001, field=none, sequence=0, memory=mmap
> >     plane 0: bytesused=6324, data_offset=0x00000000, offset/userptr=0x40000000, length=2097152
> >     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> >     video2: VIDIOC_DQBUF: 00:00:00.000000 index=0, type=vid-out-mplane, request_fd=0, flags=0x00004001, field=none, sequence=0, memory=mmap
> >     plane 0: bytesused=153600, data_offset=0x00000000, offset/userptr=0x0, length=153600
> >     timecode=00:00:00 type=0, flags=0x00000000, frames=0, userbits=0x00000000
> >
> > Gstreamer doesn't do PREPAREBUF calls, so that path was not verified.
> > However the code changes are exactly the same, so I'm quite confident
> > about them.
> >
> > ---
> >  drivers/media/v4l2-core/v4l2-mem2mem.c | 46 ++++++++++++++++++++------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > index e2654b422334..b47f25297c43 100644
> > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > @@ -585,19 +585,14 @@ int v4l2_m2m_reqbufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_m2m_reqbufs);
> >
> > -int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> > -                   struct v4l2_buffer *buf)
> > +static void v4l2_m2m_adjust_mem_offset(struct vb2_queue *vq,
> > +                                    struct v4l2_buffer *buf)
> >  {
> > -     struct vb2_queue *vq;
> > -     int ret = 0;
> > -     unsigned int i;
> > -
> > -     vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> > -     ret = vb2_querybuf(vq, buf);
> > -
> >       /* Adjust MMAP memory offsets for the CAPTURE queue */
> >       if (buf->memory == V4L2_MEMORY_MMAP && V4L2_TYPE_IS_CAPTURE(vq->type)) {
> >               if (V4L2_TYPE_IS_MULTIPLANAR(vq->type)) {
> > +                     unsigned int i;
> > +
> >                       for (i = 0; i < buf->length; ++i)
> >                               buf->m.planes[i].m.mem_offset
> >                                       += DST_QUEUE_OFF_BASE;
> > @@ -605,6 +600,19 @@ int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> >                       buf->m.offset += DST_QUEUE_OFF_BASE;
> >               }
> >       }
> > +}
> > +
> > +int v4l2_m2m_querybuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> > +                   struct v4l2_buffer *buf)
> > +{
> > +     struct vb2_queue *vq;
> > +     int ret = 0;
> > +
> > +     vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> > +     ret = vb2_querybuf(vq, buf);
> > +
> > +     /* Adjust MMAP memory offsets for the CAPTURE queue */
> > +     v4l2_m2m_adjust_mem_offset(vq, buf);
> >
> >       return ret;
> >  }
> > @@ -760,6 +768,10 @@ int v4l2_m2m_qbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> >       }
> >
> >       ret = vb2_qbuf(vq, vdev->v4l2_dev->mdev, buf);
> > +
> > +     /* Adjust MMAP memory offsets for the CAPTURE queue */
> > +     v4l2_m2m_adjust_mem_offset(vq, buf);
> > +
> >       if (ret)
> >               return ret;
> >
> > @@ -784,9 +796,15 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> >                  struct v4l2_buffer *buf)
> >  {
> >       struct vb2_queue *vq;
> > +     int ret;
> >
> >       vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> > -     return vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
> > +     ret = vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
> > +
> > +     /* Adjust MMAP memory offsets for the CAPTURE queue */
> > +     v4l2_m2m_adjust_mem_offset(vq, buf);
> > +
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_m2m_dqbuf);
> >
> > @@ -795,9 +813,15 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> >  {
> >       struct video_device *vdev = video_devdata(file);
> >       struct vb2_queue *vq;
> > +     int ret;
> >
> >       vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
> > -     return vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
> > +     ret = vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
> > +
> > +     /* Adjust MMAP memory offsets for the CAPTURE queue */
> > +     v4l2_m2m_adjust_mem_offset(vq, buf);
> > +
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
> >
> >
>
> For all these functions you should only call v4l2_m2m_adjust_mem_offset() if !ret.
> If the vb2_* function returned an error, then the offset fields aren't filled in,
> so it makes no sense to update them. And besides, the struct isn't copied back to
> userspace anyway on error.

Got it. That makes more sense than the original code.

ChenYu
