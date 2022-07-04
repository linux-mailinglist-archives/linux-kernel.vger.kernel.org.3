Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156715651AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiGDKD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGDKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:03:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFBDE02B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:02:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so15757462ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdxpXqd5Zb/vXY/O4KXszU7VLBhJIHNKCWL85v0aSCA=;
        b=LItEpDeOzqvBLZS8mV8vwfNdRojgaEHUBqdn0g7r8G+nBY/Jy7ONq0oG5YsVdOn/L5
         MUvHyRYKPi58DokyxX6rPiRyLdXKMvkTNVY+jSLMCfGfUGCl4Mh8UhxeNMh0k233j5YH
         btFs9J3VS3F01g6trSP6Jb27yZMTJ503p4J0P0BwQEn28pd/zL18Jpj1nctZZFe+rJOJ
         6NbglyeNjU6mEjmoNdBn6atLFmJryQwVaj4rZjYRnh6aiCTgLrxgts55oLRiS5Gshl8/
         50SeVoQm6EXUdyjLDs+dwcMEHW0MAmB8CnqS5ozhgdthvDfITw6Hl7Weq+UOJz8CgjIg
         unvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdxpXqd5Zb/vXY/O4KXszU7VLBhJIHNKCWL85v0aSCA=;
        b=mLDNy5dweLuBqv/gLhRVfSJ8LS925kUZwHH/N0bK5ttWl5PCeECT4fRg/nZXDkd2tC
         WvNoD5dIMhy6zjwp2Ogl+I6TF6qbNfjVM41dPgIOExK5Yfo+pQrK/crs+Q6Myx6iyuy4
         ynYGwtgvD4BKdIgAkRF4Pv1vfl9nW0AAXYo3in+ASteYUjDOF9QeIYttOzYr4vyFD3zu
         wFl5Vh22RQlCPSagau0NheRUEnRobOV9ZubqNDpo6b+oSmD0ev1M3BILbp73X9DDZ0fZ
         IBc9WxaSWBaVIzlCGDpjo/3w33UycPWxB5Dl6YHxBjPWXHCcXtSPY0HkuouxVJn2IkiE
         mAvw==
X-Gm-Message-State: AJIora9PSxK/3Vc6V10jvND36M5LTcAQNqE4SzeHb8MAJ0FvA9tQD1qQ
        pypqZ/in1tnUWfNy6JeC+45uz8tFadn5j3EPtZ2I
X-Google-Smtp-Source: AGRyM1vgBhy7w+pruNX0WXdDQj6Wh02c2ES7UQky4LZw96ebu1SL9XdqalsAcQR+RynyPuVI7VthIcno4nJuBriEttE=
X-Received: by 2002:a17:907:7ba1:b0:726:4522:d368 with SMTP id
 ne33-20020a1709077ba100b007264522d368mr28002033ejc.662.1656928957018; Mon, 04
 Jul 2022 03:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220629082541.118-1-xieyongji@bytedance.com> <20220704092652.GB105370@storage2.sh.intel.com>
In-Reply-To: <20220704092652.GB105370@storage2.sh.intel.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 4 Jul 2022 18:02:26 +0800
Message-ID: <CACycT3siFoCcCAO4y9PqE-Wi5qmrFJ30oNwBOg4q0_59CtdfdA@mail.gmail.com>
Subject: Re: [PATCH 0/6] VDUSE: Support registering userspace memory as bounce buffer
To:     Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
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

Hi Xiaodong,

On Mon, Jul 4, 2022 at 5:27 PM Liu Xiaodong <xiaodong.liu@intel.com> wrote:
>
> On Wed, Jun 29, 2022 at 04:25:35PM +0800, Xie Yongji wrote:
> > Hi all,
> >
> > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > registering and de-registering userspace memory for IOTLB
> > as bounce buffer in virtio-vdpa case.
> >
> > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > information such as bounce buffer size. Then user can use
> > those information on VDUSE_IOTLB_REG_UMEM and
> > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > userspace memory for IOTLB.
> >
> > During registering and de-registering, the DMA data in use
> > would be copied from kernel bounce pages to userspace bounce
> > pages and back.
> >
> > With this feature, some existing application such as SPDK
> > and DPDK can leverage the datapath of VDUSE directly and
> > efficiently as discussed before [1]. They can register some
> > preallocated hugepages to VDUSE to avoid an extra memcpy
> > from bounce-buffer to hugepages.
>
> Hi, Yongji
>
> Very glad to see this enhancement in VDUSE. Thank you.
> It is really helpful and essential to SPDK.
> With this new feature, we can get VDUSE transferred data
> accessed directly by userspace physical backends, like RDMA
> and PCIe devices.
>
> In SPDK roadmap, it's one important work to export block
> services to local host, especially for container scenario.
> This patch could help SPDK do that with its userspace
> backend stacks while keeping high efficiency and performance.
> So the whole SPDK ecosystem can get benefited.
>
> Based on this enhancement, as discussed, I drafted a VDUSE
> prototype module in SPDK for initial evaluation:
> [TEST]vduse: prototype for initial draft
> https://review.spdk.io/gerrit/c/spdk/spdk/+/13534
>

Thanks for this nice work!

> Running SPDK on single CPU core, configured with 2 P3700 NVMe,
> and exported block devices to local host kernel via different
> protocols. The randwrite IOPS through each protocol are:
> NBD               121K
> NVMf-tcp loopback 274K
> VDUSE             463K
>
> SPDK with RDMA backends should have a similar ratio.
> VDUSE has a great performance advantage for SPDK.
> We have kept investigating on this usage for years.
> Originally, some SPDK users used NBD. Then NVMf-tcp loopback
> is SPDK community accommended way. In future, VDUSE could be
> the preferred way.
>

Glad to see SPDK can benefit from this feature. I will continue to
improve this feature to make it available ASAP.

Thanks,
Yongji

> > The kernel and userspace codes could be found in github:
> >
> > https://github.com/bytedance/linux/tree/vduse-umem
> > https://github.com/bytedance/qemu/tree/vduse-umem
> >
> > To test it with qemu-storage-daemon:
> >
> > $ qemu-storage-daemon \
> >     --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server=on,wait=off \
> >     --monitor chardev=charmonitor \
> >     --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0
> > \
> >     --export type=vduse-blk,id=vduse-test,name=vduse-test,node-name=disk0,writable=on
> >
> > [1] https://lkml.org/lkml/2021/6/27/318
> >
> > Please review, thanks!
>
> Waiting for its review process.
>
> Thanks
> Xiaodong
