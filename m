Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62750F3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbiDZI3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbiDZI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:28:27 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E90C13566E;
        Tue, 26 Apr 2022 01:24:09 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:23:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650961448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdGDIqYqS8uTN3qBHotmaehDUrqrCAd/ATCDmNWx4J8=;
        b=F5B/akNZx0UWFc1a5zQAxRrrtRqnAQ+rEmouQVvUMOqPXm8YevuVpoikV0FD/OB0lqQMfm
        1OM0kQltfw+/E4mXL7FzYhpRHk0Ur2BalRnHy7cm88OZGzBIu70RoL9cvlUrRse0q2brDg
        M07BkQ9+qnbcASu4CcWq3g4zBvPwmPo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 4/4] drm/nvdla/uapi: Add UAPI of NVDLA driver
Message-ID: <20220426082341.GA83596@chq-T47>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <20220426060808.78225-5-cai.huoqing@linux.dev>
 <618a4f53-0998-1e6b-e32b-8bf2d3057cec@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <618a4f53-0998-1e6b-e32b-8bf2d3057cec@amd.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 4月 22 08:31:05, Christian König wrote:
> Am 26.04.22 um 08:08 schrieb Cai Huoqing:
> > The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> > which is integrated into NVIDIA Jetson AGX Xavier,
> > so add UAPI of this driver.
> > 
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > ---
> > v1->v2:
> > *Rename nvdla_drm.[ch] to nvdla_drv.[ch] and rename nvdla_ioctl.h to nvdla_drm.h,
> >   move it to uapi.
> >   comments link: https://lore.kernel.org/lkml/20bac605-97e6-e5cd-c4e4-83a8121645d8@amd.com/
> > 
> >   include/uapi/drm/nvdla_drm.h | 99 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 99 insertions(+)
> >   create mode 100644 include/uapi/drm/nvdla_drm.h
> > 
> > diff --git a/include/uapi/drm/nvdla_drm.h b/include/uapi/drm/nvdla_drm.h
> > new file mode 100644
> > index 000000000000..984635285525
> > --- /dev/null
> > +++ b/include/uapi/drm/nvdla_drm.h
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> > +/*
> > + * Copyright (C) 2017-2018 NVIDIA CORPORATION.
> > + * Copyright (C) 2022 Cai Huoqing
> > + */
> > +
> > +#ifndef __LINUX_NVDLA_IOCTL_H
> > +#define __LINUX_NVDLA_IOCTL_H
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +#if !defined(__KERNEL__)
> > +#define __user
> > +#endif
> > +
> > +/**
> > + * struct nvdla_mem_handle structure for memory handles
> > + *
> > + * @handle		handle to DMA buffer allocated in userspace
> > + * @reserved		Reserved for padding
> > + * @offset		offset in bytes from start address of buffer
> > + *
> > + */
> > +struct nvdla_mem_handle {
> > +	__u32 handle;
> > +	__u32 reserved;
> > +	__u64 offset;
> > +};
> > +
> > +/**
> > + * struct nvdla_ioctl_submit_task structure for single task information
> > + *
> > + * @num_addresses		total number of entries in address_list
> > + * @reserved			Reserved for padding
> > + * @address_list		pointer to array of struct nvdla_mem_handle
> > + *
> > + */
> > +struct nvdla_ioctl_submit_task {
> > +#define NVDLA_MAX_BUFFERS_PER_TASK (6144)
> > +	__u32 num_addresses;
> > +#define NVDLA_NO_TIMEOUT    (0xffffffff)
> > +	__u32 timeout;
> 
> What format does that timeout value have?
> 
> In general it is best practice to have absolute 64bit nanosecond timeouts
> (to be used with ktime inside the kernel) so that restarting interrupted
> IOCTLs works smooth.
> 
> > +	__u64 address_list;
> 
> Maybe make the comments inline, cause I just wanted to write that you should
> note that this is pointing to an nvdla_mem_handle array until I saw the
> comment above.
> 
> > +};
> > +
> > +/**
> > + * struct nvdla_submit_args structure for task submit
> > + *
> > + * @tasks		pointer to array of struct nvdla_ioctl_submit_task
> > + * @num_tasks		number of entries in tasks
> > + * @flags		flags for task submit, no flags defined yet
> > + * @version		version of task structure
> > + *
> > + */
> > +struct nvdla_submit_args {
> > +	__u64 tasks;
> > +	__u16 num_tasks;
> > +#define NVDLA_MAX_TASKS_PER_SUBMIT	24
> > +#define NVDLA_SUBMIT_FLAGS_ATOMIC	(1 << 0)
> 
> Well that "no flags defined yet" from the comment above is probably outdated
> :)
> 
> A comment what this flag means would also be nice to have.
> 
> Apart from all those nit picks that looks pretty solid to me. Just one core
> functionality we usually have seems to be missing here: How is completion
> signaling implemented?
Hi,thank for your reply.

Do you mean fence signal? In this driver, IOCTL_SUBMIT is a synchronous call
which do task submission & wait for done completion. This accerletor deal
with massive compute operator (Pooling, Conv...), that is different to
GPU. It's unnecessary to expose fence API to UMD for reducing such less time.

Thanks,
Cai
> 
> Regards,
> Christian.
> 
> > +	__u16 flags;
> > +	__u32 version;
> > +};
> > +
> > +/**
> > + * struct nvdla_gem_create_args for allocating DMA buffer through GEM
> > + *
> > + * @handle		handle updated by kernel after allocation
> > + * @flags		implementation specific flags
> > + * @size		size of buffer to allocate
> > + */
> > +struct nvdla_gem_create_args {
> > +	__u32 handle;
> > +	__u32 flags;
> > +	__u64 size;
> > +};
> > +
> > +/**
> > + * struct nvdla_gem_map_offset_args for mapping DMA buffer
> > + *
> > + * @handle		handle of the buffer
> > + * @reserved		reserved for padding
> > + * @offset		offset updated by kernel after mapping
> > + */
> > +struct nvdla_gem_map_offset_args {
> > +	__u32 handle;
> > +	__u32 reserved;
> > +	__u64 offset;
> > +};
> > +
> > +#define DRM_NVDLA_SUBMIT		0x00
> > +#define DRM_NVDLA_GEM_CREATE	0x01
> > +#define DRM_NVDLA_GEM_MMAP		0x02
> > +
> > +#define DRM_IOCTL_NVDLA_SUBMIT DRM_IOWR(DRM_COMMAND_BASE + DRM_NVDLA_SUBMIT, struct nvdla_submit_args)
> > +#define DRM_IOCTL_NVDLA_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_NVDLA_GEM_CREATE, struct nvdla_gem_create_args)
> > +#define DRM_IOCTL_NVDLA_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE + DRM_NVDLA_GEM_MMAP, struct nvdla_gem_map_offset_args)
> > +
> > +#endif
> 
