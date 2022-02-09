Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9E4AF19C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiBIM32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiBIM3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:29:05 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9EC05CB9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:29:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V4.YQeC_1644409741;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4.YQeC_1644409741)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 20:29:02 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
Date:   Wed,  9 Feb 2022 20:28:47 +0800
Message-Id: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio spec already supports the virtio queue reset function. This patch set
is to add this function to the kernel. The relevant virtio spec information is
here:

    https://github.com/oasis-tcs/virtio-spec/issues/124

Also regarding MMIO support for queue reset, I plan to support it after this
patch is passed.

Please review. Thanks.

v4:
  1. just the code of virtio, without virtio-net
  2. Performing reset on a queue is divided into these steps:
    1. reset_vq: reset one vq
    2. recycle the buffer from vq by virtqueue_detach_unused_buf()
    3. release the ring of the vq by vring_release_virtqueue()
    4. enable_reset_vq: re-enable the reset queue
  3. Simplify the parameters of enable_reset_vq()
  4. add container structures for virtio_pci_common_cfg

v3:
  1. keep vq, irq unreleased

Xuan Zhuo (14):
  virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
  virtio: queue_reset: add VIRTIO_F_RING_RESET
  virtio_ring: queue_reset: add function vring_setup_virtqueue()
  virtio_ring: queue_reset: split: add __vring_init_virtqueue()
  virtio_ring: queue_reset: split: support enable reset queue
  virtio_ring: queue_reset: packed: support enable reset queue
  virtio_ring: queue_reset: extract the release function of the vq ring
  virtio_ring: queue_reset: add vring_release_virtqueue()
  virtio: queue_reset: struct virtio_config_ops add callbacks for
    queue_reset
  virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
    option functions
  virtio_pci: queue_reset: release vq by vp_dev->vqs
  virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
  virtio_pci: queue_reset: vp_setup_vq() support ring_num
  virtio_pci: queue_reset: support VIRTIO_F_RING_RESET

 drivers/virtio/virtio_pci_common.c     |  65 +++++++---
 drivers/virtio/virtio_pci_common.h     |  11 +-
 drivers/virtio/virtio_pci_legacy.c     |   5 +-
 drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
 drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
 drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
 include/linux/virtio.h                 |   6 +
 include/linux/virtio_config.h          |  13 ++
 include/linux/virtio_pci_modern.h      |   2 +
 include/linux/virtio_ring.h            |  37 ++++--
 include/uapi/linux/virtio_config.h     |   7 +-
 include/uapi/linux/virtio_pci.h        |  14 ++
 12 files changed, 375 insertions(+), 93 deletions(-)

--
2.31.0

