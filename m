Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7525604C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiF2PhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiF2PhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:37:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567D3818C;
        Wed, 29 Jun 2022 08:37:16 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77912660191F;
        Wed, 29 Jun 2022 16:37:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656517034;
        bh=1Pml/+GQJj4lTb2xPQ0+gCn/RVoDC41JqJVlxNLfVxo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=B3/RM3PEkye7m5Y/h1xpmK8qc29lWEwJZDqUZ3nhRHJCpKiBjJssAA+FAvvdQje6s
         HjxiCC63nZzrRa9gCBTDrySHD8HvZihxqpl1i2Kvq0m/Upr68gGgDjO/ThrBZ9JTmO
         riEK8uxzf7gaLI41+gxjnKhjzQjCrJayortxfHr/p1YHPgzIDakAANA6BqQ+IzjSu3
         BWx5nXh5dp4av6t+I97TW8jW52cLWa1Uyr3sns6C1OSSCi+KRuuPttrciZaZJC/wK4
         7IbTM2Um5ACfxcaGD13njMWeGZxub0CGTuhRFw3/OpwBJ331E8XLTyqBt4NgqYxTmP
         bFPkjf43jAajQ==
Message-ID: <f66a02b6-5e2d-5e28-8c92-0a76d53269f7@collabora.com>
Date:   Wed, 29 Jun 2022 18:37:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] media: videobuf2: Allow applications customize data
 offsets of capture buffers
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <bbrezillon@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Laura Nao <laura.nao@collabora.com>
References: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
 <a7c858461b99de2d4afad22d888acc3a74850240.camel@ndufresne.ca>
 <9ec970d6-ea09-802c-419b-b2ef26800990@collabora.com>
 <5be83f0b343c04d877a2c2d805fb5f71ca9973b1.camel@ndufresne.ca>
 <fe24d151-6097-aa8e-7691-5e4d81fa42c6@collabora.com>
 <f80128c50d3dacff0af70bd88521abae42476f85.camel@ndufresne.ca>
 <1c1fda82-334a-04ec-fc2e-d1ea2da466e9@xs4all.nl>
 <11bd51f2-ca35-4e01-95e9-ad35b37f26d8@collabora.com>
In-Reply-To: <11bd51f2-ca35-4e01-95e9-ad35b37f26d8@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/22 13:22, Dmitry Osipenko wrote:
...
>> On 3/25/22 13:32, Nicolas Dufresne wrote:
>>> Le jeudi 24 mars 2022 à 21:20 +0300, Dmitry Osipenko a écrit :
>>>> The root of the problem is that DRM UAPI is more flexible and allows to
>>>> customize offsets for both S/MPLANEs, while V4L doesn't allow to do it
>>>> at all. I'm exploring all the potential options, so far neither of the
>>>> proposed variants is ideal.
>>>
>>> In GStreamer kmssink, the way DRM is used, is that if you have 2 planes in your
>>> pixel format, but only received 1 DMABuf, we will pass this DMABuf twice (well
>>> GEM handles, but twice), with appropriate offset.
>>>
>>> With this in mind, the idea for V4L2 could be to always resort to MPLANE for
>>> this purpose. The tricky part for userland is that it needs to know the dual
>>> pixel format and map that accordingly. That is a bit difficult and this is
>>> something Helen was trying to address with the v4l2_buffer_ext (that and
>>> allowing space to store DRM Modifiers in the future).
>>
>> FYI: here is Helen's last patch series. Since Helen is no longer active in
>> the media subsystem, someone else who is sufficiently motivated would have to
>> take over.
>>
>> https://patchwork.linuxtv.org/project/linux-media/cover/20210114180738.1758707-1-helen.koike@collabora.com/
>>
>> I'm not enthusiastic about messing with data_offset: it was - in hindsight - a
>> bad idea.
> 
> I'm aware of the Helen's work. To me the addition of the new IOCTLs that
> partially duplicate the older ones doesn't feel like the best approach.
> But since you're good with it, then I'll try to refresh the Helen's work
> for 5.20 and we'll see where it will go.
> 

