Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E5B50FCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244394AbiDZM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbiDZM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:28:06 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E453C15C396;
        Tue, 26 Apr 2022 05:24:57 -0700 (PDT)
Date:   Tue, 26 Apr 2022 20:24:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650975895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ihWfybmQBLwWs2JDnc+H/HKvcZbSpd7+Ep5O3IrtFw=;
        b=RxPE+S/KZdvXUPCvXIpza6SglxVNoMOI1kqQVJy2QL5+sq14mkJDaDXHCg/nbpzOaVBdPo
        cdLL7xkr5NfPMQor8TaWV2iOB6XUiyoU2pPVh4qcxYVHHhhyP/Urq0MTP8JFi2VCXp7AFp
        yyhYC5ykSb/j7hdEe6UsQcwRNo+WeYg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [Linaro-mm-sig] Re: [PATCH v2 4/4] drm/nvdla/uapi: Add UAPI of
 NVDLA driver
Message-ID: <20220426122404.GA6788@chq-T47>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <20220426060808.78225-5-cai.huoqing@linux.dev>
 <618a4f53-0998-1e6b-e32b-8bf2d3057cec@amd.com>
 <CAK8P3a2w1t7Sk897u0ndD66Lwp5a4DuOqqQLN4yHSg=JmrpOHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2w1t7Sk897u0ndD66Lwp5a4DuOqqQLN4yHSg=JmrpOHQ@mail.gmail.com>
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

On 26 4月 22 12:50:50, Arnd Bergmann wrote:
> On Tue, Apr 26, 2022 at 8:31 AM Christian König
> <christian.koenig@amd.com> wrote:
> > Am 26.04.22 um 08:08 schrieb Cai Huoqing:
> > > The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> > > which is integrated into NVIDIA Jetson AGX Xavier,
> > > so add UAPI of this driver.
> > >
> > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> 
> I saw the reply but no the original mail, so I'll comment here
Hi, thanks for your reply
The patches here:
https://lore.kernel.org/lkml/20220426060808.78225-3-cai.huoqing@linux.dev/
> 
> > > +
> > > +#if !defined(__KERNEL__)
> > > +#define __user
> > > +#endif
> 
> This is done in the 'make headers_install' step, no need to define it
> separately.
> 
> > > +#define NVDLA_NO_TIMEOUT    (0xffffffff)
> > > +     __u32 timeout;
> >
> > What format does that timeout value have?
> >
> > In general it is best practice to have absolute 64bit nanosecond
> > timeouts (to be used with ktime inside the kernel) so that restarting
> > interrupted IOCTLs works smooth.
> 
> When using absolute values, one also needs to decide whether this should be
> realtime, monotonic or boottime and document the decision.
> 
> 
> > > + * struct nvdla_submit_args structure for task submit
> > > + *
> > > + * @tasks            pointer to array of struct nvdla_ioctl_submit_task
> > > + * @num_tasks                number of entries in tasks
> > > + * @flags            flags for task submit, no flags defined yet
> > > + * @version          version of task structure
> > > + *
> > > + */
> > > +struct nvdla_submit_args {
> > > +     __u64 tasks;
> > > +     __u16 num_tasks;
> > > +#define NVDLA_MAX_TASKS_PER_SUBMIT   24
> > > +#define NVDLA_SUBMIT_FLAGS_ATOMIC    (1 << 0)
> >
> > Well that "no flags defined yet" from the comment above is probably
> > outdated :)
> 
> > > +     __u16 flags;
> > > +     __u32 version;
> > > +};
> 
> Versioned interfaces are usually a bad idea. If you introduce an ioctl command,
> it should generally keep working. If you ever need to change the interface, just
> use a new command number for the new version.
> 
> > > +/**
> > > + * struct nvdla_gem_create_args for allocating DMA buffer through GEM
> > > + *
> > > + * @handle           handle updated by kernel after allocation
> > > + * @flags            implementation specific flags
> > > + * @size             size of buffer to allocate
> > > + */
> > > +struct nvdla_gem_create_args {
> > > +     __u32 handle;
> > > +     __u32 flags;
> > > +     __u64 size;
> > > +};
> > > +
> > > +/**
> > > + * struct nvdla_gem_map_offset_args for mapping DMA buffer
> > > + *
> > > + * @handle           handle of the buffer
> > > + * @reserved         reserved for padding
> > > + * @offset           offset updated by kernel after mapping
> > > + */
> > > +struct nvdla_gem_map_offset_args {
> > > +     __u32 handle;
> > > +     __u32 reserved;
> > > +     __u64 offset;
> > > +};
> > > +
> > > +#define DRM_NVDLA_SUBMIT             0x00
> > > +#define DRM_NVDLA_GEM_CREATE 0x01
> > > +#define DRM_NVDLA_GEM_MMAP           0x02
> 
> Is this an actual mmap() call, or something that needs to be done before the
> mmap()? Is the 'handle' a file descriptor or some internal number?
It's an gem object mmap which calls drm_gem_dumb_map_offset() inside and
the handle is gem object handle.

Thanks,
Cai
> 
>       Arnd
