Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA13046E14A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhLIDdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:33:04 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55566 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhLIDdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:33:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V-.oFPb_1639020567;
Received: from 30.21.164.175(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0V-.oFPb_1639020567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Dec 2021 11:29:28 +0800
Message-ID: <ae5e154e-ac59-f0fa-a7c7-091a2201f581@linux.alibaba.com>
Date:   Thu, 9 Dec 2021 11:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [PATCH] virtio-pci: fix the confusing error message
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error message on the failure of pfn check should tell
virtio-pci rather than virtio-mmio, just fix it.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
---
  drivers/virtio/virtio_pci_legacy.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c 
b/drivers/virtio/virtio_pci_legacy.c
index d62e983..0ede3bf 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -144,7 +144,7 @@ static struct virtqueue *setup_vq(struct 
virtio_pci_device *vp_dev,
  	q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
  	if (q_pfn >> 32) {
  		dev_err(&vp_dev->pci_dev->dev,
-			"platform bug: legacy virtio-mmio must not be used with RAM above 
0x%llxGB\n",
+			"platform bug: legacy virtio-pci must not be used with RAM above 
0x%llxGB\n",
  			0x1ULL << (32 + PAGE_SHIFT - 30));
  		err = -E2BIG;
  		goto out_del_vq;
-- 
1.8.3.1