Hello Hans,

I'm having hard time convincing myself that the addition of the new IOCTLs is the right approach for us. Helen was adding the new QBUF IOCTLs that supposed to:

1. Support DRM modifiers.
2. Support per-plane dma-buf offsets.
3. Support new features that "are good to have", like 64bit timestamp and unified multi/single planar formats. 

The idea of using DRM modifiers is obsoleted now. Mixing DRM with V4L will be a mess and nobody really needs that feature anymore because there are not that many compressed framebuffer formats needed by V4L drivers.

The dma-buf offsets is the main thing that is really wanted by multiple users and we can support it by extending the current UAPI, which should be the best option IMO. It will be simple to implement and doesn't require much changes form the existing applications.

If we will ever really need to introduce a brand new UAPI, then I think it should be covering more things like deprecating the creation of multiple buffers at once, making buffers independent and reusable, ability to destroy buffer and etc. This will be a lot of work that doesn't worth the effort today since everybody in userspace already adapted to the current state of V4L.

I typed another variant of the patch that extends the struct v4l2_plane with the new buffer offset field and curious what you're thinking about it. It works fine by replacing the data_offset with the new buf_offset in the Tegra decoder driver since it already supports the data_offset which was previously unused because initially I thought that it was about buffer offsets when implemented V4L support for the Tegra driver. If we will agree on this approach then RKISP and MTK should be the next drivers that may get support for the dma-buf offsets.

Or maybe you have good arguments for the addition of new IOCTLs? Other ideas?

Here is the patch in question:

--- >8 ---

Subject: [PATCH] media: videobuf2: Introduce new buf_offset field for dma-buf
 memory planes

Add new optional buf_offset field to struct v4l2_plane of the videdev2
UAPI and support it in the V4L2 core. This new field designates the offset
from the start of a memory plane's dma-buf.

The primary user of this new field are downstream software stacks that
transition to upstream kernel. ChromeOS is one of those stacks and Android
might be the other. The downstream kernel fork of ChromeOS re-uses the
data_offset field for the dma-buf offsets, but data_offset has a different
meaning, and thus, this approach isn't acceptable for the upstream. The
reason why it's needed by ChromeOS is the integration with GPU subsystem
that uses DRM. In some cases there is disagreement between V4L and DRM
drivers on the memory plane offsets, which is difficult to resolve without
overriding the offsets in V4L.

Since not all drivers will support the new buf_offset, the new capability
flag "supports_mem_plane_offset" is added to the struct vb2_queue. Drivers
supporting dma-buf offsets will have to explicitly enable the new capability.

The buf_offset field is meant to be application-specific because there is
no generic way for conveying the h/w requirements to userspace in V4L.

Note that only drivers can validate the dma-buf offsets properly because
of the different h/w alignment requirements. Hence we can't support the
dma-buf offsets handling in the V4L core and it needs to be done within
drivers in the buf_prepare() callback of the vb2_ops.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c |  2 ++
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 10 ++++++++++
 include/media/videobuf2-core.h                  |  6 ++++++
 include/uapi/linux/videodev2.h                  |  5 ++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b203c1e26353..431fe1c8578c 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1278,6 +1278,7 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 		vb->planes[plane].bytesused = 0;
 		vb->planes[plane].length = 0;
 		vb->planes[plane].m.fd = 0;
+		vb->planes[plane].buf_offset = 0;
 		vb->planes[plane].data_offset = 0;
 
 		/* Acquire each plane's memory */
@@ -1323,6 +1324,7 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 		vb->planes[plane].bytesused = planes[plane].bytesused;
 		vb->planes[plane].length = planes[plane].length;
 		vb->planes[plane].m.fd = planes[plane].m.fd;
+		vb->planes[plane].buf_offset = planes[plane].buf_offset;
 		vb->planes[plane].data_offset = planes[plane].data_offset;
 	}
 
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 075d24ebf44c..e79c8ec03d00 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -219,6 +219,13 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 					b->m.planes[plane].m.fd;
 				planes[plane].length =
 					b->m.planes[plane].length;
