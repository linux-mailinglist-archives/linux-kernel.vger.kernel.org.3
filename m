Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D204B1DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 06:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiBKFlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 00:41:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiBKFlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 00:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3DFE5596
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 21:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644558067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDY2/mAEz0DQk9D+NgCrbqdeAZ4u0IeTKwgJqx2x5yo=;
        b=fG/m58JDT132raZrNZX0zPMIATN9B8iRv2A1w5Aop8L0tsSw7ss82NMY/66FMzBI9NxOfx
        IkzFY/2O8FkiVG9+MldsY3jsHX99TSoqukuBvzuFRas6j1LYM9BehxrLD8ihTxpfRv2YR6
        kJxoO8JKScTrwPUyUVEoXRczboxIOuc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-44ISMBkOPCSbgt2TbTejyQ-1; Fri, 11 Feb 2022 00:41:05 -0500
X-MC-Unique: 44ISMBkOPCSbgt2TbTejyQ-1
Received: by mail-lf1-f72.google.com with SMTP id c25-20020a056512325900b0043fc8f2e1f6so1866475lfr.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 21:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDY2/mAEz0DQk9D+NgCrbqdeAZ4u0IeTKwgJqx2x5yo=;
        b=R59XlTWaFBtiHObcaVEdxh94zZNz+BdMlsL9xKob66ZGaaSGpy/u/KxF8LGTanKwo/
         qoEPy748o1IVdI+jbxsKkpiyvwIU07BMa0Q8c2z/S2+jNrsvUGuEcJkOz5VVH8uMKhMC
         6NQU2EaZkmRE+mMjEr0az12wHCTsCJh0xS+zOEAfoFNuxk11gN5W1Jh4F8ld5YnTjlqT
         JCZwviEtJgq/HlyynxczPnp91yp/5o54nowkOkj/cwOqGV2ET+AuaTuaG7igdypVhpzM
         I4QHb+NMuYJ8zJaHJ6YRwsAZP+Gv/Cxt4uYKA2l1aAGbEjIZvLENowwOCbDaONh3ooLT
         9tDQ==
X-Gm-Message-State: AOAM5325lWPZaaCCNIhUrvFGeDmQUEeocCWo1wE/mLHBknEvKYKfVoO9
        pBHub6iuFPa4ujI5n9fE7A7y2GuPKj+wKA+bxICmmIqIH1sGcYOqLThWbeO29Cq3lXGZVeaga+s
        noVkzGYP5tfDW1h5TqGvE5gnup1Hw3/OARzgjKDz2
X-Received: by 2002:a05:6512:3986:: with SMTP id j6mr111864lfu.84.1644558063685;
        Thu, 10 Feb 2022 21:41:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT2cx1o5JMs7VMOWCwzGsHA1oGktnK5f/g5wrBlZbEi8ZfHJV1PtgZpflHUjAvgefPOGvfRNR1EMudlMR8YO0=
X-Received: by 2002:a05:6512:3986:: with SMTP id j6mr111854lfu.84.1644558063470;
 Thu, 10 Feb 2022 21:41:03 -0800 (PST)
MIME-Version: 1.0
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Feb 2022 13:40:52 +0800
Message-ID: <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 8:29 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> The virtio spec already supports the virtio queue reset function. This patch set
> is to add this function to the kernel. The relevant virtio spec information is
> here:
>
>     https://github.com/oasis-tcs/virtio-spec/issues/124
>
> Also regarding MMIO support for queue reset, I plan to support it after this
> patch is passed.

So I had an idea, we can implement ethtool_set_ringparam() in this
series to get one real users.

But this came into another question: it looks to me current virito-net
just uses the maximum ring size, so it basically means we just can
decrease the number from startup, so I wonder how much value if we
don't limit the startup queue size to a dedicated value.

Thanks

>
> Please review. Thanks.
>
> v4:
>   1. just the code of virtio, without virtio-net
>   2. Performing reset on a queue is divided into these steps:
>     1. reset_vq: reset one vq
>     2. recycle the buffer from vq by virtqueue_detach_unused_buf()
>     3. release the ring of the vq by vring_release_virtqueue()
>     4. enable_reset_vq: re-enable the reset queue
>   3. Simplify the parameters of enable_reset_vq()
>   4. add container structures for virtio_pci_common_cfg
>
> v3:
>   1. keep vq, irq unreleased
>
> Xuan Zhuo (14):
>   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
>   virtio: queue_reset: add VIRTIO_F_RING_RESET
>   virtio_ring: queue_reset: add function vring_setup_virtqueue()
>   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
>   virtio_ring: queue_reset: split: support enable reset queue
>   virtio_ring: queue_reset: packed: support enable reset queue
>   virtio_ring: queue_reset: extract the release function of the vq ring
>   virtio_ring: queue_reset: add vring_release_virtqueue()
>   virtio: queue_reset: struct virtio_config_ops add callbacks for
>     queue_reset
>   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
>     option functions
>   virtio_pci: queue_reset: release vq by vp_dev->vqs
>   virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
>   virtio_pci: queue_reset: vp_setup_vq() support ring_num
>   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
>
>  drivers/virtio/virtio_pci_common.c     |  65 +++++++---
>  drivers/virtio/virtio_pci_common.h     |  11 +-
>  drivers/virtio/virtio_pci_legacy.c     |   5 +-
>  drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
>  drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
>  drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
>  include/linux/virtio.h                 |   6 +
>  include/linux/virtio_config.h          |  13 ++
>  include/linux/virtio_pci_modern.h      |   2 +
>  include/linux/virtio_ring.h            |  37 ++++--
>  include/uapi/linux/virtio_config.h     |   7 +-
>  include/uapi/linux/virtio_pci.h        |  14 ++
>  12 files changed, 375 insertions(+), 93 deletions(-)
>
> --
> 2.31.0
>

