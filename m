Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6F50CE9D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiDXCnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiDXCnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:43:47 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E59F7CDCC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:40:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAzRZXj_1650768044;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VAzRZXj_1650768044)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 10:40:45 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 00/16] virtio_ring: resize support re-use the old buffers
Date:   Sun, 24 Apr 2022 10:40:28 +0800
Message-Id: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on "virtio pci support VIRTIO_F_RING_RESET". This patch
set is rfc since it hasn't been merged yet. And "virtio pci support
VIRTIO_F_RING_RESET" is currently waiting for Jason Wang's "rework on the IRQ
hardening of virtio".

This patch set implements the reuse of buffers committed before resize.
And it is resubmitted to the new vq in the order of the original submission.

A core idea is to detach the original vring after the new vring is allocated.
Then, the buffers are sequentially obtained from the old vring and submitted to
the new vq.

Please review.

Xuan Zhuo (16):
  virtio_ring: split: vring_unmap_one_split() get extra by arg
  virtio_ring: split: introduce vring_virtqueue_detach_split()
  virtio_ring: split: extract virtqueue_update_split()
  virtio_ring: split: extract detach_from_vring_split()
  virtio_ring: split: support copy from vring
  virtio_ring: split: introduce vring_reuse_bufs_split()
  virtio_ring: split: resize support re-use buffers
  virtio_ring: packed: extract next_idx()
  virtio_ring: packed: always update desc_extra
  virtio_ring: packed: introduce vring_virtqueue_detach_packed()
  virtio_ring: packed: extract virtqueue_update_packed()
  virtio_ring: packed: extract detach_from_vring_packed()
  virtio_ring: packed: support copy from vring
  virtio_ring: packed: introduce vring_reuse_bufs_packed()
  virtio_ring: packed: resize support re-use buffers
  virtio_ring: virtqueue_resize() no longer call recycle() directly

 drivers/virtio/virtio_ring.c | 685 ++++++++++++++++++++++++++---------
 1 file changed, 518 insertions(+), 167 deletions(-)

--
2.31.0