+				planes[plane].buf_offset =
+					b->m.planes[plane].buf_offset;
+
+				if (planes[plane].buf_offset && !q->supports_mem_plane_offset) {
+					dprintk(q, 1, "dma-buf offset unsupported by the queue\n");
+					return -EINVAL;
+				}
 			}
 			break;
 		default:
@@ -294,6 +301,7 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 			break;
 		}
 
+		planes[0].buf_offset = 0;
 		planes[0].data_offset = 0;
 		if (V4L2_TYPE_IS_OUTPUT(b->type)) {
 			if (b->bytesused == 0)
@@ -528,6 +536,7 @@ static void __fill_v4l2_buffer(struct vb2_buffer *vb, void *pb)
 				pdst->m.userptr = psrc->m.userptr;
 			else if (q->memory == VB2_MEMORY_DMABUF)
 				pdst->m.fd = psrc->m.fd;
+			pdst->buf_offset = psrc->buf_offset;
 			pdst->data_offset = psrc->data_offset;
 			memset(pdst->reserved, 0, sizeof(pdst->reserved));
 		}
@@ -612,6 +621,7 @@ static int __fill_vb2_buffer(struct vb2_buffer *vb, struct vb2_plane *planes)
 			planes[plane].length = vbuf->planes[plane].length;
 		}
 		planes[plane].bytesused = vbuf->planes[plane].bytesused;
+		planes[plane].buf_offset = vbuf->planes[plane].buf_offset;
 		planes[plane].data_offset = vbuf->planes[plane].data_offset;
 	}
 	return 0;
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 5468b633b9d2..195381837a41 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -171,6 +171,8 @@ struct vb2_mem_ops {
  *		descriptor associated with this plane.
  * @data_offset:	offset in the plane to the start of data; usually 0,
  *		unless there is a header in front of the data.
+ * @buf_offset:	offset in the memory buffer to the start of plane; always 0
+ *		for non-dmabuf buffers.
  *
  * Should contain enough information to be able to cover all the fields
  * of &struct v4l2_plane at videodev2.h.
@@ -188,6 +190,7 @@ struct vb2_plane {
 		int		fd;
 	} m;
 	unsigned int		data_offset;
+	unsigned int		buf_offset;
 };
 
 /**
@@ -506,6 +509,8 @@ struct vb2_buf_ops {
  *		->finish().
  * @non_coherent_mem: when set queue will attempt to allocate buffers using
  *		non-coherent memory.
+ * @supports_mem_plane_offset: when set, a non-zero buf_offset is allowed
+ *		for dma-buf memory planes.
  * @lock:	pointer to a mutex that protects the &struct vb2_queue. The
  *		driver can set this to a mutex to let the v4l2 core serialize
  *		the queuing ioctls. If the driver wants to handle locking
@@ -586,6 +591,7 @@ struct vb2_queue {
 	unsigned int			uses_requests:1;
 	unsigned int			allow_cache_hints:1;
 	unsigned int			non_coherent_mem:1;
+	unsigned int			supports_mem_plane_offset:1;
 
 	struct mutex			*lock;
 	void				*owner;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5311ac4fde35..caf33fe0ae79 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -996,6 +996,8 @@ struct v4l2_requestbuffers {
  * @m:			union of @mem_offset, @userptr and @fd
  * @data_offset:	offset in the plane to the start of data; usually 0,
  *			unless there is a header in front of the data
+ * @buf_offset		offset in the memory buffer to the start of plane;
+ *			always 0 for non-dmabuf buffers
  * @reserved:		drivers and applications must zero this array
  *
  * Multi-planar buffers consist of one or more planes, e.g. an YCbCr buffer
@@ -1012,7 +1014,8 @@ struct v4l2_plane {
 		__s32		fd;
 	} m;
 	__u32			data_offset;
-	__u32			reserved[11];
+	__u32			buf_offset;
+	__u32			reserved[7];
 };
 
 /**
-- 
2.36.1
