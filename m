Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD656B606
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiGHJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiGHJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:53:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC56823B5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:53:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g1so18607654edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CsNiG9gNGdYVbUKKzqCxuAt7nlOt4uKYT3q8NTFK18=;
        b=xWm4R0VrydRB9h71CQX0pqrYowh0ln0y6UktzQXnKFKjVyOgbM6xjFCM9HoXpkl+rJ
         7q/T+9UTAV3xP0ewyNIJaWxyFLlZ6H4bWAVIrSgV+FWGvqtpOfl3+kk9sPtOsunddIHg
         L7nYJ/UKFaiuNhRcKfUcb6Tx5WHF1qiKs3ArCVyPV3r2rcGtRRkvaAsYF7bjHx1e++Q2
         mlbUrRR5weplXyu05SWta0SSw5rZi894UIUM2j+ChJtQ/wgkyP/AsS7eQTkoqjkCDotn
         Kv/zQHqE5cf7yf4LXYT3kvzuFhWYI7jnCRnjTW2X3AOehxTW6Ux4yV4WGND4Xvd+s3Q2
         m82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CsNiG9gNGdYVbUKKzqCxuAt7nlOt4uKYT3q8NTFK18=;
        b=qDDGB/a4Isk7CvwOxZa3fk5Nh2eMWyIlkZkt84hsvtF5lNf64Eb/3vOHNGFKqHjaqL
         rgxC30eyfMlb3nZf+dv6qYSL71l1iRM7es0u4C13G4Ijzn9BXD8eZbKdf1vwCqeZgpsr
         j6G3G7AV4t5rQhYxH4aUY2Ofh28Bwnnphqcv/rN4DD227wYNLiuQbJ1bpzjQ7OQMLHhZ
         AO1L3x0fEz/gMEDPobRCFpWoG94XqpW2U78BnPuftGSEUR0cbUz06a6lxaDCvT0HnNHR
         3z5SWFUwnnQRyC7kxYXO0vgP+/K5Gjolc9+m7Pt+XMvJL4LUWvnBc7SDDqBFr67YuVj9
         C0ow==
X-Gm-Message-State: AJIora81DAp0CLdIJGOM9UWt6IDqw24/Xi1D8M8JxWGsRj7a5AZF7+k7
        qsfJA9t6jcgt0EPgauVSDLUCmf5RaNgoMg0FyKmC
X-Google-Smtp-Source: AGRyM1tbwlDj/K2IJgqHtWLAVcqmTicDferGWDwamFG0dIl2C3s8V7gfmzCi97ksM3Faq7kOIGHWHApBw2UA2o/fJ4U=
X-Received: by 2002:aa7:d555:0:b0:43a:1be7:9e17 with SMTP id
 u21-20020aa7d555000000b0043a1be79e17mr3687236edr.183.1657274035180; Fri, 08
 Jul 2022 02:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com> <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
In-Reply-To: <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 8 Jul 2022 17:53:45 +0800
Message-ID: <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 4:38 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jul 6, 2022 at 6:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > > > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > > > registering and de-registering userspace memory for IOTLB
> > > > as bounce buffer in virtio-vdpa case.
> > > >
> > > > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > > > information such as bounce buffer size. Then user can use
> > > > those information on VDUSE_IOTLB_REG_UMEM and
> > > > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > > > userspace memory for IOTLB.
> > > >
> > > > During registering and de-registering, the DMA data in use
> > > > would be copied from kernel bounce pages to userspace bounce
> > > > pages and back.
> > > >
> > > > With this feature, some existing application such as SPDK
> > > > and DPDK can leverage the datapath of VDUSE directly and
> > > > efficiently as discussed before [1][2]. They can register
> > > > some preallocated hugepages to VDUSE to avoid an extra
> > > > memcpy from bounce-buffer to hugepages.
> > >
> > > This is really interesting.
> > >
> > > But a small concern on uAPI is that this seems to expose the VDUSE
> > > internal implementation (bounce buffer) to userspace. We tried hard to
> > > hide it via the GET_FD before. Anyway can we keep it?
> > >
> >
> > Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
> > field to indicate whether a IOVA region supports userspace memory
> > registration. Then userspace can use
> > VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
> > userspace memory for this IOVA region.
>
> Looks better.
>

OK.

> > Any suggestions?
>
> I wonder what's the value of keeping the compatibility with the kernel
> mmaped bounce buffer. It means we need to take extra care on e.g data
> copying when reg/reg user space memory.
>

I'm not sure I get your point on the compatibility with the kernel
bounce buffer. Do you mean they use the same iova region?

The userspace daemon might crash or reboot. In those cases, we still
need a kernel buffer to store/recover the data.

> Can we simply allow the third kind of fd that only works for umem registration?
>

Do you mean using another iova region for umem? I think we don't need
a fd in umem case since the userspace daemon can access the memory
directly without using mmap() to map it into the address space in
advance.

Thanks,
Yongji
