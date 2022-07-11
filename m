Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AAE56D6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiGKHYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGKHYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:24:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A85B13FB6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:24:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e15so5141855edj.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDveJzFZvRjiL1p9LtdiJFd70DGE33Tfto29/Q9eZIc=;
        b=faCMdkRJbTLAW1mT2GEpBEvgCpZbtj4RfoLXG75nue3CJ/SqoLmZGuLfHs/21mK5e6
         4sARlKgvrEhQ8rhJOEi1P1hf8qPUjiq0yXfgagquQm9wJHr3mQixjkEx5LfyOYXy469F
         sLc8sohYou4aJy2giHSCUjlbVfYuGzVCFO9JfPpDJYOYicAMCyVnBsXVgQ5ByMT49Pi0
         u4Wpe3WZzVKLDaFHsQi4qw2TYlbbYgk40ZlDX3lnnJkB5MZVv0ZRiebHOkmHFGDfKCCh
         3fR1b5Dc3CcsT4inKT5rMvLtWYUBTodWRDswp4RRDuBMZTEyv8KzSXdwggESl/orK6IJ
         lqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDveJzFZvRjiL1p9LtdiJFd70DGE33Tfto29/Q9eZIc=;
        b=GNVSKjJ2U9GcTBdlduEoLeZzXOh3L+8vneZglqsCkm08JhjBxRaVm9rMMgLToCpTf2
         6FJjOSJj+U52Vhb9j715C8d+leAJBFdyn7BEMmNyXFlOYwB17JGVKHnaN1rK9izsozmO
         HRLr9UpneOBN6EEM/375iCOWLvXIXBLWRdkYFFBAy+bo2/Lri60BdVeopPz/T9m5OAjz
         KZJcBc01Qp63z6E72qBhU5NOkK/B1T2Moe3BnEIdPU2eEV95vtHax1BOgCAVb6AApR8R
         7LDyDgkaHIPqLvMVpuA1506eTkAn5563AJN1NSDxh/OC3jfCFoxEzU2xwkTgYLI/jKE3
         JhTg==
X-Gm-Message-State: AJIora9St4OSyQZlafRff0hrXGCeP8MazMQfZI4P+lswRMp/uH5pauRI
        DUQNhIRuT8oddpjPGjwfKSaZonFqfi7h9+Ed1g/i
X-Google-Smtp-Source: AGRyM1vv0aPwxFE/jj4WcGMRymePPG14ezSoC47aHzECUL2MuCr+eTMM0BvBw0+r4HWJPU5QcGRM3VnUbYrpnMYBr4Q=
X-Received: by 2002:a05:6402:240a:b0:437:d2b6:3dde with SMTP id
 t10-20020a056402240a00b00437d2b63ddemr23062785eda.62.1657524284790; Mon, 11
 Jul 2022 00:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
 <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
 <CACGkMEvtC1VmGjhV6QpEeu+nUikGj5eT79hhyS59rpK1s31TUg@mail.gmail.com>
 <CACycT3sNnmV8jrnjFkft6oST_6SGLc43f8Y4ZpomkPeOsvsorQ@mail.gmail.com> <CACGkMEsuGif+X4Maa-qSNYLzfkvBKV9ZkVEUFgYnjsUUwS4Dkw@mail.gmail.com>
In-Reply-To: <CACGkMEsuGif+X4Maa-qSNYLzfkvBKV9ZkVEUFgYnjsUUwS4Dkw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 11 Jul 2022 15:24:33 +0800
Message-ID: <CACycT3vgaOrLVq+GDRK1PqqBRCkUAU0bYH=2CDvudsX0F9FBDA@mail.gmail.com>
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

On Mon, Jul 11, 2022 at 2:02 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Jul 8, 2022 at 5:53 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Fri, Jul 8, 2022 at 4:38 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Jul 6, 2022 at 6:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > >
> > > > On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > > > > > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > > > > > registering and de-registering userspace memory for IOTLB
> > > > > > as bounce buffer in virtio-vdpa case.
> > > > > >
> > > > > > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > > > > > information such as bounce buffer size. Then user can use
> > > > > > those information on VDUSE_IOTLB_REG_UMEM and
> > > > > > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > > > > > userspace memory for IOTLB.
> > > > > >
> > > > > > During registering and de-registering, the DMA data in use
> > > > > > would be copied from kernel bounce pages to userspace bounce
> > > > > > pages and back.
> > > > > >
> > > > > > With this feature, some existing application such as SPDK
> > > > > > and DPDK can leverage the datapath of VDUSE directly and
> > > > > > efficiently as discussed before [1][2]. They can register
> > > > > > some preallocated hugepages to VDUSE to avoid an extra
> > > > > > memcpy from bounce-buffer to hugepages.
> > > > >
> > > > > This is really interesting.
> > > > >
> > > > > But a small concern on uAPI is that this seems to expose the VDUSE
> > > > > internal implementation (bounce buffer) to userspace. We tried hard to
> > > > > hide it via the GET_FD before. Anyway can we keep it?
> > > > >
> > > >
> > > > Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
> > > > field to indicate whether a IOVA region supports userspace memory
> > > > registration. Then userspace can use
> > > > VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
> > > > userspace memory for this IOVA region.
> > >
> > > Looks better.
> > >
> >
> > OK.
> >
> > > > Any suggestions?
> > >
> > > I wonder what's the value of keeping the compatibility with the kernel
> > > mmaped bounce buffer. It means we need to take extra care on e.g data
> > > copying when reg/reg user space memory.
> > >
> >
> > I'm not sure I get your point on the compatibility with the kernel
> > bounce buffer. Do you mean they use the same iova region?
>
> Yes.
>
> >
> > The userspace daemon might crash or reboot. In those cases, we still
> > need a kernel buffer to store/recover the data.
>
> Yes, this should be a good point.
>
> >
> > > Can we simply allow the third kind of fd that only works for umem registration?
> > >
> >
> > Do you mean using another iova region for umem?
>
> I meant having a new kind of fd that only allows umem registration.
>

OK. It seems to be a little complicated to allow mapping a registered
user memory via a new fd, e.g. how to handle the mapping if the
userspace daemon exits but the fd is already passed to another
process.

> >I think we don't need
> > a fd in umem case since the userspace daemon can access the memory
> > directly without using mmap() to map it into the address space in
> > advance.
>
> Ok, I will have a look at the code and get back.
>

OK. Looking forward to your reply.

Thanks,
Yongji
