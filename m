Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70B514121
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiD2ECT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiD2ECR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:02:17 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57059B9F1D;
        Thu, 28 Apr 2022 20:58:57 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:58:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651204735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGbVJ2oBgQd9WBhBVcYIZ91yYFFi5lls4Cqv+m8iT0Y=;
        b=G3wXv49vKJ30/lKminB+CrcC5Q6qT5Pwjp6Z3SJ7dAQvIGT46/aCRlKluDdq10B0+3LHKF
        czPEjwExecGkZ0rdli93xZsN07GHkkdOtoWnyXxlNRLladQOoJCQ8NZypSB4guh0wI1YLE
        CpgN5e9NdYxatNMmEOoSCOZMiuiPpgQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/nvdla/uapi: Add UAPI of NVDLA driver
Message-ID: <20220429035830.GB15753@chq-T47>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <20220426060808.78225-5-cai.huoqing@linux.dev>
 <618a4f53-0998-1e6b-e32b-8bf2d3057cec@amd.com>
 <20220426082341.GA83596@chq-T47>
 <YmqocpCdc7cuYJm7@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmqocpCdc7cuYJm7@orome>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 4月 22 16:45:06, Thierry Reding wrote:
> On Tue, Apr 26, 2022 at 04:23:41PM +0800, Cai Huoqing wrote:
> > On 26 4月 22 08:31:05, Christian König wrote:
> > > Am 26.04.22 um 08:08 schrieb Cai Huoqing:
> > > > The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> > > > which is integrated into NVIDIA Jetson AGX Xavier,
> > > > so add UAPI of this driver.
> > > > 
> > > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > > > ---
> > > > v1->v2:
> > > > *Rename nvdla_drm.[ch] to nvdla_drv.[ch] and rename nvdla_ioctl.h to nvdla_drm.h,
> > > >   move it to uapi.
> > > >   comments link: https://lore.kernel.org/lkml/20bac605-97e6-e5cd-c4e4-83a8121645d8@amd.com/
> > > > 
> > > >   include/uapi/drm/nvdla_drm.h | 99 ++++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 99 insertions(+)
> > > >   create mode 100644 include/uapi/drm/nvdla_drm.h
> > > > 
> > > > diff --git a/include/uapi/drm/nvdla_drm.h b/include/uapi/drm/nvdla_drm.h
> > > > new file mode 100644
> > > > index 000000000000..984635285525
> > > > --- /dev/null
> > > > +++ b/include/uapi/drm/nvdla_drm.h
> > > > @@ -0,0 +1,99 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> > > > +/*
> > > > + * Copyright (C) 2017-2018 NVIDIA CORPORATION.
> > > > + * Copyright (C) 2022 Cai Huoqing
> > > > + */
> > > > +
> > > > +#ifndef __LINUX_NVDLA_IOCTL_H
> > > > +#define __LINUX_NVDLA_IOCTL_H
> > > > +
> > > > +#include <linux/ioctl.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#if !defined(__KERNEL__)
> > > > +#define __user
> > > > +#endif
> > > > +
> > > > +/**
> > > > + * struct nvdla_mem_handle structure for memory handles
> > > > + *
> > > > + * @handle		handle to DMA buffer allocated in userspace
> > > > + * @reserved		Reserved for padding
> > > > + * @offset		offset in bytes from start address of buffer
> > > > + *
> > > > + */
> > > > +struct nvdla_mem_handle {
> > > > +	__u32 handle;
> > > > +	__u32 reserved;
> > > > +	__u64 offset;
> > > > +};
> > > > +
> > > > +/**
> > > > + * struct nvdla_ioctl_submit_task structure for single task information
> > > > + *
> > > > + * @num_addresses		total number of entries in address_list
> > > > + * @reserved			Reserved for padding
> > > > + * @address_list		pointer to array of struct nvdla_mem_handle
> > > > + *
> > > > + */
> > > > +struct nvdla_ioctl_submit_task {
> > > > +#define NVDLA_MAX_BUFFERS_PER_TASK (6144)
> > > > +	__u32 num_addresses;
> > > > +#define NVDLA_NO_TIMEOUT    (0xffffffff)
> > > > +	__u32 timeout;
> > > 
> > > What format does that timeout value have?
> > > 
> > > In general it is best practice to have absolute 64bit nanosecond timeouts
> > > (to be used with ktime inside the kernel) so that restarting interrupted
> > > IOCTLs works smooth.
> > > 
> > > > +	__u64 address_list;
> > > 
> > > Maybe make the comments inline, cause I just wanted to write that you should
> > > note that this is pointing to an nvdla_mem_handle array until I saw the
> > > comment above.
> > > 
> > > > +};
> > > > +
> > > > +/**
> > > > + * struct nvdla_submit_args structure for task submit
> > > > + *
> > > > + * @tasks		pointer to array of struct nvdla_ioctl_submit_task
> > > > + * @num_tasks		number of entries in tasks
> > > > + * @flags		flags for task submit, no flags defined yet
> > > > + * @version		version of task structure
> > > > + *
> > > > + */
> > > > +struct nvdla_submit_args {
> > > > +	__u64 tasks;
> > > > +	__u16 num_tasks;
> > > > +#define NVDLA_MAX_TASKS_PER_SUBMIT	24
> > > > +#define NVDLA_SUBMIT_FLAGS_ATOMIC	(1 << 0)
> > > 
> > > Well that "no flags defined yet" from the comment above is probably outdated
> > > :)
> > > 
> > > A comment what this flag means would also be nice to have.
> > > 
> > > Apart from all those nit picks that looks pretty solid to me. Just one core
> > > functionality we usually have seems to be missing here: How is completion
> > > signaling implemented?
> > Hi,thank for your reply.
> > 
> > Do you mean fence signal? In this driver, IOCTL_SUBMIT is a synchronous call
> > which do task submission & wait for done completion. This accerletor deal
> > with massive compute operator (Pooling, Conv...), that is different to
> > GPU. It's unnecessary to expose fence API to UMD for reducing such less time.
> 
> Are you saying that using fences won't be a big benefit because the DLA
> can't effectively process tasks from multiple sources in parallel? That
> is only part of where some sort of signalling would be useful. Another
> reason why it would be good to have is to make it easier to write user-
> space that can hand off a set of tasks to the DLA, then go off and do
> something else and get notified about the completion somehow. If not a
> full-blown fence API, then perhaps FD polling would be a simple
> mechanism to allow some degree of asynchronicity.
Agree, I will add fence IOCTL if resend patch

Thanks
Cai
> 
> Thierry


