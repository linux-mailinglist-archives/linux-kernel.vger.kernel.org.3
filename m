Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B14B1E98
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbiBKGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:34:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiBKGek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:34:40 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799D7E56
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:34:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V47kJqh_1644561276;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V47kJqh_1644561276)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Feb 2022 14:34:37 +0800
Message-ID: <1644560833.8375504-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
Date:   Fri, 11 Feb 2022 14:27:13 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com>
In-Reply-To: <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 13:40:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Feb 9, 2022 at 8:29 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The virtio spec already supports the virtio queue reset function. This patch set
> > is to add this function to the kernel. The relevant virtio spec information is
> > here:
> >
> >     https://github.com/oasis-tcs/virtio-spec/issues/124
> >
> > Also regarding MMIO support for queue reset, I plan to support it after this
> > patch is passed.
>
> So I had an idea, we can implement ethtool_set_ringparam() in this
> series to get one real users.

I agree, in fact my local test is using this feature.

>
> But this came into another question: it looks to me current virito-net
> just uses the maximum ring size, so it basically means we just can
> decrease the number from startup, so I wonder how much value if we
> don't limit the startup queue size to a dedicated value.

I also have this consideration, so I want to add a virtio-net module parameter
to specify an initial value.

This initial value also has another meaning. In order to achieve high
performance, the backend can provide a large ring size capability, but we also
hope that the ring size can only be increased through ethtool -G when the user
needs it.

To implement this function, we need to add a new parameter to find_vqs().

If there is no problem, I will bring this function in the next version.

Thannks.


>
> Thanks
>
> >
> > Please review. Thanks.
> >
> > v4:
> >   1. just the code of virtio, without virtio-net
> >   2. Performing reset on a queue is divided into these steps:
> >     1. reset_vq: reset one vq
> >     2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> >     3. release the ring of the vq by vring_release_virtqueue()
> >     4. enable_reset_vq: re-enable the reset queue
> >   3. Simplify the parameters of enable_reset_vq()
> >   4. add container structures for virtio_pci_common_cfg
> >
> > v3:
> >   1. keep vq, irq unreleased
> >
> > Xuan Zhuo (14):
> >   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
> >   virtio: queue_reset: add VIRTIO_F_RING_RESET
> >   virtio_ring: queue_reset: add function vring_setup_virtqueue()
> >   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
> >   virtio_ring: queue_reset: split: support enable reset queue
> >   virtio_ring: queue_reset: packed: support enable reset queue
> >   virtio_ring: queue_reset: extract the release function of the vq ring
> >   virtio_ring: queue_reset: add vring_release_virtqueue()
> >   virtio: queue_reset: struct virtio_config_ops add callbacks for
> >     queue_reset
> >   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
> >     option functions
> >   virtio_pci: queue_reset: release vq by vp_dev->vqs
> >   virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
> >   virtio_pci: queue_reset: vp_setup_vq() support ring_num
> >   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
> >
> >  drivers/virtio/virtio_pci_common.c     |  65 +++++++---
> >  drivers/virtio/virtio_pci_common.h     |  11 +-
> >  drivers/virtio/virtio_pci_legacy.c     |   5 +-
> >  drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
> >  drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
> >  drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
> >  include/linux/virtio.h                 |   6 +
> >  include/linux/virtio_config.h          |  13 ++
> >  include/linux/virtio_pci_modern.h      |   2 +
> >  include/linux/virtio_ring.h            |  37 ++++--
> >  include/uapi/linux/virtio_config.h     |   7 +-
> >  include/uapi/linux/virtio_pci.h        |  14 ++
> >  12 files changed, 375 insertions(+), 93 deletions(-)
> >
> > --
> > 2.31.0
> >
>
