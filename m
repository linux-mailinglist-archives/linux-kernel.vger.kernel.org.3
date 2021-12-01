Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5B464C7E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbhLALXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348898AbhLALXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:23:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA1C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 03:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87FF9B81E42
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7584C53FAD;
        Wed,  1 Dec 2021 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638357625;
        bh=h4pe6R3IKPLJE7gAZEY/78vP3LYUKYBWeqawkRntwQg=;
        h=From:To:Cc:Subject:Date:From;
        b=rqqFWwbSSaAMiyYSJOyFLyotOWNhV3ERbAJDmUBeWTjkRLj5UfTrkBwuuqBO8cSZw
         Tj180waDZ1dHfzfe8DHOo2dPaom9ddarw0WhcTuGNil42e+8sMxd9C6RDeAAn/n8Jm
         0UFyINaz4IQPr237FbFAAZ4m2qMNn7caiyA+6vW0DIi11I9l9XiX3iVuUZ3u4Nqyc7
         vmJ6LrXaI1L/h8hdiykTW/P4rHbDsJJ9zgZb5+pCpxB8SHNjVzzHeQvVOWv7vdxKk8
         3n7qU96pZg+Rkp+9hg1QzKDNyfkgULq27IToMUawE/ce2MNQnNNQOTZiWTI4qI5dqy
         ZrReUmphWF8gw==
From:   Will Deacon <will@kernel.org>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH] virtio_ring: Fix querying of maximum DMA mapping size for virtio device
Date:   Wed,  1 Dec 2021 11:20:18 +0000
Message-Id: <20211201112018.25276-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_max_dma_size() returns the maximum DMA mapping size of the virtio
device by querying dma_max_mapping_size() for the device when the DMA
API is in use for the vring. Unfortunately, the device passed is
initialised by register_virtio_device() and does not inherit the DMA
configuration from its parent, resulting in SWIOTLB errors when bouncing
is enabled and the default 256K mapping limit (IO_TLB_SEGSIZE) is not
respected:

  | virtio-pci 0000:00:01.0: swiotlb buffer is full (sz: 294912 bytes), total 1024 (slots), used 725 (slots)

Follow the pattern used elsewhere in the virtio_ring code when calling
into the DMA layer and pass the parent device to dma_max_mapping_size()
instead.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6d2614e34470..028b05d44546 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -268,7 +268,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
 	size_t max_segment_size = SIZE_MAX;
 
 	if (vring_use_dma_api(vdev))
-		max_segment_size = dma_max_mapping_size(&vdev->dev);
+		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
 
 	return max_segment_size;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

